set background=dark
highlight clear

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let colors_name = "custom"
set guifont=Monospace\ 13

" Cterm only for now

" Defaults based on the "slate" colorscheme
set t_Co=256

hi Normal               cterm=NONE         ctermfg=white       ctermbg=black
hi Normal                 gui=NONE           guifg=white         guibg=black

hi SpecialKey                              ctermfg=236
hi SpecialKey                                guifg=#303030
hi Statement                               ctermfg=69
hi Statement              gui=NONE           guifg=#5f87ff
hi NonText              cterm=bold         ctermfg=232
hi NonText                gui=NONE           guifg=lightgrey
hi Question                                ctermfg=green
hi Question                                  guifg=green
hi Title                cterm=bold         ctermfg=yellow
hi Title                  gui=NONE           guifg=#808000
hi String                                  ctermfg=77
hi String                                    guifg=#5fd75f
hi Comment                                 ctermfg=darkgrey
hi Comment                                   guifg=darkgrey
hi Constant                                ctermfg=130
hi Constant                                  guifg=#af5f00
hi Number                                  ctermfg=130
hi Number                                    guifg=#af5f00
hi Special                                 ctermfg=130
hi Special                                   guifg=#af5f00
hi Identifier                              ctermfg=red
hi Identifier                                guifg=red
hi Include                                 ctermfg=red
hi Include                                   guifg=red
hi PreProc                                 ctermfg=red
hi PreProc                                   guifg=red
hi Operator                                ctermfg=red
hi Operator                                  guifg=red
hi Define                                  ctermfg=yellow
hi Define                                    guifg=yellow
hi Type                                    ctermfg=darkgreen
hi Type                                      guifg=darkgreen
hi Function                                ctermfg=130
hi Function                                  guifg=#af5f00
hi Structure                               ctermfg=green
hi Structure                                 guifg=green
hi CustomTypes          cterm=NONE         ctermfg=166         ctermbg=NONE
hi CustomTypes            gui=NONE           guifg=NONE          guibg=NONE
hi GroupChars           cterm=NONE         ctermfg=243         ctermbg=NONE
hi GroupChars             gui=NONE           guifg=NONE          guibg=NONE

hi CursorLine           cterm=NONE         ctermfg=NONE        ctermbg=233
hi CursorLine             gui=NONE           guifg=NONE          guibg=NONE
hi def link CustomCursorLine CursorLine
hi ColorColumn                             ctermfg=202         ctermbg=235
hi ColorColumn                               guifg=NONE          guibg=NONE

hi Visual               cterm=NONE         ctermfg=NONE        ctermbg=238
hi Visual                 gui=NONE           guifg=NONE          guibg=NONE
hi VisualNOS            cterm=NONE         ctermfg=NONE        ctermbg=238
hi VisualNOS              gui=NONE           guifg=NONE          guibg=NONE

hi MatchParen           cterm=NONE         ctermfg=NONE        ctermbg=235
hi MatchParen             gui=NONE           guifg=gray          guibg=NONE

hi Search               cterm=underline    ctermfg=NONE        ctermbg=NONE
hi Search                 gui=underline      guifg=NONE          guibg=NONE
hi IncSearch            cterm=NONE         ctermfg=NONE        ctermbg=cyan
hi IncSearch              gui=NONE           guifg=NONE          guibg=cyan

hi Folded                                  ctermfg=yellow      ctermbg=235
hi Folded                                    guifg=yellow        guibg=darkgrey
hi FoldColumn                              ctermfg=lightgray   ctermbg=black
hi FoldColumn                                guifg=lightgray     guibg=black

hi TabLine              cterm=NONE         ctermfg=black       ctermbg=69
"hi TabLine                gui=bold,reverse                       ctermbg=153
hi TabLineEm            cterm=bold         ctermfg=darkred     ctermbg=69
"hi TabLineEm              gui=bold,reverse                       ctermbg=153

hi TabLineSel           cterm=NONE         ctermfg=white       ctermbg=black
"hi TabLineSel             gui=reverse                          ctermbg=69
hi TabLineSelEm         cterm=bold         ctermfg=red         ctermbg=black
"hi TabLineSelEm           gui=bold,reverse                       ctermbg=69

hi TabLineFill          cterm=NONE         ctermfg=black       ctermbg=153
"hi TabLineFill            gui=bold,reverse                       ctermbg=69

hi StatusLine           cterm=NONE         ctermfg=black       ctermbg=69
"hi StatusLine             gui=bold,reverse                       ctermbg=69
hi StatusLineNC         cterm=NONE         ctermfg=black       ctermbg=153
"hi StatusLineNC           gui=reverse                          ctermbg=69

hi User1                cterm=bold         ctermfg=red         ctermbg=69
" hi User1                                     guifg=red
hi User2                                   ctermfg=red         ctermbg=black
" hi User2                                     guifg=red           guibg=black

hi LineNr                                  ctermfg=yellow
hi LineNr                                    guifg=yellow

hi WildMenu                                ctermfg=black       ctermbg=yellow
hi WildMenu                                  guifg=black         guibg=yellow

hi VertSplit            cterm=reverse
hi VertSplit              gui=reverse

hi ErrorMsg             cterm=bold         ctermfg=white       ctermbg=red
hi ErrorMsg               gui=bold           guifg=white         guibg=red
hi WarningMsg                              ctermfg=red
hi WarningMsg                                guifg=red
hi ModeMsg              cterm=none         ctermfg=130
hi ModeMsg                gui=none           guifg=#af5f00
hi MoreMsg                                 ctermfg=darkgreen
hi MoreMsg                                   guifg=darkgreen

hi Ignore               cterm=bold         ctermfg=white
hi Ignore                 gui=bold           guifg=white
hi Directory                               ctermfg=darkcyan
hi Directory                                 guifg=darkcyan

hi DiffAdd                                                     ctermbg=022
hi DiffAdd                                                       guibg=NONE
hi DiffDelete                                                  ctermbg=052
hi DiffDelete                                                    guibg=NONE
hi DiffChange                                                  ctermbg=018
hi DiffChange                                                    guibg=NONE
hi DiffText                                                    ctermbg=130
hi DiffText                                                      guibg=NONE

hi Underlined           cterm=underline    ctermfg=magenta
hi Underlined             gui=underline      guifg=magenta

hi Error                cterm=bold         ctermfg=white       ctermbg=red
hi Error                  gui=bold           guifg=white         guibg=red
hi SpellErrors          cterm=bold         ctermfg=white       ctermbg=red
hi SpellErrors            gui=bold           guifg=white         guibg=red

" Make colorscheme

hi makeTarget           cterm=bold         ctermfg=12
hi makeTarget             gui=bold           guifg=NONE
hi makeIdent            cterm=bold         ctermfg=34
hi makeIdent              gui=bold           guifg=orange
hi makeIdentAssign      cterm=NONE         ctermfg=yellow
hi makeIdentAssign        gui=NONE           guifg=yellow
hi makeStatement        cterm=bold         ctermfg=red
hi makeStatement          gui=bold           guifg=red
hi makeRulePattern                         ctermfg=green
hi makeRulePattern                           guifg=green

" Colors
"
hi vimColor0                               ctermfg=0           ctermbg=white
hi vimColor1                               ctermfg=1
hi vimColor2                               ctermfg=2
hi vimColor3                               ctermfg=3
hi vimColor4                               ctermfg=4
hi vimColor5                               ctermfg=5
hi vimColor6                               ctermfg=6
hi vimColor7                               ctermfg=7
hi vimColor8                               ctermfg=8
hi vimColor9                               ctermfg=9
hi vimColor10                              ctermfg=10
hi vimColor11                              ctermfg=11
hi vimColor12                              ctermfg=12
hi vimColor13                              ctermfg=13
hi vimColor14                              ctermfg=14
hi vimColor15                              ctermfg=15
hi vimColor16                              ctermfg=16          ctermbg=white
hi vimColor17                              ctermfg=17
hi vimColor18                              ctermfg=18
hi vimColor19                              ctermfg=19
hi vimColor20                              ctermfg=20
hi vimColor21                              ctermfg=21
hi vimColor22                              ctermfg=22
hi vimColor23                              ctermfg=23
hi vimColor24                              ctermfg=24
hi vimColor25                              ctermfg=25
hi vimColor26                              ctermfg=26
hi vimColor27                              ctermfg=27
hi vimColor28                              ctermfg=28
hi vimColor29                              ctermfg=29
hi vimColor30                              ctermfg=30
hi vimColor31                              ctermfg=31
hi vimColor32                              ctermfg=32
hi vimColor33                              ctermfg=33
hi vimColor34                              ctermfg=34
hi vimColor35                              ctermfg=35
hi vimColor36                              ctermfg=36
hi vimColor37                              ctermfg=37
hi vimColor38                              ctermfg=38
hi vimColor39                              ctermfg=39
hi vimColor40                              ctermfg=40
hi vimColor41                              ctermfg=41
hi vimColor42                              ctermfg=42
hi vimColor43                              ctermfg=43
hi vimColor44                              ctermfg=44
hi vimColor45                              ctermfg=45
hi vimColor46                              ctermfg=46
hi vimColor47                              ctermfg=47
hi vimColor48                              ctermfg=48
hi vimColor49                              ctermfg=49
hi vimColor50                              ctermfg=50
hi vimColor51                              ctermfg=51
hi vimColor52                              ctermfg=52
hi vimColor53                              ctermfg=53
hi vimColor54                              ctermfg=54
hi vimColor55                              ctermfg=55
hi vimColor56                              ctermfg=56
hi vimColor57                              ctermfg=57
hi vimColor58                              ctermfg=58
hi vimColor59                              ctermfg=59
hi vimColor60                              ctermfg=60
hi vimColor61                              ctermfg=61
hi vimColor62                              ctermfg=62
hi vimColor63                              ctermfg=63
hi vimColor64                              ctermfg=64
hi vimColor65                              ctermfg=65
hi vimColor66                              ctermfg=66
hi vimColor67                              ctermfg=67
hi vimColor68                              ctermfg=68
hi vimColor69                              ctermfg=69
hi vimColor70                              ctermfg=70
hi vimColor71                              ctermfg=71
hi vimColor72                              ctermfg=72
hi vimColor73                              ctermfg=73
hi vimColor74                              ctermfg=74
hi vimColor75                              ctermfg=75
hi vimColor76                              ctermfg=76
hi vimColor77                              ctermfg=77
hi vimColor78                              ctermfg=78
hi vimColor79                              ctermfg=79
hi vimColor80                              ctermfg=80
hi vimColor81                              ctermfg=81
hi vimColor82                              ctermfg=82
hi vimColor83                              ctermfg=83
hi vimColor84                              ctermfg=84
hi vimColor85                              ctermfg=85
hi vimColor86                              ctermfg=86
hi vimColor87                              ctermfg=87
hi vimColor88                              ctermfg=88
hi vimColor89                              ctermfg=89
hi vimColor90                              ctermfg=90
hi vimColor91                              ctermfg=91
hi vimColor92                              ctermfg=92
hi vimColor93                              ctermfg=93
hi vimColor94                              ctermfg=94
hi vimColor95                              ctermfg=95
hi vimColor96                              ctermfg=96
hi vimColor97                              ctermfg=97
hi vimColor98                              ctermfg=98
hi vimColor99                              ctermfg=99
hi vimColor100                             ctermfg=100
hi vimColor101                             ctermfg=101
hi vimColor102                             ctermfg=102
hi vimColor103                             ctermfg=103
hi vimColor104                             ctermfg=104
hi vimColor105                             ctermfg=105
hi vimColor106                             ctermfg=106
hi vimColor107                             ctermfg=107
hi vimColor108                             ctermfg=108
hi vimColor109                             ctermfg=109
hi vimColor110                             ctermfg=110
hi vimColor111                             ctermfg=111
hi vimColor112                             ctermfg=112
hi vimColor113                             ctermfg=113
hi vimColor114                             ctermfg=114
hi vimColor115                             ctermfg=115
hi vimColor116                             ctermfg=116
hi vimColor117                             ctermfg=117
hi vimColor118                             ctermfg=118
hi vimColor119                             ctermfg=119
hi vimColor120                             ctermfg=120
hi vimColor121                             ctermfg=121
hi vimColor122                             ctermfg=122
hi vimColor123                             ctermfg=123
hi vimColor124                             ctermfg=124
hi vimColor125                             ctermfg=125
hi vimColor126                             ctermfg=126
hi vimColor127                             ctermfg=127
hi vimColor128                             ctermfg=128
hi vimColor129                             ctermfg=129
hi vimColor130                             ctermfg=130
hi vimColor131                             ctermfg=131
hi vimColor132                             ctermfg=132
hi vimColor133                             ctermfg=133
hi vimColor134                             ctermfg=134
hi vimColor135                             ctermfg=135
hi vimColor136                             ctermfg=136
hi vimColor137                             ctermfg=137
hi vimColor138                             ctermfg=138
hi vimColor139                             ctermfg=139
hi vimColor140                             ctermfg=140
hi vimColor141                             ctermfg=141
hi vimColor142                             ctermfg=142
hi vimColor143                             ctermfg=143
hi vimColor144                             ctermfg=144
hi vimColor145                             ctermfg=145
hi vimColor146                             ctermfg=146
hi vimColor147                             ctermfg=147
hi vimColor148                             ctermfg=148
hi vimColor149                             ctermfg=149
hi vimColor150                             ctermfg=150
hi vimColor151                             ctermfg=151
hi vimColor152                             ctermfg=152
hi vimColor153                             ctermfg=153
hi vimColor154                             ctermfg=154
hi vimColor155                             ctermfg=155
hi vimColor156                             ctermfg=156
hi vimColor157                             ctermfg=157
hi vimColor158                             ctermfg=158
hi vimColor159                             ctermfg=159
hi vimColor160                             ctermfg=160
hi vimColor161                             ctermfg=161
hi vimColor162                             ctermfg=162
hi vimColor163                             ctermfg=163
hi vimColor164                             ctermfg=164
hi vimColor165                             ctermfg=165
hi vimColor166                             ctermfg=166
hi vimColor167                             ctermfg=167
hi vimColor168                             ctermfg=168
hi vimColor169                             ctermfg=169
hi vimColor170                             ctermfg=170
hi vimColor171                             ctermfg=171
hi vimColor172                             ctermfg=172
hi vimColor173                             ctermfg=173
hi vimColor174                             ctermfg=174
hi vimColor175                             ctermfg=175
hi vimColor176                             ctermfg=176
hi vimColor177                             ctermfg=177
hi vimColor178                             ctermfg=178
hi vimColor179                             ctermfg=179
hi vimColor180                             ctermfg=180
hi vimColor181                             ctermfg=181
hi vimColor182                             ctermfg=182
hi vimColor183                             ctermfg=183
hi vimColor184                             ctermfg=184
hi vimColor185                             ctermfg=185
hi vimColor186                             ctermfg=186
hi vimColor187                             ctermfg=187
hi vimColor188                             ctermfg=188
hi vimColor189                             ctermfg=189
hi vimColor190                             ctermfg=190
hi vimColor191                             ctermfg=191
hi vimColor192                             ctermfg=192
hi vimColor193                             ctermfg=193
hi vimColor194                             ctermfg=194
hi vimColor195                             ctermfg=195
hi vimColor196                             ctermfg=196
hi vimColor197                             ctermfg=197
hi vimColor198                             ctermfg=198
hi vimColor199                             ctermfg=199
hi vimColor200                             ctermfg=200
hi vimColor201                             ctermfg=201
hi vimColor202                             ctermfg=202
hi vimColor203                             ctermfg=203
hi vimColor204                             ctermfg=204
hi vimColor205                             ctermfg=205
hi vimColor206                             ctermfg=206
hi vimColor207                             ctermfg=207
hi vimColor208                             ctermfg=208
hi vimColor209                             ctermfg=209
hi vimColor210                             ctermfg=210
hi vimColor211                             ctermfg=211
hi vimColor212                             ctermfg=212
hi vimColor213                             ctermfg=213
hi vimColor214                             ctermfg=214
hi vimColor215                             ctermfg=215
hi vimColor216                             ctermfg=216
hi vimColor217                             ctermfg=217
hi vimColor218                             ctermfg=218
hi vimColor219                             ctermfg=219
hi vimColor220                             ctermfg=220
hi vimColor221                             ctermfg=221
hi vimColor222                             ctermfg=222
hi vimColor223                             ctermfg=223
hi vimColor224                             ctermfg=224
hi vimColor225                             ctermfg=225
hi vimColor226                             ctermfg=226
hi vimColor227                             ctermfg=227
hi vimColor228                             ctermfg=228
hi vimColor229                             ctermfg=229
hi vimColor230                             ctermfg=230
hi vimColor231                             ctermfg=231
hi vimColor232                             ctermfg=232       ctermbg=240
hi vimColor233                             ctermfg=233       ctermbg=239
hi vimColor234                             ctermfg=234
hi vimColor235                             ctermfg=235
hi vimColor236                             ctermfg=236
hi vimColor237                             ctermfg=237
hi vimColor238                             ctermfg=238
hi vimColor239                             ctermfg=239
hi vimColor240                             ctermfg=240
hi vimColor241                             ctermfg=241
hi vimColor242                             ctermfg=242
hi vimColor243                             ctermfg=243
hi vimColor244                             ctermfg=244
hi vimColor245                             ctermfg=245
hi vimColor246                             ctermfg=246
hi vimColor247                             ctermfg=247
hi vimColor248                             ctermfg=248
hi vimColor249                             ctermfg=249
hi vimColor250                             ctermfg=250
hi vimColor251                             ctermfg=251
hi vimColor252                             ctermfg=252
hi vimColor253                             ctermfg=253
hi vimColor254                             ctermfg=254
hi vimColor255                             ctermfg=255
