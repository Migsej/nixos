hook global BufCreate .+\.(lean) %{
  set-option buffer filetype lean
}

hook global WinSetOption filetype=lean %{
  require-module lean


  add-highlighter window/lean ref lean

}

provide-module lean %{
  
  add-highlighter shared/lean regions
  add-highlighter shared/lean/code default-region group

  add-highlighter shared/lean/onelinecomment region '--' '$' fill comment
  add-highlighter shared/lean/multilinecomment region -recurse /- /- -/ fill comment
  add-highlighter shared/lean/string region '"'   (?<!\\)(\\\\)*"  fill string

  add-highlighter shared/lean/code/number regex [\d]+(\.\d*)? 0:value
  add-highlighter shared/lean/code/sorry regex \bsorry\b 0:red

  add-highlighter shared/lean/code/command regex '#(print|exit|eval|check|reduce)\b' 0:meta
  add-highlighter shared/lean/code/keyword regex '\b(import|prelude|protected|private|noncomputable|def|definition|renaming|hiding|parameter|parameters|begin|conjecture|constant|constants|lemma|variable|variables|theory|theorem|notation|example|open|axiom|inductive|instance|class|with|structure|record|universe|universes|alias|help|reserve|match|infix|infixl|infixr|notation|postfix|prefix|meta|run_cmd|do|end|this|suppose|using|namespace|section|fields|attribute|local|set_option|extends|include|omit|calc|have|show|suffices|by|in|at|let|if|then|else|assume|assert|take|obtain|from)\b' 0:keyword
  add-highlighter shared/lean/code/type regex '\b(Type|Sort|Prop)\b' 0:type
}
