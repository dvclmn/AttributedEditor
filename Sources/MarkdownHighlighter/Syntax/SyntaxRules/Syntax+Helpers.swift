//
//  Syntax+Grouping.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools
import Foundation
import HighlighterCommon

enum AttributeKind {
  case foreground(NSColor)
  case font(NSFont)
  case background(NSColor)
}

extension AttributedRanges {

  /// Type-safe version
  mutating func update(
    _ attribute: AttributeKind,
    in range: Range<String.Index>
  ) {
    switch attribute {
      case .foreground(let colour):
        self.update(.foregroundColor, with: colour, in: range)

      case .font(let font):
        self.update(.font, with: font, in: range)

      case .background(let colour):
        self.update(.backgroundColor, with: colour, in: range)

    }
  }

  private mutating func update(
    _ key: NSAttributedString.Key,
    with value: Any,
    in range: Range<String.Index>
  ) {
    /// If an existing run matches exactly, update it.
    if let index = self.firstIndex(where: { $0.range == range }) {
      self[index].attributes[key] = value
      return
    }

    /// Otherwise, append a new run.
    self.append(AttributedRun(range: range, attributes: [key: value]))
  }
}

extension Regex where Output == RegexShape.Wrap {
  public func apply(
    match: Match,
    perform: (KeyPath<Output, Substring>, Range<String.Index>) -> Void,
  ) {
    let paths: [KeyPath<Output, Substring>] = [\.0, \.leading, \.content, \.trailing]

    for path in paths {
      let substring = match.output[keyPath: path]

      /// This range is correct because the `Substring` points into the parent string
      let range = substring.startIndex..<substring.endIndex
      perform(path, range)

    }
  }
}

//extension NSRange {
//  public init?<T>(
//    from match: Regex<AnyRegexOutput>.Match,
//    as outputType: T.Type,
//    keyPath: KeyPath<T, Substring>,
//    in text: String
//  ) {
//    guard let output = match.output.extractValues(as: outputType) else {
//      return nil
//    }
//    let substring = output[keyPath: keyPath]
//    guard let range = text.range(of: substring)?.toNSRange(in: text) else {
//      return nil
//    }
//    self = range
//  }
//}

//public enum DelimiterShape: Sendable {
//  case none
//  case prefix(String)  // e.g. "# ", "> "
//  case wrapper(prefix: String, suffix: String)  // e.g. "**", "*", "`"
//  case paired(prefix: String, mid: String, suffix: String)  // e.g. "[", "](", ")"
//  case fenced(start: String, end: String)  // e.g. ``` ... ```
//}
//
//public enum ContentRole: Sendable {
//  case inlineText
//  case blockText  // block-level content (useful for block ranges)
//  case labelAndDestination  // links/images
//  case keyAndText  // footnotes
//  case ignored
//}
//
//public enum CaptureProfile: Sendable {
//  case none
//  case single(name: String)
//  case two(name1: String, name2: String)
//  case three(name1: String, name2: String, name3: String)
//  case blockBody(name: String)  // capture the block body
//}

//public enum CaptureOutput<T: RegexComponent>: Sendable {
//  case none
//  case single()
//  case two(name1: String, name2: String)
//  case three(name1: String, name2: String, name3: String)
//  case blockBody(name: String)  // capture the block body
//}

//extension CaptureProfile {
//  /// Number of captures expressed by this profile
//  public var count: Int {
//    switch self {
//      case .none: 0
//      case .single: 1
//      case .two: 2
//      case .three: 3
//      case .blockBody: 1
//    }
//  }
//
//  /// Capture names in positional order
//  public var names: [String] {
//    switch self {
//      case .none: []
//      case .single(let n): [n]
//      case .two(let a, let b): [a, b]
//      case .three(let a, let b, let c): [a, b, c]
//      case .blockBody(let n): [n]
//    }
//  }
//}
