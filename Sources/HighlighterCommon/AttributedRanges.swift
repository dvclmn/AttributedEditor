//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools
import ThemePark

public typealias AttributedRanges = [AttributedRun]
//public typealias NSAttributedRanges = [NSAttributedRun]

public typealias BlockRanges = [Range<String.Index>]
public typealias NSBlockRanges = [NSRange]

public struct AttributedRun {

  /// The lexeme/syntax/operator/keyword etc that this run is attached to
  public let keyword: SyntaxSpecifier
  public let range: Range<String.Index>
  public var attributes: TextAttributes

  public init(
    keyword: SyntaxSpecifier,
    range: Range<String.Index>,
    attributes: TextAttributes
  ) {
    self.keyword = keyword
    self.range = range
    self.attributes = attributes
  }
}

extension AttributedRun {
  /// Semantically here meaning that the identifying properties
  /// like keyword and range are equal, but the style attributes may
  /// not be. So there'd be a choice about overwriting, preserving, etc.
  func isSemanticallyEqual(to other: AttributedRun) -> Bool {
    keyword == other.keyword && range == other.range
  }
}


extension AttributedRun {
  public func nsRange(in text: String) -> NSRange? { range.toNSRange(in: text) }
}

extension AttributedRanges {

  //  public func toNSRanges(
  //    in text: String,
  ////    tag: String?
  //  ) -> NSAttributedRanges {
  //    self.compactMap { run in
  //      guard let range = run.range.toNSRange(in: text) else {
  //        print("Error getting NSRange?")
  //        return nil
  //      }
  //      let attributes = run.attributes
  //      return NSAttributedRun(range: range, attributes: attributes)
  //      //      return (range, attributes)
  //    }
  //  }

  /// `Attribute` is a small type safe wrapper
  /// around `NSAttributedString.Key`
  public mutating func update(
    with attributes: [AttributeKey?],
    for keyword: SyntaxSpecifier,
    in range: Range<String.Index>,
    //    tag: String?
  ) {
//    guard let attributes else { return }

    /// Find any runs with same range, if any present
    let existingRun = self.first(where: { $0.range == range })
    
    
    /// If an existing run matches exactly, update it.
    if let index = self.firstIndex(where: { $0.range == range }) {
      
//      attributes[key] = self.value
//      attribute.update(&self[index].attributes)
    } else {
      /// Otherwise, append a new run.
      let new = AttributedRun(
        keyword: keyword,
        range: range,
        attributes: attribute.attribute
      )
      self.append(new)
    }

  }

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

//extension NSAttributedRanges {
//
//  public mutating func update(
//    _ attribute: AttributeKey?,
//    in range: NSRange,
//    //    tag: String?
//  ) {
//    /// Could be wrong, but I *thiiink* this is very ueseful, having this
//    /// as optional, so I can freely call this method (whether I know if there'll
//    /// be a value or not), for more generalised code over in Regex shape.
//    guard let attribute else { return }
//
//    /// 1. Ensure the range is valid.
//    /// Also check for negative lengths (`NSRange` uses Int in Swift, allowing negatives).
//    guard range.location != NSNotFound, range.length >= 0 else {
//      assertionFailure("Attempted to update invalid NSRange: \(range)")
//      return
//    }
//
//    /// 2. Exact Match Check
//    if let index = self.firstIndex(where: { $0.range == range }) {
//      /// Update the existing item in place
//      attribute.update(&self[index].attributes)
//    } else {
//      /// 3. Append New
//      let new = NSAttributedRun(
//        //        tag: tag,
//        range: range,
//        attributes: attribute.attribute
//      )
//      self.append(new)
//    }
//  }
//
//  public mutating func update(
//    _ attributes: [AttributeKey?],
//    in range: NSRange,
//    //    tag: String?
//  ) {
//    /// Could be wrong, but I *thiiink* this is very ueseful, having this
//    /// as optional, so I can freely call this method (whether I know if there'll
//    /// be a value or not), for more generalised code over in Regex shape.
//    //    guard let attribute else { return }
//    let foundAttr = attributes.compactMap(\.self)
//    guard !foundAttr.isEmpty else { return }
//    for attr in foundAttr {
//      self.update(attr, in: range)
//    }
//  }
//}

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
//}
