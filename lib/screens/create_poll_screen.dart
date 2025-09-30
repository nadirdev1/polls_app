import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_app/utils/app_handlers.dart';
import 'package:image_picker/image_picker.dart';

class CreatePollScreen extends StatefulWidget {
  final String currentUserId;
  const CreatePollScreen({super.key, required this.currentUserId});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final titleCtrl = TextEditingController();
  final List<TextEditingController> optionCtrls = [];
  final List<File?> optionImgs = [];
  bool loader = false;

  @override
  void initState() {
    super.initState();
    _ensureCount(3); // taille initiale
  }

  void _ensureCount(int n) {
    while (optionCtrls.length < n) {
      optionCtrls.add(TextEditingController());
      optionImgs.add(null);
    }
    while (optionCtrls.length > n) {
      optionCtrls.removeLast().dispose();
      optionImgs.removeLast();
    }
  }

  void _addOption() => setState(() => _ensureCount(optionCtrls.length + 1));

  void _removeOption(int i) => setState(() {
        optionCtrls.removeAt(i).dispose();
        optionImgs.removeAt(i);
      });

  Future<void> _pickImage(int i) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) setState(() => optionImgs[i] = File(file.path));
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    for (final c in optionCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Poll'), centerTitle: true),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _card(
              child: TextFormField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Poll Title'),
              ),
            ),
            for (int i = 0; i < optionCtrls.length; i++)
              _card(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: ValueKey(optionCtrls[i]), // stabilité
                        controller: optionCtrls[i],
                        decoration:
                            InputDecoration(labelText: 'Option ${i + 1}'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => _pickImage(i),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: optionImgs[i] != null
                            ? Image.file(optionImgs[i]!,
                                height: 50, width: 50, fit: BoxFit.cover)
                            : Container(
                                height: 50,
                                width: 50,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image),
                              ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Remove',
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeOption(i),
                    ),
                  ],
                ),
              ),
            _card(
              child: ListTile(
                title: const Text('Add option'),
                trailing: const Icon(Icons.add),
                onTap: _addOption,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: loader
                  ? const CircularProgressIndicator(
                      color: Colors.orange,
                    )
                  : ElevatedButton(
                      onPressed: () async => await submitPoll(
                        userId: widget.currentUserId,
                        context: context,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 48),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Create Poll",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child}) => Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      );

  Future<void> submitPoll(
      {required String userId, required BuildContext context}) async {
    if (!validateForm(context)) return;
    setState(() {
      loader = true;
    });

    try {
      final DocumentReference<Map<String, dynamic>> pollDoc =
          FirebaseFirestore.instance.collection("polls").doc();

      final pollId = pollDoc.id;

      final List<Map<String, dynamic>> options = [];

      for (var i = 0; i < optionImgs.length; i++) {
        final String? imageUrl = await uploadImage(optionImgs[i], pollId, i);

        if (imageUrl == null) throw Exception("Image Upload failed");

        options.add({
          'name': optionCtrls[i].text,
          'imageUrl': imageUrl,
          'votes': 0,
        });
      }

      await pollDoc.set(
        {
          'pollId': pollId,
          'title': titleCtrl.text,
          'options': options,
          'createdAt': FieldValue.serverTimestamp(),
          'creatorId': userId,
          'total_votes': 0
        },
      );
      if (context.mounted) {
        AppHandlers.showSnackBar(context: context, message: 'Poll Created');
        Navigator.pop(context);
      }

      // optionImgs.map((img) async => await uploadImage(img));
    } catch (e) {
      if (context.mounted) {
        AppHandlers.showSnackBar(
            context: context, message: 'Failed to create Poll');
      }
    } finally {
      loader = false;
    }
  }

  Future<String?> uploadImage(File? optionImg, String pollId, int i) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('poll/$pollId/${i.toString()}_$pollId.jpg');
      final uploadedImage = await storageRef.putFile(optionImg!);
      return uploadedImage.ref.getDownloadURL();
    } catch (e) {
      log("Error uploading Image : $e");
    }
    return null;
  }

  bool validateForm(BuildContext context) {
    int? ind;

    if (titleCtrl.text.trim().isEmpty) {
      AppHandlers.showSnackBar(context: context, message: "Title is required");
      return false;
    }

    ind = optionCtrls.indexWhere((c) => c.text.trim().isEmpty);
    if (ind != -1) {
      AppHandlers.showSnackBar(
        context: context,
        message: 'Option ${ind + 1} name is required',
      );
      return false;
    }

    ind = optionImgs.indexWhere((c) => c == null);
    if (ind != -1) {
      AppHandlers.showSnackBar(
        context: context,
        message: 'Option ${ind + 1} Image is required',
      );
      return false;
    }
    return true;
  }
}
