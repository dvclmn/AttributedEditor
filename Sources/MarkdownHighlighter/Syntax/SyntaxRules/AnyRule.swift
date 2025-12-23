//
//  AnyRule.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

//import Foundation
//
//protocol AnySyntaxRule {
//  var syntax: Markdown.Syntax { get }
//  var exposesBlockRange: Bool { get }
//
//  func matches(in text: String) -> [AnyMatch]
//}
//
//struct AnyMatch {
//  let range: Range<String.Index>
//  let captures: [String: Substring]  // capture name → value
//}
//
//public struct AnyRule {
//  public let syntax: Markdown.Syntax
//  public let exposesBlockRange: Bool
//  private let _matches: (String) -> [AnyMatch]
//
//  public init<T>(_ rule: SyntaxRule<T>) {
//    syntax = rule.syntax
//    exposesBlockRange = rule.exposesBlockRange
//
//    _matches = { text in
//      text.matches(of: rule.pattern).compactMap { match in
////        guard let typed = AnyRegexOutput(match).extractValues(as: T.self)
////        else { return nil }
//        
////        let captures: [String: Substring] = match.output.reduce(into: [:]) { partial, match in
////          let thing = partial
////          
////        }
//        return AnyMatch(range: match.range, captures: captures)
////        return AnyMatch(
////          wholeRange: match.range,
////          output: typed,
////          original: match
////        )
//      }
//    }
//  }
//
//  public func matches(in text: String) -> [AnyMatch] {
//    _matches(text)
//  }
//}

//public struct AnyRuleMatch {
//  public let wholeRange: Range<String.Index>
//  public let output: Any
//  public let original: Any
//}

//struct AnyRule: AnySyntaxRule {
//  private let _syntax: Markdown.Syntax
//  private let _exposesBlockRange: Bool
//  private let _matches: (String) -> [AnyMatch]
//
//  var syntax: Markdown.Syntax { _syntax }
//  var exposesBlockRange: Bool { _exposesBlockRange }
//
//  func matches(in text: String) -> [AnyMatch] {
//    _matches(text)
//  }
//
//  init<T>(_ rule: Markdown.SyntaxRule<T>) {
//    _syntax = rule.syntax
//    _exposesBlockRange = rule.exposesBlockRange
//
//    _matches = { text in
//      text.matches(of: rule.pattern).map { match in
//        var captures: [String: Substring] = [:]
//        // Iterate over Regex output shape to extract values
//        Mirror(reflecting: match.1).children.forEach {
//          if let label = $0.label,
//             let value = $0.value as? Substring
//          {
//            captures[label] = value
//          }
//        }
//        return AnyMatch(range: match.0.range, captures: captures)
//      }
//    }
//  }
//}
//
