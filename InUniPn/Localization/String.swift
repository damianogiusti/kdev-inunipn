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
  /// An error occourred while loggin in, try again later
  static let errorWhileLogginIn = L10n.tr("Error while loggin in")
  /// An error occourred while signin up, try again later
  static let errorWhileSigninUp = L10n.tr("Error while signin up")
  /// Please fill all the required fields
  static let fillAllFields = L10n.tr("Fill all fields")
  /// You have successfully joined the lesson
  static let joinedSuccessfully = L10n.tr("joined successfully")
  /// Lessons
  static let lessons = L10n.tr("Lessons")
  /// Loading, please wait...
  static let loading = L10n.tr("loading")
  /// Name
  static let name = L10n.tr("Name")
  /// Mario Rossi
  static let namePlaceholder = L10n.tr("Name placeholder")
  /// News
  static let news = L10n.tr("News")
  /// It seems that you have no news. Let's stay tuned!
  static let noNewsPresent = L10n.tr("no news present")
  /// Password
  static let password = L10n.tr("Password")
  /// Select the university you are attending
  static let pickUniversity = L10n.tr("Pick university")
  /// Profile
  static let profile = L10n.tr("Profile")
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
