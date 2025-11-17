//
//  Pattern+Default.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

enum DefaultPattern {
  static func build(captures: CaptureProfile) -> String {
    switch captures {
      case .single(let name):
        return "(?<\(name)>[\\s\\S]+?)"
      default:
        return "([\\s\\S]+?)"
    }
  }
}
