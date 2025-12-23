//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import HighlighterCommon

extension RegexShape.Fragment {
  
  var styleRole: Markdown.StyleRole {
    switch self {
      case .content, .single: .content
      case .syntaxStart, .syntaxEnd: .syntax
      case .languageHint, .url, .prefix: .metadata
    }
  }
  
}

extension Markdown {
  public typealias Components = [Syntax: [RegexShape.Fragment]?]
  public struct Component {
    let syntax: Syntax
    let fragments: [RegexShape.Fragment]

    public init(_ syntax: Syntax, fragments: [RegexShape.Fragment]) {
      self.syntax = syntax
      self.fragments = fragments
    }
  }

}

extension Markdown.Syntax {
  //extension Markdown.Component {

  //  static let components: Markdown.Components = [
  //    .
  //  ]
  //  static let bold: Self = .init(.body, fragments: .)

  //  static var components: [Component] {
  ////  static var components: Components {
  //    [
  //
  //    ]
  var fragments: [RegexShape.Fragment]? {

    switch self {

      /// ``RegexShape/Prefix``
      case .heading1,
        .heading2,
        .heading3,
        .heading4,
        .heading5,
        .heading6,
        .quoteBlock,
        .list:
        RegexShape.Fragment.prefixShape

      /// ``RegexShape/Wrap``
      case .bold,
        .italic,
        .boldItalic,
        .inlineCode,
        .strikethrough,
        .highlight:
        RegexShape.Fragment.wrapShape

      case .codeBlock:
        RegexShape.Fragment.codeBlockShape

      case .horizontalRule:
        RegexShape.Fragment.singleShape

      case .callout, .body, .link, .image: nil  // Haven't thought this through yet
    }
  }
}

extension Markdown.Syntax {

  //  public var shapes: [RegexShape: [RegexShape.Fragment]]? {
  //
  //  }

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
