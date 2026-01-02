//
//  Shape+Part.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 22/12/2025.
//

import Foundation

/// The available possible parts, found within Regex Shapes
/// This loosely relates to `StyleRole`, just more granular
public enum Fragment: String, Sendable {
  case content  // Or title? For link, image?
  case syntaxLeading  // Aka leading
  case syntaxTrailing  //  Aka trailing
  
  case label // Image, link, callout
  /// Not sure, but I think anything after here should be something
  /// that I can't logically categorise as leading or trailing syntax
  case exclamation // For image
//  case prefix  // List "-", Image "!", Quote ">", Heading "#"
  case languageHint  // Of type `StyleRole.metadata`
  case url
  
  /// Should/cloud this actually be covered under `content`?
  case single  // ---
}

extension Fragment {
  var toStyleRole: StyleRole {
    switch self {
      case .content, .label, .single: .content
      case .syntaxLeading, .syntaxTrailing: .syntax
      case .languageHint, .url, .exclamation: .metadata
    }
  }
}

// MARK: - Fragment Metadata
extension Fragment {
  public var name: String {
    switch self {
      case .content, .label, .exclamation, .single: rawValue.capitalized
      case .syntaxLeading: "Syntax Start"
      case .syntaxTrailing: "Syntax End"
      case .languageHint: "Language Hint"
      case .url: "URL"
    }
  }
}

extension Fragment: CustomStringConvertible {
  public var description: String { rawValue }
}
