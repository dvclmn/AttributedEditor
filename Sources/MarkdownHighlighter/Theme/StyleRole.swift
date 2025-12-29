//
//  Syntax+StyleRole.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools

/// Expresses rendering intent. E.g. this doesn't list out
/// leading and trailing syntax; because as far as visual styles
/// go, both should be styled the same.
//@CaseDetection
//public enum StyleRole: Hashable, Sendable, CaseIterable {
//  case content
//  case syntax
//  case metadata
//  
//  var rolePath: WritableKeyPath<RoleStyles, StyleToken?> {
//    switch self {
//      case .content: \.content
//      case .syntax: \.syntax
//      case .metadata: \.metadata
//    }
//  }
//}

typealias RolePath = KeyPath<StyleRole, StyleToken?>

// Previously RoleStyles
struct StyleRole {
  var content: StyleToken?
  var syntax: StyleToken?
  var metadata: StyleToken?
}
