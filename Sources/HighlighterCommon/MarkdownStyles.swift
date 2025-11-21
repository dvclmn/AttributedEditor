//
//  MarkdownStyles.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import CoreTools

public struct MarkdownStyles {
  /// For styling text
  let attributes: AttributedRanges
  
  /// For drawing backgrounds
  let blocks: [Range<String.Index>]
  
  public init(attributes: AttributedRanges, blocks: [Range<String.Index>]) {
    self.attributes = attributes
    self.blocks = blocks
  }
}

extension MarkdownStyles: CustomStringConvertible {
  public var description: String {
    DisplayString {
      Indented("Text Attributes") {
        Labeled("Count", value: attributes.count)
        Labeled("Count", value: attributes.count)
        
        Indented("Attributes") {
          for attr in attributes {
            let dictString = attr.attributes.map { (key, value) in
              let keyString = key.rawValue.components(separatedBy: " ").joined("7")
              let valueString = String(describing: value)
              return "\(keyString):\(valueString)"
            }.joined(":")
            Labeled("Tag", value: "\(attr.tag, default: "none")")
            Labeled("Desc.", value: "\(dictString)")
            Divider()
          }
        }
      }
    }.plainText
  } // END description
}
