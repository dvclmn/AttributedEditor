//
//  RegexShape+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import Foundation

public typealias MatchPath<T> = KeyPath<T, Substring>
public typealias ApplyRegex<T> = (MatchPath<T>, Range<String.Index>) -> Void
public typealias NSApplyRegex<T> = (MatchPath<T>, NSRange) -> Void

// MARK: - Process Match keypaths
extension Regex {
//  fileprivate func processMatch<T>(
//    paths: [MatchPath<T>],
//    match: Match,
//    perform: ApplyRegex<T>
//  ) {
//    for path in paths {
//      guard let output = match.output as? T else {
//        assertionFailure("Unexpected output type")
//        return
//      }
//      let substring = output[keyPath: path]
//
//      /// This range is correct because the `Substring` points into the parent string
//      let range = substring.startIndex..<substring.endIndex
//
//      perform(path, range)
//    }
//  }
//
//  fileprivate func processMatchWithNSRange<T>(
//    in text: String,
//    paths: [MatchPath<T>],
//    match: Match,
//    perform: NSApplyRegex<T>
//  ) {
//    for path in paths {
//      guard let output = match.output as? T else {
//        assertionFailure("Unexpected output type")
//        return
//      }
//
//      /// 1. Get the substring from the keypath
//      let substring = output[keyPath: path]
//
//      /// 2. Identify the range in Swift indices
//      let range = substring.startIndex..<substring.endIndex
//
//      let rangeAlt = match.range
//
//      /// 3. Convert to NSRange
//      /// Use `substring.base` to calculate the offsets relative
//      /// to the entire original string, not just the match.
//      let nsRange = NSRange(rangeAlt, in: text)
//      //      let nsRange = NSRange(rangeAlt, in: substring.base)
//
//      perform(path, nsRange)
//
//    }
//  }
}

// MARK: - Create Match output Keypaths
//extension Regex where Output == RegexShape.Single {
//  public func processMatch(
//    match: Match,
//    perform: NSApplyRegex<Output>
//    //    perform: ApplyRegex<Output>
//  ) {
//    let paths: [MatchPath<Output>] = [\.self]
//    processMatchWithNSRange(paths: paths, match: match, perform: perform)
//  }
//}
//
////extension Regex where Output == RegexShape.Prefix {
////  public func processMatch(
////    _ match: Match,
////    perform: NSApplyRegex<Output>
////  ) {
////    let paths: [MatchPath<Output>] = [
////      \.0,
////      \.prefix,
////      \.content,
////    ]
////    processMatchWithNSRange(paths: paths, match: match, perform: perform)
////    //    apply(paths: paths, match: match, perform: perform)
////  }
////}
//
//extension Regex where Output == RegexShape.Wrap {
//  public func processMatch(
//    _ match: Match,
//    perform: NSApplyRegex<Output>
//  ) {
//    let paths: [MatchPath<Output>] = [
//      \.0,
//      \.leading,
//      \.content,
//      \.trailing,
//    ]
//    processMatchWithNSRange(in: <#String#>, paths: paths, match: match, perform: perform)
//    //    apply(paths: paths, match: match, perform: perform)
//  }
//}
//
//extension Regex where Output == RegexShape.CodeBlock {
//  public func processMatch(
//    _ match: Match,
//    perform: NSApplyRegex<Output>
//  ) {
//    let paths: [MatchPath<Output>] = [
//      \.0,
//      \.start,
//      \.langHint,
//      \.content,
//      \.end,
//    ]
//    processMatchWithNSRange(paths: paths, match: match, perform: perform)
//    //    apply(paths: paths, match: match, perform: perform)
//  }
//}
//
//extension Regex where Output == RegexShape.WrapPair {
//  public func processMatch(
//    _ match: Match,
//    perform: NSApplyRegex<Output>
//  ) {
//    let paths: [MatchPath<Output>] = [
//      \.0,
//      \.prefix,
//      \.leadingA,
//      \.title,
//      \.trailingA,
//      \.leadingB,
//      \.url,
//      \.trailingB,
//    ]
//    processMatchWithNSRange(paths: paths, match: match, perform: perform)
//    //    apply(paths: paths, match: match, perform: perform)
//  }
//}
