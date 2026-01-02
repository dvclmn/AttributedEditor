//
//  Syntax+RegexLiterals.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation
import RegexBuilder

extension Markdown.Syntax {
  public var pattern: Regex<AnyRegexOutput>? {
    switch self {

      case .heading:

        /// `^`
        /// Ensures we start at the beginning of a line.
        ///
        /// `(?<prefix>#{1,6})`
        /// Captures the hashes
        ///
        /// `(?![#])`
        /// Ensures the match doesn't stop prematurely if there are more hashes.
        ///
        /// `[ \t]+`
        /// Ensures at least one space/tab exists after the hashes
        ///
        /// `(?<content>.+?)`
        /// Captures the actual text of the heading.
        ///
        /// `(?:[ \t]+#+)?$`
        /// Handles optional trailing hashes (e.g., # Title ##) and finds the end of the line.
        return Regex(
          /^[ ]{0,3}(?<prefix>#{1,6})(?![#])[ \t]+(?<content>.+?)(?:[ \t]+#+)?$/
//          /^(?<prefix>#{1,6})[ \t]+(?<content>.*?)(?:[ \t]+#+)?$/
        )
        .anchorsMatchLineEndings()

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
