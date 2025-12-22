//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown.Syntax {

  //  func token(with theme: Markdown.Theme) -> TokenStyle {
  //    return theme.style(for: <#T##Markdown.Syntax#>, part: <#T##Markdown.SyntaxPart#>)
  //  }

  //  var supportsRegexShape: Bool { regexShape != nil }

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
    }
  }

  public var pattern: Regex<AnyRegexOutput>? {
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
        Regex(
          #/
          (?<leading>(?:\*{2}|_{2}))
          (?<content>[^\n]+?)
          (?<trailing>\k<leading>)
          /#
        )
      case .italic:
        Regex(
          #/
          (?<leading>[\*_])
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<trailing>\k<leading>)
          /#
        )
      case .boldItalic:
        Regex(
          #/
          (?<leading>(?:\*{3}|_{3}))
          (?<content>[^\n]+?)
          (?<trailing>\k<leading>)
          /#
        )

      case .inlineCode:
        Regex(
          #/
          (?<leading>`)
          (?<content>(?:[^`\n])+?)
          (?<trailing>`)
          /#
        )
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
