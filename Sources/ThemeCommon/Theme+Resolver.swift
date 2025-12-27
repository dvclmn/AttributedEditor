//
//  Theme+Resolver.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

import Foundation
import HighlighterCommon
import CoreTools

struct ThemeResolver {

  let theme: any Highlighter.Theme

  func resolveStyleToken(for run: HighlightRun) -> ResolvedRun {
//  func resolveStyleToken(for run: HighlightRun) -> StyleToken {
    //    if let token = theme.styleToken(
    //      syntaxID: run.syntaxID,
    //      role: run.role
    //    ) {
    //      return token
    //    }

    let semanticToken = theme.styleToken(
      kind: run.semanticKind,
      role: run.role
    )
    
    let token = semanticToken ?? theme.defaultToken(for: run.role)
    
    let attrs = theme.textAttributes(for: token)
    
    let resolved = ResolvedRun(
      range: run.range,
      attributes: attrs,
//      attributes: TextAttributes.init(for: token),
      background: token.background
    )
    
    return resolved
//    if let token = theme.styleToken(
//      kind: run.semanticKind,
//      role: run.role
//    ) {
//      styleToken = token
////      return token
//    }

//    return theme.defaultToken(for: run.role)
  }

  //  func resolveStyleToken(
  //    _ run: HighlightRun
  //  ) -> ResolvedRun {
  //    let token = theme.styleToken(
  //      for: run.syntaxID,
  //      role: run.role
  //    )
  //
  //    let attributes = TextAttributes.from(token)
  //
  //    return ResolvedRun(
  //      range: run.range,
  //      attributes: attributes,
  //      background: token.background
  //    )
  //  }
}

struct ResolvedRun {
  let range: Range<String.Index>
  let attributes: TextAttributes
  let background: StyleToken.BackgroundStyle?
}
