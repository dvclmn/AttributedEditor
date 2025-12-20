//
//  Theme.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/12/2025.
//

import AppKit

extension Highlighter {
  public protocol Theme: AnyObject {
    /// Base font
    var font: NSFont { get set }
    
    /// Default text/base colour
    var textColour: NSColor { get }
    
    func updateFont(with newFont: NSFont)
  }
  
}

extension Highlighter.Theme {
//  public var font: NSFont { NSFont.systemFont(ofSize: 14) }
  public var textColour: NSColor { .textColor }
  public func updateFont(with newFont: NSFont) {
    self.font = newFont
  }
}
