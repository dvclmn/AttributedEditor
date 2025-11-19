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

  public var otherKind: String? {
    if case .other(let value) = kind { return value }
    return nil
  }

}

/// Provide defaults where possible, that can be overriden
/// as needed. To reduce repetitive colour/font definitions
//  public enum SyntaxComponent {
//    case body
//    case heading1(ComponentKind)
//    case heading2(ComponentKind)
//    case heading3(ComponentKind)
//    case heading4(ComponentKind)
//    case heading5(ComponentKind)
//    case heading6(ComponentKind)
//    case bold(ComponentKind)
//    case italic(ComponentKind)
//    case boldItalic(ComponentKind)
//    case inlineCode(ComponentKind)
//    case codeBlock(ComponentKind)
//    case list(ComponentKind)
//    case quoteBlock(ComponentKind)
//    case callout(ComponentKind)
//    case strikethrough(ComponentKind)
//    case highlight(ComponentKind)
//    case link(ComponentKind)
//    case image(ComponentKind)
//    case horizontalRule
//  }

//}
