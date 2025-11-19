//
//  Shape+Single.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import HighlighterCommon

extension SyntaxRule where T == RegexShape.Single {

  func apply(
    match: Regex<T>.Match,
    theme: Markdown.Theme,
    attrs: inout AttributedRanges
  ) {
    
    precondition(syntax.regexShape == .single, "Only syntaxes with RegexShape of .wrap are valid here.")
    
    let range = match.range
    //      let font = NSFont.system(.body, size: fontSize * 0.97, monospaced: true)

    attrs.update(.foreground(.systemPink), in: range)
    
//    attrs.update(
//      .foregroundColor,
//      with: ThemeColour.reddish, in: range)

  }

}
