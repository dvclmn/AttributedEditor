//
//  MakePattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

extension SyntaxRule {
  private func apply(_ rule: SyntaxRule, to text: NSString, attributes: inout AttributedRanges) {
    let pattern: String
    do {
      pattern = try PatternBuilder.buildPattern(for: rule)
    } catch {
      // You might log the error or fail gracefully
      return
    }
    
    guard let regex = try? NSRegularExpression(pattern: pattern, options: rule.regexOptions) else { return }
    
    let matches = regex.matches(
      in: text as String,
      range: NSRange(location: 0, length: text.length)
    )
    
    for match in matches {
      rule.apply(match, text, &attributes)
    }
  }

}
