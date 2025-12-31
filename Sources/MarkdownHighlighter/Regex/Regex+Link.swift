//
//  Regex+Link.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

struct LinkSpec {
  let kind: Kind
}

extension LinkSpec {
  enum Kind {
    case link
    case image
  }
  
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
