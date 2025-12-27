//
//  Markdown+Kind.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 27/12/2025.
//

import EditorCore

extension Markdown.Syntax {
  
  public var toSemanticKind: SemanticKind? {
    switch self {
      case .body:
        <#code#>
      case .heading1:
        <#code#>
      case .heading2:
        <#code#>
      case .heading3:
        <#code#>
      case .heading4:
        <#code#>
      case .heading5:
        <#code#>
      case .heading6:
        <#code#>
      case .bold:
        <#code#>
      case .italic:
        <#code#>
      case .boldItalic:
        <#code#>
      case .inlineCode:
        <#code#>
      case .codeBlock:
        <#code#>
      case .list:
        <#code#>
      case .quoteBlock:
        <#code#>
      case .callout:
        <#code#>
      case .strikethrough:
        <#code#>
      case .highlight:
        <#code#>
      case .link:
        <#code#>
      case .image:
        <#code#>
      case .horizontalRule:
        <#code#>
    }
  }
}
