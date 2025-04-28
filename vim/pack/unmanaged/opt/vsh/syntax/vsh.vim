
let &syntax=fnamemodify(&shell, ":t")

syn match shSpecial /^>/
syn match shString /\(^>\)\@<=.*$/

syn match shSpecial /^</
syn match shString /\(^<\)\@<=.*$/
