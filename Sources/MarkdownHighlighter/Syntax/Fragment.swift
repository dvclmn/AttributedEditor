//
//  Shape+Part.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 22/12/2025.
//

import Foundation

/// The available possible parts, found within Regex Shapes
/// This loosely relates to `StyleRole`, just more granular
public enum Fragment: Sendable, CaseIterable {
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

  case content(ContentKind = .general)  // Or title? For link, image?
  case syntax(SyntaxKind = .wrapLeadingPrimary)
  //  case syntaxLeading  // Aka leading
  //  case syntaxTrailing  //  Aka trailing
  case metadata(Metadata = .general)
  //  case label  // Image, link, callout
  /// Not sure, but I think anything after here should be something
  /// that I can't logically categorise as leading or trailing syntax
  //  case exclamation  // For image
  //  case prefix  // List "-", Image "!", Quote ">", Heading "#"
  //  case languageHint  // Of type `StyleRole.metadata`
  //  case url

  /// Should/cloud this actually be covered under `content`?
  //  case single  // ---
}

extension Fragment {
  public enum Metadata: Sendable {
    case general
    case url
    case languageHint
    case exclamation

    public var name: String {
      switch self {
        case .general: "General"
        case .url: "URL"
        case .languageHint: "Language Hint"
        case .exclamation: "Exclamation"
      }
    }
  }

  public enum ContentKind: Sendable {
    case general
    case label
    case code
    case single  // E.g. horizontal rule
  }

  public enum SyntaxKind: Sendable {
    case prefix
    case wrapLeadingPrimary
    case wrapTrailingPrimary
    case wrapLeadingSecondary
    case wrapTrailingSecondary

    public var name: String {
      switch self {
        case .prefix: "Prefix"
        case .wrapLeadingPrimary: "Wrap Leading Primary"
        case .wrapTrailingPrimary: "Wrap Trailing Primary"
        case .wrapLeadingSecondary: "Wrap Leading Secondary"
        case .wrapTrailingSecondary: "Wrap Trailing Secondary"
      }
    }
  }
}

extension Fragment {
  var toStyleRole: StyleRole {
    switch self {
      case .content: .content
      case .syntax: .syntax
      case .metadata: .metadata
    }
  }
}

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
