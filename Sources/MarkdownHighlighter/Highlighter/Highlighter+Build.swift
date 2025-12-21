//
//  Syntax+Thingy.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import CoreTools
import Foundation
import HighlighterCommon

struct StyleLibrary {
  let text: String
  let theme: Markdown.Theme
//  let theme: any Highlighter.Theme
  let attributes: TextAttributes
  
  init(
    text: String,
    theme: Markdown.Theme,
    attributes: TextAttributes
  ) {
    self.text = text
    self.theme = theme
    self.attributes = attributes
  }
  
  static var initial: StyleLibrary {
    .init(
      text: "",
      theme: .default,
      attributes: [:]
    )
  }
}

extension StyleLibrary {
  var activeSyntax: [Markdown.Syntax] {
    [
      //      /// 📣 Important: This ordering matters:
      //      /// 1: `italic`
      //      /// 2: `bold`
      //      /// 3: `boldItalic`
      .inlineCode
    ]
  }
  var rules: [Markdown.SyntaxRule] {
    activeSyntax.compactMap(\.regexRule)
  }
  
  

//}
  
  func buildForSyntax(_ syntax: Markdown.Syntax) -> NSAttributedRanges {
    
    /// Not all of these may be needed
    let syntaxToken = theme.style(for: syntax, part: .syntax)
    let contentToken = theme.style(for: syntax, part: .content)
    let metaToken = theme.style(for: syntax, part: .meta)
    
    let syntaxTraits = syntaxToken.fontTraits ?? []
    let contentTraits = contentToken.fontTraits ?? []
    
  }

//extension MarkdownHighlighter {
  func buildStyledRanges(
    _ rule: Markdown.SyntaxRule,
    //    _ shape: RegexShape,
    text: String,
  ) -> NSAttributedRanges {
    //  ) -> (NSAttributedRanges, NSBlockRanges) {
    
    var attrs: NSAttributedRanges = []
    var blocks: NSBlockRanges = []
    
    
    
    return attrs
  }
  
  func token(for syntax: part: )
  
//    return (attrs, blocks)
    //    switch shape {
    //      case .wrap(let rule):
    //        for match in text.matches(of: rule.pattern) {
    //          rule.apply(
    //            match: match,
    //            theme: theme,
    //            attrs: &attrs
    //          )
    //          if rule.syntax.drawsBackground {
    //            blocks.append(from: match, in: text)
    ////            blocks.appendOptional(match.nsRange(in: text))
    ////            blocks.append(match.range.toNSRange(in: text))
    //          }
    //        }
    //
    //      case .prefix(let rule):
    //        for match in text.matches(of: rule.pattern) {
    //          rule.apply(
    //            match: match,
    //            theme: theme,
    //            attrs: &attrs
    //          )
    //          if rule.syntax.drawsBackground {
    //            blocks.append(from: match, in: text)
    ////            blocks.append(match.range)
    //          }
    //        }
    //
    //      case .single(let rule):
    //        for match in text.matches(of: rule.pattern) {
    //          rule.apply(
    //            match: match,
    //            theme: theme,
    //            attrs: &attrs
    //          )
    //          if rule.syntax.drawsBackground {
    //            blocks.append(from: match, in: text)
    ////            blocks.append(match.range)
    //          }
    //        }
    //
    //      case .codeBlock(let rule):
    //        for match in text.matches(of: rule.pattern) {
    //          rule.apply(
    //            match: match,
    //            theme: theme,
    //            attrs: &attrs
    //          )
    //          if rule.syntax.drawsBackground {
    //            blocks.append(from: match, in: text)
    ////            blocks.append(match.range)
    //          }
    //        }
    //
    //      case .wrapPair(let rule):
    //        for match in text.matches(of: rule.pattern) {
    //          rule.apply(
    //            match: match,
    //            theme: theme,
    //            attrs: &attrs
    //          )
    //          if rule.syntax.drawsBackground {
    //            blocks.append(from: match, in: text)
    ////            blocks.append(match.range)
    //          }
    //        }
    //    }  // END switch
    //    return (attrs, blocks)
//  }
}
