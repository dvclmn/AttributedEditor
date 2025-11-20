//
//  Syntax+Highlight.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//


import AppKit
import ColourKit
import CoreTools

extension Markdown.SyntaxRule where T == RegexShape.Wrap {
  
    static var highlight: Self {
    
    let pattern = /(?<leading>==)(?<content>[^== \n][^\n]*?[^== \n])(?<trailing>\k<leading>)/
    let syntax: Markdown.Syntax = .inlineCode
    
    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      exposesBlockRange: false
    )
//    { match, attrs in
//      
//      pattern.apply(
//        match: match,
//      ) {
//        path,
//        range in
//        
//        switch path {
//            
//          case \.0:
//
//            attrs.update(
//              .backgroundColor,
//              with: CodableColour.system(.blue).nsColor().opacity(0.2),
//              //              with: ThemeColour.olive,
//              in: range
//            )
//            
//          case \.leading,
//            \.trailing:
//            attrs.update(.foregroundColor, with: CodableColour.mix(.cyan, .gray, 0.3).nsColor().opacity(0.3), in: range)
////            attrs.update(.foregroundColor, with: ThemeColour.syntaxColour, in: range)
//            
//          case \.content:
//            
////            attrs.update(.foregroundColor, with: CodableColour.mix(.cyan, .blue, 0.6).nsColor(), in: range)
//            attrs.update(.foregroundColor, with: CodableColour.system(.cyan).nsColor(), in: range)
//            //            attrs.update(.foregroundColor, with: ThemeColour.reddish, in: range)
//            
//          default: return
//        }
//        
//      }
//    }
  }
}
