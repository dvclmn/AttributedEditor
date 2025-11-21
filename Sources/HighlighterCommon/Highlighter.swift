//
//  SourceEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import SwiftUI

/// Protocol defining how text should be analyzed and highlighted
public protocol Highlighter {

  //  var editorConfig: Editor.Configuration { get }
  var blockRanges: BlockRanges { get set }
  func buildStyles(in text: String) -> AttributedRanges
//  func buildStyles(in text: String) -> MarkdownStyles

  /// Return ranges that should have custom background rendering
  //  func blockRanges(text: String) -> [NSRange]
  func drawBlockPath(in rect: CGRect) -> NSBezierPath
}

extension Highlighter {
  public func drawBlockPath(
    in rect: CGRect,
  ) -> NSBezierPath {
    /// Add padding around the text
    let paddedRect = rect.insetBy(dx: -5, dy: -4).offsetBy(dx: 0, dy: -3)

    /// Create a rounded rectangle path
    let path = NSBezierPath(
      roundedRect: paddedRect,
      xRadius: 6,
      yRadius: 6
    )

    /// Fill with a subtle background color
    /// Note: `setFill()` and `setStrok()` set the fill and stroke color
    /// in the current graphics context. They "prepare" the context for drawing,
    /// but don't themselves draw anything yet. It's the `path.fill()` and
    /// `path.stroke()` that actually render the shape onto the view.
    NSColor.controlBackgroundColor.opacity(0.5).setFill()
    NSColor.separatorColor.setStroke()
    path.lineWidth = 1
    return path
  }

  //  /// Default implementation returns no block ranges
  //  public func blockRanges(text: String) -> [NSRange] {
  //    return []
  //  }
}
