//
//  Theme+Resolver.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

import CoreTools
import Foundation

package struct ThemeResolver {

  let theme: MarkdownTheme

  init(_ theme: MarkdownTheme) {
    self.theme = theme
  }

  func resolveToken(for run: SyntaxRun) -> ResolvedRun {
    let token = theme.styleToken(
      for: run.syntax,
      role: run.role
    )

    let attrs = theme.textAttributes(for: token)

    return ResolvedRun(
      range: run.range,
      attributes: attrs,
    )
  }
}

package struct ResolvedRun {
  package let range: Range<String.Index>
  package let attributes: TextAttributes
}
