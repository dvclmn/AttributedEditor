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

//extension Editor {
//  public struct Defaults {
//    public let font: NSFont
//    public let textColour: NSColor
//    
//    public init(font: NSFont, textColour: NSColor) {
//      self.font = font
//      self.textColour = textColour
//    }
//    //  var defaultFont() NSFont {
//    //    NSFont.systemFont(ofSize: self.fontSize)
//    //  }
//    //  var defaultColour: NSColor { NSColor.textColor }
//    //  //    NSFont.systemFont(ofSize: self.fontSize)
//    //  //  }
//    
//  }
//}


/// Highlighter Common expects the Source Editor to
/// supply an instance of this.
public enum Editor {

  /// X main categories;
  ///
  /// ## TextView
  /// Applicable regardless of grammar used. Lower level, relating
  /// to the `NSTextView` itself
  ///
  /// ## Grammar
  public struct Configuration {

    public let isEditable: Bool
    public let options: Options

    //    @Shared(.fontSize) var fontSize
    //    public let fontSize: CGFloat

    /// A multiplier/factor, not absolute.
    /// E.g. `1.4`
    public let lineSpacing: CGFloat

    /// Note: `lineFragmentPadding` is leading and trailing,
    /// `textContainerInset` is top/bottom(?)
    public let insets: CGSize
    
    /// Expressed in number of lines
    public let overScroll: Int

    /// Maximum comfortable reading width, where text
    /// stops growing and remains centered horizontally
    public let maxWidth: CGFloat?

    public init(
      isEditable: Bool = true,
      options: Options = [],
      lineSpacing: CGFloat = 1.4,
      insets: CGSize = CGSize(10, 20),
      overScroll: Int = 20,
//      overScroll: CGFloat = 40,
      maxWidth: CGFloat? = nil,
    ) {
      self.isEditable = isEditable
      self.options = options
      self.lineSpacing = lineSpacing
      self.insets = insets
      self.overScroll = overScroll
      self.maxWidth = maxWidth
    }
  }
}

extension Editor.Configuration {
  public var codeBlockInsets: CGSize { insets.multiplyBoth(by: 0.4) }

  public var paragraphStyle: NSParagraphStyle {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing

    return paragraphStyle
  }
}
