//
//  SyntaxData.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import Foundation
import CoreTools
import HighlighterCommon

struct SyntaxData {
  let syntaxID: Markdown.Syntax.ID
  let pattern: Regex<AnyRegexOutput>
  let shape: RegexShape
  let fragments: [RegexShape.Fragment]
}
extension SyntaxData {
  init?(syntax: Markdown.Syntax) {
    /// No need to process anything if provided Syntax has no regex shape
    guard let shape = syntax.regexShape else { return nil }
    
    /// Ensure we have a Regex pattern for this syntax
    guard let pattern = syntax.pattern else {
      print("No pattern for syntax \(syntax.name)")
      return nil
    }
    
    /// Again, no fragments means no need to process
    guard let fragments = syntax.fragments else { return nil }
    
    self.init(
      syntaxID: syntax.id,
      pattern: pattern,
      shape: shape,
      fragments: fragments
    )
  }
  
  func processMatch(
    _ match: Regex<AnyRegexOutput>.Match,
    theme: Markdown.Theme,
    attrs attributes: inout AttributedRanges,
  ) {
    
    for fragment in fragments {
      let range = shape.range(for: match, fragment: fragment)
      guard let range else {
        print("No range for fragment: \(fragment)")
        continue
      }
      let runAlreadyExists = attributes.contains(where: { $0.range == range })
      guard !runAlreadyExists else { continue }
      
      let role = fragment.styleRole
      let textAttrs = theme.textAttributes(for: syntaxID, role: role)
      let attributedRun = AttributedRun(range: range, attributes: textAttrs)
      attributes.append(attributedRun)
    }
  }
  
}
