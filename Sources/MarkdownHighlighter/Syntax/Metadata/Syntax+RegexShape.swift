//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown.Syntax {

  var supportsRegexShape: Bool { regexShape != nil }

  var regexShape: RegexShape? {
//  var regexShape: RegexShape.Meta? {
    switch self {
      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6, .quoteBlock:
        .prefix

      case .bold, .italic, .boldItalic, .inlineCode, .strikethrough, .highlight:
        .wrap

      case .codeBlock:
        .codeBlock

      case .link, .image:
        .wrapPair

      case .horizontalRule:
        .single

      case .body, .list, .callout:
        nil
    //        fatalError("\(self.name) not yet supported.")
    }
  }
  
  public var regexRule: Markdown.SyntaxRule? {
    guard let regexShape, let pattern else { return nil }
    return Markdown.SyntaxRule(
      for: self,
      pattern: pattern,
      shape: regexShape
    )
  }
  
  public var pattern: (any RegexComponent)? {
    switch self {
      case .body:
        nil
      case .heading1:
        nil
      case .heading2:
        nil
      case .heading3:
        nil
      case .heading4:
        nil
      case .heading5:
        nil
      case .heading6:
        nil
      case .bold:
        /(?<leading>(?:\*{2}|_{2}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
      case .italic:
        /(?<leading>[\*_])(?<content>[^\*_ \n][^\n]*?[^\*_ \n])(?<trailing>\k<leading>)/
      case .boldItalic:
        /(?<leading>(?:\*{3}|_{3}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
      case .inlineCode:
        nil
      case .codeBlock:
        nil
      case .list:
        nil
      case .quoteBlock:
        nil
      case .callout:
        nil
      case .strikethrough:
        nil
      case .highlight:
        nil
      case .link:
        nil
      case .image:
        nil
      case .horizontalRule:
        nil
    }
  }
}
