//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools

public typealias AttributedRanges = [AttributedRun]

public struct AttributedRun {
  public let range: Range<String.Index>
  public var attributes: TextAttributes
  
  public init(
    range: Range<String.Index>,
    attributes: [NSAttributedString.Key : Any]
  ) {
    self.range = range
    self.attributes = attributes
  }
}
