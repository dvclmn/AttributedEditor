//
//  Theme+Resolver.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

import CoreTools
import EditorCore
import Foundation

struct ThemeResolver {

  let theme: MarkdownTheme

  func resolveStyleToken(for run: HighlightRun) -> ResolvedRun {
    let semanticToken = theme.styleToken(
      kind: run.semanticKind,
      role: run.role
    )

    let token = semanticToken ?? theme.defaultToken(for: run.role)

    let attrs = theme.textAttributes(for: token)

    let resolved = ResolvedRun(
      range: run.range,
      attributes: attrs,
      background: token.background
    )

    return resolved
  }

}

struct ResolvedRun {
  let range: Range<String.Index>
  let attributes: TextAttributes
  let background: StyleToken.BackgroundStyle?
}
