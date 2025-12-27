//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools


//import ThemePark

//public typealias AttributedRanges = [SyntaxRun]
//public typealias BlockRanges = [Range<String.Index>]
//public typealias NSBlockRanges = [NSRange]

/// No colours, fonts, background, attrs
/// This is the output of the Highlighter.
public struct SyntaxRun {
//public struct SyntaxRun<Syntax: Hashable> {

  //  public let syntaxID: AnyHashable
  //  public let semanticKind: SemanticKind

//  public var syntax: AnyHashable
  public let syntax: Markdown.Syntax
  //  public let syntax: Markdown.Syntax
  public let role: StyleRole
  public let range: Range<String.Index>

  /// Optional extra meaning, not styling
  //  public let fragment: Fragment?

  /// The lexeme/syntax/operator/keyword etc that this run is attached to
  /// This is a String for now, until I set up Theming
  /// that works for *any* Highlighter, not just markdown
  //  public let fragment: Fragment
  //  public let fragment: String?
  //  public let keyword: SyntaxSpecifier

  //  public let metadata: String?
  //  public let range: Range<String.Index>
  //  public var attributes: TextAttributes
  //  public var attributes: NSTextAttributes

  //  public init(
  //    //    _ fragment: String? = nil,
  //    //    _ keyword: SyntaxSpecifier,
  //    metadata: String?,
  //    range: Range<String.Index>,
  //    attributes: TextAttributes,
  //    //    attributes: NSTextAttributes
  //  ) {
  //    //    self.fragment = fragment
  //    //    self.keyword = keyword
  //    self.metadata = metadata
  //    self.range = range
  //    self.attributes = attributes
  //  }
}

extension SyntaxRun {
  /// Semantically here meaning that the identifying properties
  /// like keyword and range are equal, but the style attributes may
  /// not be. So there'd be a choice about overwriting, preserving, etc.
  //  func isSemanticallyEqual(to other: SyntaxRun) -> Bool {
  //    range == other.range
  //    //    fragment == other.fragment && range == other.range
  //  }

  public func hasSameRange(as other: SyntaxRun) -> Bool {
    range == other.range
  }
}

extension SyntaxRun {
  public func nsRange(in text: String) -> NSRange? { range.toNSRange(in: text) }
}

//extension AttributedRanges {
//
//  func run(
//    matching range: Range<String.Index>,
//    _ fragment: String
//  ) -> SyntaxRun? {
//    first(where: { $0.range == range })
//    //    first(where: { $0.range == range && $0.fragment == fragment })
//  }
//
//  func runIndex(
//    matching range: Range<String.Index>,
//    _ fragment: String
//  ) -> Int? {
//    firstIndex(where: { $0.range == range })
//    //    firstIndex(where: { $0.range == range && $0.fragment == fragment })
//  }
//}

//extension SyntaxRun: CustomStringConvertible {
//  public var description: String {
//    DisplayString {
//      Indented("SyntaxRun") {
//        Labeled("Metadata", value: metadata)
//        Labeled("Range", value: range)
//        Labeled("Attributes", value: attributes)
//      }
//    }.plainText
//  }
//}

//extension NSBlockRanges {
//  public mutating func append<T>(
//    from match: Regex<T>.Match,
//    in text: String
//  ) {
//    guard let range = match.nsRange(in: text) else { return }
//    self.append(range)
//  }
//}
