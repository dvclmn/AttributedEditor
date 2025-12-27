//
//  SyntaxData.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import CoreTools
import Foundation

struct SyntaxData {
  let syntax: Markdown.Syntax
//  let syntaxID: Markdown.Syntax.ID
  let pattern: Regex<AnyRegexOutput>
  let shape: RegexShape
  let fragments: [Fragment]
}

extension SyntaxData {

  // TODO: Expand on docs here
  /// Three basic components needed to style and find ranges for a syntax.
  /// 1. Shape
  /// 2. Regex Pattern
  /// 3. Fragments
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
      syntax: syntax,
//      syntaxID: syntax.id,
      pattern: pattern,
      shape: shape,
      fragments: fragments
    )
  }

  func processMatch(
    _ match: Regex<AnyRegexOutput>.Match,
    for syntax: Markdown.Syntax,
    theme: MarkdownTheme,
    runs: inout MarkdownRuns,
  ) {

    for fragment in fragments {
      let range = shape.range(for: match, fragment: fragment)
      guard let range else {
        print("No range for fragment: \(fragment)")
        continue
      }
      
      /// Currently using the range as the sole marker for 'equality' here
      let runAlreadyExists = attributes.contains(where: { $0.range == range })
      guard !runAlreadyExists else { continue }
      
      /// If a run with this range is not already present, add a new one

      let run = SyntaxRun(syntax: syntax, fragment: fragment, range: range)
      //      let attrRun = HighlightRun(
//        syntaxID: syntaxID,
//        fragment: fragment,
//        range: range,
//        theme: theme
//      )
      attributes.append(run)
    }
    
//    var fragmentDesc: String = "\(syntax.name), w/ Fragments: ["
//
//    let fragmentsList = fragments.filter { fragment in
//      let range = range(for: fragment, in: match)
//      let runAlreadyExists = attributes.contains(where: { $0.range == range })
//      return !runAlreadyExists
//    }
//
//    for fragment in fragmentsList {
//      guard let range = range(for: fragment, in: match) else {
//        print("No range for fragment: \(fragment)")
//        continue
//      }
//
//      /// Currently using the range as the sole marker for 'equality' here
//      //      let runAlreadyExists = attributes.contains(where: { $0.range == range })
//      //      guard !runAlreadyExists else { continue }
//
////      let isFinalFragment: Bool = fragment == fragmentsList.last
////
////      if !isFinalFragment {
////        fragmentDesc += "\(fragment.rawValue), "
////      } else {
////        fragmentDesc += "\(fragment.rawValue)]"
////      }
//
//      /// If a run with this range is not already present, add a new one
//      let attrRun = AttributedRun(
//        syntaxID: syntaxID,
//        fragment: fragment,
//        range: range,
//        theme: theme,
//        desc: fragmentDesc
//      )
//      attributes.append(attrRun)
//    }
  }

  private func range(
    for fragment: Fragment,
    in match: Regex<AnyRegexOutput>.Match
  ) -> Range<String.Index>? {
    shape.range(for: match, fragment: fragment)
  }
}

extension SyntaxRun {
  init(
    syntax: Markdown.Syntax,
//    syntaxID: Markdown.Syntax.ID,
    fragment: Fragment,
    range: Range<String.Index>,
//    theme: MarkdownTheme,
//    desc: String?
  ) {
    let metadata = "\(syntax), Fragment: \(fragment.rawValue)"
    let role = fragment.styleRole
    self.init(syntax: syntax, role: role, range: range)
//    let textAttrs = theme.textAttributes(for: syntaxID, role: role)
//    self.init(metadata: metadata, range: range, attributes: textAttrs)
//    self.init(desc, range: range, attributes: textAttrs)
  }
}
