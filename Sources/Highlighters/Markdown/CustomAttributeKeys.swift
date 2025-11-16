//
//  CustomAttributeKeys.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

//TextBackground.inlineCode.attributeKey: false,
//TextBackground.codeBlock.attributeKey: false,
//TextBackground.highlight.attributeKey: false,

//public enum TextBackground: CaseIterable {
//
//  case inlineCode
//  case codeBlock
//  case highlight
//
//  public var attributeKey: NSAttributedString.Key {
//    switch self {
//      case .inlineCode: NSAttributedString.Key("inlineCode")
//      case .codeBlock: NSAttributedString.Key("codeBlock")
//      case .highlight: NSAttributedString.Key("highlight")
//    }
//  }
//
//  public var insets: (dx: CGFloat, dy: CGFloat) {
//    switch self {
//      case .inlineCode, .codeBlock, .highlight:
//        (-2, -1)
//    }
//  }
//
//  public func fillColour(from configuration: EditorConfiguration) -> Color {
//    switch self {
//      case .inlineCode: configuration.theme.inlineCodeBackgroundColour
//      case .codeBlock: configuration.theme.codeBlockBackgroundColour
//      case .highlight: configuration.theme.highlightBackground
//    }
//  }
//}
