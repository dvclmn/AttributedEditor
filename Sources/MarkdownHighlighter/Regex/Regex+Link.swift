//
//  Regex+Link.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import RegexBuilder

struct LinkSpec {
  let kind: Kind
}

extension LinkSpec {
  enum Kind {
    case link
    case image
  }

  var pattern: Regex<AnyRegexOutput> {
    let title = Reference(Substring.self)
    let url = Reference(Substring.self)

    let pattern = Regex {
      Optionally("!")
      "["
      Capture {
        ZeroOrMore {
          CharacterClass.anyOf("]").inverted
        }
      }
      "]"
      "("
      Capture {
        ZeroOrMore {
          CharacterClass.anyOf(")").inverted
        }
      }
      ")"
    }

    return Regex(pattern)
  }

}
