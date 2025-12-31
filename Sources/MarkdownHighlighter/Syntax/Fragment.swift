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
  case content // Or title? For link, image?
  case syntaxLeading  // Aka leading
  case syntaxTrailing  //  Aka trailing
  case prefix  // Image "!", Quote ">", etc
  case languageHint  // Of type `StyleRole.metadata`
  case url
  case single  // ---
}

extension Fragment {
  public var name: String {
    switch self {
      case .content, .prefix, .single: rawValue.capitalized
      case .syntaxLeading: "Syntax Start"
      case .syntaxTrailing: "Syntax End"
      case .languageHint: "Language Hint"
      case .url: "URL"
    }
  }

  var toStyleRole: StyleRole {
    switch self {
      case .content, .single: .content
      case .syntaxLeading, .syntaxTrailing: .syntax
      case .languageHint, .url, .prefix: .metadata
    }
  }
}
extension Fragment: CustomStringConvertible {
  public var description: String { rawValue }
}
