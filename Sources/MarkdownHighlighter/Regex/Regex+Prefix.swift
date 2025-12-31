//
//  Regex+Prefix.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation
import RegexBuilder

struct PrefixSpec {
  let markers: [String]  // "#", "##", ">"
  let kind: Kind
  let level: Int
  //  let requiresSpace: Bool
}

extension PrefixSpec {

  enum Kind: String {
    case heading = "#"
    case quoteBlock = ">"
  }
  func pattern() -> Regex<AnyRegexOutput> {
    //  func pattern(for level: Int) -> Regex<AnyRegexOutput> {
    let prefix = Reference(Substring.self)
    let content = Reference(Substring.self)

    let pattern = Regex {

      Capture(as: prefix) {
        createPrefix(for: kind)
      }

      One(.whitespace)

      //      Capture {
      //        //      Optionally {
      //        if requiresSpace {
      //        }
      //        //      }
      //      }

      Capture(as: content) {
        ZeroOrMore {
          CharacterClass.anyOf("\n").inverted
        }
      }
    }
    return Regex(pattern)
  }

  private func createPrefix(
    for kind: Kind,
    //    level: Int
  ) -> ChoiceOf<Substring> {
    ChoiceOf {
      String(repeating: kind.rawValue, count: level)
    }
  }
}
