//
//  Theme+Resolver.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

import CoreTools
import EditorCore
import Foundation

package struct ThemeResolver {

  package let theme: MarkdownTheme

  package init(_ theme: MarkdownTheme) {
    self.theme = theme
  }

  package func resolveStyleToken(for run: SyntaxRun) -> ResolvedRun {
    let semanticToken = theme.styleToken(
      syntax: run.syntax,
      //      kind: run.semanticKind,
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

package struct ResolvedRun {
  package let range: Range<String.Index>
  package let attributes: TextAttributes
  package let background: StyleToken.BackgroundStyle?
}
