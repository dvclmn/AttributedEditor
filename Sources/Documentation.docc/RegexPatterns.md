# Backups of some Regex Patterns

In case they're useful in future

I'm going to refer to the backtick character as a "b", to avoid breaking markdown formatting.

body
—

heading1
heading2
heading3
heading4
heading5
heading6
```
/(?<leading>\s*#)(?<content>[^#*]*?)(?<trailing>)/
```



bold
italic
boldItalic

inlineCode
codeBlock
```
/(?<leading>bbb[a-zA-Z]*)\n(?<content>.*?)(?<trailing>bbb)/
```



```
bbb[^\\n]*\\n[\\s\\S]*?bbb
```



list
```
/(?<leading>\[)(?<content>[^\]]+)(?<trailing>\]\([^\)]+\))/
```


quoteBlock
```
/(?<leading>^>)(?<content>[^>\n]+)(?<trailing>)/
```



callout

strikethrough
highlight

link
```
/(?<leading>\[)(?<content>[^\]]+)(?<trailing>\]\([^\)]+\))/
```


image
```
/(?<leading>!\[)(?<content>[^\]]+)(?<trailing>\]\([^\)]+\))/
```

horizontalRule

## Snippets (legacy `NSRegularExpression`)

Emphasised content: `(.*?)`
Italic Syntax: `"(_|\\*)"`
Bold Syntax: `"(__|\\*\\*)"`
BoldItalic Syntax: `"(___|\\*\\*\\*)"`

heading: `"^(#{\(level)})\\s+(.+)"`
inlineCode: `"(b)((?:[^`\n])+?)(b)"`
strikethrough: `"(~~)([^~]*?)(~~)"`
italic: `italicSyntax + emphasisContent + italicSyntax`
bold: `boldSyntax + emphasisContent + boldSyntax`
boldItalic: `boldItalicSyntax + emphasisContent + boldItalicSyntax`
codeBlock: `"(bbb(?:\\s*\\w+\\s?)\n)([\\s\\S]*?)(\\nbbb)"`
highlight: `"==([^=]+)==(?!=)"`
list: `"^\\s{0,3}([-*]|\\d+\\.)\\s+(.+)$"`
horizontalRule: `"^[-*_]{3,}$"`
quoteBlock: `"^>\\s*(.+)"`
link: `"(\\[)(.*?)(\\]\\()(.*?)(\\))"`
image: `"(!\\[)(.*?)(\\]\\()(.*?)(\\))"`
body: `nil`
