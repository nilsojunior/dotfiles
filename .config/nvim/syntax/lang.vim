syntax keyword yourlangKeyword if else for while return int fn str struct in until match def repeat
syntax match yourlangComment "--.*"
syntax match yourlangString /"\(\\.\|[^"]\)*"/

highlight link yourlangKeyword Keyword
highlight link yourlangComment Comment
highlight link yourlangString String
