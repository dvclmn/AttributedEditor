//
//  Text+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import AppKit

/// Full credit to [Marcin Krzyzanowski](https://github.com/krzyzanowskim)
/// and his [STTextView](https://github.com/krzyzanowskim/STTextView)
/// library, as a direct reference for this code.
extension NSTextView {
//  func typingAttributes(
//    at startLocation: NSTextLocation
//  ) -> [NSAttributedString.Key: Any] {
//    if textLayoutManager.documentRange.isEmpty {
//      return _defaultTypingAttributes
//    }
//    
//    var typingAttrs: [NSAttributedString.Key: Any] = [:]
//    // The attribute is derived from the previous (upstream) location,
//    // except for the beginning of the document where it from whatever is at location 0
//    let options: NSTextContentManager.EnumerationOptions = startLocation == textLayoutManager.documentRange.location ? [] : [.reverse]
//    let offsetDiff = startLocation == textLayoutManager.documentRange.location ? 0 : -1
//    
//    textContentManager.enumerateTextElements(from: startLocation, options: options) { textElement in
//      if let attributedTextElement = textElement as? STAttributedTextElement,
//         let elementRange = textElement.elementRange,
//         let textContentManager = textElement.textContentManager {
//        let offset = textContentManager.offset(from: elementRange.location, to: startLocation)
//        assert(offset != NSNotFound, "Unexpected location")
//        typingAttrs = attributedTextElement.attributedString.attributes(at: offset + offsetDiff, effectiveRange: nil)
//      }
//      
//      return false
//    }
//    
//    // fill in with missing typing attributes if needed
//    return typingAttrs.merging(_defaultTypingAttributes, uniquingKeysWith: { current, _ in current })
//  }
}
