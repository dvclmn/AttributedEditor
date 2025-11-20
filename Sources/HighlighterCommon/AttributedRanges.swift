//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools

public typealias AttributedRanges = [AttributedRun]

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

public struct AttributedRun {
  public let range: Range<String.Index>
  public var attributes: TextAttributes
  
  public init(
    range: Range<String.Index>,
    attributes: TextAttributes
  ) {
    self.range = range
    self.attributes = attributes
  }
}

extension AttributedRanges {
  
  /// Type-safe version
  public mutating func update(
    _ attribute: Attribute?,
    in range: Range<String.Index>
  ) {
    guard let attribute else {
      print("No Attribute supplied, exiting early.")
      return
    }
    /// If an existing run matches exactly, update it.
    if let index = self.firstIndex(where: { $0.range == range }) {
      attribute.update(&self[index].attributes)
    }
    
    /// Otherwise, append a new run.
    let new = AttributedRun(range: range, attributes: attribute.attribute)
    self.append(new)

  }
}
