//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown.Syntax {

  //  public var shapes: [RegexShape: [RegexShape.Fragment]]? {
  //
  //  }

  var fragments: [RegexShape.Fragment]? {
    switch self {
      case .body: nil

      /// ``RegexShape/Prefix``
      case .heading1,
        .heading2,
        .heading3,
        .heading4,
        .heading5,
        .heading6,
        .quoteBlock,
        .list:
        [.prefix, .content]

      /// ``RegexShape/Wrap``
      case .bold,
        .italic,
        .boldItalic,
        .inlineCode,
        .strikethrough,
        .highlight:
        [.syntaxStart, .content, .syntaxEnd]

      case .codeBlock:
        [
          .syntaxStart,
          .languageHint,
          .content,
          .syntaxEnd,
        ]

      case .callout: nil  // Haven't thought this through yet

      case .link: nil  // [ .syntaxStart, .content, .syntaxEnd, .syntaxStart, .url, .syntaxEnd]
      case .image: nil  // [ .prefix .syntaxStart, .content, .syntaxEnd, .syntaxStart, .url, .syntaxEnd]
      case .horizontalRule: [.horizontalRule]
    }
  }

  var regexShape: RegexShape? {
    switch self {
      case .heading1,
        .heading2,
        .heading3,
        .heading4,
        .heading5,
        .heading6,
        .quoteBlock:
        .prefix

      case .bold,
        .italic,
        .boldItalic,
        .inlineCode,
        .strikethrough,
        .highlight:
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
