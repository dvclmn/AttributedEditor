//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools

public typealias AttributedRanges = [AttributedRun]
public typealias NSAttributedRanges = [NSAttributedRun]

public typealias BlockRanges = [Range<String.Index>]
public typealias NSBlockRanges = [NSRange]

//public typealias AttributedNSRanges = [(
//  range: NSRange,
//  attributes: TextAttributes
//)]

public struct AttributedRun {
  public let tag: String?  // For debugging
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

public struct NSAttributedRun {
  public let tag: String?  // For debugging
  public let range: NSRange
  public var attributes: TextAttributes

  public init(
    tag: String?,
    range: NSRange,
    attributes: TextAttributes
  ) {
    self.tag = tag
    self.range = range
    self.attributes = attributes
  }
}

extension AttributedRanges {

  public func toNSRanges(
    in text: String,
    tag: String?
  ) -> NSAttributedRanges {
    self.compactMap { run in
      guard let range = run.range.toNSRange(in: text) else {
        print("Error getting NSRange?")
        return nil
      }
      let attributes = run.attributes
      return NSAttributedRun(tag: tag, range: range, attributes: attributes)
      //      return (range, attributes)
    }
  }

  /// `Attribute` is a small type safe wrapper
  /// around `NSAttributedString.Key`
  public mutating func update(
    _ attribute: AttributeKey?,
    in range: Range<String.Index>,
    tag: String?
  ) {
    guard let attribute else { return }

    /// If an existing run matches exactly, update it.
    if let index = self.firstIndex(where: { $0.range == range }) {
      attribute.update(&self[index].attributes)
    } else {
      /// Otherwise, append a new run.
      let new = AttributedRun(
        tag: tag,
        range: range,
        attributes: attribute.attribute
      )
      self.append(new)
    }

  }

}

extension NSAttributedRanges {

  public mutating func update(
    _ attribute: AttributeKey?,
    in range: NSRange,
    tag: String?
  ) {
    guard let attribute else { return }

    /// 1. Ensure the range is valid.
    /// Also check for negative lengths (`NSRange` uses Int in Swift, allowing negatives).
    guard range.location != NSNotFound, range.length >= 0 else {
      assertionFailure("Attempted to update invalid NSRange: \(range)")
      return
    }

    /// 2. Exact Match Check
    if let index = self.firstIndex(where: { $0.range == range }) {
      /// Update the existing item in place
      attribute.update(&self[index].attributes)
    } else {
      /// 3. Append New
      let new = NSAttributedRun(
        tag: tag,
        range: range,
        attributes: attribute.attribute
      )
      self.append(new)
    }
  }
  //  /// `Attribute` is a small type safe wrapper
  //  /// around `NSAttributedString.Key`
  //  public mutating func update(
  //    _ attribute: AttributeKey?,
  //    in range: NSRange,
  ////    in range: Range<String.Index>,
  //    tag: String?
  //  ) {
  //    guard let attribute else { return }
  //
  //    /// If an existing run matches exactly, update it.
  //    if let index = self.firstIndex(where: { $0.range == range }) {
  //      attribute.update(&self[index].attributes)
  //    }
  //
  //    //    let nsRange = range.toNSRange(in: <#T##String#>)
  //
  //    /// Otherwise, append a new run.
  //    let new = AttributedRun(
  //      tag: tag,
  //      range: range,
  //      attributes: attribute.attribute
  //    )
  //    self.append(new)
  //  }
}

extension NSBlockRanges {
  public mutating func append<T>(
    from match: Regex<T>.Match,
    in text: String
  ) {

    guard let range = match.nsRange(in: text) else { return }
    self.append(range)
  }
}
