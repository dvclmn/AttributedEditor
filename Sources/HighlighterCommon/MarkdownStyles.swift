//
//  MarkdownStyles.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import CoreTools

public struct MarkdownStyles {
  /// For styling text
  var attributes: AttributedRanges

  /// For drawing backgrounds
  var blocks: BlockRanges

  public init(
    attributes: AttributedRanges,
    blocks: BlockRanges
  ) {
    self.attributes = attributes
    self.blocks = blocks
  }
}
extension MarkdownStyles {
  public mutating func add(attributes newAttr: AttributedRanges) {
    self.attributes += newAttr
  }

  public mutating func add(blocks newBlocks: BlockRanges) {
    self.blocks += newBlocks
  }
  //  mutating func updateAttributes(with new: AttributedRanges) {
  ////    new.update(<#T##attribute: Attribute?##Attribute?#>, in: <#T##Range<String.Index>#>, tag: <#T##String?#>)
  //  }
}

extension AttributedRanges {

  public func toNSRanges(
    in text: String
  ) -> AttributedNSRanges {
    self.map { run in
      let range = run.range.toNSRange(in: text)
      let attributes = run.attributes
      return (range, attributes)
    }
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
  }  // END description
}
