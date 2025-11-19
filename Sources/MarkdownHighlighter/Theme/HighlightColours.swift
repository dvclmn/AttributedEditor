//
//  HighlightColours.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import ColourKit

extension Markdown.Theme {
  public enum HighlightColours: String, Sendable {
    case blue
    case purple
    case orange
    case yellow
    case green
    case red
  }
}
extension Markdown.Theme.HighlightColours {

  public var colourSyntaxChar: CodableColour {
    CodableColour.mix(colourContrast, .gray, 0.3, opacity: 0.3)
    
//    return codable.nsColor(fallback: ThemeColour.syntaxColourFallback).withAlphaComponent(0.3)
  }
  
  public var colourContent: CodableColour {
    CodableColour.system(colourContrast)
//    return codable.nsColor(fallback: ThemeColour.contentColourFallback)
  }
  
  public var colourBG: CodableColour {
    CodableColour.system(colourMain, opacity: 0.2)
//    return codable.nsColor(fallback: ThemeColour.contentColourFallback).withAlphaComponent(0.2)
  }

  
//  public var colourSyntaxChar: NSColor {
//    let codable = CodableColour.mix(colourContrast, .gray, 0.3)
//    
//    return codable.nsColor(fallback: ThemeColour.syntaxColourFallback).withAlphaComponent(0.3)
//  }
//
//  public var colourContent: NSColor {
//    let codable = CodableColour.system(colourContrast)
//    return codable.nsColor(fallback: ThemeColour.contentColourFallback)
//  }
//  
//  public var colourBG: NSColor {
//    let codable = CodableColour.system(colourMain)
//    return codable.nsColor(fallback: ThemeColour.contentColourFallback).withAlphaComponent(0.2)
//  }

  
  public var colourMain: SystemColour {
    SystemColour(rawValue: rawValue) ?? .primary
  }
  public var colourContrast: SystemColour {
    switch self {
      case .blue: .cyan
      case .purple: .mint
      case .orange: .yellow
      case .yellow: .primary
      case .green: .teal
      case .red: .orange
    }
  }
}
