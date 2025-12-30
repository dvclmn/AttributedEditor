//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import RegexBuilder

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
      case .heading1: return nil
      case .heading2: return nil
      case .heading3: return nil
      case .heading4: return nil
      case .heading5: return nil
      case .heading6: return nil
      case .bold:

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

extension Markdown {
  
  struct Pattern {
    let characters: CharacterClass
    let count: Int
  }
}
extension Markdown.Pattern {
  init(_ characters: Character..., count: Int = 1) {
    precondition(!characters.isEmpty, "Must provide at least one character")
    if characters.count == 1, let first = characters.first {
      self.init(characters: .anyOf(<#T##s: Sequence##Sequence#>), count: <#T##Int#>)
    } else {
      
    }
    guard let first = characters.first else
    self.init(
      characters: CharacterClass(characters.toString),
      count: count
    )
  }
}

extension RegexShape {
  func characters(for syntax: Markdown.Syntax) -> Markdown.Pattern {
    switch syntax {
      case .bold: .init("*", count: 2)
      case .italic: .init("*", count: 1)
      case .boldItalic: .init("*", count: 2)
      case .inlineCode: .init("*", count: 2)
      case .strikethrough: .init("*", count: 2)
      case .highlight: .init("*", count: 2)
//      case .heading1:
//      case .heading2:
//      case .heading3:
//      case .heading4:
//      case .heading5:
//      case .heading6:
//      case .bold:
//      case .italic:
//      case .boldItalic:
//      case .inlineCode:
//      case .codeBlock:
//      case .list:
//      case .quoteBlock:
//      case .callout:
//      case .strikethrough:
//      case .highlight:
//      case .link:
//      case .image:
//      case .horizontalRule:
    }
  }
}

extension Markdown.Syntax {
  
  
  
  private func buildWrapRegex() -> some RegexComponent {
    
    /// `(?:…)` = Non-capturing group
    /// `{2}` = Match two of the preceeding token
    let leading = Reference(Substring.self)
    let content = Reference(Substring.self)
    let trailing = Reference(Substring.self)
    
    let syntax = ChoiceOf {
      Repeat("*", count: 2)
      Repeat("_", count: 2)
    }
    
    return Regex(
      Regex {
        
        Capture(as: leading) { syntax }
        Capture(as: content) {
          OneOrMore(.anyNonNewline.subtracting(.anyOf("*_")), .reluctant)
        }
        Capture(as: trailing) { syntax }
        
      }
    )
  }
}
