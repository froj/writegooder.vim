"
" Toggle writegooder mode
"
function! writegooder#toggle()
    call writegooder#init()

    if empty(w:writegooder_on)
        call writegooder#enable()
    else
        call writegooder#disable()
    endif
endfunction

"
" Init the w:writegooder_on variable.
"
function! writegooder#init()
  let w:writegooder_on = exists('w:writegooder_on') ? w:writegooder_on : 0
endfunction

"
" Turn on all match highlighting
"
function! writegooder#enable()
    let w:writegooder_on = 1
    " Highlight duplicates
    call writegooder#highlight_dups()
    " Highlight weasel words
    call writegooder#highlight_weasel()
    " Highlight passive voice
    call writegooder#highlight_passive()
    " swears
    call writegooder#swears()
endfunction

"
" Deletes all matches
"
function! writegooder#disable()
    call matchdelete(s:dups)
    call matchdelete(s:passive)
    call matchdelete(s:weasel)
    call matchdelete(s:swears)
    let w:writegooder_on = 0
endfunction!

"
" Pattern for highlighting duplicate words, works across lines.
"
function writegooder#highlight_dups()
    let s:dups=matchadd('Error', '\v(<\w+>)\_s*<\1>', 10)
endfunction

"
" Weasel words take from Matt Might's blog.
"
function writegooder#highlight_weasel()
    let s:weasel=matchadd('Error', '\c\v<many>|<various>|<very>|<fairly>|<several>|<extremely>|<exceedingly>|<quite>|<remarkably>|<few>|<surprisingly>|<mostly>|<largely>|<huge>|<tiny>|<((are>|<is) a number)>|<excellent>|<interestingly>|<significantly>|<substantially>|<clearly>|<vast>|<relatively>|<completely>', 10)
endfunction

"
" Passive words take from Matt Might's blog.
" There could (must be) a better way to do this!
"
function writegooder#highlight_passive()
    let s:passive=matchadd('Error','\c\v(am|are|were|being|is|been|was|be)\v([ ]*|\n*)\c\v(\w+ed|<awoken>|<been>|<born>|<beat>|<become>|<begun>|<bent>|<beset>|<bet>|<bid>|<bidden>|<bound>|<bitten>|<bled>|<blown>|<broken>|<bred>|<brought>|<broadcast>|<built>|<burnt>|<burst>|<bought>|<cast>|<caught>|<chosen>|<clung>|<come>|<cost>|<crept>|<cut>|<dealt>|<dug>|<dived>|<done>|<drawn>|<dreamt>|<driven>|<drunk>|<eaten>|<fallen>|<fed>|<felt>|<fought>|<found>|<fit>|<fled>|<flung>|<flown>|<forbidden>|<forgotten>|<foregone>|<forgiven>|<forsaken>|<frozen>|<gotten>|<given>|<gone>|<ground>|<grown>|<hung>|<heard>|<hidden>|<hit>|<held>|<hurt>|<kept>|<knelt>|<knit>|<known>|<laid>|<led>|<leapt>|<learnt>|<left>|<lent>|<let>|<lain>|<lighted>|<lost>|<made>|<meant>|<met>|<misspelt>|<mistaken>|<mown>|<overcome>|<overdone>|<overtaken>|<overthrown>|<paid>|<pled>|<proven>|<put>|<quit>|<read>|<rid>|<ridden>|<rung>|<risen>|<run>|<sawn>|<said>|<seen>|<sought>|<sold>|<sent>|<set>|<sewn>|<shaken>|<shaven>|<shorn>|<shed>|<shone>|<shod>|<shot>|<shown>|<shrunk>|<shut>|<sung>|<sunk>|<sat>|<slept>|<slain>|<slid>|<slung>|<slit>|<smitten>|<sown>|<spoken>|<sped>|<spent>|<spilt>|<spun>|<spit>|<split>|<spread>|<sprung>|<stood>|<stolen>|<stuck>|<stung>|<stunk>|<stridden>|<struck>|<strung>|<striven>|<sworn>|<swept>|<swollen>|<swum>|<swung>|<taken>|<taught>|<torn>|<told>|<thought>|<thrived>|<thrown>|<thrust>|<trodden>|<understood>|<upheld>|<upset>|<woken>|<worn>|<woven>|<wed>|<wept>|<wound>|<won>|<withheld>|<withstood>|<wrung>|<written>)', 10)
endfunction

"
" 7 words you can't say on TV
"
function writegooder#swears()
  let s:swears=matchadd('Error','\c\v<shit>|<piss>|<fuck>|<cunt>|<cocksucker>|<motherfucker>|<tits>', 10)
endfunction

"
" Words to Avoid in Educational Writing
" https://css-tricks.com/words-avoid-educational-writing/
"

function writegooder#avoid_words()
  let s:swears=matchadd('Error','\c\v<obviously>|<basically>|<simply>|<of\scourse>|<clearly>|<just>|<everyone knows>|<however>|<so>|<easy>', 10)
endfunction


"
" Fix common misused phrases
"

function writegooder#misused_phrase()
" 1: Nip it in the butt vs. Nip it in the bud
" 2: I could care less vs. I couldn’t care less
" 3: One in the same vs.One and the same
" 4: You’ve got another thing coming vs. You’ve got another think coming
" 5: Each one worse than the next vs. Each one worse than the last
" 6: On accident vs. By accident
" 7: Statue of limitations vs. Statute of limitations
" 8: For all intensive purposes vs. For all intents and purposes
" 9: He did good vs. He did well
" 10: Extract revenge vs. Exact revenge
" 11: Old timer’s disease vs. Alzheimer’s Disease
" 12: I’m giving you leadway vs. I’m giving you leeway
" 13: Aks vs. Ask
" 14: What’s your guyses opinion? vs. What’s your opinion, guys?
" 15: Expresso vs. Espresso
" 16: Momento vs. Memento
" 17: Irregardless vs. Regardless
" 18: Sorta vs. Sort of
" 18b: Kinda vs. Kind of
" 19: Conversating vs. Conversing
" 20: Scotch free and Scott free vs. Scot free
" 22: Curl up in the feeble position vs. Curl up in the fetal position
" 23: Phase vs. Faze
" 24: Hone in vs. Home in
" 25: Brother in laws vs. Brothers in law
endfunction
