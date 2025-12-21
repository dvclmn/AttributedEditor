//
//  Regex+Container.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 21/12/2025.
//

extension Markdown {

  public struct Pattern<Shape> {
    let syntax: Syntax
    let expression: Regex<Shape>
    //    let shape: RegexShape
    //    let shape: RegexShape
  }
}

extension Markdown.Pattern where Shape == RegexShape.Wrap {
  static var inlineCode: Self {
    .init(
      syntax: .inlineCode, expression: /(?<leading>`)(?<content>(?:[^`\n])+?)(?<trailing>`)/)
  }
}
