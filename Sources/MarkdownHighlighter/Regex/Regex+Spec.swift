//
//  Regex+Spec.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import CoreTools
import Foundation

//@AssociatedValues
enum SyntaxDescriptor {
  case wrap(WrapSpec)
  //  case prefix(PrefixSpec)
  //  case codeBlock(CodeBlockSpec)
  //  case pair(PairSpec)
}
extension SyntaxDescriptor {
  var shape: RegexShape {
    switch self {
      case .wrap(_): .wrap
    }
  }
  func pattern(for syntax: Markdown.Syntax) -> Regex<AnyRegexOutput> {
    precondition(syntax.regexShape == shape, "Syntax '\(syntax.name)' must have RegexShape \(shape.name).")

    return switch self {
      case .wrap(let wrapSpec): wrapSpec.pattern()
    }
  }
}
