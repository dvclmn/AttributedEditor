//
//  Regex+Wrap.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation
import RegexBuilder

struct WrapSpec {
  let altA: Character
  let altB: Character?
  let count: Int

  var requiresIsolation: Bool { count == 1 }

  init(altA: Character, altB: Character? = nil, count: Int) {
    self.altA = altA
    self.altB = altB
    self.count = count
  }
}

extension WrapSpec {
  
  var wrapper: Regex<Substring> {
    Regex {
      if requiresIsolation {
        NegativeLookbehind {
          altA
        }
      }
      
      ChoiceOf {
        Repeat(altA, count: count)
        if let altB {
          Repeat(altB, count: count)
        }
      }
      
      if requiresIsolation {
        NegativeLookahead {
          altA
        }
      }
    }
  }


  var pattern: Regex<AnyRegexOutput> {
    let leading = Reference(Substring.self)
    let content = Reference(Substring.self)
    let trailing = Reference(Substring.self)

    let wrapper = Regex {
      ChoiceOf {
        Repeat(altA, count: count)
        Repeat(altB ?? altA, count: count)
      }
    }

    let pattern = Regex {
      Capture(as: leading) {
        wrapper
      }

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
