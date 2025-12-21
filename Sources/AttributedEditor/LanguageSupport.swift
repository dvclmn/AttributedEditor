//
//  LanguageSupport.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/12/2025.
//

/// Languages with syntax highlighting support
/// I guess these literally correspond to the Highlighters
public enum LanguageHint: String {
  case markdown
  case swift
  case python
  
  /// Perhaps able to provide basic catch-all highlighting
  /// for common keywords? `var`, `let` etc?
  /// Numbers and strings?
  case generic
}

extension LanguageHint {
  public var validNames: [String] {
    switch self {
      case .markdown: return ["markdown", "md"]
      case .swift: return ["swift"]
      case .python: return ["python", "py", "pyi"]
      case .generic: return []
    }
  }
}
