// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
// swiftlint:disable nesting
// swiftlint:disable variable_name
// swiftlint:disable valid_docs
// swiftlint:disable type_name

enum L10n {
  /// Annulla
  static let cancel = L10n.tr("Cancel")
  /// Sei sicuro di voler effettuare il logout?
  static let confirmLogoutMessage = L10n.tr("confirm logout message")
  /// Conferma password
  static let confirmPassword = L10n.tr("Confirm password")
  /// Ripeti la password
  static let confirmPasswordPlaceholder = L10n.tr("Confirm password placeholder")
  /// Mi sto collegando a Facebook, attendi...
  static let contactingFacebook = L10n.tr("contacting facebook")
  /// Dettaglio
  static let detail = L10n.tr("Detail")
  /// Indirizzo email
  static let email = L10n.tr("Email")
  /// esempio@unipn.it
  static let emailPlaceholder = L10n.tr("Email placeholder")
  /// Errore
  static let error = L10n.tr("Error")
  /// Errore durante il salvataggio della lezione
  static let errorJoiningLessons = L10n.tr("Error joining lessons")
  /// Si è verificato un errore durante il download delle lezioni, riprova più tardi
  static let errorRetrievingLessons = L10n.tr("Error retrieving lessons")
  /// Si è verificato un errore durante il download delle news, riprova più tardi
  static let errorRetrievingNews = L10n.tr("Error retrieving news")
  /// Si è verificato un errore durante la selezione delle università, riprova più tardi
  static let errorRetrievingUniveristies = L10n.tr("Error retrieving univeristies")
  /// Si è verificato un errore durante il salvataggio delle informazioni
  static let errorSaving = L10n.tr("Error saving")
  /// Si è verificato un errore durante il login, riprova più tardi
  static let errorWhileLogginIn = L10n.tr("Error while loggin in")
  /// Si è verificato un errore durante la registrazione, riprova più tardi
  static let errorWhileSigninUp = L10n.tr("Error while signin up")
  /// Evento salvato con successo!
  static let eventAdded = L10n.tr("event added")
  /// Please fill all the required fields
  static let fillAllFields = L10n.tr("Fill all fields")
  /// Lezione salvata con successo
  static let joinedSuccessfully = L10n.tr("joined successfully")
  /// Lezioni
  static let lessons = L10n.tr("Lessons")
  /// Notifica lezioni
  static let lessonsNotifications = L10n.tr("Lessons Notifications")
  /// Tempo notifica lezioni
  static let lessonsReminderInterval = L10n.tr("Lessons Reminder Interval")
  /// Caricamento, attendi...
  static let loading = L10n.tr("loading")
  /// Logout
  static let logout = L10n.tr("Logout")
  /// minuti
  static let minutePlural = L10n.tr("Minute plural")
  /// minuto
  static let minuteSingular = L10n.tr("Minute singular")
  /// Nome
  static let name = L10n.tr("Name")
  /// Mario Rossi
  static let namePlaceholder = L10n.tr("Name placeholder")
  /// News
  static let news = L10n.tr("News")
  /// Non ci sono lezioni salvate. Un'ottima occasione per andare al mare!
  static let noLessonsPresent = L10n.tr("no lessons present")
  /// Non hai salvato alcuna news. Rimani aggiornato!
  static let noNewsPresent = L10n.tr("no news present")
  /// Non è possibile usufruire di questa funzionalità senza i permessi
  static let noPermissionGiven = L10n.tr("No permission given")
  /// Notifiche
  static let notifications = L10n.tr("Notifications")
  /// Password
  static let password = L10n.tr("Password")
  /// Seleziona la tua università
  static let pickUniversity = L10n.tr("Pick university")
  /// Profilo
  static let profile = L10n.tr("Profile")
  /// Impostazioni
  static let settings = L10n.tr("Settings")
  /// Università
  static let university = L10n.tr("University")
  /// Lezione dimenticata con successo
  static let unjoinedSuccessfully = L10n.tr("unjoined successfully")
  /// Si è verificato un errore, riprova più tardi
  static let unknownError = L10n.tr("Unknown error")
}

extension L10n {
  fileprivate static func tr(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

// swiftlint:enable type_body_length
// swiftlint:enable nesting
// swiftlint:enable variable_name
// swiftlint:enable valid_docs
