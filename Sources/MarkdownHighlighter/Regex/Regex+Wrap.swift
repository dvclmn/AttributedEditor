//
//  Regex+Wrap.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation
import RegexBuilder

struct WrapSpec {
  let alternatives: [Character]  // precondition: 1...2
  let count: Int
}

//struct WrapSpec: Equatable {
//  enum MixingRule {
//    case uniform  // "**bold**", "__bold__"
//    case allowMix  // (if you ever support it)
//  }
//
//  let markers: [Character]
//  let count: Int
//  let mixing: MixingRule
//  let allowsNewlines: Bool
//}

extension Markdown.Syntax {
  //  var descriptor: SyntaxDescriptor {
  //    switch self {
  //      case .italic:
  //        .wrap(
  //          .init(
  //            markers: ["*", "_"],
  //            count: 1,
  //            mixing: .uniform,
  //            allowsNewlines: false
  //          ))
  //
  //      case .bold:
  //        .wrap(
  //          .init(
  //            markers: ["*", "_"],
  //            count: 2,
  //            mixing: .uniform,
  //            allowsNewlines: false
  //          ))
  //
  //      case .inlineCode:
  //        .wrap(
  //          .init(
  //            markers: ["`"],
  //            count: 1,
  //            mixing: .uniform,
  //            allowsNewlines: false
  //          ))
  //
  //      // …
  //      default: fatalError("Markdown Syntax '\(self.name)' is not compatible with Wrap Regex Shape.")
  //    }
  //  }
}

extension RegexShape {
  static func wrap(_ spec: WrapSpec) -> Regex<AnyRegexOutput> {
    //  static func wrap(_ spec: WrapSpec) -> Regex<Wrap> {
    precondition((1...2).contains(spec.alternatives.count))

    let pattern = Regex {

      let wrapper = Regex {
        ChoiceOf {
          Repeat("*", count: spec.count)
          Repeat("_", count: spec.count)
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

  //  static func wrap(_ spec: WrapSpec) -> Regex<AnyRegexOutput> {
  //    let marker = ChoiceOf {
  //      for ch in spec.markers {
  //        Repeat(ch, count: spec.count)
  //      }
  //    }
  //
  //    let pattern = Regex {
  //      Capture {
  //        marker
  //      } transform: {
  //        $0
  //      }
  //
  //      Capture {
  //        OneOrMore {
  //          spec.allowsNewlines
  //            ? .any
  //            : CharacterClass.anyOf("\n").inverted
  //        }
  //      }
  //
  //      Capture {
  //        marker
  //      }
  //    }
  //
  //    return Regex(pattern)
  //  }
}
