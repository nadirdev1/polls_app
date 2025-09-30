import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course_app/services/auth/auth_firebase_services.dart';

// Mocks
class _MockFirebaseAuth extends Mock implements FirebaseAuth {}

class _MockUserCredential extends Mock implements UserCredential {}

class _MockUser extends Mock implements User {}

void main() {
  late _MockFirebaseAuth mockAuth;
  late AuthServices service;
  late _MockUserCredential cred;
  late _MockUser user;

  setUp(() {
    mockAuth = _MockFirebaseAuth();
    service = AuthServices(auth: mockAuth);
    cred = _MockUserCredential();
    user = _MockUser();
    when(() => cred.user).thenReturn(user);
  });

  group('AuthServices.signUpWithEmail', () {
    test('success → success=true, message OK, user non-null', () async {
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => cred);

      final res = await service.signUpWithEmail('a@b.com', 'Strong#123');

      expect(res.success, true);
      expect(res.message, 'Sign-up successful');
      expect(res.user, isNotNull);
    });

    test('email-already-in-use → success=false, message FR', () async {
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      final res = await service.signUpWithEmail('dup@x.com', 'Strong#123');

      expect(res.success, false);
      expect(res.message, 'Cet email est déjà utilisé.');
    });

    test('weak-password → success=false, message FR', () async {
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(FirebaseAuthException(code: 'weak-password'));

      final res = await service.signUpWithEmail('z@y.com', '123');

      expect(res.success, false);
      expect(res.message, 'Mot de passe trop faible.');
    });
  });

  group('AuthServices.signInWithEmail', () {
    test('success → success=true, message OK, user non-null', () async {
      when(() => mockAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => cred);

      final res = await service.signInWithEmail('c@d.com', 'Passw0rd!');

      expect(res.success, true);
      expect(res.message, 'Sign-in successful');
      expect(res.user, isNotNull);
    });

    test('invalid-credential → incorrect credentials FR', () async {
      when(() => mockAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(FirebaseAuthException(code: 'invalid-credential'));

      final res = await service.signInWithEmail('e@f.com', 'wrong');

      expect(res.success, false);
      expect(res.message, 'Email ou mot de passe incorrect.');
    });

    test('user-disabled → message FR', () async {
      when(() => mockAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(FirebaseAuthException(code: 'user-disabled'));

      final res = await service.signInWithEmail('x@y.com', 'Any#123');

      expect(res.success, false);
      expect(res.message, 'Ce compte est désactivé.');
    });

    test('network-request-failed → message FR', () async {
      when(() => mockAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(FirebaseAuthException(code: 'network-request-failed'));

      final res = await service.signInWithEmail('n@n.com', 'Any#123');

      expect(res.success, false);
      expect(res.message, contains('Problème réseau'));
    });

    test('exception non FirebaseAuthException → Unexpected error', () async {
      when(() => mockAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(StateError('boom'));

      final res = await service.signInWithEmail('a@a.com', 'x');

      expect(res.success, false);
      expect(res.message, startsWith('Unexpected error:'));
    });
  });
}
