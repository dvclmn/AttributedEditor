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
  case linkOrImage
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
    languageHint: Substring?,
    code: Substring,
    syntaxTrailingPrimary: Substring
  )

  public typealias Single = (Substring)

  public typealias Prefix = (
    Substring,
    prefix: Substring,  // Aka prefix
    content: Substring,
  )

  /// Need to extract leading/trailing syntax specially for
  /// Link, from both content and metadata fragments
  public typealias LinkOrImage = (
    Substring,
    exclamation: Substring?,
    syntaxLeadingPrimary: Substring,
    label: Substring,
    syntaxTrailingPrimary: Substring,
    syntaxLeadingSecondary: Substring,
    url: Substring,
    syntaxTrailingSecondary: Substring,
  )

  /// ```
  /// > [!NOTE] The title part
  /// > The normal text part
  /// ```
  ///
  /// Callout types:
  /// NOTE
  /// TIP
  /// IMPORTANT
  /// WARNING
  /// CAUTION

  public typealias Callout = (
    Substring,
    prefix: Substring,  // Just like quoteBlock
    syntaxLeadingPrimary: Substring,
    exclamation: Substring,
    label: Substring,
    syntaxTrailingPrimary: Substring,
    title: Substring,
    content: Substring,
  )

}
