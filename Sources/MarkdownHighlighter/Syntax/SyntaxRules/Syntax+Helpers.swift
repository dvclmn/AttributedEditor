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

public enum RegexShape {

  public typealias Three = (
    Substring,
    leading: Substring,
    content: Substring,
    trailing: Substring
  )
  //  public static var three: Three.Type { Three.self }
}

extension AttributedRanges {
  mutating func updating(
    _ key: NSAttributedString.Key,
    with value: Any,
    in range: Range<String.Index>,
    //    in range: NSRange,
  ) {
    self[range, default: [:]][key] = value
  }
}

extension Regex where Output == RegexShape.Three {
  public func apply(
    match: Match,
    in text: String,
    for keyPaths: KeyPath<Output, Substring>...,
    perform: (KeyPath<Output, Substring>, Range<String.Index>) -> Void
  ) {

    for path in keyPaths {
      let substring = match.output[keyPath: path]
      guard
        let range = text.range(of: substring)
        //        let r = text.range(of: substring)?.toNSRange(in: text)
      else { continue }

      perform(path, range)
      //      perform(typed, r)
      //      perform(Regex<T>.Match(output: typed), r)
    }
  }
}

extension NSRange {
  public init?<T>(
    from match: Regex<AnyRegexOutput>.Match,
    as outputType: T.Type,
    keyPath: KeyPath<T, Substring>,
    in text: String
  ) {
    guard let output = match.output.extractValues(as: outputType) else {
      return nil
    }
    let substring = output[keyPath: keyPath]
    guard let range = text.range(of: substring)?.toNSRange(in: text) else {
      return nil
    }
    self = range
  }
}

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
