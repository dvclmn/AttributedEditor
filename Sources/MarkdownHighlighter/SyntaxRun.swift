//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools

public typealias MarkdownRuns = [SyntaxRun]

/// No colours, fonts, background, attrs
/// This is the output of the Highlighter.
public struct SyntaxRun {
  public let syntax: Markdown.Syntax
  public let role: StyleRole
  public let range: Range<String.Index>

}
