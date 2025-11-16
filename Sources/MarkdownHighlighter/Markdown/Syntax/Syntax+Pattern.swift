//
//  Syntax+GeneratePattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import Foundation

private func esc(_ s: String) -> String {
  return NSRegularExpression.escapedPattern(for: s)
}

extension SyntaxRule {
  func makePattern() -> String {
    switch (delimiter, captures) {

      // fenced code block: start ```, optional lang token, newline, body, end ```
      case (.fenced(let start, let end), .two(let name1, let name2)):
        // Note: reluctant `*?` for body so we get minimal matching
        return """
          \(esc(start))([A-Za-z0-9_+-]*)\\n([\\s\\S]*?)\(esc(end))
          """

      // wrapper with a single capture (e.g. `**bold**`, `*italic*`, `` `code` ``)
      case (.wrapper(let prefix, let suffix), .single(let name)):
        return """
          \(esc(prefix))(?<\(name)>.+?)\(esc(suffix))
          """

      // prefix lines, anchored at line start (e.g. headings "# " or "> ")
      case (.prefix(let start), .single(let name)):
        // anchorsMatchLines option should be used by caller if intended
        return "^\(esc(start))(?<\(name)>.+)$"

      // paired constructs like link: [label](dest "title")
      case (.paired(let prefix, let mid, let suffix), .three(let name1, let name2, let name3)):
        // prefix e.g. '[' mid e.g. '](' suffix e.g. ')'
        // label: anything up to ']' ; dest: up to whitespace or ) ; optional title in quotes
        fatalError("Not yet implemented")
      //        return """
      //            \(esc(prefix)(/* "[" */))(?<\(name1)>[^\\]]+)\(esc(mid))(?<\(name2)>[^\\s)]+)(?:\\s+\"(?<\(name3)>[^\"]+)\")?\(esc(suffix))
      //            """

      // paired minimum (label + dest) using two captures
      case (.paired(let prefix, let mid, let suffix), .two(let name1, let name2)):
        return """
          \(esc(prefix))(?<\(name1)>[^\\]]+)\(esc(mid))(?<\(name2)>[^\\s)]+)\(esc(suffix))
          """

      // block body capture for prefixed fenced block without explicit lang capture
      case (.fenced(let start, let end), .blockBody(let name)):
        return "\(esc(start))\\n(?<\(name)>[\\s\\S]*?)\(esc(end))"

      case (.none, _):
        return "([\\s\\S]+?)"

      default:
        // Fallback: try a permissive capture
        return "([\\s\\S]+?)"
    }
  }
}

//extension SyntaxRule {
//  func makePattern() -> String {
//    switch (delimiter, captures) {
//
//      case (.fenced(let start, let end), .two(let name1, let name2)):
//        return """
//          \(NSRegularExpression.escapedPattern(for: start))([A-Za-z0-9_+-]*)\\n([\\s\\S]*?)\(NSRegularExpression.escapedPattern(for: end))
//          """
//
//      case (.wrapper(let prefix, let suffix), .single(let name)):
//        return """
//          \(NSRegularExpression.escapedPattern(for: prefix))
//          (?<\(name)>.+?)
//          \(NSRegularExpression.escapedPattern(for: suffix))
//          """
//
//      case (.prefix(let start), .single(let name)):
//        return "^\(NSRegularExpression.escapedPattern(for: start))(?<\(name)>.+)$"
//
//      case (.none, _):
//        return ".*"
//
//      default:
//        fatalError("Pattern generation not implemented")
//    }
//  }
//}
