//
//  CaptureProfile.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

public enum CaptureProfile: Sendable {
  case none
  case single(name: String)  // one named capture
  case two(name1: String, name2: String)  // two named captures
  case three(name1: String, name2: String, name3: String)
  case blockBody(name: String)  // capture the block body
}

public extension CaptureProfile {
  /// Number of captures expressed by this profile
  var count: Int {
    switch self {
      case .none: return 0
      case .single: return 1
      case .two: return 2
      case .three: return 3
      case .blockBody: return 1
    }
  }
  
  /// Capture names in positional order
  var names: [String] {
    switch self {
      case .none:
        return []
      case .single(let n):
        return [n]
      case .two(let a, let b):
        return [a, b]
      case .three(let a, let b, let c):
        return [a, b, c]
      case .blockBody(let n):
        return [n]
    }
  }
}
