//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown.Syntax {

  var supportsRegexShape: Bool { regexShape != nil }

  var regexShape: RegexShape.Meta? {
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
  
//  public var regexAnyShape: Regex<AnyRegexOutput>? {
//    switch self {
//
//      case .bold:
//        /(?<leading>(?:\*{2}|_{2}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
//        
//      case .italic:
//        /(?<leading>[\*_])(?<content>[^\*_ \n][^\n]*?[^\*_ \n])(?<trailing>\k<leading>)/
//   
//      case .boldItalic:
//        /(?<leading>(?:\*{3}|_{3}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
//        
//      default: nil
//    }
//  }
}
