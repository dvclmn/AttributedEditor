//
//  RegexShape+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import Foundation

public typealias MatchPath<T> = KeyPath<T, Substring>
public typealias ApplyRegex<T> = (MatchPath<T>, Range<String.Index>) ->
  Void

// MARK: - Process Match keypaths
extension Regex {
  fileprivate func apply<T>(
    paths: [MatchPath<T>],
    match: Match,
    perform: ApplyRegex<T>
  ) {
    for path in paths {
      guard let output = match.output as? T else {
        assertionFailure("Unexpected output type")
        return
      }
      let substring = output[keyPath: path]

      /// This range is correct because the `Substring` points into the parent string
      let range = substring.startIndex..<substring.endIndex
      perform(path, range)

    }
  }
}

// MARK: - Create Match output Keypaths
extension Regex where Output == RegexShape.Single {
  public func apply(
    match: Match,
    perform: ApplyRegex<Output>
  ) {
    let paths: [MatchPath<Output>] = [\.self]
    apply(paths: paths, match: match, perform: perform)
  }
}

extension Regex where Output == RegexShape.Prefix {
  public func apply(
    match: Match,
    perform: ApplyRegex<Output>
  ) {
    let paths: [MatchPath<Output>] = [
      \.0,
      \.prefix,
      \.content,
    ]
    apply(paths: paths, match: match, perform: perform)
  }
}

extension Regex where Output == RegexShape.Wrap {
  public func apply(
    match: Match,
    perform: ApplyRegex<Output>
  ) {
    let paths: [MatchPath<Output>] = [
      \.0,
      \.leading,
      \.content,
      \.trailing,
    ]
    apply(paths: paths, match: match, perform: perform)
  }
}

extension Regex where Output == RegexShape.CodeBlock {
  public func apply(
    match: Match,
    perform: ApplyRegex<Output>
  ) {
    let paths: [MatchPath<Output>] = [
      \.0,
      \.start,
      \.langHint,
      \.content,
      \.end,
    ]
    apply(paths: paths, match: match, perform: perform)
  }
}

extension Regex where Output == RegexShape.WrapPair {
  public func apply(
    match: Match,
    perform: ApplyRegex<Output>
  ) {
    let paths: [MatchPath<Output>] = [
      \.0,
      \.prefix,
      \.leadingA,
      \.title,
      \.trailingA,
      \.leadingB,
      \.url,
      \.trailingB,
    ]
    apply(paths: paths, match: match, perform: perform)
  }
}
