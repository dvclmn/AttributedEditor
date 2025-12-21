//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools
import Foundation

/// What needs a special case, and how does RegexShape
/// relate to `Markdown.Component` and fonts/colours too
///
/// Worth noting: RegexShape is *only* concerned with text
/// content, so that helps reduce some coupling, e.g.
/// `SyntaxPart.background` is irrelevant to regex.
//@MetaEnum
public enum RegexShape {
  case wrap(Markdown.Pattern<Wrap>)
  case prefix(Markdown.Pattern<Prefix>)
  case single(Markdown.Pattern<Single>)
  case codeBlock(Markdown.Pattern<CodeBlock>)
  case wrapPair(Markdown.Pattern<WrapPair>)
//  case wrap
//  case prefix
//  case single
//  case codeBlock
//  case wrapPair
  //  case wrap(Wrap)
  //  case prefix(Prefix)
  //  case single(Single)
  //  case codeBlock(CodeBlock)
  //  case wrapPair(WrapPair)
  //  case wrap(SyntaxRule<Wrap>)
  //  case prefix(SyntaxRule<Prefix>)
  //  case single(SyntaxRule<Single>)
  //  case codeBlock(SyntaxRule<CodeBlock>)
  //  case wrapPair(SyntaxRule<WrapPair>)

  public typealias Single = (Substring)

  // E.g. # Header, > Quotes
  public typealias Prefix = (
    Substring,
    prefix: Substring,
    content: Substring,
  )

  // E.g. *Italics*, ==Highlight==
  public typealias Wrap = (
    Substring,
    leading: Substring,
    content: Substring,
    trailing: Substring
  )

  public typealias CodeBlock = (
    Substring,
    start: Substring,
    langHint: Substring,
    content: Substring,
    end: Substring
  )

  // Link, image
  // If link, the 'prefix' group will be empty
  public typealias WrapPair = (
    Substring,
    prefix: Substring,
    leadingA: Substring,
    title: Substring,
    trailingA: Substring,
    leadingB: Substring,
    url: Substring,
    trailingB: Substring,
  )
}

extension RegexShape {
  
  func getAnyRegex() -> Regex<AnyRegexOutput> {
    switch self {
      case .wrap(let pattern): Regex(pattern.expression)
      case .prefix(let pattern): Regex(pattern.expression)
      case .single(let pattern): Regex(pattern.expression)
      case .codeBlock(let pattern): Regex(pattern.expression)
      case .wrapPair(let pattern): Regex(pattern.expression)
        
    }
  }
  
  /// Struggling to understand what to call this
  func processMatches(
    for syntax: Markdown.Syntax,
    //    for pattern: any RegexComponent,
    in text: String,

  ) {

    switch self {
      case .wrap(let pattern):
        
//        guard  else {
//          print("Couldn't convert strongly-typed pattern to Regex with AnyRegexOutput")
//        }
//        guard let anyPattern = syntax.pattern else { return }
//        guard let thing = Regex(anyPattern.regex) else { return }
        
        
        
//        guard let patt = syntax.toAnyRegex() else { return }
        //        guard let thing = Regex(patt, as: Self.Wrap.self) else { return }

        //        guard let patt = syntax.pattern, let thing = patt as? Self.Wrap.Type else { return }

        let matches = text.matches(of: patt.regex)

        for match in matches {
          
          guard let values = match.output.extractValues(as: Self.Wrap.self) else {
            continue
          }
          
          print("Values: \(values)")
        }

      //        for path in matchKeyPaths {
      //
      //        }
      //        let thing = Regex.init(pattern, as: Self.Wrap)

      //      case .prefix:
      //        <#code#>
      //      case .single:
      //        <#code#>
      //      case .codeBlock:
      //        <#code#>
      //      case .wrapPair:
      //        <#code#>

      default: fatalError("Not hooked up yet")
    }

    //    for match in text.matches(of: pattern) {
    //    }
  }

//  private func findPathsOrSomething(
//    match: Regex<AnyRegexOutput>.Match,
//    //    match: Regex<T>.Match,
//  ) {
//    let thing = match.output.extractValues(as: <#T##Output.Type#>)
//  }
}
