//
//  Theme.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/12/2025.
//

//import AppKit
//import CoreTools
//import EditorCore

/// - Theme does not parse Markdown
/// - Theme does not know about AST shape
/// - Theme *does* know how to style roles for a given syntax
//public protocol MarkdownTheme {
//  typealias StyleTokens = [StyleRole: StyleToken]
//
//  var styleDefinitions: [AnyHashable: StyleTokens] { get set }
//
//  //  public protocol Theme: AnyObject {
//  /// Base font
//  //    var font: NSFont { get set }
//
//  /// Default text/base colour
//  var textColour: NSColor { get }
//
//  func styleToken(kind: SemanticKind, role: StyleRole) -> StyleToken?
//  func defaultToken(for role: StyleRole) -> StyleToken
//
//  //    static var `default`: Self { get }
//
//  //    mutating func updateFont(with newFont: NSFont)
//}
