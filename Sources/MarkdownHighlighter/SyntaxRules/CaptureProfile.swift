//
//  CaptureProfile.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

public enum CaptureProfile: Sendable {
  case none
  case single(name: String)
  case two(name1: String, name2: String)
  case three(name1: String, name2: String, name3: String)
  case blockBody(name: String)  // capture the block body
}

extension CaptureProfile {
  /// Number of captures expressed by this profile
  public var count: Int {
    switch self {
      case .none: 0
      case .single: 1
      case .two: 2
      case .three: 3
      case .blockBody: 1
    }
  }

  /// Capture names in positional order
  public var names: [String] {
    switch self {
      case .none: []
      case .single(let n): [n]
      case .two(let a, let b): [a, b]
      case .three(let a, let b, let c): [a, b, c]
      case .blockBody(let n): [n]
    }
  }
}
