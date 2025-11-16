//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit

//import NSUI

// MARK: - Markdown Syntax Highlighter

public class MarkdownHighlighter: Highlighter {

  private let areHeadersBig: Bool = false
  package let fontSize: CGFloat
  let monospacedFontReduction: CGFloat = 0.88

  public init(
    fontSize: CGFloat
  ) {
    self.fontSize = fontSize
  }

  public func highlight(text: String) -> [NSRange: [NSAttributedString.Key: Any]] {
    var attributes: [NSRange: [NSAttributedString.Key: Any]] = [:]
    let nsString = text as NSString

    /// Order matters: block-level syntax first, then inline
    highlightFencedCodeBlocks(in: nsString, attributes: &attributes)
    highlightHeaders(in: nsString, attributes: &attributes)
    highlightBlockquotes(in: nsString, attributes: &attributes)
    highlightBold(in: nsString, attributes: &attributes)
    highlightItalic(in: nsString, attributes: &attributes)
    highlightStrikethrough(in: nsString, attributes: &attributes)
    highlightInlineCode(in: nsString, attributes: &attributes)
    highlightLinks(in: nsString, attributes: &attributes)
    highlightLists(in: nsString, attributes: &attributes)

    return attributes
  }

  public func blockRanges(text: String) -> [NSRange] {
    // Return ranges for fenced code blocks that should have custom backgrounds
    var ranges: [NSRange] = []
    let pattern = "```[^\\n]*\\n[\\s\\S]*?```"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return ranges }

    let nsString = text as NSString
    let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
    for match in matches {
      ranges.append(match.range)
    }
    return ranges
  }

  private func highlightFencedCodeBlocks(
    in text: NSString,
    attributes: inout [NSRange: [NSAttributedString.Key: Any]]
  ) {
    let pattern = "```([A-Za-z0-9_+-]*)\\n([\\s\\S]*?)```"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
    
    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    
    for match in matches {
      let blockRange = match.range(at: 0)
      let langRange  = match.range(at: 1)
      let bodyRange  = match.range(at: 2)
      
      // Base block style (background, monospaced, etc.)
      attributes[blockRange] = [
        .font: codeFont,
        .foregroundColor: NSColor.secondaryLabelColor,
      ]
      
      // Language tag (```swift)
      attributes[langRange] = [
        .foregroundColor: NSColor.tertiaryLabelColor,
      ]
      
      // Body
      attributes[bodyRange] = [
        .foregroundColor: NSColor.textColor,
      ]
    }
  }
  
//  private func highlightFencedCodeBlocks(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]])
//  {
//    /// Match fenced code blocks: ```language\n...\n```
//    /// [\s\S] matches any character including newlines
//    let pattern = "```([A-Za-z0-9_+-]*)\\n([\\s\\S]*?)```"
////    let pattern = "```[^\\n]*\\n[\\s\\S]*?```"
//    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
//
//    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
//    for match in matches {
//      attributes[match.range] = [
//        .foregroundColor: codeBlockColor,
//        .font: codeFont,
//      ]
//    }
//  }

  private func highlightHeaders(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match headers: # Header, ## Header, etc. (from start of line)
    let pattern = "^#{1,6}\\s+.+$"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      /// Count the number of # to determine header level
      let headerText = text.substring(with: match.range)
      let level = headerText.prefix(while: { $0 == "#" }).count

      let fontSize: CGFloat =
        areHeadersBig
        ? fontSize + CGFloat(7 - level) * 2
        : fontSize

      let weight: NSFont.Weight = {
        if level >= 2 { return .semibold }
        if level >= 4 { return .bold }
        return .medium
      }()

      attributes[match.range] = [
        .foregroundColor: headerColor,
        .font: NSFont.systemFont(ofSize: fontSize, weight: weight),
      ]
    }
  }

  private func highlightBlockquotes(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match blockquotes: > text (from start of line)
    let pattern = "^>\\s+.+$"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      attributes[match.range] = [
        .foregroundColor: quoteColor,
        .font: NSFont.systemFont(ofSize: fontSize, weight: .regular),
        //          .font: NSFont.systemFont(ofSize: fontSize, weight: .regular).italic()
      ]
    }
  }

  private func highlightBold(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    /// Match bold: **text** or __text__ (not crossing newlines)
    let patterns = ["\\*\\*[^*\\n]+\\*\\*", "__[^_\\n]+__"]

    for pattern in patterns {
      guard let regex = try? NSRegularExpression(pattern: pattern) else { continue }
      let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
      for match in matches {
        if attributes[match.range] == nil {
          attributes[match.range] = [
            .font: boldFont
          ]
        }
      }
    }
  }

  private func highlightItalic(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match italic: *text* or _text_ (not crossing newlines, not inside bold)
    // This pattern ensures we don't match ** or __
    let patterns = ["(?<!\\*)\\*(?!\\*)[^*\\n]+\\*(?!\\*)", "(?<!_)_(?!_)[^_\\n]+_(?!_)"]

    for pattern in patterns {
      guard let regex = try? NSRegularExpression(pattern: pattern) else { continue }
      let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
      for match in matches {
        if attributes[match.range] == nil {
          attributes[match.range] = [
            .font: italicFont
          ]
        }
      }
    }
  }

  private func highlightStrikethrough(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match strikethrough: ~~text~~
    let pattern = "~~[^~\\n]+~~"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      attributes[match.range] = [
        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
        .strikethroughColor: NSColor.labelColor,
      ]
    }
  }

  private func highlightInlineCode(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match inline code: `code` (not crossing newlines)
    let pattern = "`[^`\\n]+`"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      attributes[match.range] = [
        .foregroundColor: codeColor,
        .font: codeFont,
      ]
    }
  }

  private func highlightLinks(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match markdown links: [text](url)
    let pattern = "\\[[^\\]\\n]+\\]\\([^)\\n]+\\)"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      attributes[match.range] = [
        .foregroundColor: linkColor,
        .underlineStyle: NSUnderlineStyle.single.rawValue,
      ]
    }
  }

  private func highlightLists(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match list markers at start of line: -, *, +, or numbered lists
    let pattern = "^[\\s]*([\\-*+]|\\d+\\.)\\s"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      attributes[match.range] = [
        .foregroundColor: NSColor.systemOrange,
        .font: NSFont.systemFont(ofSize: fontSize, weight: .semibold),
      ]
    }
  }
}
