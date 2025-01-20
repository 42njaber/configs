
if exists("b:current_syntax")
	finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax match Operator "\^\|=\|//\|\*\|/\|%\|+\|-\|\.\|==\|!=\|<\|<=\|>\|>=\|&\||"

syntax keyword tpt2IntType int contained
syntax keyword tpt2DoubleType double contained
syntax keyword tpt2StringType string contained

syn match tpt2IntPrefix "\<i" contained
syn match tpt2DoublePrefix "\<d" contained
syn match tpt2StringPrefix "\<s" contained

syn keyword tpt2Local local contained
syn keyword tpt2Global global contained

syn match tpt2LocalPrefix "\<l" contained
syn match tpt2GlobalPrefix "\<g" contained

syntax match tpt2LocalVariable "^:local \(int\|string\|double\) [a-zA-Z][a-zA-Z0-9._]*$" contains=tpt2IntType,tpt2DoubleType,tpt2StringType
syntax match tpt2GlobalVariable "^:global \(int\|string\|double\) [a-zA-Z][a-zA-Z0-9._]*$" contains=tpt2IntType,tpt2DoubleType,tpt2StringType

syntax match tpt2Label "^\zs[a-zA-Z][a-zA-Z0-9]*:"

syntax match tpt2Impulse "^\s*\(wakeup\|key.[a-z0-9]\|open\.\(mine\|factory\|workshop\|powerplant\|museum\)\|game.newround\)()\s*$"


syn match tpt2Int "\<\d\+\>"
syn match tpt2Double "\<\d\+\.\(\d*\>\)\?"

syn match tpt2String '"[^"]*"'
syn match tpt2String "'[^']*'"

syn match tpt2IntFunction "\(local\|global\)\.int\.\(get\|set\)(\@=" contains=tpt2Local,tpt2Global
syn match tpt2IntFunction "\([gl]i[gs]\|d2i\)(\@=" contains=tpt2LocalPrefix,tpt2GlobalPrefix,tpt2DoublePrefix
syn match tpt2IntFunction "\(string.length\|len\)(\@=" contains=tpt2StringType

syn match tpt2DoubleFunction "\(local\|global\)\.double\.\(get\|set\)(\@=" contains=tpt2Local,tpt2Global
syn match tpt2DoubleFunction "\([gl]d[gs]\|i2d\)(\@=" contains=tpt2LocalPrefix,tpt2GlobalPrefix,tpt2IntPrefix
syn match tpt2DoubleFunction "\(const.pi\)()"

syn match tpt2StringFunction "\(local\|global\)\.string\.\(get\|set\)(\@=" contains=tpt2Local,tpt2Global
syn match tpt2StringFunction "\([gl]s[gs]\|[id]2s\)(\@=" contains=tpt2LocalPrefix,tpt2GlobalPrefix,tpt2IntPrefix,tpt2DoubleType
syn match tpt2StringFunction "\(concat\|sub\(string\)\?\)(\@="

syn match tpt2FlowFunction "\(goto\(if\)\?\|execute\(sync\)\?\|stop\|wait\(while\|until\)\?\|if\)(\@="

syn keyword tpt2Todo TODO FIXME XXX contained
syn match tpt2Comment ";.*$" contains=tpt2String

let w:preproc_no_comments = 1 
let w:preproc_no_comment_fold = 1 
let w:preproc_no_fold_conditions = 1 
let w:preproc_no_if0 = 1 

function! AssignMatches()
	let l:i = 1
	while (l:i <= line('$'))
		let l:line = getline(l:i)
		let l:global = matchstr(l:line, '^:global \(int\|string\|double\) \zs[a-zA-Z][a-zA-Z0-9._]*$')
		if (!empty(l:global))
			call matchadd("tpt2GlobalVariable", '[a-zA-Z0-9._]\@<!\V' . l:global . '\m[a-zA-Z0-9._]\@!', -10)
		endif
		let l:local = matchstr(l:line, '^:local \(int\|string\|double\) \zs[a-zA-Z][a-zA-Z0-9._]*$')
		if (!empty(l:local))
			call matchadd("tpt2LocalVariable", '[a-zA-Z0-9._]\@<!\V' . l:local . '\m[a-zA-Z0-9._]\@!', -20)
		endif
		let l:label = matchstr(l:line, '^\zs[a-zA-Z][a-zA-Z0-9]*\ze:')
		if (!empty(l:label))
			call matchadd("tpt2Label", '[a-zA-Z0-9._]\@<!\V' . l:label . '\m[a-zA-Z0-9._]\@!', -30)
		endif
		let l:i += 1
	endwhile
endfunc

call AssignMatches()

augroup tpt2variablescollection
	au!
	" au BufRead,BufNewFile,TextChanged,TextChangedI *.tpt2 call AssignMatches()
augroup END

" bool comparison.<typeext>(<typeext>, op_comp, <typeext>)
" <type> arithmetic.<type>(<type>, op_mod, <type>)
" 
" 
" double const.pi() Number
" 
" <num> <num>.min(<num>, <num>)
" <num> <num>.max(<num>, <num>)
" <num> <num>.rnd(<num>, <num>)
" 
" void min(void, void) {Number number min (a, b)}
" void max(void, void) {Number number max (a, b)}
" void rnd(void, void) {Number number rnd (min, max)}
" double double.floor(double) Number
" double double.ceil(double) Number
" double double.round(double) Number
" 
" 
" double vec2.x(vector) Vector
" double vec2.y(vector) Vector
" vector vec.fromCoords(double:x, double:y) Vector #vec#
" vector mouse.position() Vector
" 
" void generic.execute(string:script) Generic
" void generic.executesync(string:script) Generic
" void generic.stop(string:script) Generic
" void generic.wait(double:seconds) Generic
" void generic.waitwhile(bool) Generic
" void generic.waituntil(bool) Generic
" void generic.goto(label) Generic
" void generic.gotoif(label, bool) Generic
" void generic.click(vector) Generic
" void generic.slider(vector:where, double:value[0-1]) Generic
" void generic.scrollrect(vector:where, double:horizontal[scroll], double:vertical[scroll]) Generic #scrollbar#
" 
" int screen.width() Generic
" int screen.height() Generic
" double screen.width.d() Generic #width.d#
" double screen.height.d() Generic #height.d#
" 
" bool town.window.isopen(string:window[window]) Town
" void town.window.show(string:window[window], bool) Town
" 
" bool tower.stunned() Tower
" int tower.buffs.negative() Tower
" double tower.health(bool:percent) Tower
" double tower.health.max() Tower #health.max#
" double tower.health.regeneration() Tower #health.regen#
" double tower.energy(bool:percent) Tower
" double tower.energy.max() Tower #energy.max#
" double tower.energy.regeneration() Tower #energy.regen#
" double tower.shield(bool:percent) Tower
" double tower.shield.max() Tower #shield.max#
" double tower.module.cooldown(int:skill) Tower
" void tower.module.useinstant(int:skill) Tower
" 
" void powerplant.sell(int:x[sellx], int:y[selly]) Power Plant
" 
" void mine.newlayer() Mine
" void mine.dig(int:x[dig], int:y[dig]) Mine
" 
" bool factory.machine.active(string:machine[machine]) Factory
" double factory.items.count(string:item[item], int:tier[tier]) Factory
" void factory.craft(string:item[craft], int:tier[tier], double:amount) Factory
" void factory.produce(string:item[produce], int:tier[tier], double:amount, string:machine[machine]) Factory
" 
" bool museum.isfill() Museum
" int museum.freeSlots(string:inventory[inv]) Museum
" int museum.stone.tier(string:inventory[inv], int:slot) Museum
" string museum.stone.element(string:inventory[inv], int:slot) Museum
" void museum.fill(bool:enable) Museum
" void museum.buy(string:element[element]) Museum
" void museum.buyMarket(string:element[elementMarket], int:tier) Museum
" void museum.combine(int:tierMax) Museum
" void museum.transmute() Museum
" void museum.move(string:from[inv], int:slot, string:to[inv]) Museum
" void museum.delete(string:inventory[inv], int:slot) Museum
" void museum.clear(string:inventory[inv]) Museum
" 
" int tradingpost.offerCount() Trading Post
" void tradingpost.refresh() Trading Post
" void tradingpost.trade(int:offer, double:pct[0-1]) Trading Post
" 
" void clickrel(double:x[0-1], double:y[0-1]) Shortcut
