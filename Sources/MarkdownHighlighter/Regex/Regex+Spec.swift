//
//  Regex+Spec.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation

enum SyntaxDescriptor {
  case wrap(WrapSpec)
  case prefix(PrefixSpec)
  case codeBlock(CodeBlockSpec)
  case pair(PairSpec)
}


struct WrapSpec {
  let markers: [Character]
  let count: Int
}
