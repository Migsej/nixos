hook global BufCreate .+\.(typ|typst) %{
  set-option buffer filetype typst
}

hook global WinSetOption filetype=typst %{
  require-module typst
}

hook -group typst-highlight global WinSetOption filetype=typst %{
  add-highlighter window/typst ref typst
  hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/typst }
}

provide-module typst %{

  add-highlighter shared/typst regions
  add-highlighter shared/typst/comment region '/\*' '\*/' fill comment
  add-highlighter shared/typst/line-comment region '//' '\n' fill comment

  add-highlighter shared/typst/code default-region group

  add-highlighter shared/typst/code/ regex '^=[^\n]*' 0:header
  add-highlighter shared/typst/code/ regex '#[A-Za-z]+' 0:keyword
  add-highlighter shared/typst/code/ regex '\$[^$]*\$' 0:type
}
