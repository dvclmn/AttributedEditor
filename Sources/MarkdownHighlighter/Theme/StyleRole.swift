//
//  Syntax+StyleRole.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools

/// the role domain
public enum StyleRole: String, CaseIterable, Hashable, Sendable {
  case content
  case syntax
  case metadata

  public var name: String { rawValue.capitalized }
}

/// container for treatments of roles
public struct StyleRoles: Sendable {

  public var values: [StyleRole: StyleToken] = [:]

  public init(values: [StyleRole: StyleToken] = [:]) {
    self.values = values
  }
}

extension StyleRoles {

  public subscript(_ role: StyleRole) -> StyleToken? {
    get { values[role] }
    set { values[role] = newValue }
  }

  /// convenience initializer
  //    @inlinable
  //    public init(_ pairs: (StyleRole, StyleToken)...) {
  //      var dict: [StyleRole: StyleToken] = [:]
  //      for (r, t) in pairs { dict[r] = t }
  //      self.init(values: dict)
  //    }

  mutating func set(_ role: StyleRole, style token: StyleToken?) {
    values[role] = token
  }

  /// iterate in deterministic order
  public func forEach(_ body: (StyleRole, StyleToken) -> Void) {
    for role in StyleRole.allCases {
      if let token = values[role] { body(role, token) }
    }
  }

  public mutating func merge(
    _ other: StyleRoles,
    prefer: (StyleToken, StyleToken) -> StyleToken
  ) {
    for (role, token) in other.values {
      if let existing = values[role] {
        values[role] = prefer(existing, token)
      } else {
        values[role] = token
      }
    }
  }

}
