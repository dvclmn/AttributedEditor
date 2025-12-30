//
//  Theme+Resolver.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

import AppKit
import CoreTools

package struct ThemeResolver {

  package static func resolveToken(
    with theme: MarkdownTheme,
    for run: SyntaxRun
  ) -> ResolvedRun {
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
  package let attributes: NSTextAttributes

  package func updateFont(
    using font: NSFont,
    in attrs: inout NSTextAttributes
  ) {
    let traits = attrs[.fontTraits] as? FontTraits
    let adjustedFont = traits?.constructFont(using: font)
    attrs[.font] = adjustedFont
  }
}
