//
//  Shape+Part.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 22/12/2025.
//

extension RegexShape {

  /// The available possible parts, found within Regex Shapes
  public enum Fragment: Sendable {
    case content
    case syntaxStart  // Aka leading
    case syntaxEnd  //  Aka trailing
    case languageHint  // Of type `StyleRole.metadata`
    case url
    case prefix  // Image "!", Quote ">", etc
    case single  // ---
  }
}

extension RegexShape.Fragment {

  public static let prefixShape: [Self] = [.prefix, .content]
  public static let wrapShape: [Self] = [.syntaxStart, .content, .syntaxEnd]
  public static let singleShape: [Self] = [.single]
  public static let codeBlockShape: [Self] = [
    .syntaxStart,
    .languageHint,
    .content,
    .syntaxEnd,
  ]
}
