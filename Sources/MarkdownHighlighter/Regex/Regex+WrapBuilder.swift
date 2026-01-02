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
      ChoiceOf {
        NegativeLookahead {
          Repeat(altA, count: count)
          
        }
//        Regex {
//
//        }
        //        Repeat(altB ?? altA, count: count)
      }
    }
  }

  //  var wrapperForIsolation: Regex<Substring> {
  //    Regex {
  //      wrapper
  //      NegativeLookahead {
  //        ChoiceOf {
  //          altA
  //          altB ?? altA
  //        }
  //      }
  //    }
  //  }

  var pattern: Regex<AnyRegexOutput> {
    let leading = Reference(Substring.self)
    let content = Reference(Substring.self)
    let trailing = Reference(Substring.self)

    let pattern = Regex {
      Capture(as: leading) {
        wrapper
        //        requiresIsolation ? wrapper : wrapperForIsolation
      }

      Capture(as: content) {
        OneOrMore {
          CharacterClass.anyNonNewline
        }
      }

      Capture(as: trailing) {
        wrapper
        //        requiresIsolation ? wrapper : wrapperForIsolation
      }
    }

    return Regex(pattern)
  }

}
