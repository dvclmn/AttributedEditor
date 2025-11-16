//
//  ThemeModels.swift
//  SwiftDown
//
//  Created by Dave Coleman on 26/2/2025.
//

//import NSUI
//
///// Goal: Incremental(?) configuration. Basically being able to override
///// a default with a single new declaration any time.
//
///// Usage:
/////
///// ```swift
///// // Default theme
///// let defaultTheme = MarkdownTheme()
/////
///// // Custom theme
///// var customTheme = MarkdownTheme()
///// customTheme.colors[.header1] = .systemRed
///// customTheme.colors[.codeBlock] = .systemBlue
/////
///// // Completely custom theme
///// let allCustomColors: MarkdownTheme.ColorMap = [
/////   .header1: .systemRed,
/////   .header2: .systemOrange,
/////   // other settings...
///// ]
///// let fullyCustomTheme = MarkdownTheme(colors: ThemeColors(values: allCustomColors))
/////
///// ```
//
//public typealias MarkdownColorMap = [Markdown.Syntax: NSUIColor]
//public typealias MarkdownFontMap = [Markdown.Syntax: FontConfig]
//
//public struct MarkdownTheme: Sendable{
//  public var name: String?
//  public var fontSize: CGFloat
//  public var colors: Colours
//  public var fonts: Fonts
//  public var editor: EditorStyles
//
//  public static let defaultTheme: MarkdownTheme = .init()
//
//  public init(
//    themeName: String? = nil,
//    fontSize: CGFloat = 14,
//    colors: Colours = .defaults,
//    fonts: Fonts = .defaults,
//    editor: EditorStyles = .defaults
//  ) {
//    self.name = themeName
//    self.fontSize = fontSize
//    self.colors = colors
//    self.fonts = fonts
//    self.editor = editor
//  }
//}
//
//protocol VisualProperty {
//  var style: AnyHashable { get }
//}
//
//extension MarkdownTheme {
//
//  /// Set size for a markdown type
//  public func set(_ type: Markdown.Syntax, _ size: CGFloat) -> Self {
//    var copy = self
//    copy.fonts = fonts.with(type, size: size)
//    return copy
//  }
//
//  /// Set color for a markdown type
//  public func set(_ type: Markdown.Syntax, _ color: NSUIColor) -> Self {
//    var copy = self
//    copy.colors = colors.with(type, color: color)
//    return copy
//  }
//
//  /// Set weight for a markdown type
//  public func set(_ type: Markdown.Syntax, _ weight: NSUIFont.Weight) -> Self {
//    var copy = self
//    copy.fonts = fonts.with(type, weight: weight)
//    return copy
//  }
//
//  /// Set font properties for a markdown type
//  ///
//  /// Note: most of these work by being able to infer exactly what needs
//  /// to change, and nothing more, to set the new value. However changing
//  /// the weight for a named font requires knowing how to set the naming
//  /// appropriately. Need to figure that out.
//  public func set(_ type: Markdown.Syntax, _ fontConfig: FontConfig) -> Self {
//    var copy = self
//    var newFonts = copy.fonts
//    newFonts[type] = fontConfig
//    copy.fonts = newFonts
//    return copy
//  }
//}
//
//extension MarkdownTheme {
//
//  // MARK: - Colours
//  public struct Colours: Sendable {
//    public var foreground: MarkdownColorMap
//    public var background: MarkdownColorMap
//    public static let defaults: Colours = .init()
//    
//    public init(
//      foreground: MarkdownColorMap = .defaultColours,
//      background: MarkdownColorMap = [:]
//    ) {
//      self.foreground = foreground
//      self.background = background
//    }
//  }
//
//  // MARK: - Fonts
//  public struct Fonts: Sendable {
//    public var fonts: MarkdownFontMap
//    public static let defaults: Fonts = .init()
//    
//    public init(fonts: MarkdownFontMap = [:]) {
//      self.fonts = fonts
//    }
//  }
//
//  // MARK: - Editor Styles
//  public struct EditorStyles: Sendable {
//    public var backgroundColor: BackgroundStyle = .color(.gray)
//    public var tintColor: NSUIColor = .gray
//    public var cursorColor: NSUIColor = .gray
//
//    public static let defaults: EditorStyles = .init()
//  }
//}
//
//extension MarkdownTheme {
//
//  func attributes(forType type: Markdown.Syntax) -> [NSAttributedString.Key: Any] {
//    var attributes: [NSAttributedString.Key: Any] = [:]
//
//    /// Apply color
//    attributes[.foregroundColor] = colors[forType: type]
//
//    if let fontConfig = fonts.fonts[type] {
//      attributes[.font] = fontConfig.resolvedFont()
//      attributes[.foregroundColor] = colors[forType: type]
//      attributes[.backgroundColor] = colors[forType: type, forComponent: .background]
//    }
//
//    return attributes
//  }
//}
//
//public enum TextComponent {
//  case foreground
//  case background
//}
//
//extension MarkdownTheme.Colours {
//  public subscript(forType type: Markdown.Syntax, forComponent component: TextComponent = .foreground) -> NSUIColor {
//    get {
//      
//      switch component {
//        case .foreground:
//          foreground[type] ?? .label
//          
//        case .background:
//          background[type] ?? .clear
//      }
//    }
//    set {
//      switch component {
//        case .foreground:
////          let copy = foreground[type]
//          foreground[type] = newValue
//          
//        case .background:
//          background[type] = newValue
//      }
//      
//    }
//  }
//
//  public func with(
//    _ type: Markdown.Syntax,
//    color: NSUIColor,
//    forComponent component: TextComponent = .foreground
//  ) -> Self {
//    var copy = self
//    copy[forType: type, forComponent: component] = color
//    return copy
//  }
//}
//
//// MARK: - EditorStyles
//extension MarkdownTheme.EditorStyles {
//  public enum BackgroundStyle: Sendable {
//    case color(NSUIColor)
//    case noBackground
//
//    public var asUniversalColor: NSUIColor {
//      switch self {
//        case .color(let color):
//          return color
//        case .noBackground:
//          return .clear
//      }
//    }
//  }
//}
//
//// MARK: - Extensions
//extension Dictionary where Key == Markdown.Syntax {
//
//  public static var defaultColours: MarkdownColorMap {
//    var map: MarkdownColorMap = [:]
//
//    for type in Markdown.Syntax.allCases {
//      map[type] = type.defaultColor
//    }
//    return map
//  }
//}
//
////extension Dictionary where Key == FontStyleType {
////
////  static var defaultFonts: MarkdownFontMap {
////    var map: MarkdownFontMap = [:]
////
////    for type in Markdown.Syntax.allCases {
////      map[type] = type.defaultFont()
////    }
////    return map
////  }
////}
