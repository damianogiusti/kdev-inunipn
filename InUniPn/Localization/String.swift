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
  /// Error
  static let error = L10n.tr("Error")
  /// Impossible to join this kind of lesson
  static let errorJoiningLessons = L10n.tr("Error joining lessons")
  /// An error occourred while loggin in, try again later
  static let errorWhileLogginIn = L10n.tr("Error while loggin in")
  /// An error occourred while signin up, try again later
  static let errorWhileSigninUp = L10n.tr("Error while signin up")
  /// Please fill all the required fields
  static let fillAllFields = L10n.tr("Fill all fields")
  /// You have successfully joined the lesson
  static let joinedSuccessfully = L10n.tr("joined successfully")
  /// You have successfully unjoined the lesson
  static let unjoinedSuccessfully = L10n.tr("unjoined successfully")
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
