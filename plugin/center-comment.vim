" center-comment.vim - Center Comment
" Author:       Jonathan baird
" Version:      1.0

" -------------------------------------------------------------------------------------------------------------------- "
"                        check to see if there as any reason why we shouldn't load this plugin                         "
"                                            if there is then short circuit                                            "
"                                 otherwise flag it as loaded so we don't double load                                  "
" -------------------------------------------------------------------------------------------------------------------- "
if exists("g:loaded_center_comment") || &cp || v:version < 700
	finish
endif
let g:loaded_center_comment = 1
let s:save_cpo = &cpo
set cpo&vim

fun! s:customCenter(width)
	let oldexpandtab = &expandtab
	set expandtab
	exe 'center '.a:width
	let &expandtab = oldexpandtab
endfun

fun! s:centerComment(width, centerChar)
	exe "normal gmm0\"cyt\<space>0df\<space>"
	exe 'CustomCenter '.a:width
	exe "normal 0lvwhhr".a:centerChar."0\"cPA\<space>\<esc>A".a:centerChar."\<esc>".(a:width / 2).'.'
endfun

command! -nargs=1 CustomCenter call s:customCenter(<f-args>)

fun! s:centerCommentWrapper(header, ...)
	let centerChar = a:0 > 0 ? a:1 : "\<space>"
	if (a:header > 0)
		call s:centerHeaderComment(centerChar)
	else
		call s:centerGeneralComment(centerChar)
	endif
endfun

fun! s:getOriginalTextWidth()
	let originaltextwidth = &textwidth > 0 ? &textwidth : 80
	let &textwidth = 0
	return originaltextwidth
endfun

fun! s:centerGeneralComment(centerChar)
	echo 'centering general comment'
	let originaltextwidth = s:getOriginalTextWidth()
	let commentWidth = originaltextwidth - strlen(@c)
	call s:centerComment(commentWidth, a:centerChar)
	exe "normal 'm$d".(originaltextwidth)."\<bar>"
	let &textwidth = originaltextwidth
endfun

fun! s:centerHeaderComment(centerChar)
	echo 'centering header comment'
	let originaltextwidth = s:getOriginalTextWidth()
	call s:centerComment((originaltextwidth - strlen(@c) * 2), a:centerChar)
	exe "normal 'm$d".(originaltextwidth - strlen(@c) - 1)."\<bar>A\<space>\<esc>\"cp"
	let &textwidth = originaltextwidth
endfun

fun! s:centerCommentCompletion(ArgLead, CmdLine, CursorPos)
	return ['-', '*', '=', '_', '+', '#', '@', '!', '$', '%', '^', '&', '?', '<', '>', '.', ',', '`', '~', '"', '\'']
endfun

" -------------------------------------------------------------------------------------------------------------------- "
"                                         Create CenterHeaderComment Mappings                                          "
" -------------------------------------------------------------------------------------------------------------------- "

" -------------------------------------------------- create command ----------------------------------------------------
if !exists(':CenterHeaderComment')
	command -nargs=*
	      \ -complete=customlist,s:centerCommentCompletion
	      \ CenterHeaderComment
	      \ :call s:centerCommentWrapper(1, <f-args>)
endif

" ----------------------------------------------- create <SID> mappings ------------------------------------------------
noremap <SID>CenterHeaderComment           :call <SID>centerCommentWrapper(1)<CR>
noremap <SID>CenterHeaderCommentDash       :call <SID>centerCommentWrapper(1, '-')<CR>
noremap <SID>CenterHeaderCommentAstrisk    :call <SID>centerCommentWrapper(1, '*')<CR>
noremap <SID>CenterHeaderCommentEq         :call <SID>centerCommentWrapper(1, '=')<CR>
noremap <SID>CenterHeaderCommentUnderscore :call <SID>centerCommentWrapper(1, '_')<CR>
noremap <SID>CenterHeaderCommentPlus       :call <SID>centerCommentWrapper(1, '+')<CR>
noremap <SID>CenterHeaderCommentHash       :call <SID>centerCommentWrapper(1, '#')<CR>
noremap <SID>CenterHeaderCommentAt         :call <SID>centerCommentWrapper(1, '@')<CR>
noremap <SID>CenterHeaderCommentBang       :call <SID>centerCommentWrapper(1, '!')<CR>
noremap <SID>CenterHeaderCommentDollar     :call <SID>centerCommentWrapper(1, '$')<CR>
noremap <SID>CenterHeaderCommentMod        :call <SID>centerCommentWrapper(1, '%')<CR>
noremap <SID>CenterHeaderCommentCaret      :call <SID>centerCommentWrapper(1, '^')<CR>
noremap <SID>CenterHeaderCommentAnd        :call <SID>centerCommentWrapper(1, '&')<CR>
noremap <SID>CenterHeaderCommentQuestion   :call <SID>centerCommentWrapper(1, '?')<CR>
noremap <SID>CenterHeaderCommentLess       :call <SID>centerCommentWrapper(1, '<')<CR>
noremap <SID>CenterHeaderCommentGreater    :call <SID>centerCommentWrapper(1, '>')<CR>
noremap <SID>CenterHeaderCommentDot        :call <SID>centerCommentWrapper(1, '.')<CR>
noremap <SID>CenterHeaderCommentComma      :call <SID>centerCommentWrapper(1, ',')<CR>
noremap <SID>CenterHeaderCommentTick       :call <SID>centerCommentWrapper(1, '`')<CR>
noremap <SID>CenterHeaderCommentTilde      :call <SID>centerCommentWrapper(1, '~')<CR>
noremap <SID>CenterHeaderCommentQuote      :call <SID>centerCommentWrapper(1, '"')<CR>
noremap <SID>CenterHeaderCommentApost      :call <SID>centerCommentWrapper(1, '\'')<CR>

" ---------------------------------------------- create <Plug> mappings ------------------------------------------------
noremap  <unique> <script> <Plug>CenterHeaderComment           <SID>CenterHeaderComment
noremap  <unique> <script> <Plug>CenterHeaderCommentDash       <SID>CenterHeaderCommentDash
noremap  <unique> <script> <Plug>CenterHeaderCommentAstrisk    <SID>CenterHeaderCommentAstrisk
noremap  <unique> <script> <Plug>CenterHeaderCommentEq         <SID>CenterHeaderCommentEq
noremap  <unique> <script> <Plug>CenterHeaderCommentUnderscore <SID>CenterHeaderCommentUnderscore
noremap  <unique> <script> <Plug>CenterHeaderCommentPlus       <SID>CenterHeaderCommentPlus
noremap  <unique> <script> <Plug>CenterHeaderCommentHash       <SID>CenterHeaderCommentHash
noremap  <unique> <script> <Plug>CenterHeaderCommentAt         <SID>CenterHeaderCommentAt
noremap  <unique> <script> <Plug>CenterHeaderCommentBang       <SID>CenterHeaderCommentBang
noremap  <unique> <script> <Plug>CenterHeaderCommentDollar     <SID>CenterHeaderCommentDollar
noremap  <unique> <script> <Plug>CenterHeaderCommentMod        <SID>CenterHeaderCommentMod
noremap  <unique> <script> <Plug>CenterHeaderCommentCaret      <SID>CenterHeaderCommentCaret
noremap  <unique> <script> <Plug>CenterHeaderCommentAnd        <SID>CenterHeaderCommentAnd
noremap  <unique> <script> <Plug>CenterHeaderCommentQuestion   <SID>CenterHeaderCommentQuestion
noremap  <unique> <script> <Plug>CenterHeaderCommentLess       <SID>CenterHeaderCommentLess
noremap  <unique> <script> <Plug>CenterHeaderCommentGreater    <SID>CenterHeaderCommentGreater
noremap  <unique> <script> <Plug>CenterHeaderCommentDot        <SID>CenterHeaderCommentDot
noremap  <unique> <script> <Plug>CenterHeaderCommentComma      <SID>CenterHeaderCommentComma
noremap  <unique> <script> <Plug>CenterHeaderCommentTick       <SID>CenterHeaderCommentTick
noremap  <unique> <script> <Plug>CenterHeaderCommentTilde      <SID>CenterHeaderCommentTilde
noremap  <unique> <script> <Plug>CenterHeaderCommentQuote      <SID>CenterHeaderCommentQuote
noremap  <unique> <script> <Plug>CenterHeaderCommentApost      <SID>CenterHeaderCommentApost

" ------------------------------------------------ create menu mapping -------------------------------------------------
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment             <SID>CenterHeaderComment
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Dash       <SID>CenterHeaderCommentDash
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Astrisk    <SID>CenterHeaderCommentAstrisk
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Eq         <SID>CenterHeaderCommentEq
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Underscore <SID>CenterHeaderCommentUnderscore
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Plus       <SID>CenterHeaderCommentPlus
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Hash       <SID>CenterHeaderCommentHash
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ At         <SID>CenterHeaderCommentAt
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Bang       <SID>CenterHeaderCommentBang
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Dollar     <SID>CenterHeaderCommentDollar
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Mod        <SID>CenterHeaderCommentMod
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Caret      <SID>CenterHeaderCommentCaret
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ And        <SID>CenterHeaderCommentAnd
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Question   <SID>CenterHeaderCommentQuestion
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Less       <SID>CenterHeaderCommentLess
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Greater    <SID>CenterHeaderCommentGreater
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Dot        <SID>CenterHeaderCommentDot
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Comma      <SID>CenterHeaderCommentComma
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Tick       <SID>CenterHeaderCommentTick
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Tilde      <SID>CenterHeaderCommentTilde
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Quote      <SID>CenterHeaderCommentQuote
noremenu <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Apost      <SID>CenterHeaderCommentApost

" ------------------------------------------------- create keymapping --------------------------------------------------
if !hasmapto('<Plug>CenterHeaderComment')
	map <unique> <Leader>fch <Plug>CenterHeaderComment
endif
if !hasmapto('<Plug>CenterHeaderCommentDash')
	map <unique> <Leader>fch- <Plug>CenterHeaderCommentDash
endif
if !hasmapto('<Plug>CenterHeaderCommentAstrisk')
	map <unique> <Leader>fch* <Plug>CenterHeaderCommentAstrisk
endif
if !hasmapto('<Plug>CenterHeaderCommentEq')
	map <unique> <Leader>fch= <Plug>CenterHeaderCommentEq
endif
if !hasmapto('<Plug>CenterHeaderCommentUnderscore')
	map <unique> <Leader>fch_ <Plug>CenterHeaderCommentUnderscore
endif
if !hasmapto('<Plug>CenterHeaderCommentPlus')
	map <unique> <Leader>fch+ <Plug>CenterHeaderCommentPlus
endif
if !hasmapto('<Plug>CenterHeaderCommentHash')
	map <unique> <Leader>fch# <Plug>CenterHeaderCommentHash
endif
if !hasmapto('<Plug>CenterHeaderCommentAt')
	map <unique> <Leader>fch@ <Plug>CenterHeaderCommentAt
endif
if !hasmapto('<Plug>CenterHeaderCommentBang')
	map <unique> <Leader>fch! <Plug>CenterHeaderCommentBang
endif
if !hasmapto('<Plug>CenterHeaderCommentDollar')
	map <unique> <Leader>fch$ <Plug>CenterHeaderCommentDollar
endif
if !hasmapto('<Plug>CenterHeaderCommentMod')
	map <unique> <Leader>fch% <Plug>CenterHeaderCommentMod
endif
if !hasmapto('<Plug>CenterHeaderCommentCaret')
	map <unique> <Leader>fch^ <Plug>CenterHeaderCommentCaret
endif
if !hasmapto('<Plug>CenterHeaderCommentAnd')
	map <unique> <Leader>fch& <Plug>CenterHeaderCommentAnd
endif
if !hasmapto('<Plug>CenterHeaderCommentQuestion')
	map <unique> <Leader>fch? <Plug>CenterHeaderCommentQuestion
endif
if !hasmapto('<Plug>CenterHeaderCommentLess')
	map <unique> <Leader>fch< <Plug>CenterHeaderCommentLess
endif
if !hasmapto('<Plug>CenterHeaderCommentGreater')
	map <unique> <Leader>fch> <Plug>CenterHeaderCommentGreater
endif
if !hasmapto('<Plug>CenterHeaderCommentDot')
	map <unique> <Leader>fch. <Plug>CenterHeaderCommentDot
endif
if !hasmapto('<Plug>CenterHeaderCommentComma')
	map <unique> <Leader>fch, <Plug>CenterHeaderCommentComma
endif
if !hasmapto('<Plug>CenterHeaderCommentTick')
	map <unique> <Leader>fch` <Plug>CenterHeaderCommentTick
endif
if !hasmapto('<Plug>CenterHeaderCommentTilde')
	map <unique> <Leader>fch~ <Plug>CenterHeaderCommentTilde
endif
if !hasmapto('<Plug>CenterHeaderCommentQuote')
	map <unique> <Leader>fch" <Plug>CenterHeaderCommentQuote
endif
if !hasmapto('<Plug>CenterHeaderCommentApost')
	map <unique> <Leader>fch' <Plug>CenterHeaderCommentApost
endif

" -------------------------------------------------------------------------------------------------------------------- "
"                                            Create CenterComment Mappings                                             "
" -------------------------------------------------------------------------------------------------------------------- "

" -------------------------------------------------- create command ----------------------------------------------------
if !exists(':CenterComment')
	command -nargs=*
	      \ -complete=customlist,s:centerCommentCompletion
	      \ CenterComment
	      \ :call s:centerCommentWrapper(0, <f-args>)
endif

" ----------------------------------------------- create <SID> mappings ------------------------------------------------
noremap <SID>CenterComment           :call <SID>centerCommentWrapper(0)<CR>
noremap <SID>CenterCommentDash       :call <SID>centerCommentWrapper(0, '-')<CR>
noremap <SID>CenterCommentAstrisk    :call <SID>centerCommentWrapper(0, '*')<CR>
noremap <SID>CenterCommentEq         :call <SID>centerCommentWrapper(0, '=')<CR>
noremap <SID>CenterCommentUnderscore :call <SID>centerCommentWrapper(0, '_')<CR>
noremap <SID>CenterCommentPlus       :call <SID>centerCommentWrapper(0, '+')<CR>
noremap <SID>CenterCommentHash       :call <SID>centerCommentWrapper(0, '#')<CR>
noremap <SID>CenterCommentAt         :call <SID>centerCommentWrapper(0, '@')<CR>
noremap <SID>CenterCommentBang       :call <SID>centerCommentWrapper(0, '!')<CR>
noremap <SID>CenterCommentDollar     :call <SID>centerCommentWrapper(0, '$')<CR>
noremap <SID>CenterCommentMod        :call <SID>centerCommentWrapper(0, '%')<CR>
noremap <SID>CenterCommentCaret      :call <SID>centerCommentWrapper(0, '^')<CR>
noremap <SID>CenterCommentAnd        :call <SID>centerCommentWrapper(0, '&')<CR>
noremap <SID>CenterCommentQuestion   :call <SID>centerCommentWrapper(0, '?')<CR>
noremap <SID>CenterCommentLess       :call <SID>centerCommentWrapper(0, '<')<CR>
noremap <SID>CenterCommentGreater    :call <SID>centerCommentWrapper(0, '>')<CR>
noremap <SID>CenterCommentDot        :call <SID>centerCommentWrapper(0, '.')<CR>
noremap <SID>CenterCommentComma      :call <SID>centerCommentWrapper(0, ',')<CR>
noremap <SID>CenterCommentTick       :call <SID>centerCommentWrapper(0, '`')<CR>
noremap <SID>CenterCommentTilde      :call <SID>centerCommentWrapper(0, '~')<CR>
noremap <SID>CenterCommentQuote      :call <SID>centerCommentWrapper(0, '"')<CR>
noremap <SID>CenterCommentApost      :call <SID>centerCommentWrapper(0, '\'')<CR>

" ---------------------------------------------- create <Plug> mappings ------------------------------------------------
noremap  <unique> <script> <Plug>CenterComment           <SID>CenterComment
noremap  <unique> <script> <Plug>CenterCommentDash       <SID>CenterCommentDash
noremap  <unique> <script> <Plug>CenterCommentAstrisk    <SID>CenterCommentAstrisk
noremap  <unique> <script> <Plug>CenterCommentEq         <SID>CenterCommentEq
noremap  <unique> <script> <Plug>CenterCommentUnderscore <SID>CenterCommentUnderscore
noremap  <unique> <script> <Plug>CenterCommentPlus       <SID>CenterCommentPlus
noremap  <unique> <script> <Plug>CenterCommentHash       <SID>CenterCommentHash
noremap  <unique> <script> <Plug>CenterCommentAt         <SID>CenterCommentAt
noremap  <unique> <script> <Plug>CenterCommentBang       <SID>CenterCommentBang
noremap  <unique> <script> <Plug>CenterCommentDollar     <SID>CenterCommentDollar
noremap  <unique> <script> <Plug>CenterCommentMod        <SID>CenterCommentMod
noremap  <unique> <script> <Plug>CenterCommentCaret      <SID>CenterCommentCaret
noremap  <unique> <script> <Plug>CenterCommentAnd        <SID>CenterCommentAnd
noremap  <unique> <script> <Plug>CenterCommentQuestion   <SID>CenterCommentQuestion
noremap  <unique> <script> <Plug>CenterCommentLess       <SID>CenterCommentLess
noremap  <unique> <script> <Plug>CenterCommentGreater    <SID>CenterCommentGreater
noremap  <unique> <script> <Plug>CenterCommentDot        <SID>CenterCommentDot
noremap  <unique> <script> <Plug>CenterCommentComma      <SID>CenterCommentComma
noremap  <unique> <script> <Plug>CenterCommentTick       <SID>CenterCommentTick
noremap  <unique> <script> <Plug>CenterCommentTilde      <SID>CenterCommentTilde
noremap  <unique> <script> <Plug>CenterCommentQuote      <SID>CenterCommentQuote
noremap  <unique> <script> <Plug>CenterCommentApost      <SID>CenterCommentApost

" ------------------------------------------------ create menu mapping -------------------------------------------------
noremenu <script> Plugin.Center\ Comment.Center\ Comment             <SID>CenterComment
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Dash       <SID>CenterCommentDash
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Astrisk    <SID>CenterCommentAstrisk
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Eq         <SID>CenterCommentEq
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Underscore <SID>CenterCommentUnderscore
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Plus       <SID>CenterCommentPlus
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Hash       <SID>CenterCommentHash
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ At         <SID>CenterCommentAt
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Bang       <SID>CenterCommentBang
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Dollar     <SID>CenterCommentDollar
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Mod        <SID>CenterCommentMod
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Caret      <SID>CenterCommentCaret
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ And        <SID>CenterCommentAnd
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Question   <SID>CenterCommentQuestion
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Less       <SID>CenterCommentLess
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Greater    <SID>CenterCommentGreater
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Dot        <SID>CenterCommentDot
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Comma      <SID>CenterCommentComma
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Tick       <SID>CenterCommentTick
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Tilde      <SID>CenterCommentTilde
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Quote      <SID>CenterCommentQuote
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Apost      <SID>CenterCommentApost

" ------------------------------------------------- create keymapping --------------------------------------------------
if !hasmapto('<Plug>CenterComment')
	map <unique> <Leader>fc <Plug>CenterComment
endif
if !hasmapto('<Plug>CenterCommentDash')
	map <unique> <Leader>fc- <Plug>CenterCommentDash
endif
if !hasmapto('<Plug>CenterCommentAstrisk')
	map <unique> <Leader>fc* <Plug>CenterCommentAstrisk
endif
if !hasmapto('<Plug>CenterCommentEq')
	map <unique> <Leader>fc= <Plug>CenterCommentEq
endif
if !hasmapto('<Plug>CenterCommentUnderscore')
	map <unique> <Leader>fc_ <Plug>CenterCommentUnderscore
endif
if !hasmapto('<Plug>CenterCommentPlus')
	map <unique> <Leader>fc+ <Plug>CenterCommentPlus
endif
if !hasmapto('<Plug>CenterCommentHash')
	map <unique> <Leader>fc# <Plug>CenterCommentHash
endif
if !hasmapto('<Plug>CenterCommentAt')
	map <unique> <Leader>fc@ <Plug>CenterCommentAt
endif
if !hasmapto('<Plug>CenterCommentBang')
	map <unique> <Leader>fc! <Plug>CenterCommentBang
endif
if !hasmapto('<Plug>CenterCommentDollar')
	map <unique> <Leader>fc$ <Plug>CenterCommentDollar
endif
if !hasmapto('<Plug>CenterCommentMod')
	map <unique> <Leader>fc% <Plug>CenterCommentMod
endif
if !hasmapto('<Plug>CenterCommentCaret')
	map <unique> <Leader>fc^ <Plug>CenterCommentCaret
endif
if !hasmapto('<Plug>CenterCommentAnd')
	map <unique> <Leader>fc& <Plug>CenterCommentAnd
endif
if !hasmapto('<Plug>CenterCommentQuestion')
	map <unique> <Leader>fc? <Plug>CenterCommentQuestion
endif
if !hasmapto('<Plug>CenterCommentLess')
	map <unique> <Leader>fc< <Plug>CenterCommentLess
endif
if !hasmapto('<Plug>CenterCommentGreater')
	map <unique> <Leader>fc> <Plug>CenterCommentGreater
endif
if !hasmapto('<Plug>CenterCommentDot')
	map <unique> <Leader>fc. <Plug>CenterCommentDot
endif
if !hasmapto('<Plug>CenterCommentComma')
	map <unique> <Leader>fc, <Plug>CenterCommentComma
endif
if !hasmapto('<Plug>CenterCommentTick')
	map <unique> <Leader>fc` <Plug>CenterCommentTick
endif
if !hasmapto('<Plug>CenterCommentTilde')
	map <unique> <Leader>fc~ <Plug>CenterCommentTilde
endif
if !hasmapto('<Plug>CenterCommentQuote')
	map <unique> <Leader>fc" <Plug>CenterCommentQuote
endif
if !hasmapto('<Plug>CenterCommentApost')
	map <unique> <Leader>fc' <Plug>CenterCommentApost
endif

" ------------------------------------------------- enable repeating ---------------------------------------------------
silent! call repeat#set('<Plug>CenterComment', v:count)
silent! call repeat#set('<Plug>CenterCommentDash', v:count)
silent! call repeat#set('<Plug>CenterCommentAstrisk', v:count)
silent! call repeat#set('<Plug>CenterCommentEq', v:count)
silent! call repeat#set('<Plug>CenterCommentUnderscore', v:count)
silent! call repeat#set('<Plug>CenterCommentPlus', v:count)
silent! call repeat#set('<Plug>CenterCommentHash', v:count)
silent! call repeat#set('<Plug>CenterCommentAt', v:count)
silent! call repeat#set('<Plug>CenterCommentBang', v:count)
silent! call repeat#set('<Plug>CenterCommentDollar', v:count)
silent! call repeat#set('<Plug>CenterCommentMod', v:count)
silent! call repeat#set('<Plug>CenterCommentCaret', v:count)
silent! call repeat#set('<Plug>CenterCommentAnd', v:count)
silent! call repeat#set('<Plug>CenterCommentQuestion', v:count)
silent! call repeat#set('<Plug>CenterCommentLess', v:count)
silent! call repeat#set('<Plug>CenterCommentGreater', v:count)
silent! call repeat#set('<Plug>CenterCommentDot', v:count)
silent! call repeat#set('<Plug>CenterCommentComma', v:count)
silent! call repeat#set('<Plug>CenterCommentTick', v:count)
silent! call repeat#set('<Plug>CenterCommentTilde', v:count)
silent! call repeat#set('<Plug>CenterCommentQuote', v:count)
silent! call repeat#set('<Plug>CenterCommentApost', v:count)
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

let &cpo = s:save_cpo
