//
//  Syntax+RegexLiterals.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation
import RegexBuilder

extension Markdown.Syntax {

  /// Reminder:
  /// `*` = Preceeding character zero or more times
  /// `+` = Preceeding character one or more times
  public var pattern: Regex<AnyRegexOutput>? {

    switch self {

      // MARK: - Single

      case .horizontalRule:
        return Regex(/\n---+?/)
          .anchorsMatchLineEndings()
          .ignoresCase()

      // MARK: - Wrap
      case .italic:
        return Regex(
          #/
          (?<leading>(?:\*{1}|_{1}))
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<trailing>\k<leading>)
          /#
        )

      case .bold:
        return Regex(
          #/
          (?<leading>(?:\*{2}|_{2}))
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<trailing>\k<leading>)
          /#
        )

      case .boldItalic:
        return Regex(
          #/
          (?<leading>(?:\*{3}|_{3}))
          (?<content>[^\*_ \n][^\n]*?[^\*_ \n])
          (?<trailing>\k<leading>)
          /#
        )
      case .inlineCode:
        return Regex(
          #/
          (?<leading>`)
          (?<content>(?:[^`\n])+?)
          (?<trailing>\k<leading>)
          /#
        )

      case .strikethrough:
        return Regex(
          #/
          (?<syntaxLeadingPrimary>(?:\~{2}))
          (?<content>[^~ \n][^\n]*?[^~ \n])
          (?<trailing>\k<syntaxLeadingPrimary>)
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

      // MARK: - Prefix
      case .heading:
        ///
        return Regex(
          #/
          ^[\s]{0,3}
          (?<prefix>\#{1,6})
          (?![\#])[\s\t]+
          (?<content>.+?)
          (?:[\s\t]+\#+)?$
          /#
        )
        .anchorsMatchLineEndings()

      // MARK: - Code Block
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

      // MARK: - Link/Image

      case .image, .link:
        return Regex(
          #/
          (?<exclamation>!?)
          (?<leading>\[)
          (?<label>[^\]\n]+)
          (?<trailing>\])
          (?<leadingSecondary>\()
          (?<url>[^\)\n]+)
          (?<trailingSecondary>\))
          /#
        )

      // MARK: - Callout

      case .callout: return nil

      case .list: return nil
      case .quoteBlock: return nil

    }
  }
}
