//
//  Syntax+Regex.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

extension Markdown.Syntax {
  public var pattern: Regex<AnyRegexOutput>? {
    switch self {
        
        // /(?<prefix>(?:#{1}))(?<content>[^#]+?)/
        // .anchorsMatchNewLines
      case .heading1: return nil
      case .heading2: return nil
      case .heading3: return nil
      case .heading4: return nil
      case .heading5: return nil
      case .heading6: return nil
      case .bold: return nil
        
      case .italic:
        return Regex(
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
        return nil
        
      case .inlineCode:
        return Regex(
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
        return nil
      case .list:
        return nil
      case .quoteBlock: return nil
      case .callout: return nil
      case .strikethrough:
        return Regex(
          #/
          (?<leading>(?:\~{2}))
          (?<content>[^\n]+?)
          (?<trailing>\k<leading>)
          /#
        )
        
      case .highlight:
        return Regex(
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
        return nil
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
        return nil
      case .horizontalRule:
        return nil
        //            Regex(/\n---+?/)
        //          .anchorsMatchLineEndings()
        //          .ignoresCase()
    }
  }
}
