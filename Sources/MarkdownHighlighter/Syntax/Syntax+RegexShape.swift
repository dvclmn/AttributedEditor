//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown.Syntax {

  var fragments: [Fragment]? {
    self.regexShape?.toFragments
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

      case .list, .callout:
        nil
    }
  }

  public var pattern: Regex<AnyRegexOutput>? {
    switch self {

      // /(?<prefix>(?:#{1}))(?<content>[^#]+?)/
      // .anchorsMatchNewLines
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
        
        /// `(?:…)` = Non-capturing group
        /// `{2}` = Match two of the preceeding token
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
          /#)
      case .boldItalic:
        //        Regex(
        //          #/
        //          (?<leading>(?:\*{3}|_{3}))
        //          (?<content>[^\n]+?)
        //          (?<trailing>\k<leading>)
        //          /#
        //        )
        nil

      case .inlineCode:
        Regex(
          #/
          (?<leading>`)
          (?<content>(?:[^`\n])+?)
          (?<trailing>`)
          /#
        )
      case .codeBlock:
        //        Regex(
        //          #/
        //          (?<start>```[ \t]*)
        //          (?<langHint>[^\n]*)\n
        //          (?<content>(?:.|\n)*?)
        //          (?<end>^```[ \t]*$)
        //          /#
        //        )
        //        .dotMatchesNewlines()
        //        .anchorsMatchLineEndings()
        nil
      case .list:
        nil
      case .quoteBlock:  nil
      case .callout: nil
      case .strikethrough:
        Regex(
          #/
          (?<leading>(?:\~{2}))
          (?<content>[^\n]+?)
          (?<trailing>\k<leading>)
          /#
        )
        
      case .highlight:
        Regex(
          #/
          (?<leading>==)
          (?<content>[^== \n][^\n]*?[^== \n])
          (?<trailing>\k<leading>)
          /#
        )
      case .link:
        //        Regex(
        //          #/
        //          (?<leadingA>\[)
        //          (?<title>[^\]\n]+)
        //          (?<trailingA>\])
        //          (?<leadingB>\()
        //          (?<url>[^\)\n]+)
        //          (?<trailingB>\))
        //          /#
        //        )
        nil
      case .image:
        //        Regex(
        //          #/
        //          (?<prefix>!?)
        //          (?<leadingA>\[)
        //          (?<title>[^\]\n]+)
        //          (?<trailingA>\])
        //          (?<leadingB>\()
        //          (?<url>[^\)\n]+)
        //          (?<trailingB>\))
        //          /#
        //        )
        nil
      case .horizontalRule:
        nil
//            Regex(/\n---+?/)
//          .anchorsMatchLineEndings()
//          .ignoresCase()
    }
  }
}
