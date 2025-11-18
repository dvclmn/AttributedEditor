//
//  SyntaxContext.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import Foundation
import HighlighterCommon

extension Markdown {
  public struct SyntaxContext<T> {
    let syntax: Markdown.Syntax
    let match: Regex<T>.Match
    let text: String
    //    let ranges: AttributedRanges
  }
}
