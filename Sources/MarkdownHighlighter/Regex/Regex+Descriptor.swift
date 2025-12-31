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
  case prefix(PrefixSpec)
  case link(LinkSpec)
  //  case codeBlock(CodeBlockSpec)
  //  case pair(PairSpec)
}
extension SyntaxDescriptor {
  var shape: RegexShape {
    switch self {
      case .wrap(_): .wrap
      case .prefix(_): .prefix
      case .link(_): .link
    }
  }
  var pattern: Regex<AnyRegexOutput> {
    //    precondition(syntax.regexShape == shape, "Syntax '\(syntax.name)' must have RegexShape \(shape.name).")

    return switch self {
      case .wrap(let spec): spec.pattern
      case .prefix(let spec): spec.pattern
      case .link(let spec): spec.pattern
    }
  }
}
