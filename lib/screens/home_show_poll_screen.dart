import 'package:flutter/material.dart';
import 'package:flutter_course_app/services/auth/auth_app_handlers.dart';
import 'package:flutter_course_app/services/auth/auth_firebase_services.dart';

class HomeShowPollScreen extends StatefulWidget {
  const HomeShowPollScreen({super.key});

  @override
  State<HomeShowPollScreen> createState() => _HomeShowPollScreenState();
}

class _HomeShowPollScreenState extends State<HomeShowPollScreen> {
  AuthServices? _auth;
  String? _currentUserId;

  @override
  void initState() {
    _auth = AuthServices();
    _currentUserId = _auth!.currentUser!.uid.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3, // nombre de tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Show polls"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async => await AuthAppHandlers.handleLogout(
                    context,
                    () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/signin',
                          (route) => false,
                        )),
                icon: const Icon(Icons.logout),
              ),
            ],
            bottom: const TabBar(
              indicatorColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Posted'),
                Tab(text: 'Voted'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text("All polls")),
              Center(child: Text("Posted polls")),
              Center(child: Text("Voted polls")),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/create',
                arguments: _currentUserId),
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}
