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
  /// Confirm password
  static let confirmPassword = L10n.tr("Confirm password")
  /// Repeat your password
  static let confirmPasswordPlaceholder = L10n.tr("Confirm password placeholder")
  /// Contacting Facebook, please wait...
  static let contactingFacebook = L10n.tr("contacting facebook")
  /// Email address
  static let email = L10n.tr("Email")
  /// example@unipn.it
  static let emailPlaceholder = L10n.tr("Email placeholder")
  /// Error
  static let error = L10n.tr("Error")
  /// Impossible to join this kind of lesson
  static let errorJoiningLessons = L10n.tr("Error joining lessons")
  /// An error occourred while retrieving lessons, try again later
  static let errorRetrievingLessons = L10n.tr("Error retrieving lessons")
  /// An error occourred while retrieving news, try again later
  static let errorRetrievingNews = L10n.tr("Error retrieving news")
  /// An error occourred while retrieving universities, try again later
  static let errorRetrievingUniveristies = L10n.tr("Error retrieving univeristies")
  /// An error occourred while saving
  static let errorSaving = L10n.tr("Error saving")
  /// An error occourred while loggin in, try again later
  static let errorWhileLogginIn = L10n.tr("Error while loggin in")
  /// An error occourred while signin up, try again later
  static let errorWhileSigninUp = L10n.tr("Error while signin up")
  /// Your event was added successfully
  static let eventAdded = L10n.tr("event added")
  /// Please fill all the required fields
  static let fillAllFields = L10n.tr("Fill all fields")
  /// You have successfully joined the lesson
  static let joinedSuccessfully = L10n.tr("joined successfully")
  /// Lessons
  static let lessons = L10n.tr("Lessons")
  /// Notify for lessons
  static let lessonsNotifications = L10n.tr("Lessons Notifications")
  /// Lessons reminder
  static let lessonsReminderInterval = L10n.tr("Lessons Reminder Interval")
  /// Loading, please wait...
  static let loading = L10n.tr("loading")
  /// Name
  static let name = L10n.tr("Name")
  /// Mario Rossi
  static let namePlaceholder = L10n.tr("Name placeholder")
  /// News
  static let news = L10n.tr("News")
  /// There are no planned lessons. A good opportunity to go sunbathing!
  static let noLessonsPresent = L10n.tr("no lessons present")
  /// It seems that you have no news. Let's stay tuned!
  static let noNewsPresent = L10n.tr("no news present")
  /// I cannot perform this operation without your permission
  static let noPermissionGiven = L10n.tr("No permission given")
  /// Notifications
  static let notifications = L10n.tr("Notifications")
  /// Password
  static let password = L10n.tr("Password")
  /// Select the university you are attending
  static let pickUniversity = L10n.tr("Pick university")
  /// Profile
  static let profile = L10n.tr("Profile")
  /// Account settings
  static let settings = L10n.tr("Settings")
  /// University
  static let university = L10n.tr("University")
  /// You have successfully unjoined the lesson
  static let unjoinedSuccessfully = L10n.tr("unjoined successfully")
  /// An unknown error occourred, try again later
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
