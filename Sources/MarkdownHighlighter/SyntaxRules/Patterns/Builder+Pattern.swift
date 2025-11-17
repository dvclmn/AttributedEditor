//
//  Builder+Pattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

public enum PatternBuilder {
  public static func buildPattern(for rule: SyntaxRule) throws -> String {
    try RuleValidator.validate(rule)
    
    switch rule.delimiter {
      case .wrapper(let prefix, let suffix):
        return try WrapperPattern.build(prefix: prefix, suffix: suffix, captures: rule.captures)
        
      case .prefix(let prefix):
        return try PrefixPattern.build(prefix: prefix, captures: rule.captures)
        
      case .paired(let p, let mid, let s):
        return try PairedPattern.build(prefix: p, mid: mid, suffix: s, captures: rule.captures)
        
      case .fenced(let start, let end):
        return try FencedPattern.build(start: start, end: end, captures: rule.captures)
        
      case .none:
        return DefaultPattern.build(captures: rule.captures)
    }
  }
}
