//
//  Syntax+Thingy.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import CoreTools
import Foundation
import HighlighterCommon

extension StyleLibrary {
  /// Need to define very clear boundaries around the start and end
  /// of getting concrete Regex types
  ///
}
  //    return (attrs, blocks)
  //    switch shape {
  //      case .wrap(let rule):
  //        for match in text.matches(of: rule.pattern) {
  //          rule.apply(
  //            match: match,
  //            theme: theme,
  //            attrs: &attrs
  //          )
  //          if rule.syntax.drawsBackground {
  //            blocks.append(from: match, in: text)
  ////            blocks.appendOptional(match.nsRange(in: text))
  ////            blocks.append(match.range.toNSRange(in: text))
  //          }
  //        }
  //
  //      case .prefix(let rule):
  //        for match in text.matches(of: rule.pattern) {
  //          rule.apply(
  //            match: match,
  //            theme: theme,
  //            attrs: &attrs
  //          )
  //          if rule.syntax.drawsBackground {
  //            blocks.append(from: match, in: text)
  ////            blocks.append(match.range)
  //          }
  //        }
  //
  //      case .single(let rule):
  //        for match in text.matches(of: rule.pattern) {
  //          rule.apply(
  //            match: match,
  //            theme: theme,
  //            attrs: &attrs
  //          )
  //          if rule.syntax.drawsBackground {
  //            blocks.append(from: match, in: text)
  ////            blocks.append(match.range)
  //          }
  //        }
  //
  //      case .codeBlock(let rule):
  //        for match in text.matches(of: rule.pattern) {
  //          rule.apply(
  //            match: match,
  //            theme: theme,
  //            attrs: &attrs
  //          )
  //          if rule.syntax.drawsBackground {
  //            blocks.append(from: match, in: text)
  ////            blocks.append(match.range)
  //          }
  //        }
  //
  //      case .wrapPair(let rule):
  //        for match in text.matches(of: rule.pattern) {
  //          rule.apply(
  //            match: match,
  //            theme: theme,
  //            attrs: &attrs
  //          )
  //          if rule.syntax.drawsBackground {
  //            blocks.append(from: match, in: text)
  ////            blocks.append(match.range)
  //          }
  //        }
  //    }  // END switch
  //    return (attrs, blocks)
  //  }
//}
