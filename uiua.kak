
# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](ua) %{
    set-option buffer filetype uiua
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=uiua %{
    require-module uiua


    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window uiua-.+ }
}

hook -group uiua-highlight global WinSetOption filetype=uiua %{
    add-highlighter window/uiua ref uiua
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/uiua }
}

provide-module uiua %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/uiua regions
add-highlighter shared/uiua/code default-region group
add-highlighter shared/uiua/string-format region \$" '"'             fill string
add-highlighter shared/uiua/string  region '"' (?<!\\)(\\\\)*" fill string
add-highlighter shared/uiua/string-multiline region '\$' '$'             fill string
add-highlighter shared/uiua/comment region '#' '$'             fill comment

add-highlighter shared/uiua/code/ regex \\b[a-zA-Z]+[!‼]*\\b 0:variable
add-highlighter shared/uiua/code/ regex \*[a-zA-Z][\w!$%&*+./:<=>?@^_~-]*\* 0:variable

add-highlighter shared/uiua/code/ regex @(\\\\(x[0-9A-Fa-f]{2}|u[0-9A-Fa-f]{4}|.)|.) 0:value 
add-highlighter shared/uiua/code/ regex [`¯]?(\\d+|η|π|τ|∞|eta|pi|tau|inf(i(n(i(t(y)?)?)?)?)?)([./]\\d+|e[+-]?\\d+)? 0:value 
add-highlighter shared/uiua/code/ regex [.,:◌?⸮∘]|(?<![a-zA-Z$])(dup(l(i(c(a(t(e)?)?)?)?)?)?|over|flip|po(p)?|stack|trac(e)?|id(e(n(t(i(t(y)?)?)?)?)?)?)(?![a-zA-Z]) 0:operator

add-highlighter shared/uiua/code/ regex [⚂]|(?<![a-zA-Z$])(rand(o(m)?)?|tag|now|&sc|&ts|&args|&clget|&asr|&clget|&args|&asr|&ts|&sc|now|tag)(?![a-zA-Z]) 0:rgb:ed5e6a
add-highlighter shared/uiua/code/ regex "[¬±¯`⌵√∿⌊⌈⁅⧻△⇡⊢⇌♭¤⋯⍉⍏⍖⊚⊛◴◰□⋕]|(?<![a-zA-Z$])(not|sig(n)?|neg(a(t(e)?)?)?|abs(o(l(u(t(e( (v(a(l(u(e)?)?)?)?)?)?)?)?)?)?)?|sqr(t)?|sin(e)?|flo(o(r)?)?|cei(l(i(n(g)?)?)?)?|rou(n(d)?)?|len(g(t(h)?)?)?|sha(p(e)?)?|ran(g(e)?)?|fir(s(t)?)?|rev(e(r(s(e)?)?)?)?|des(h(a(p(e)?)?)?)?|fix|bit(s)?|tra(n(s(p(o(s(e)?)?)?)?)?)?|ris(e)?|fal(l)?|whe(r(e)?)?|cla(s(s(i(f(y)?)?)?)?)?|ded(u(p(l(i(c(a(t(e)?)?)?)?)?)?)?)?|uni(q(u(e)?)?)?|box|pars(e)?|wait|recv|tryrecv|gen|utf(₈)?|type|datetime|fft|json|csv|xlsx|repr|&s|&pf|&p|&exit|&raw|&var|&runi|&runc|&runs|&cd|&clset|&sl|&invk|&cl|&fo|&fc|&fde|&ftr|&fe|&fld|&fif|&fras|&frab|&ims|&ap|&tcpl|&tlsl|&tcpa|&tcpc|&tlsc|&tcpsnb|&tcpaddr|&camcap|&memfree|&memfree|&tcpaddr|datetime|&camcap|&tcpsnb|tryrecv|&clset|utf₈|&tlsc|&tcpc|&tcpa|&tlsl|&tcpl|&frab|&fras|&invk|&runs|&runc|&runi|&exit|&ims|&fif|&fld|&ftr|&fde|&var|&raw|repr|xlsx|json|type|recv|wait|&ap|&fe|&fc|&fo|&cl|&sl|&cd|&pf|csv|fft|gen|&p|&s)(?![a-zA-Z])|⋊[a-zA-Z]*" 0:rgb:95d16a
# add-highlighter shared/uiua/code/ regex "[==≠<≤>≥+\\-×\\*÷%◿ⁿₙ↧↥∠ℂ≍⊟⊂⊏⊡↯☇↙↘↻⮌◫▽⌕⦷∊⊗⍤]|(?<![a-zA-Z$])(equals|not (e(q(u(a(l(s)?)?)?)?)?)?|less than|les(s( (o(r( (e(q(u(a(l)?)?)?)?)?)?)?)?)?)?|greater than|gre(a(t(e(r( (o(r( (e(q(u(a(l)?)?)?)?)?)?)?)?)?)?)?)?)?|add|subtract|mul(t(i(p(l(y)?)?)?)?)?|div(i(d(e)?)?)?|mod(u(l(u(s)?)?)?)?|pow(e(r)?)?|log(a(r(i(t(h(m)?)?)?)?)?)?|min(i(m(u(m)?)?)?)?|max(i(m(u(m)?)?)?)?|ata(n(g(e(n(t)?)?)?)?)?|com(p(l(e(x)?)?)?)?|mat(c(h)?)?|cou(p(l(e)?)?)?|joi(n)?|sel(e(c(t)?)?)?|pic(k)?|res(h(a(p(e)?)?)?)?|rer(a(n(k)?)?)?|tak(e)?|dro(p)?|rot(a(t(e)?)?)?|ori(e(n(t)?)?)?|win(d(o(w(s)?)?)?)?|chunk(s)?|kee(p)?|fin(d)?|mas(k)?|mem(b(e(r)?)?)?|ind(e(x(o(f)?)?)?)?|ass(e(r(t)?)?)?|send|regex|map|has|get|remove|&rs|&rb|&ru|&w|&fwa|&ime|&gife|&gifs|&ae|&tcpsrt|&tcpswt|&ffi|&tcpswt|&tcpsrt|remove|chunks|&gifs|&gife|regex|&ffi|&ime|&fwa|send|&ae|&ru|&rb|&rs|get|has|map|&w)" 0:rgb:54b0fc
add-highlighter shared/uiua/code/ regex "[/∧\\\\∵≡⊞⍚⍥⊕⊜◹◇⋅⊙⟜⤙⤚◠◡⊸∩¨°]|(?<![a-zA-Z$])(reduce|fol(d)?|scan|eac(h)?|row(s)?|tab(l(e)?)?|inv(e(n(t(o(r(y)?)?)?)?)?)?|rep(e(a(t)?)?)?|gro(u(p)?)?|par(t(i(t(i(o(n)?)?)?)?)?)?|tri(a(n(g(l(e)?)?)?)?)?|con(t(e(n(t)?)?)?)?|ga(p)?|dip|on|but|wit(h)?|abo(v(e)?)?|bel(o(w)?)?|by|bot(h)?|bac(k(w(a(r(d)?)?)?)?)?|un|case|memo|comptime|spawn|pool|dump|stringify|quote|signature|&ast|signature|stringify|comptime|quote|spawn|&ast|dump|pool|memo|case)(?![a-zA-Z])" 0:rgb:f0c36f
add-highlighter shared/uiua/code/ regex "[⍜⊃⊓⍢⬚⨬⍣]|(?<![a-zA-Z$])(setinv|setund|und(e(r)?)?|for(k)?|bra(c(k(e(t)?)?)?)?|do|fil(l)?|sw(i(t(c(h)?)?)?)?|try|astar|setund|setinv|astar)(?![a-zA-Z])" 0:rgb:cc6be9


# Commands
# ‾‾‾‾‾‾‾‾

define-command -hidden uiua-trim-indent %{
    # remove trailing white spaces
    try %{ execute-keys -draft -itersel x s \h+$ <ret> d }
}


}
