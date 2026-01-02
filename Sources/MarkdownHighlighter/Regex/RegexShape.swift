//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools

/// I think we don't need assoc. values here, because would mean I'm
/// attempting to handle type erasure, and `AnyRegexOutput` should
/// be handling this entirely.
///
/// Also, assoc. value would imply it is possible to express some specific
/// *value*, based on the declared type for a case. However there is no
/// value to be passed in; the type *is* the value.
@CaseDetection
public enum RegexShape: String, Equatable, Hashable, Sendable {
  case wrap
  case prefix
  case single
  case codeBlock
  case link
  //  case list
  case callout

  public var name: String {
    switch self {
      case .codeBlock: "Code Block"
      default: rawValue.capitalized
    }
  }

  public typealias Wrap = (
    Substring,
    syntaxLeadingPrimary: Substring,
    content: Substring,
    syntaxTrailingPrimary: Substring
  )

  public typealias CodeBlock = (
    Substring,
    syntaxLeadingPrimary: Substring,
    langHint: Substring,
    code: Substring,
    syntaxTrailingPrimary: Substring
  )

  public typealias Single = (Substring)

  public typealias Prefix = (
    Substring,
    prefix: Substring, // Aka prefix
    content: Substring,
  )

  /// Need to extract leading/trailing syntax specially for
  /// Link, from both content and metadata fragments
  public typealias Link = (
    Substring,
    syntaxLeadingPrimary: Substring,
    label: Substring,
    syntaxTrailingPrimary: Substring,
    syntaxLeadingSecondary: Substring,
    url: Substring,
    syntaxTrailingSecondary: Substring,
  )

  //  public typealias List = (
  //    Substring,
  //    marker: Substring,
  //    content: Substring
  //  )

//  public typealias Callout = (
//    Substring,
//    prefix: Substring,
//    label: Substring,
//    content: Substring
//  )

  //  public typealias Image = (
  //    Substring,
  //    prefix: Substring, // "!"
  //    title: Substring,
  //    url: Substring
  //  )
}
extension RegexShape {

  /// Return a range for a given Regex Match and shape part
  /// `text` is the original main text being searched for matches
  public func range(
    for match: Regex<AnyRegexOutput>.Match,
    fragment: Fragment,
  ) throws -> Range<String.Index> {
    switch self {
      // MARK: - Warp
      case .wrap:
        guard let values = match.output.extractValues(as: Wrap.self) else {
          throw RegexError.failedValueExtraction(self, fragment)
        }
        return switch fragment {
          case .syntax(.wrapLeadingPrimary):
            values.syntaxLeadingPrimary.indexRange
            
          case .content(.general):
            values.content.indexRange
            
          case .syntax(.wrapTrailingPrimary):
            values.syntaxTrailingPrimary.indexRange
            
          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
        }
      // MARK: - Prefix
      case .prefix:
        guard let values = match.output.extractValues(as: Prefix.self) else {
          throw RegexError.failedValueExtraction(self, fragment)
        }
        return switch fragment {
          case .syntax(.prefix):
            values.prefix.indexRange
            
          case .content(.general):
            values.content.indexRange
            
          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
        }

      // MARK: - Single
      case .single:
        guard let values = match.output.extractValues(as: Single.self) else {
          throw RegexError.failedValueExtraction(self, fragment)
        }
        return switch fragment {
          case .content(.single): values.indexRange
          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
        }

      // MARK: - Code Block
      case .codeBlock:
        guard let values = match.output.extractValues(as: CodeBlock.self) else {
          throw RegexError.failedValueExtraction(self, fragment)
        }
        return switch fragment {
          case .syntax(.wrapLeadingPrimary):
            values.syntaxLeadingPrimary.indexRange
            
          case .metadata(.languageHint):
            values.langHint.indexRange
            
          case .content(.code):
            values.code.indexRange
            
          case .syntax(.wrapTrailingPrimary):
            values.syntaxTrailingPrimary.indexRange
            
          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
        }

      // MARK: - Link
      case .link:
        guard let values = match.output.extractValues(as: Link.self) else {
          throw RegexError.failedValueExtraction(self, fragment)
        }
        return switch fragment {
          case .syntax(.wrapLeadingPrimary):
            values.syntaxLeadingPrimary.indexRange
            
          case .content(.label):
            values.label.indexRange
            
          case .syntax(.wrapTrailingPrimary):
            values.syntaxTrailingPrimary.indexRange
            
          case .syntax(.wrapLeadingSecondary):
            values.syntaxLeadingSecondary.indexRange
            
          case .metadata(.url):
            values.url.indexRange
            
          case .syntax(.wrapTrailingSecondary):
            values.syntaxTrailingSecondary.indexRange

          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")

        }

      // MARK: - Callout
      case .callout:
        fatalError("Not yet implemented")
//        guard let values = match.output.extractValues(as: Callout.self) else {
//          throw RegexError.failedValueExtraction(self, fragment)
//        }
//        return switch fragment {
//          case .syntaxLeading: values.prefix.indexRange
//          case .label: values.label.indexRange
//          case .content: values.content.indexRange
//          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
//
//        }
    }
  }

  /// Return a range for a given Regex Match and shape part
  /// `text` is the original main text being searched for matches
  public func nsRange(
    for match: Regex<AnyRegexOutput>.Match,
    fragment: Fragment,
    in text: String,
  ) -> NSRange? {
    let stringRange = try? self.range(for: match, fragment: fragment)
    return stringRange?.toNSRange(in: text)
  }
}
