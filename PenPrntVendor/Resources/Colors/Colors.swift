// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2b2b2b"></span>
  /// Alpha: 100% <br/> (0x2b2b2bff)
  internal static let startColor = ColorName(rgbaValue: 0x2b2b2bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#efeff4"></span>
  /// Alpha: 100% <br/> (0xefeff4ff)
  internal static let borderColor = ColorName(rgbaValue: 0xefeff4ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00bc41"></span>
  /// Alpha: 100% <br/> (0x00bc41ff)
  internal static let completeColor = ColorName(rgbaValue: 0x00bc41ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#efa61d"></span>
  /// Alpha: 100% <br/> (0xefa61dff)
  internal static let progressColor = ColorName(rgbaValue: 0xefa61dff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00aeef"></span>
  /// Alpha: 100% <br/> (0x00aeefff)
  internal static let skyColor = ColorName(rgbaValue: 0x00aeefff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#707070"></span>
  /// Alpha: 100% <br/> (0x707070ff)
  internal static let storeBorder = ColorName(rgbaValue: 0x707070ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d6d6d6"></span>
  /// Alpha: 100% <br/> (0xd6d6d6ff)
  internal static let welcomeBorder = ColorName(rgbaValue: 0xd6d6d6ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map {
      CGFloat($0 & 0xff)
    }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
