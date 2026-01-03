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

      case .list: return nil
      case .quoteBlock: return nil
      case .callout: return nil
      case .strikethrough:

      case .heading:
        return Regex(
          #/
          ^[\s]{0,3}(?<prefix>\#{1,6})
          (?![\#])[ \t]+(?<content>.+?)
          (?:[\s\t]+\#+)?$
          /#
        )
        .anchorsMatchLineEndings()

      case .italic:
        return Regex(
          #/
          (?<syntaxLeadingPrimary>(?:\*{1}|_{1}))
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<syntaxTrailingPrimary>\k<syntaxLeadingPrimary>)
          /#
        )

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
      case .image, .link:
        return Regex(
          #/
          (?<exclamation>(!)?)
          (?<syntaxLeadingPrimary>\[)
          (?<label>[^\]\n]+)
          (?<syntaxTrailingPrimary>\])
          (?<syntaxLeadingSecondary>\()
          (?<url>[^\)\n]+)
          (?<syntaxTrailingSecondary>\))
          /#
        )

      case .horizontalRule:
        return Regex(/\n---+?/)
          .anchorsMatchLineEndings()
          .ignoresCase()
    }
  }
}
