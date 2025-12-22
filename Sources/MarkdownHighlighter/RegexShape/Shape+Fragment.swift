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
    case syntaxStart
    case syntaxEnd
    //    case syntax(Boundary)
    //    case codeBlock(Boundary)
    case languageHint  // Of type `SyntaxPart.metadata`
    case prefix  // Image "!", Quote ">", etc
  }
}
extension RegexShape.Fragment {
  
}
