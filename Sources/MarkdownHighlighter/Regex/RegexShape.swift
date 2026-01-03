//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools

@CaseDetection
public enum RegexShape: String, Equatable, Hashable, Sendable {
  case single
  case wrap
  case prefix
  case codeBlock
  case linkOrImage
  case callout

  public var name: String {
    switch self {
      case .codeBlock: "Code Block"
      case .linkOrImage: "Link/Image"
      default: rawValue.capitalized
    }
  }
}

extension RegexShape {

  public typealias Single = (Substring)

  public typealias Wrap = (
    Substring,
    leading: Substring,
    content: Substring,
    trailing: Substring
  )

  public typealias Prefix = (
    Substring,
    prefix: Substring,  // Aka prefix
    content: Substring,
  )

  public typealias CodeBlock = (
    Substring,
    leading: Substring,
    languageHint: Substring?,
    code: Substring,
    trailing: Substring
  )

  /// Need to extract leading/trailing syntax specially for
  /// Link, from both content and metadata fragments
  public typealias LinkOrImage = (
    Substring,
    exclamation: Substring?,
    leading: Substring,
    label: Substring,
    trailing: Substring,
    leadingSecondary: Substring,
    url: Substring,
    trailingSecondary: Substring,
  )

  public typealias Callout = (
    Substring,
    prefix: Substring,  // ">" Just like quoteBlock
    leading: Substring,
    exclamation: Substring,
    label: Substring,
    trailing: Substring,
    title: Substring,
    content: Substring,
  )

}
