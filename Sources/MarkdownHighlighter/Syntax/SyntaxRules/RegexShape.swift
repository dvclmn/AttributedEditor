//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import Foundation

public enum RegexShape {
  public typealias Single = (Substring)
  
  public typealias Three = (
    Substring,
    leading: Substring,
    content: Substring,
    trailing: Substring
  )
}
