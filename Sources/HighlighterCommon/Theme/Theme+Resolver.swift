//
//  Theme+Resolver.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

struct ThemeResolver {
  
  let theme: any Highlighter.Theme
  
  func resolve(
    _ run: HighlightRun
  ) -> ResolvedRun {
    let token = theme.styleToken(
      for: run.syntaxID,
      role: run.role
    )
    
    let attributes = TextAttributes.from(token)
    
    return ResolvedRun(
      range: run.range,
      attributes: attributes,
      background: token.background
    )
  }
}
