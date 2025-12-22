//
//  Shape+Part.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 22/12/2025.
//

extension RegexShape {
  
  /// The available possible parts, found within Regex Shapes
  public enum Fragment {
    case content
    case syntaxStart // Aka leading
    case syntaxEnd //  Aka trailing
    case languageHint  // Of type `SyntaxPart.metadata`
    case url
    case prefix  // Image "!", Quote ">", etc
  }
}
extension RegexShape.Fragment {
  
}
