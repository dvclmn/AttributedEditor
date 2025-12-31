//
//  Regex+Wrap.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation
import RegexBuilder

struct WrapSpec {
  //  let alternatives: [Character]
  let altA: Character
  let altB: Character?
  let count: Int
}

extension WrapSpec {

  func pattern() -> Regex<AnyRegexOutput> {
    let leading = Reference(Substring.self)
    let content = Reference(Substring.self)
    let trailing = Reference(Substring.self)
    let pattern = Regex {
      let wrapper = Regex {
        ChoiceOf {
          Repeat(altA, count: count)
          Repeat(altB ?? altA, count: count)
        }
      }
      Capture(as: leading) { wrapper }

      Capture(as: content) {
        OneOrMore {
          CharacterClass.anyNonNewline
        }
      }

      Capture(as: trailing) { wrapper }
    }

    return Regex(pattern)
  }

}
