// test/error_mapper_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course_app/services/auth/error_mapper.dart';

FirebaseAuthException _ex(String code, [String? msg]) =>
    FirebaseAuthException(code: code, message: msg);

void main() {
  group('AuthErrorMapper.fromException', () {
    test(
        'Crédentials invalides (MFA = Multi-Factor Authentication possible côté produit)',
        () {
      final codes = [
        'invalid-credential',
        'invalid-login-credentials',
        'wrong-password',
        'wrong_password_hash',
        'auth/invalid_password',
      ];
      for (final c in codes) {
        expect(
          AuthErrorMapper.fromException(_ex(c)),
          'Email ou mot de passe incorrect.',
          reason: 'code=$c',
        );
      }
      // Fallback message
      expect(
        AuthErrorMapper.fromException(_ex('weird', 'The password is invalid')),
        'Email ou mot de passe incorrect.',
      );
    });

    test('Utilisateur', () {
      expect(
        AuthErrorMapper.fromException(_ex('user-not-found')),
        'Aucun compte ne correspond à cet email.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('user-disabled')),
        'Ce compte est désactivé.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('user-token-expired')),
        'La session a expiré. Veuillez vous reconnecter.',
      );
      // Fallback message
      expect(
        AuthErrorMapper.fromException(_ex('unknown', 'No user record found')),
        'Aucun compte ne correspond à cet email.',
      );
    });

    test('Email', () {
      expect(
        AuthErrorMapper.fromException(_ex('email-already-in-use')),
        'Cet email est déjà utilisé.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('invalid-email')),
        'Adresse email invalide.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('unverified-email')),
        'Veuillez vérifier votre adresse email avant de continuer.',
      );
    });

    test('Mot de passe', () {
      expect(
        AuthErrorMapper.fromException(_ex('weak-password')),
        'Mot de passe trop faible.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('missing-password')),
        'Veuillez saisir un mot de passe.',
      );
    });

    test('Fournisseurs/flux (IdP = Identity Provider)', () {
      expect(
        AuthErrorMapper.fromException(_ex('operation-not-allowed')),
        'Cette méthode de connexion est désactivée.',
      );
      expect(
        AuthErrorMapper.fromException(
            _ex('account-exists-with-different-credential')),
        'Un compte existe déjà avec un autre mode de connexion.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('provider-already-linked')),
        'Ce fournisseur est déjà lié au compte.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('credential-already-in-use')),
        'Ces identifiants sont déjà utilisés par un autre compte.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('invalid-provider-id')),
        'Identifiant du fournisseur invalide.',
      );
    });

    test('Popups (UX = User eXperience)', () {
      expect(
        AuthErrorMapper.fromException(_ex('popup-closed-by-user')),
        'La fenêtre de connexion a été fermée.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('cancelled-popup-request')),
        'Une autre fenêtre de connexion est déjà ouverte.',
      );
    });

    test('Sécurité/quotas', () {
      expect(
        AuthErrorMapper.fromException(_ex('requires-recent-login')),
        'Réauthentification requise pour cette action.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('too-many-requests')),
        'Trop de tentatives. Réessayez plus tard.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('captcha-check-failed')),
        'Échec de la vérification de sécurité (captcha).',
      );
      expect(
        AuthErrorMapper.fromException(_ex('app-not-authorized')),
        'Application non autorisée à utiliser Firebase Auth.',
      );
    });

    test('Téléphone / MFA (Multi-Factor Authentication)', () {
      expect(
        AuthErrorMapper.fromException(_ex('missing-phone-number')),
        'Numéro de téléphone manquant.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('invalid-phone-number')),
        'Numéro de téléphone invalide.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('invalid-verification-code')),
        'Code de vérification incorrect.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('invalid-verification-id')),
        'ID de vérification invalide.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('session-expired')),
        'Session expirée. Redemandez un nouveau code.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('quota-exceeded')),
        'Quota de SMS dépassé. Réessayez plus tard.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('mfa-required')),
        'Une authentification à deux facteurs est requise.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('mfa-info-not-found')),
        'Informations MFA introuvables.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('mfa-session-expired')),
        'Session MFA expirée. Réessayez.',
      );
    });

    test('Réseau (HTTP = HyperText Transfer Protocol)', () {
      expect(
        AuthErrorMapper.fromException(_ex('network-request-failed')),
        'Problème réseau. Vérifiez votre connexion.',
      );
      expect(
        AuthErrorMapper.fromException(_ex('random', 'Network timed out')),
        'Problème réseau. Vérifiez votre connexion.',
      );
    });

    test('Fallback diagnostic', () {
      expect(
        AuthErrorMapper.fromException(_ex('auth/SOME_NEW_CODE')),
        'Erreur d’authentification (auth/SOME_NEW_CODE).',
      );
    });

    test('Normalisation (API = Application Programming Interface)', () {
      // Doit normaliser auth/ et underscores
      final m = AuthErrorMapper.fromException(_ex('auth/invalid_credential'));
      expect(m, 'Email ou mot de passe incorrect.');
    });
  });
}
