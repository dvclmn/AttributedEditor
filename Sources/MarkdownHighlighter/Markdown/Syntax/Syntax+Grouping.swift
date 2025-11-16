//
//  Syntax+Grouping.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import Foundation
import HighlighterCommon

enum DelimiterShape {
  case none  // body, plain text
  case prefix(String)  // "# ", "> ", "- ", "```"
  case wrapper(prefix: String, suffix: String)  // ** **, * *, ` `
  case paired(prefix: String, mid: String, suffix: String)  // [text](url)
  case fenced(start: String, end: String)  // ```swift ... ```
}

enum ContentRole {
  case inlineText
  case blockText
  case labelAndDestination        // links/images: label + url (+ title)
  case keyAndText                 // footnotes: key + body
  case ignored
}

enum CaptureProfile {
  case none
  case single(name: String)
  case two(name1: String, name2: String)
  case three(name1: String, name2: String, name3: String)
  case blockBody(name: String)
}

struct SyntaxRule {
  let syntax: Markdown.Syntax
  let delimiter: DelimiterShape
  let role: ContentRole
  let captures: CaptureProfile
  let regexOptions: NSRegularExpression.Options = []
  
  /// Applies styling after the regex has matched.
  let apply: (NSTextCheckingResult, NSString, inout AttributedRanges) -> Void
}
