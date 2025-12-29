//
//  Syntax+StyleRole.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools

// the role domain
public enum StyleRole: CaseIterable, Hashable, Sendable {
  case content
  case syntax
  case metadata

  // optional: a stable string key (useful for serialisation, debug)
  public var key: String {
    switch self {
      case .content: return "content"
      case .syntax: return "syntax"
      case .metadata: return "metadata"
    }
  }

  // optional: human-friendly label, ordering, etc
  public var displayName: String {
    switch self {
      case .content: return "Content"
      case .syntax: return "Syntax"
      case .metadata: return "Metadata"
    }
  }
}

// container for treatments of roles
public struct StyleRoles: Sendable {
  // small dictionary: role -> token
  // Use a specialised small typedef if you like, but Dict is fine.
  public var values: [StyleRole: StyleToken] = [:]

  public init(values: [StyleRole: StyleToken] = [:]) {
    self.values = values
  }

  public subscript(_ role: StyleRole) -> StyleToken? {
    get { values[role] }
    set {
      values[role] = newValue
    }
  }

  // convenience initializer
  @inlinable
  public init(_ pairs: (StyleRole, StyleToken)...) {
    var dict: [StyleRole: StyleToken] = [:]
    for (r, t) in pairs { dict[r] = t }
    self.init(values: dict)
  }

  // iterate in deterministic order
  public func forEach(_ body: (StyleRole, StyleToken) -> Void) {
    for role in StyleRole.allCases {
      if let token = values[role] { body(role, token) }
    }
  }

  // merge helper
  public mutating func merge(_ other: StyleRoles, prefer: (StyleToken, StyleToken) -> StyleToken) {
    for (role, token) in other.values {
      if let existing = values[role] {
        values[role] = prefer(existing, token)
      } else {
        values[role] = token
      }
    }
  }
}


//package typealias RolePath = KeyPath<StyleRole, StyleToken?>

// Previously RoleStyles
//package struct StyleRole {
//  var content: StyleToken?
//  var syntax: StyleToken?
//  var metadata: StyleToken?
//}

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
