//
//  StaticText.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2025.
//

import SwiftUI

public typealias StyledRanges = [Markdown.Syntax: [Range<AttributedString.Index>]]

public struct MarkdownRanges {
  public var ranges: StyledRanges
  public var text: AttributedString
  public init(
    ranges: StyledRanges,
    text: AttributedString
  ) {
    self.ranges = ranges
    self.text = text
  }
}

//struct MarkdownRanges {
//  let all: NSRange
//  let leading: NSRange
//  let content: NSRange
//  let trailing: NSRange
//}


//public func styleMarkdownText(theme: MarkdownTheme, appHandler: AppHandler) -> AttributedString {
//  // Use the cache
//  let (_, attributedString) = appHandler.getCachedMarkdownRanges(for: self, theme: theme)
//  return attributedString
//}

extension String {
  /// Convenience function to create a styled AttributedString
//  public func styleMarkdownText(
//    theme: MarkdownTheme,
//    ranges: MarkdownRanges
//  ) -> AttributedString {
//
//    let attributedString = ranges.text
//    return attributedString
////    var attributedString = AttributedString(self)
////    attributedString.applyMarkdownTheme(theme)
////    return attributedString
//  }
}

extension AttributedString {
//  mutating func applyMarkdownTheme(_ theme: MarkdownTheme) {
//    /// Create a String copy once - more efficient than repeatedly accessing self.string
//    let stringContent = self.string
//    
//    for type in Markdown.Syntax.allCases {
//      guard let regex = type.regexLiteral else { continue }
//      
//      // Prepare attributes once outside the loop
//      let attributes = AttributeContainer.fromTheme(theme, for: type)
//      
//      // Find all matches
//      let matches = stringContent.matches(of: regex)
//      for match in matches {
//        guard let fullRange = self.range(of: match.output.0) else { continue }
//        self[fullRange].setAttributes(attributes)
//      }
//    }
//  }
//  
//  public mutating func applyMarkdownTheme(_ theme: MarkdownTheme) {
//    
//    /// Create a String copy once - more efficient than repeatedly accessing self.string
//    let stringContent = self.string
//    
//    /// Process each markdown type with its associated regex
//    for type in Markdown.Syntax.allCases {
//      guard let regex = type.regexLiteral else { continue }
//      
//      /// Prepare attributes once outside the loop
//      let attributes = AttributeContainer.fromTheme(theme, for: type)
//      
//      /// Find all matches for this markdown type
//      let matches = stringContent.matches(of: regex)
//      
//      for match in matches {
//        // Get the full match range
//        guard let fullRange = self.range(of: match.output.0) else { continue }
//        
//        // Get the content range (excluding the markdown symbols)
//        //        let contentMatch = match.output.2  // Assuming output.2 is the content capture group
//        //        guard let contentRange = self.range(of: contentMatch) else { continue }
//        
//        // Apply styling to the content only
//        self[fullRange].setAttributes(attributes)
//        
//        // For debugging
//        print("Applied \(type) styling to: \(self[fullRange])")
//      }
//    }
//  }
}

extension AttributeContainer {
  
  public static func fromTheme(_ theme: MarkdownTheme, for type: Markdown.Syntax) -> AttributeContainer {
    var container = AttributeContainer()
    
    /// Add foreground color
    container.foregroundColor = theme.colors[forType: type]
    container.backgroundColor = theme.colors[forType: type, forComponent: .background]
    
    /// Add font if available
    if let fontConfig = theme.fonts.fonts[type] {
      container.font = fontConfig.resolvedFont()
    }
    
    return container
  }
  
  
  
  // Create an AttributeContainer from a MarkdownTheme for a specific markdown type
//  static func fromTheme(
//    _ theme: MarkdownTheme,
//    for type: Markdown.Syntax
//  ) -> AttributeContainer {
//    var container = AttributeContainer()
//    
//    // Apply color
//    container.foregroundColor = Color(theme.colors[type])
//    
//    // Apply font if available
////    if let fontConfig = theme.fonts.fonts[type],
////       let font = fontConfig.resolvedFont()
////    {
////      container.font = Font(font as CTFont)
////    }
//    
//    // Apply additional styling based on markdown type
//    //    switch type {
//    //      case .code:
//    //        // Code blocks typically have a background color
//    //        container.backgroundColor = Color(theme.colors[type]).opacity(0.1)
//    //        container.baselineOffset = 0  // Adjust as needed
//    //      case .quote:
//    //        // Quotes might have italics or other styling
//    ////        container. = true
//    //        // Handle other types as needed
//    //      default:
//    //        break
//    //    }
//    
//    return container
//  }
}

