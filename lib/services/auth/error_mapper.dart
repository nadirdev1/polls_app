import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorMapper {
  static String fromException(FirebaseAuthException e) {
    final code = _normalize(e.code);
    final msg = (e.message ?? '').toLowerCase();

    bool isAny(String c, List<String> list) => list.contains(c);

    // Credentials invalides (codes variables selon version/config/protection anti-énumération)
    if (isAny(code, [
      'invalid-credential',
      'invalid-login-credentials',
      'wrong-password',
      'wrong-password-hash',
      'invalid-password',
    ])) {
      return 'Email ou mot de passe incorrect.';
    }

    // Utilisateur
    if (code == 'user-not-found') {
      return 'Aucun compte ne correspond à cet email.';
    }
    if (code == 'user-disabled') {
      return 'Ce compte est désactivé.';
    }
    if (code == 'user-token-expired') {
      return 'La session a expiré. Veuillez vous reconnecter.';
    }

    // Email
    if (code == 'email-already-in-use') {
      return 'Cet email est déjà utilisé.';
    }
    if (code == 'invalid-email') {
      return 'Adresse email invalide.';
    }
    if (code == 'unverified-email') {
      return 'Veuillez vérifier votre adresse email avant de continuer.';
    }

    // Mot de passe
    if (code == 'weak-password') {
      return 'Mot de passe trop faible.';
    }
    if (code == 'missing-password') {
      return 'Veuillez saisir un mot de passe.';
    }

    // Auth provider / méthode
    if (code == 'operation-not-allowed') {
      return 'Cette méthode de connexion est désactivée.';
    }
    if (code == 'account-exists-with-different-credential') {
      return 'Un compte existe déjà avec un autre mode de connexion.';
    }
    if (code == 'provider-already-linked') {
      return 'Ce fournisseur est déjà lié au compte.';
    }
    if (code == 'credential-already-in-use') {
      return 'Ces identifiants sont déjà utilisés par un autre compte.';
    }
    if (code == 'invalid-provider-id') {
      return 'Identifiant du fournisseur invalide.';
    }

    // Identifiants tiers (Google, Apple, etc.)
    if (code == 'popup-closed-by-user') {
      return 'La fenêtre de connexion a été fermée.';
    }
    if (code == 'cancelled-popup-request') {
      return 'Une autre fenêtre de connexion est déjà ouverte.';
    }

    // Sécurité / restrictions
    if (code == 'requires-recent-login') {
      return 'Réauthentification requise pour cette action.';
    }
    if (code == 'too-many-requests') {
      return 'Trop de tentatives. Réessayez plus tard.';
    }
    if (code == 'captcha-check-failed') {
      return 'Échec de la vérification de sécurité (captcha).';
    }
    if (code == 'app-not-authorized') {
      return 'Application non autorisée à utiliser Firebase Auth.';
    }

    // Téléphone / MFA
    if (code == 'missing-phone-number') {
      return 'Numéro de téléphone manquant.';
    }
    if (code == 'invalid-phone-number') {
      return 'Numéro de téléphone invalide.';
    }
    if (code == 'invalid-verification-code') {
      return 'Code de vérification incorrect.';
    }
    if (code == 'invalid-verification-id') {
      return 'ID de vérification invalide.';
    }
    if (code == 'session-expired') {
      return 'Session expirée. Redemandez un nouveau code.';
    }
    if (code == 'quota-exceeded') {
      return 'Quota de SMS dépassé. Réessayez plus tard.';
    }
    if (code == 'mfa-required') {
      return 'Une authentification à deux facteurs est requise.';
    }
    if (code == 'mfa-info-not-found') {
      return 'Informations MFA introuvables.';
    }
    if (code == 'mfa-session-expired') {
      return 'Session MFA expirée. Réessayez.';
    }

    // Réseau
    if (code == 'network-request-failed') {
      return 'Problème réseau. Vérifiez votre connexion.';
    }
    if (msg.contains('network') || msg.contains('timed out')) {
      return 'Problème réseau. Vérifiez votre connexion.';
    }

    // Fallbacks robustes basés sur le message
    if (msg.contains('password is invalid') ||
        msg.contains('invalid password')) {
      return 'Email ou mot de passe incorrect.';
    }
    if (msg.contains('no user record') ||
        msg.contains('user may have been deleted')) {
      return 'Aucun compte ne correspond à cet email.';
    }

    // Dernier recours : exposer le code brut pour diagnostic
    return 'Erreur d’authentification (${e.code}).';
  }

  static String _normalize(String raw) =>
      raw.trim().toLowerCase().replaceAll('auth/', '').replaceAll('_', '-');
}
