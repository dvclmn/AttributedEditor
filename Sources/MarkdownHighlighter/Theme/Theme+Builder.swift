//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 29/12/2025.
//

@resultBuilder
public struct ThemeBuilder {
  public static func buildBlock(
    _ syntaxRoles: SyntaxRoleDef...
  ) -> [SyntaxRoleDef] {
    syntaxRoles
  }
}
extension ThemeBuilder {
  public static func buildExpression(
    _ expression: [SyntaxRoleDef]
  ) -> [SyntaxRoleDef] {
    expression
  }
}

public struct SyntaxRoleDef {
  var syntax: Markdown.Syntax
  var roles: StyleRoles

  init(_ syntax: Markdown.Syntax, roles: StyleRoles) {
    self.syntax = syntax
    self.roles = roles
  }
}

func Syntax(
  _ syntax: Markdown.Syntax...,
  build: (inout StyleRoles) -> Void
) -> [SyntaxRoleDef] {
  var roles = StyleRoles()
  build(&roles)

  var defs: [SyntaxRoleDef] = []
  
  for syn in syntax {
    defs.append(SyntaxRoleDef(syn, roles: roles))
  }
  return defs
}

extension StyleRoles {
  mutating func set(_ role: StyleRole, _ token: StyleToken?) {
    values[role] = token
  }
}

// convenience functions for more fluent DSL:
func role(_ r: StyleRole, _ token: StyleToken) -> (StyleRole, StyleToken) {
  (r, token)
}

//func Syntax(
//  _ syntax: Markdown.Syntax,
//  build: (inout StyleRole) -> Void
//) -> SyntaxRoleDef {
//  var role = StyleRole()
//  build(&role)
//  return SyntaxRoleDef(syntax, role: role)
//}
