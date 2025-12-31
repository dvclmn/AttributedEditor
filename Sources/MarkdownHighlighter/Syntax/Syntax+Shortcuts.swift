//
//  Syntax+Shortcuts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import CoreTools

extension Markdown.Syntax {
  public var shortcuts: [KBShortcut] {
    switch self {
      case .heading(let level):
        //        let levelString = self.rawValue.suffix(1)
        //        guard let level = Int(levelString) else {
        //          return []
        //        }
        return [
          KBShortcut(
            .character(Character("\(level)")),
            modifiers: [.command]
          )
        ]

      case .bold:
        return [
          KBShortcut(
            .character("b"),
            modifiers: [.command],
            label: KBShortcut.Label(title: self.name, icon: "bold")
          )
        ]
      case .italic:
        return [
          KBShortcut(
            .character("i"),
            modifiers: [.command],
            label: KBShortcut.Label(title: self.name, icon: "italic")
          )
        ]
      case .boldItalic:
        return [
          KBShortcut(
            .character("b"),
            modifiers: [.command, .shift]
          )
        ]
      case .inlineCode:
        return [
          KBShortcut(
            .character("`"),
            label: KBShortcut.Label(
              title: self.name, icon: "chevron.left.forwardslash.chevron.right")
          )
        ]
      case .highlight:
        return [
          KBShortcut(
            .character("h"),
            modifiers: [.command]
          )
        ]
      case .strikethrough:
        return [
          KBShortcut(
            .character("s"),
            modifiers: [.command]
          )
        ]

      default:
        return []
    }
  }

}
