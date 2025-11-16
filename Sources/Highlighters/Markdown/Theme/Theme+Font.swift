//
//  Theme+Font.swift
//  SwiftDown
//
//  Created by Dave Coleman on 26/2/2025.
//

import NSUI

//extension MarkdownTheme.Fonts {
//  public subscript(type: Markdown.Syntax) -> FontConfig {
//    get { fonts[type] ?? .system(size: 14) }
//    set { fonts[type] = newValue }
//  }
//
////  public func with(_ type: Markdown.Syntax, size: CGFloat) -> Self {
////    var copy = self
////    var fontConfig = copy[type]
////    fontConfig.setSize(size)
////    copy[type] = fontConfig
////    return copy
////  }
////  
////  public func with(_ type: Markdown.Syntax, weight: NSUIFont.Weight) -> Self {
////    var copy = self
////    var fontConfig = copy[type]
////    fontConfig.setWeight(weight)
////    copy[type] = fontConfig
////    return copy
////  }
//  
//  // Immutable approach using withSize instead of setSize
//  public func with(_ type: Markdown.Syntax, size: CGFloat) -> Self {
//    var copy = self
//    let currentConfig = copy[type]
//    copy[type] = currentConfig.withSize(size)
//    return copy
//  }
//  
//  // Additional helper for weight
//  public func with(_ type: Markdown.Syntax, weight: NSUIFont.Weight) -> Self {
//    var copy = self
//    let currentConfig = copy[type]
//    copy[type] = currentConfig.withWeight(weight)
//    return copy
//  }
//  
//  // Helper for traits
//  public func with(_ type: Markdown.Syntax, traits: NSUIFontDescriptor.SymbolicTraits) -> Self {
//    var copy = self
//    let currentConfig = copy[type]
//    copy[type] = currentConfig.withTraits(traits)
//    return copy
//  }
//  
//  // Combined helper for multiple attributes
//  public func with(
//    _ type: Markdown.Syntax,
//    size: CGFloat? = nil,
//    weight: NSUIFont.Weight? = nil,
//    traits: NSUIFontDescriptor.SymbolicTraits? = nil
//  ) -> Self {
//    var copy = self
//    var currentConfig = copy[type]
//    
//    if let size = size {
//      currentConfig = currentConfig.withSize(size)
//    }
//    
//    if let weight = weight {
//      currentConfig = currentConfig.withWeight(weight)
//    }
//    
//    if let traits = traits {
//      currentConfig = currentConfig.withTraits(traits)
//    }
//    
//    copy[type] = currentConfig
//    return copy
//  }
//}
//
//
//
