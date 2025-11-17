//
//  Font+Config.swift
//  SwiftDown
//
//  Created by Dave Coleman on 26/2/2025.
//

import NSUI

//public enum FontDescriptor: Sendable {
//  case system(weight: NSUIFont.Weight, design: NSUIFontDescriptor.SystemDesign)
//  case named(String)
//
//  static let `default` = FontDescriptor.system(
//    weight: .regular,
//    design: .default
//  )
//}
//
//public struct FontConfig: Sendable {
//  public let size: CGFloat
//  public let descriptor: FontDescriptor
//  public let traits: NSUIFontDescriptor.SymbolicTraits
//
//  public init(
//    size: CGFloat,
//    descriptor: FontDescriptor,
//    traits: NSUIFontDescriptor.SymbolicTraits = []
//  ) {
//    self.size = size
//    self.descriptor = descriptor
//    self.traits = traits
//  }
//
//  /// Use functions that return new instances instead of mutating
//  public func withSize(_ newSize: CGFloat) -> FontConfig {
//    return FontConfig(size: newSize, descriptor: descriptor, traits: traits)
//  }
//  
////  public mutating func setSize(_ newSize: CGFloat) {
////    size = newSize
////  }
//
//  public func withWeight(_ newWeight: NSUIFont.Weight) -> FontConfig {
//    switch descriptor {
//      case .system(_, let design):
//        return FontConfig(
//          size: size,
//          descriptor: .system(weight: newWeight, design: design),
//          traits: traits
//        )
//      case .named:
//        // Return self for named fonts since we can't change the weight
//        return self
//    }
//  }
//  
//  public func withTraits(_ newTraits: NSUIFontDescriptor.SymbolicTraits) -> FontConfig {
//    return FontConfig(size: size, descriptor: descriptor, traits: newTraits)
//  }
////  public mutating func setWeight(_ newWeight: NSUIFont.Weight) {
////    /// Preserve the current descriptor type and other properties
////    switch descriptor {
////      case .system(_, let design):
////        descriptor = .system(weight: newWeight, design: design)
////
////      case .named(let name):
////        /// Need to find a better solution for this
////        print("Warning: Cannot set weight for named font '\(name)'. Weight changes only apply to system fonts.")
////    }
////  }
//
//  public static func system(
//    size: CGFloat,
//    weight: NSUIFont.Weight = .regular,
//    design: NSUIFontDescriptor.SystemDesign = .default,
//    traits: NSUIFontDescriptor.SymbolicTraits = []
//  ) -> Self {
//    Self(
//      size: size,
//      descriptor: .system(weight: weight, design: design),
//      traits: traits
//    )
//  }
//
//  public static func custom(
//    name: String,
//    size: CGFloat,
//    traits: NSUIFontDescriptor.SymbolicTraits = []
//  ) -> Self {
//    Self(
//      size: size,
//      descriptor: .named(name),
//      traits: traits
//    )
//  }
//
//  public static func systemBold(
//    withSize size: CGFloat
//  ) -> Self {
//    Self(
//      size: size,
//      descriptor: .default,
//      traits: []
//    )
//  }
//}
//
//extension FontConfig {
//  public func resolvedFont() -> NSUIFont? {
//    switch descriptor {
//      case .system(let weight, let design):
//        let baseFont = NSUIFont.systemFont(ofSize: size, weight: weight)
//        let descriptor = buildDescriptor(baseFont: baseFont, design: design)
//        return NSUIFont(descriptor: descriptor, size: size)
//
//      case .named(let name):
//        guard let baseFont = NSUIFont(name: name, size: size) else {
//          return nil
//        }
//        let descriptor = buildDescriptor(baseFont: baseFont)
//        return NSUIFont(descriptor: descriptor, size: size)
//    }
//  }
//
//  private func buildDescriptor(
//    baseFont: NSUIFont,
//    design: NSUIFontDescriptor.SystemDesign? = nil
//  ) -> NSUIFontDescriptor {
//
//    var descriptor = baseFont.fontDescriptor
//
//    if let design, let designDescriptor = descriptor.withDesign(design) {
//      descriptor = designDescriptor
//    }
//
//    let existingTraits = descriptor.symbolicTraits
//    let combinedTraits = existingTraits.union(traits)
//    descriptor = descriptor.nsuiWithSymbolicTraits(combinedTraits) ?? NSUIFontDescriptor()
////    descriptor = descriptor.withSymbolicTraits(combinedTraits) ?? NSUIFontDescriptor()
//    return descriptor
//  }
//}
//
//
