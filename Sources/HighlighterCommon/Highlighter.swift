//
//  SourceEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import SwiftUI

public enum Highlighter {}

extension Highlighter {
  /// Protocol defining how text should be analyzed and highlighted
  public protocol Core: AnyObject {
    associatedtype HighlighterTheme: Theme

    /// Thinking that block ranges can be expressed within `NSAttributedRanges`,
    /// by using the `blockIntent` `AttributeKey`
//    var blockRanges: NSBlockRanges { get set }
    var theme: HighlighterTheme { get set }

    func buildStyles(in text: String, with font: NSFont) -> NSAttributedRanges

    func drawBlockPath(in rect: CGRect) -> NSBezierPath
    func updateTheme(_ theme: HighlighterTheme)
  }
}

extension Highlighter.Core {


  public func updateTheme(_ theme: HighlighterTheme) {
    self.theme = theme
  }

  public func drawBlockPath(
    in rect: CGRect,
  ) -> NSBezierPath {
    /// Add padding around the text
    let paddedRect = rect.insetBy(dx: -5, dy: -4).offsetBy(dx: 0, dy: 16)

    /// Create a rounded rectangle path
    let path = NSBezierPath(
      roundedRect: paddedRect,
      xRadius: 4,
      yRadius: 4
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
}
