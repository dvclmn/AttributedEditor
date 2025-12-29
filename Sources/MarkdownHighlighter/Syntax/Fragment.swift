//
//  Shape+Part.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 22/12/2025.
//

/// The available possible parts, found within Regex Shapes
/// This loosely relates to `StyleRole`, just more granular
public enum Fragment: String, Sendable {
  case content
  case syntaxStart  // Aka leading
  case syntaxEnd  //  Aka trailing
  case languageHint  // Of type `StyleRole.metadata`
  case url
  case prefix  // Image "!", Quote ">", etc
  case single  // ---
}

extension Fragment {
  public var name: String {
    switch self {
      case .content, .prefix, .single: rawValue.capitalized
      case .syntaxStart: "Syntax Start"
      case .syntaxEnd: "Syntax End"
      case .languageHint: "Language Hint"
      case .url: "URL"
    }
  }

  public static let prefixShape: [Self] = [.prefix, .content]
  public static let wrapShape: [Self] = [.syntaxStart, .content, .syntaxEnd]
  public static let singleShape: [Self] = [.single]
  public static let codeBlockShape: [Self] = [
    .syntaxStart,
    .languageHint,
    .content,
    .syntaxEnd,
  ]

  var styleRolePath: RolePath {
    switch self {
      case .content, .single: \.content
      case .syntaxStart, .syntaxEnd: \.syntax
      case .languageHint, .url, .prefix: \.metadata
    }
  }
}
