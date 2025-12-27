//
//  Highlightable.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/12/2025.
//

import AppKit
import MarkdownHighlighter

public protocol Highlightable: NSTextView {
  /// Does this need to be updatable? Mutable?
  var highlighter: MarkdownHighlighter? { get set }
//  func drawBlocks()

  /// This updates the highlighter instance on `BackingTextView`,
  /// which includes any new block ranges
  /// Edit: Not sure if this is still neccesary, retiring at least for now
//  func updateHighlighter(with updated: any Highlighter.Core)

  /// For now, this 'hides' the replacement with `setTemporaryAttributes`,
  /// making the characters `.clear`. May adjust in future?
  ///
  /// Will need to work out how to return something that provides a suitable
  /// glyph range as reference point for drawing over the hidden characters
//  func drawReplacement()
  //  func drawReplacement(replace string: String)
}
