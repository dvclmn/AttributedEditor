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

  /// Colour for the `==` syntax characters
  public var syntax: CodableColour {
    CodableColour.mix(contrastColour, .gray, 0.3, opacity: 0.3)
  }
  
  /// The highlighted text content
  public var content: CodableColour {
    CodableColour.system(contrastColour)
  }
  
  /// Text background colour
  public var colourBG: CodableColour {
    CodableColour.system(colourMain, opacity: 0.2)
  }

  public var colourMain: SystemColour {
    SystemColour(rawValue: rawValue) ?? .primary
  }
  public var contrastColour: SystemColour {
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
