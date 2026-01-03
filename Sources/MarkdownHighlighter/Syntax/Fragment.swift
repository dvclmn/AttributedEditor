//
//  Shape+Part.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 22/12/2025.
//

import CoreTools
import Foundation

/// The available possible parts, found within Regex Shapes
/// This loosely relates to `StyleRole`, just more granular
@MetaEnum
public enum Fragment: Sendable, CaseIterable, Hashable {
  case content(ContentKind = .general)
  case syntax(SyntaxKind = .wrapLeadingPrimary)
  case metadata(Metadata = .general)
}
extension Fragment.Meta: Sendable, Hashable, CaseIterable {}
extension Fragment.Meta: CustomStringConvertible {
  public var description: String { self.name }

}

extension Fragment {

  public static var allCases: [Fragment] {
    [
      .content(.general),
      .content(.label),
      .content(.single),
      .syntax(.prefix),
      .syntax(.wrapLeadingPrimary),
      .syntax(.wrapTrailingPrimary),
      .syntax(.wrapLeadingSecondary),
      .syntax(.wrapTrailingSecondary),
      //      .syntaxLeading,
      //      .syntaxTrailing,
      .metadata(.general),
      .metadata(.url),
      .metadata(.languageHint),
      .metadata(.exclamation),
    ]
  }

}

//extension Fragment {
//  var toStyleRole: StyleRole {
//    switch self {
//      case .content: .content
//      case .syntax: .syntax
//      case .metadata: .metadata
//    }
//  }
//}

// MARK: - Fragment Metadata
extension Fragment {
  public var name: String {
    switch self {
      case .content: "Content"
      case .syntax(let kind): "Syntax \(kind.name)"
      //      case .syntaxTrailing: "Syntax Trailing"
      case .metadata(let metadata): metadata.name
    }
  }
}

extension Fragment: CustomStringConvertible {
  public var description: String { name }
}
