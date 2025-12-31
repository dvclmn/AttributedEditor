//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import RegexBuilder

extension Markdown.Syntax {

  var fragments: [Fragment]? {
    switch regexShape {
      case .wrap: [.syntaxLeading, .content, .syntaxTrailing]
      case .prefix: [.prefix, .content]
      case .single: [.single]
      case .codeBlock: [.syntaxLeading, .languageHint, .content, .syntaxTrailing]
      case .link: fatalError("Not yet implemented")
      default: nil
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
        .link

      case .horizontalRule:
        .single

      case .list, .callout:
        nil
    }
  }

}

extension RegexShape {

  /// One or more characters that are valid for this syntax.
  /// This is an array to allow some syntaxes such as `italic`
  /// to declare alternative characters, like `*` and `_`
  //  func wrapCharacters(for syntax: Markdown.Syntax) -> [Repeat<Substring>] {
  //    let boldItalicPreset: [Character] = ["*", "_"]
  //    let structure: ([Character], Int) =
  //      switch syntax {
  //        case .bold: (boldItalicPreset, 2)
  //        case .italic: (boldItalicPreset, 1)
  //        case .boldItalic: (boldItalicPreset, 3)
  //        case .inlineCode: (["`"], 1)
  //        case .strikethrough: (["~"], 2)
  //        case .highlight: (["="], 2)
  //        default: fatalError("Markdown Syntax \(syntax.name) is not compatible with RegexShape \(self.name).")
  //      //      case .heading1:
  //      //      case .heading2:
  //      //      case .heading3:
  //      //      case .heading4:
  //      //      case .heading5:
  //      //      case .heading6:
  //      //      case .bold:
  //      //      case .italic:
  //      //      case .boldItalic:
  //      //      case .inlineCode:
  //      //      case .codeBlock:
  //      //      case .list:
  //      //      case .quoteBlock:
  //      //      case .callout:
  //      //      case .strikethrough:
  //      //      case .highlight:
  //      //      case .link:
  //      //      case .image:
  //      //      case .horizontalRule:
  //      }
  //    let result = structure.0.map { Repeat($0, count: structure.1) }
  //    return result
  //  }

  //  func prefixCharacters(for syntax: Markdown.Syntax) -> [Repeat<Substring>] {
  //  }
}

extension Markdown.Syntax {

  //  func buildWrapRegex() -> some RegexComponent {
  //    precondition(self.regexShape == .wrap, "Must be a wrap syntax to build a wrap regex")
  //
  //    /// `(?:…)` = Non-capturing group
  //    /// `{2}` = Match two of the preceeding token
  //    let leading = Reference(Substring.self)
  //    let content = Reference(Substring.self)
  //    let trailing = Reference(Substring.self)
  //
  //    let thing = RegexShape.wrap.wrapCharacters(for: self)
  //    let syntax = ChoiceOf {
  //
  ////      Repeat("*", count: 2)
  //    case .bold: (boldItalicPreset, 2)
  //    case .italic: (boldItalicPreset, 1)
  //    case .boldItalic: (boldItalicPreset, 3)
  //    case .inlineCode: (["`"], 1)
  //    case .strikethrough: (["~"], 2)
  //    case .highlight: (["="], 2)
  //    }
  ////      let thing = RegexShape.wrap.wrapCharacters(for: self)
  ////      return thing
  //////      Repeat("_", count: 2)
  ////    }
  //
  //    return Regex(
  //      Regex {
  //
  //        Capture(as: leading) { syntax }
  //        Capture(as: content) {
  //          OneOrMore(.anyNonNewline.subtracting(.anyOf("*_")), .reluctant)
  //        }
  //        Capture(as: trailing) { syntax }
  //
  //      }
  //    )
  //  }
}
