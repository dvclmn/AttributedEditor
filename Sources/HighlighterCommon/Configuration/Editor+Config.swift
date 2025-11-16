//
//  Configuration.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 21/8/2024.
//

import ColourKit
import CoreTools
import Sharing
import SwiftUI

/// Highlighter Common expects the Source Editor to
/// suppler an instance of this.
public enum Editor {

  /// X main categories;
  ///
  /// ## TextView
  /// Applicable regardless of grammar used. Lower level, relating
  /// to the `NSTextView` itself
  ///
  /// ## Grammar
  public struct Configuration {

    //    let isEditable: Bool

    public let options: Options

    //    @Shared(.fontSize) var fontSize: CGFloat
    public let fontSize: CGFloat

    /// A multiplier/factor, not absolute. E.g. `1.4`
    public let lineSpacing: CGFloat

    /// Note: `lineFragmentPadding` is leading and trailing,
    /// `textContainerInset` is top/bottom(?)
    public let insets: CGSize
    public let overScroll: CGFloat

    /// Maximum comfortable reading width, where text
    /// stops growing and remains centered horizontally
    public let maxWidth: CGFloat?

    public let colours: Colours

    public init(
      options: Options = [.editable, .lineNumbers],
      fontSize: CGFloat = 15,
      lineSpacing: CGFloat = 1.4,
      insets: CGSize = CGSize(10, 20),
      overScroll: CGFloat = 40,
      maxWidth: CGFloat? = nil,
      colours: Colours = .init()
    ) {
      self.options = options
      self.fontSize = fontSize
      self.lineSpacing = lineSpacing
      self.insets = insets
      self.overScroll = overScroll
      self.maxWidth = maxWidth
      self.colours = colours
    }
  }
}

extension Editor.Configuration {
  public var minFontSize: CGFloat { 9 }
  public var defaultFont: NSFont { .systemFont(ofSize: fontSize) }
  public var defaultColour: NSColor { colours.nsColor(for: \.body) }
  public var codeFontSize: CGFloat { max(minFontSize, fontSize * 0.88) }

  public var codeBlockInsets: CGSize { insets.adjustLengths(by: 0.4) }

  public var typingAttributes: TextAttributes {
    return [
      .font: defaultFont,
      .foregroundColor: colours.nsColor(for: \.body),
      .paragraphStyle: paragraphStyle,

    ]
  }

  public var paragraphStyle: NSParagraphStyle {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing

    return paragraphStyle
  }

}

//extension Editor.Configuration {

//  public var defaultFont: NSFont { .systemFont(ofSize: fontSize) }

//  public func font(_ style: TextView.FontStyle) -> NSFont {
//
//  }
//
//  public var italicFont: NSFont {
//    let descriptor = defaultFont.fontDescriptor.withSymbolicTraits(.italic)
//    return NSFont(descriptor: descriptor, size: fontSize) ?? defaultFont
//  }
//
//  public var boldItalicFont: NSFont {
//    let descriptor = defaultFont.fontDescriptor.withSymbolicTraits([.bold, .italic])
////    let descriptor = systemFont.fontDescriptor.withSymbolicTraits([.bold, .italic])
//    return NSFont(descriptor: descriptor, size: fontSize) ?? defaultFont
//  }

//  public var boldFont: NSFont {
//    NSFont.boldSystemFont(ofSize: theme.fontSize)
//  }

//  public var mediumFont: NSFont {
//    NSFont.systemFont(ofSize: theme.fontSize, weight: .medium)
//  }
//
//  public var codeFont: NSFont {
//    NSFont.monospacedSystemFont(ofSize: codeFontSize, weight: .medium)
//  }
//
//}

//public struct EditorConfiguration: Sendable, Equatable {

//  public var isEditable: Bool = false
//  public var theme: MarkdownTheme = .default
//
//  public var isShowingFrames: Bool = false

//  public init(
//    isEditable: Bool = true,
//    theme: MarkdownTheme = .default,
//    isShowingFrames: Bool = false
//  ) {
//    self.isEditable = isEditable
//    self.theme = theme
//    self.isShowingFrames = isShowingFrames
//  }

//  /// Convenience initializer from options
//  public init(options: [Option]) {
//    var theme = MarkdownTheme.default
//
//    if options.contains(.isEditable) {
//      self.isEditable = true
//    }
//
//    if options.contains(.showingFrames) {
//      self.isShowingFrames = true
//    }
//
//    if options.contains(.hasOverScroll) {
//      theme.overScrollAmount = 60
//    }
//
//    if options.contains(.isFullWidth) {
//      theme.maxReadingWidth = nil
//    }
//
//    self.theme = theme
//  }
//
//}

//extension EditorConfiguration {
//
//  public struct Option: OptionSet, Sendable {
//    public let rawValue: Int
//
//    public init(rawValue: Int) {
//      self.rawValue = rawValue
//    }
//
//    public static let isEditable = Option(rawValue: 1 << 0)
//    public static let showingFrames = Option(rawValue: 1 << 1)
//    public static let hasOverScroll = Option(rawValue: 1 << 2)
//    public static let isFullWidth = Option(rawValue: 1 << 3)
//  }
//}
//
//
//extension EditorConfiguration {

//}
