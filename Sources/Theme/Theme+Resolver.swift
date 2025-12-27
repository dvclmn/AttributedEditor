//
//  Theme+Resolver.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

import Foundation
import HighlighterCommon

struct ThemeResolver {
  
  let theme: any Highlighter.Theme
  
  func resolveStyleToken(for run: HighlightRun) -> StyleToken {
    if let token = theme.styleToken(
      syntaxID: run.syntaxID,
      role: run.role
    ) {
      return token
    }
    
    if let token = theme.styleToken(
      semanticKind: run.semanticKind,
      role: run.role
    ) {
      return token
    }
    
    return theme.defaultToken(for: run.role)
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
