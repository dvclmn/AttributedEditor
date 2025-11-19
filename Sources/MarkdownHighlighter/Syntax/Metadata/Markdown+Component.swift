//
//  Syntax+Component.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

extension Markdown {
  public struct Component: Equatable, Hashable {
    public let syntax: Syntax
    public let kind: ComponentKind

    public init(
      _ syntax: Syntax,
      kind: ComponentKind
    ) {
      self.syntax = syntax
      self.kind = kind
    }
  }
}

// MARK: - Convenience Accessors
extension Markdown.Component {

  public var isContent: Bool {
    if case .content = kind { return true }
    return false
  }

  public var isSyntax: Bool {
    if case .syntax = kind { return true }
    return false
  }

  public var isBackground: Bool {
    if case .background = kind { return true }
    return false
  }
}

