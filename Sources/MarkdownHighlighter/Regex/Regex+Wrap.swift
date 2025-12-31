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
    let pattern = Regex {
      let wrapper = Regex {
        ChoiceOf {
          Repeat(altA, count: count)
          Repeat(altB ?? altA, count: count)
        }
      }
      Capture { wrapper }

      Capture {
        OneOrMore {
          CharacterClass.anyOf("\n").inverted
        }
      }

      Capture { wrapper }
    }

    return Regex(pattern)
  }

}
