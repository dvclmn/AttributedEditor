//
//  Elements.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 2/9/2024.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

////@MemberwiseInit(.public)
public enum Markdown {}
//
//  //  @MemberwiseInit(.public)
//  //  public struct Element: Hashable, Sendable {
//  //    public var string: String
//  //    public var syntax: Markdown.Syntax
//  //    public var ranges: Markdown.Ranges
//  //
//  //    /// These are really only for code block background, should
//  //    /// probably split into a more dedicated type at some point.
//  //    public var originY: CGFloat?
//  //    public var rectHeight: CGFloat?
//  //
//  //    public init(
//  //      string: String,
//  //      syntax: Markdown.Syntax,
//  //      ranges: Markdown.Ranges,
//  //      originY: CGFloat? = nil,
//  //      rectHeight: CGFloat? = nil
//  //    ) {
//  //      self.string = string
//  //      self.syntax = syntax
//  //      self.ranges = ranges
//  //      self.originY = originY
//  //      self.rectHeight = rectHeight
//  //    }
//  //  }
//
//  public init() {
//
//  }
//}
//
//extension Markdown {
//
//  //  @MemberwiseInit(.public)
//  public struct Ranges: Sendable, Hashable {
//    public var all: NSRange
//    public var leading: NSRange
//    public var content: NSRange
//    public var trailing: NSRange
//
//    public init(all: NSRange, leading: NSRange, content: NSRange, trailing: NSRange) {
//      self.all = all
//      self.leading = leading
//      self.content = content
//      self.trailing = trailing
//    }
//  }
//
//}
//
//extension Markdown.Ranges: CustomStringConvertible {
//
//  public var description: String {
//
//    let result: String = """
//      ---
//      Markdown Ranges:
//        - All:      \(all.info)
//        - Leading:  \(leading.info)
//        - Content:  \(content.info)
//        - Trailing: \(trailing.info)
//      ---
//
//      """
//    return result
//
//  }
//
//}

//extension Markdown.Element {
//
//  public func getRect(
//    with width: CGFloat,
//    config: EditorConfiguration
//  ) -> NSRect? {
//
//    guard let originY = self.originY, let height = self.rectHeight else { return nil }
//
//    let insets: CGFloat = config.theme.insets
//    let padding: CGFloat = config.codeBlockPadding
//
//    let originX: CGFloat = insets - padding
//    let adjustedOriginY: CGFloat = originY - padding
//
//    let adjustedWidth = width - (insets * 2) + (padding * 2)
//    let adjustedHeight = height + (padding * 2)
//
//    let rect = NSRect(
//      origin: CGPoint(x: originX, y: adjustedOriginY),
//      size: CGSize(width: adjustedWidth, height: adjustedHeight)
//    )
//
//    return rect
//  }
//
//
//  public var summary: String {
//    let result: String = """
//      Preview: \(self.string.preview())
//      Syntax: \(self.syntax.name)
//      Range: \(self.ranges)
//      """
//
//    return result
//  }
//}
