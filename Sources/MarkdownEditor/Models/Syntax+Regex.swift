//
//  Regex.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 20/8/2024.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Markdown.Syntax {
  
  public var regexLiteral: MarkdownRegex? {
    switch self {
      case .quoteBlock: return /(?<leading>^>)(?<content>[^>\n]+)(?<trailing>)/
      case .list: return /(?<leading>\[)(?<content>[^\]]+)(?<trailing>\]\([^\)]+\))/
      case .codeBlock: return /(?<leading>```[a-zA-Z]*)\n(?<content>.*?)(?<trailing>```)/
      case .heading: return /(?<leading>\s*#)(?<content>[^#*]*?)(?<trailing>)/
//      case .header2, .header3, .header4, .header5, .header6: return nil
      case .inlineCode: return /(?<leading>`)(?<content>(?:[^`\n])+?)(?<trailing>`)/
      case .italic: return /(?<leading>_|\*)(?<content>[^_|\*]*?)(?<trailing>_|\*)/
      case .bold: return /(?<leading>__|\*\*)(?<content>[^_|\*]*?)(?<trailing>__|\*\*)/
      case .link: return /(?<leading>\[)(?<content>[^\]]+)(?<trailing>\]\([^\)]+\))/
      case .image: return /(?<leading>!\[)(?<content>[^\]]+)(?<trailing>\]\([^\)]+\))/
      case .body, .boldItalic, .strikethrough, .highlight, .horizontalRule: return nil
    }
  }


  public var regexPattern: String? {

    let emphasisContent: String = "(.*?)"

    let italicSyntax: String = "(_|\\*)"
    let boldSyntax: String = "(__|\\*\\*)"
    let boldItalicSyntax: String = "(___|\\*\\*\\*)"

    return switch self {
        
      case .heading(let level): "^(#{\(level)})\\s+(.+)"
      case .inlineCode: "(`)((?:[^`\n])+?)(`)"
      case .strikethrough: "(~~)([^~]*?)(~~)"
      case .italic: italicSyntax + emphasisContent + italicSyntax
      case .bold: boldSyntax + emphasisContent + boldSyntax
      case .boldItalic: boldItalicSyntax + emphasisContent + boldItalicSyntax
      case .codeBlock: "(```(?:\\s*\\w+\\s?)\n)([\\s\\S]*?)(\\n```)"
      case .highlight: "==([^=]+)==(?!=)"
//      case .highlight: "(?<!=)==([^=]+)==(?!=)"
//      case .highlight: "(==)([^=]*?)(==)"
      case .list: "^\\s{0,3}([-*]|\\d+\\.)\\s+(.+)$"
      case .horizontalRule: "^[-*_]{3,}$"
      case .quoteBlock: "^>\\s*(.+)"
      case .link: "(\\[)(.*?)(\\]\\()(.*?)(\\))"
      case .image: "(!\\[)(.*?)(\\]\\()(.*?)(\\))"
      case .body: nil
    }
  }

  public var regexOptions: NSRegularExpression.Options {
    switch self {
      case .codeBlock:
        [.allowCommentsAndWhitespace, .anchorsMatchLines]
      default: [.anchorsMatchLines]
    }
  }

  public var nsRegex: NSRegularExpression? {
    guard let pattern = self.regexPattern else { return nil }

    do {
      let regex = try NSRegularExpression(pattern: pattern, options: self.regexOptions)
      return regex
    } catch {
      print("Error creating regex for \(self): \(error)")
      return nil
    }
  }
}

