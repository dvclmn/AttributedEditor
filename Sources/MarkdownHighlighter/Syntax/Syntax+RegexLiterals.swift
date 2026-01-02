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
          #/
          ^[\s]{0,3}(?<prefix>\#{1,6})
          (?![\#])[ \t]+(?<content>.+?)
          (?:[\s\t]+\#+)?$
          /#
        )
        .anchorsMatchLineEndings()
      //          /^(?<prefix>#{1,6})[ \t]+(?<content>.*?)(?:[ \t]+#+)?$/

      case .italic:
        return Regex(
          #/
          (?<syntaxLeadingPrimary>(?:\*{1}|_{1}))
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<syntaxTrailingPrimary>\k<syntaxLeadingPrimary>)
          /#
        )
      //        return Regex(
      //          #/
      //          (?<syntaxLeadingPrimary>[\*_])
      //          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
      //          (?<syntaxTrailingPrimary>\k<syntaxLeadingPrimary>)
      //          /#
      //        )
      case .bold:
        return Regex(
          #/
          (?<syntaxLeadingPrimary>(?:\*{2}|_{2}))
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<syntaxTrailingPrimary>\k<syntaxLeadingPrimary>)
          /#
        )

      case .boldItalic:
        return Regex(
          #/
          (?<syntaxLeadingPrimary>(?:\*{3}|_{3}))
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<syntaxTrailingPrimary>\k<syntaxLeadingPrimary>)
          /#
        )
      //        (?<content>[^\n]+?)
      //        return nil

      case .inlineCode:
        return Regex(
          #/
          (?<syntaxLeadingPrimary>`)
          (?<content>(?:[^`\n])+?)
          (?<syntaxTrailingPrimary>`)
          /#
        )
      case .codeBlock:
        return Regex(
          #/
          (?<syntaxLeadingPrimary>```[ \t]*)
          (?<langHint>[^\n]*)\n
          (?<code>(?:.|\n)*?)
          (?<syntaxTrailingPrimary>^```[ \t]*$)
          /#
        )
        .dotMatchesNewlines()
        .anchorsMatchLineEndings()
      //        return nil
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
        return Regex(
          //          #/
          //          (?<content>\[[^\]\n]+\])
          //          (?<metadata>\([^\)\n]+\))
          //          /#
          #/
          (?<leading>\[)
          (?<content>[^\]\n]+)
          (?<trailingA>\])
          (?<leadingB>\()
          (?<url>[^\)\n]+)
          (?<trailingB>\))
          /#
        )
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
