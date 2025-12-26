//
//  ConfigItems.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import Foundation

public enum Editor {
  public struct Options: OptionSet, Sendable {
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    public let rawValue: Int
    
    public static let lineNumbers = Self(rawValue: 1 << 0)
//    public static let editable = Self(rawValue: 1 << 1)
    //  public static let units = Self(rawValue: 1 << 2)
    public static let all: Self = [.lineNumbers]
  }
}
