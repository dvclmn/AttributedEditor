//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import HighlighterCommon

//import NSUI

public final class MarkdownHighlighter: Highlighter {
  public var editorConfig: Editor.Configuration
  var rules: [SyntaxRule] {
    SyntaxRulesThingy.defaultSet(fontSize: editorConfig.fontSize)
  }

  public init(config: Editor.Configuration) {
    self.editorConfig = config
  }

  public func highlight(text: String) -> AttributedRanges {
    var attributes: AttributedRanges = [:]
    let ns = text as NSString
    for rule in rules {
      apply(rule, to: ns, attributes: &attributes)
    }
    return attributes
  }

  private func apply(
    _ rule: SyntaxRule,
    to text: NSString,
    attributes: inout AttributedRanges
  ) {
    let pattern = rule.makePattern()
    guard let regex = try? NSRegularExpression(pattern: pattern, options: rule.regexOptions) else { return }
    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches {
      rule.apply(match, text, &attributes)
    }
  }

  /// blockRanges computed from same rule set: any rule that marks `exposesBlockRange == true`
  public func blockRanges(
    text: String,
  ) -> [NSRange] {
    var ranges: [NSRange] = []
    let ns = text as NSString
    let fullRange = NSRange(location: 0, length: ns.length)

    for rule in rules where rule.exposesBlockRange {
      let pattern = rule.makePattern()
      guard let regex = try? NSRegularExpression(pattern: pattern, options: rule.regexOptions) else { continue }
      let matches = regex.matches(in: text, range: fullRange)
      for m in matches {
        ranges.append(m.range(at: 0))
      }
    }
    return ranges
  }
}

struct SyntaxRulesThingy {
  //  let fontSize: CGFloat
  //  let config: Editor.Configuration
  //  let rules: [SyntaxRule]
}
extension SyntaxRulesThingy {

  static func defaultSet(fontSize: CGFloat) -> [SyntaxRule] {

    //    let bodyFont: NSFont = Editor.FontStyle.body.font(size: fontSize)
    let boldFont: NSFont = Editor.FontStyle.bold.font(size: fontSize)
    let italicFont: NSFont = Editor.FontStyle.italic.font(size: fontSize)
    let codeFont: NSFont = Editor.FontStyle.code.font(size: fontSize)

    //    let headers = SyntaxRule.allHeadings(font: bodyFont)
    let others: [SyntaxRule] = [
      SyntaxRule.fencedCodeBlock(codeFont: codeFont),
      SyntaxRule.bold(font: boldFont),
      SyntaxRule.italic(font: italicFont),
      SyntaxRule.horizontalRule(),
      //      SyntaxRule.heading(level: 1, font: boldFont),
    ]

    return others
    //    return headers + others
  }
}

// MARK: - Markdown Syntax Highlighter

//public class MarkdownHighlighter: Highlighter {
//
//  private let areHeadersBig: Bool = false
////  package let fontSize: CGFloat
//  let monospacedFontReduction: CGFloat = 0.88
//
//  public init(
//
////    fontSize: CGFloat
//  ) {
////    self.fontSize = fontSize
//  }

//  public func highlight(
//    text: String,
//    config: Editor.Configuration
//  ) -> AttributedRanges {
//    var attributes: AttributedRanges = [:]
//    let nsString = text as NSString
//
//    /// Order matters: block-level syntax first, then inline
//    highlightFencedCodeBlocks(in: nsString, attributes: &attributes)
//    highlightHeaders(in: nsString, attributes: &attributes)
//    highlightBlockquotes(in: nsString, attributes: &attributes)
//    highlightBold(in: nsString, attributes: &attributes)
//    highlightItalic(in: nsString, attributes: &attributes)
//    highlightStrikethrough(in: nsString, attributes: &attributes)
//    highlightInlineCode(in: nsString, attributes: &attributes)
//    highlightLinks(in: nsString, attributes: &attributes)
//    highlightLists(in: nsString, attributes: &attributes)
//
//    return attributes
//  }
//
//  public func blockRanges(text: String) -> [NSRange] {
//    /// Return ranges for fenced code blocks that should have custom backgrounds
//    var ranges: [NSRange] = []
//    let pattern = "```[^\\n]*\\n[\\s\\S]*?```"
//    guard let regex = try? NSRegularExpression(pattern: pattern) else { return ranges }
//
//    let nsString = text as NSString
//    let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
//    for match in matches {
//      ranges.append(match.range)
//    }
//    return ranges
//  }
//
//  private func highlightFencedCodeBlocks(
//    in text: NSString,
//    attributes: inout [NSRange: [NSAttributedString.Key: Any]]
//  ) {
//    let pattern = "```([A-Za-z0-9_+-]*)\\n([\\s\\S]*?)```"
//    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//
//    for match in matches {
//      let blockRange = match.range(at: 0)
//      let langRange  = match.range(at: 1)
//      let bodyRange  = match.range(at: 2)
//
//      // Base block style (background, monospaced, etc.)
//      attributes[blockRange] = [
//        .font: codeFont,
//        .foregroundColor: NSColor.secondaryLabelColor,
//      ]
//
//      // Language tag (```swift)
//      attributes[langRange] = [
//        .foregroundColor: NSColor.tertiaryLabelColor,
//      ]
//
//      // Body
//      attributes[bodyRange] = [
//        .foregroundColor: NSColor.textColor,
//      ]
//    }
//  }
//
//  private func highlightHeaders(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    /// Match headers: # Header, ## Header, etc. (from start of line)
//    let pattern = "^#{1,6}\\s+.+$"
//    guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//    for match in matches where attributes[match.range] == nil {
//      /// Count the number of # to determine header level
//      let headerText = text.substring(with: match.range)
//      let level = headerText.prefix(while: { $0 == "#" }).count
//
//      let fontSize: CGFloat =
//        areHeadersBig
//        ? fontSize + CGFloat(7 - level) * 2
//        : fontSize
//
//      let weight: NSFont.Weight = {
//        if level >= 2 { return .semibold }
//        if level >= 4 { return .bold }
//        return .medium
//      }()
//
//      attributes[match.range] = [
//        .foregroundColor: headerColor,
//        .font: NSFont.systemFont(ofSize: fontSize, weight: weight),
//      ]
//    }
//  }
//
//  private func highlightBlockquotes(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    // Match blockquotes: > text (from start of line)
//    let pattern = "^>\\s+.+$"
//    guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//    for match in matches where attributes[match.range] == nil {
//      attributes[match.range] = [
//        .foregroundColor: quoteColor,
//        .font: NSFont.systemFont(ofSize: fontSize, weight: .regular),
//        //          .font: NSFont.systemFont(ofSize: fontSize, weight: .regular).italic()
//      ]
//    }
//  }
//
//  private func highlightBold(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    /// Match bold: **text** or __text__ (not crossing newlines)
//    let patterns = ["\\*\\*[^*\\n]+\\*\\*", "__[^_\\n]+__"]
//
//    for pattern in patterns {
//      guard let regex = try? NSRegularExpression(pattern: pattern) else { continue }
//      let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//      for match in matches {
//        if attributes[match.range] == nil {
//          attributes[match.range] = [
//            .font: boldFont
//          ]
//        }
//      }
//    }
//  }
//
//  private func highlightItalic(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    // Match italic: *text* or _text_ (not crossing newlines, not inside bold)
//    // This pattern ensures we don't match ** or __
//    let patterns = ["(?<!\\*)\\*(?!\\*)[^*\\n]+\\*(?!\\*)", "(?<!_)_(?!_)[^_\\n]+_(?!_)"]
//
//    for pattern in patterns {
//      guard let regex = try? NSRegularExpression(pattern: pattern) else { continue }
//      let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//      for match in matches {
//        if attributes[match.range] == nil {
//          attributes[match.range] = [
//            .font: italicFont
//          ]
//        }
//      }
//    }
//  }
//
//  private func highlightStrikethrough(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    // Match strikethrough: ~~text~~
//    let pattern = "~~[^~\\n]+~~"
//    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//    for match in matches where attributes[match.range] == nil {
//      attributes[match.range] = [
//        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
//        .strikethroughColor: NSColor.labelColor,
//      ]
//    }
//  }
//
//  private func highlightInlineCode(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    // Match inline code: `code` (not crossing newlines)
//    let pattern = "`[^`\\n]+`"
//    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//    for match in matches where attributes[match.range] == nil {
//      attributes[match.range] = [
//        .foregroundColor: codeColor,
//        .font: codeFont,
//      ]
//    }
//  }
//
//  private func highlightLinks(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    // Match markdown links: [text](url)
//    let pattern = "\\[[^\\]\\n]+\\]\\([^)\\n]+\\)"
//    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//    for match in matches where attributes[match.range] == nil {
//      attributes[match.range] = [
//        .foregroundColor: linkColor,
//        .underlineStyle: NSUnderlineStyle.single.rawValue,
//      ]
//    }
//  }
//
//  private func highlightLists(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
//    // Match list markers at start of line: -, *, +, or numbered lists
//    let pattern = "^[\\s]*([\\-*+]|\\d+\\.)\\s"
//    guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//    for match in matches where attributes[match.range] == nil {
//      attributes[match.range] = [
//        .foregroundColor: NSColor.systemOrange,
//        .font: NSFont.systemFont(ofSize: fontSize, weight: .semibold),
//      ]
//    }
//  }
//}
