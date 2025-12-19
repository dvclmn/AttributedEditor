//
//  Syntax+BoldItalic.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension Markdown.SyntaxRule where T == RegexShape.Wrap {
  static var bold: Self {

    let pattern = /(?<leading>(?:\*{2}|_{2}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/

    return SyntaxRule(for: .bold, pattern: pattern)
  }

  static var italic: Self {

    let pattern =
      /(?<leading>[\*_])(?<content>[^\*_ \n][^\n]*?[^\*_ \n])(?<trailing>\k<leading>)/

    return SyntaxRule(for: .italic, pattern: pattern)
  }

  static var boldItalic: Self {

    let pattern = /(?<leading>(?:\*{3}|_{3}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/

    return SyntaxRule(for: .boldItalic, pattern: pattern)
  }
}
