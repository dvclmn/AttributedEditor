//
//  HighlightColours.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import ColourKit

extension Markdown.Theme {
  public enum HighlightColours: String {
    case blue
    case purple
    case orange
    case yellow
    case green
    case red
  }
}
extension Markdown.Theme.HighlightColours {
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
