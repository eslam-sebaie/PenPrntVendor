// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Completed
  internal static let completed = L10n.tr("Localizable", "Completed")
  /// COMPLETE ORDER
  internal static let completeOrder = L10n.tr("Localizable", "CompleteOrder")
  /// Sebaie
  internal static let eslam = L10n.tr("Localizable", "Eslam")
  /// In Progress
  internal static let inProgress = L10n.tr("Localizable", "In Progress")
  /// New Order
  internal static let newOrder = L10n.tr("Localizable", "New Order")
  /// Sign in into your Account
  internal static let signInLabel = L10n.tr("Localizable", "signInLabel")
  /// Fill your information to be able to sell products
  internal static let signUpLabel = L10n.tr("Localizable", "signUpLabel")
  /// START ORDER
  internal static let startOrder = L10n.tr("Localizable", "StartOrder")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
