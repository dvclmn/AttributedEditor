//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools

public typealias AttributedRanges = [AttributedRun]
public typealias BlockRanges = [Range<String.Index>]
public typealias AttributedNSRanges = [(
  range: NSRange,
  attributes: TextAttributes
)]

public struct AttributedRun {
  public let tag: String? // For debugging
  public let range: Range<String.Index>
  public var attributes: TextAttributes

  public init(
    tag: String?,
    range: Range<String.Index>,
    attributes: TextAttributes
  ) {
    self.tag = tag
    self.range = range
    self.attributes = attributes
  }
}

extension AttributedRanges {

  public func toNSRanges(
    in text: String
  ) -> AttributedNSRanges {
    self.compactMap { run in
      guard let range = run.range.toNSRange(in: text) else {
        print("Error getting NSRange?")
        return nil
      }
      let attributes = run.attributes
      return (range, attributes)
    }
  }

  /// `Attribute` is a small type safe wrapper
  /// around `NSAttributedString.Key`
  public mutating func update(
    _ attribute: Attribute?,
    in range: Range<String.Index>,
    tag: String?
  ) {
    guard let attribute else { return }

    /// If an existing run matches exactly, update it.
    if let index = self.firstIndex(where: { $0.range == range }) {
      attribute.update(&self[index].attributes)
    }

    /// Otherwise, append a new run.
    let new = AttributedRun(
      tag: tag,
      range: range,
      attributes: attribute.attribute
    )
    self.append(new)

  }
}
