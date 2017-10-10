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

" ---------------------------------------------- create <Plug> mappings ------------------------------------------------
noremap  <unique> <script> <Plug>CenterHeaderComment                                  <SID> centerCommentWrapper(1)
noremap  <unique> <script> <Plug>CenterHeaderCommentDash                              <SID> centerCommentWrapper(1, '-')
noremap  <unique> <script> <Plug>CenterHeaderCommentAstrisk                           <SID> centerCommentWrapper(1, '*')
noremap  <unique> <script> <Plug>CenterHeaderCommentEq                                <SID> centerCommentWrapper(1, '=')
noremap  <unique> <script> <Plug>CenterHeaderCommentUnderscore                        <SID> centerCommentWrapper(1, '_')
noremap  <unique> <script> <Plug>CenterHeaderCommentPlus                              <SID> centerCommentWrapper(1, '+')
noremap  <unique> <script> <Plug>CenterHeaderCommentHash                              <SID> centerCommentWrapper(1, '#')
noremap  <unique> <script> <Plug>CenterHeaderCommentAt                                <SID> centerCommentWrapper(1, '@')
noremap  <unique> <script> <Plug>CenterHeaderCommentBang                              <SID> centerCommentWrapper(1, '!')
noremap  <unique> <script> <Plug>CenterHeaderCommentDollar                            <SID> centerCommentWrapper(1, '$')
noremap  <unique> <script> <Plug>CenterHeaderCommentMod                               <SID> centerCommentWrapper(1, '%')
noremap  <unique> <script> <Plug>CenterHeaderCommentCaret                             <SID> centerCommentWrapper(1, '^')
noremap  <unique> <script> <Plug>CenterHeaderCommentAnd                               <SID> centerCommentWrapper(1, '&')
noremap  <unique> <script> <Plug>CenterHeaderCommentQuestion                          <SID> centerCommentWrapper(1, '?')
noremap  <unique> <script> <Plug>CenterHeaderCommentLess                              <SID> centerCommentWrapper(1, '<')
noremap  <unique> <script> <Plug>CenterHeaderCommentGreater                           <SID> centerCommentWrapper(1, '>')
noremap  <unique> <script> <Plug>CenterHeaderCommentDot                               <SID> centerCommentWrapper(1, '.')
noremap  <unique> <script> <Plug>CenterHeaderCommentComma                             <SID> centerCommentWrapper(1, ',')
noremap  <unique> <script> <Plug>CenterHeaderCommentTick                              <SID> centerCommentWrapper(1, '`')
noremap  <unique> <script> <Plug>CenterHeaderCommentTilde                             <SID> centerCommentWrapper(1, '~')
noremap  <unique> <script> <Plug>CenterHeaderCommentQuote                             <SID> centerCommentWrapper(1, '"')
noremap  <unique> <script> <Plug>CenterHeaderCommentApost                             <SID> centerCommentWrapper(1, '\'')

" ------------------------------------------------ create menu mapping -------------------------------------------------
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment             <SID> centerCommentWrapper(1)
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Dash       <SID> centerCommentWrapper(1, '-')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Astrisk    <SID> centerCommentWrapper(1, '*')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Eq         <SID> centerCommentWrapper(1, '=')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Underscore <SID> centerCommentWrapper(1, '_')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Plus       <SID> centerCommentWrapper(1, '+')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Hash       <SID> centerCommentWrapper(1, '#')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ At         <SID> centerCommentWrapper(1, '@')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Bang       <SID> centerCommentWrapper(1, '!')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Dollar     <SID> centerCommentWrapper(1, '$')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Mod        <SID> centerCommentWrapper(1, '%')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Caret      <SID> centerCommentWrapper(1, '^')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ And        <SID> centerCommentWrapper(1, '&')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Question   <SID> centerCommentWrapper(1, '?')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Less       <SID> centerCommentWrapper(1, '<')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Greater    <SID> centerCommentWrapper(1, '>')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Dot        <SID> centerCommentWrapper(1, '.')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Comma      <SID> centerCommentWrapper(1, ',')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Tick       <SID> centerCommentWrapper(1, '`')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Tilde      <SID> centerCommentWrapper(1, '~')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Quote      <SID> centerCommentWrapper(1, '"')
noremenu          <script> Plugin.Center\ Comment.Center\ Header\ Comment\ Apost      <SID> centerCommentWrapper(1, '\'')

" ------------------------------------------------- create keymapping --------------------------------------------------
if !hasmapto('<Plug>CenterHeaderComment')           | map <unique> <Leader>fch <Plug>CenterHeaderComment            | endif
if !hasmapto('<Plug>CenterHeaderCommentDash')       | map <unique> <Leader>fch- <Plug>CenterHeaderCommentDash       | endif
if !hasmapto('<Plug>CenterHeaderCommentAstrisk')    | map <unique> <Leader>fch* <Plug>CenterHeaderCommentAstrisk    | endif
if !hasmapto('<Plug>CenterHeaderCommentEq')         | map <unique> <Leader>fch= <Plug>CenterHeaderCommentEq         | endif
if !hasmapto('<Plug>CenterHeaderCommentUnderscore') | map <unique> <Leader>fch_ <Plug>CenterHeaderCommentUnderscore | endif
if !hasmapto('<Plug>CenterHeaderCommentPlus')       | map <unique> <Leader>fch+ <Plug>CenterHeaderCommentPlus       | endif
if !hasmapto('<Plug>CenterHeaderCommentHash')       | map <unique> <Leader>fch# <Plug>CenterHeaderCommentHash       | endif
if !hasmapto('<Plug>CenterHeaderCommentAt')         | map <unique> <Leader>fch@ <Plug>CenterHeaderCommentAt         | endif
if !hasmapto('<Plug>CenterHeaderCommentBang')       | map <unique> <Leader>fch! <Plug>CenterHeaderCommentBang       | endif
if !hasmapto('<Plug>CenterHeaderCommentDollar')     | map <unique> <Leader>fch$ <Plug>CenterHeaderCommentDollar     | endif
if !hasmapto('<Plug>CenterHeaderCommentMod')        | map <unique> <Leader>fch% <Plug>CenterHeaderCommentMod        | endif
if !hasmapto('<Plug>CenterHeaderCommentCaret')      | map <unique> <Leader>fch^ <Plug>CenterHeaderCommentCaret      | endif
if !hasmapto('<Plug>CenterHeaderCommentAnd')        | map <unique> <Leader>fch& <Plug>CenterHeaderCommentAnd        | endif
if !hasmapto('<Plug>CenterHeaderCommentQuestion')   | map <unique> <Leader>fch? <Plug>CenterHeaderCommentQuestion   | endif
if !hasmapto('<Plug>CenterHeaderCommentLess')       | map <unique> <Leader>fch< <Plug>CenterHeaderCommentLess       | endif
if !hasmapto('<Plug>CenterHeaderCommentGreater')    | map <unique> <Leader>fch> <Plug>CenterHeaderCommentGreater    | endif
if !hasmapto('<Plug>CenterHeaderCommentDot')        | map <unique> <Leader>fch. <Plug>CenterHeaderCommentDot        | endif
if !hasmapto('<Plug>CenterHeaderCommentComma')      | map <unique> <Leader>fch, <Plug>CenterHeaderCommentComma      | endif
if !hasmapto('<Plug>CenterHeaderCommentTick')       | map <unique> <Leader>fch` <Plug>CenterHeaderCommentTick       | endif
if !hasmapto('<Plug>CenterHeaderCommentTilde')      | map <unique> <Leader>fch~ <Plug>CenterHeaderCommentTilde      | endif
if !hasmapto('<Plug>CenterHeaderCommentQuote')      | map <unique> <Leader>fch" <Plug>CenterHeaderCommentQuote      | endif
if !hasmapto('<Plug>CenterHeaderCommentApost')      | map <unique> <Leader>fch' <Plug>CenterHeaderCommentApost      | endif

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

" ---------------------------------------------- create <Plug> mappings ------------------------------------------------
noremap  <unique> <script> <Plug>CenterComment           <SID> centerCommentWrapper(0)
noremap  <unique> <script> <Plug>CenterCommentDash       <SID> centerCommentWrapper(0, '-')
noremap  <unique> <script> <Plug>CenterCommentAstrisk    <SID> centerCommentWrapper(0, '*')
noremap  <unique> <script> <Plug>CenterCommentEq         <SID> centerCommentWrapper(0, '=')
noremap  <unique> <script> <Plug>CenterCommentUnderscore <SID> centerCommentWrapper(0, '_')
noremap  <unique> <script> <Plug>CenterCommentPlus       <SID> centerCommentWrapper(0, '+')
noremap  <unique> <script> <Plug>CenterCommentHash       <SID> centerCommentWrapper(0, '#')
noremap  <unique> <script> <Plug>CenterCommentAt         <SID> centerCommentWrapper(0, '@')
noremap  <unique> <script> <Plug>CenterCommentBang       <SID> centerCommentWrapper(0, '!')
noremap  <unique> <script> <Plug>CenterCommentDollar     <SID> centerCommentWrapper(0, '$')
noremap  <unique> <script> <Plug>CenterCommentMod        <SID> centerCommentWrapper(0, '%')
noremap  <unique> <script> <Plug>CenterCommentCaret      <SID> centerCommentWrapper(0, '^')
noremap  <unique> <script> <Plug>CenterCommentAnd        <SID> centerCommentWrapper(0, '&')
noremap  <unique> <script> <Plug>CenterCommentQuestion   <SID> centerCommentWrapper(0, '?')
noremap  <unique> <script> <Plug>CenterCommentLess       <SID> centerCommentWrapper(0, '<')
noremap  <unique> <script> <Plug>CenterCommentGreater    <SID> centerCommentWrapper(0, '>')
noremap  <unique> <script> <Plug>CenterCommentDot        <SID> centerCommentWrapper(0, '.')
noremap  <unique> <script> <Plug>CenterCommentComma      <SID> centerCommentWrapper(0, ',')
noremap  <unique> <script> <Plug>CenterCommentTick       <SID> centerCommentWrapper(0, '`')
noremap  <unique> <script> <Plug>CenterCommentTilde      <SID> centerCommentWrapper(0, '~')
noremap  <unique> <script> <Plug>CenterCommentQuote      <SID> centerCommentWrapper(0, '"')
noremap  <unique> <script> <Plug>CenterCommentApost      <SID> centerCommentWrapper(0, '\'')

" ------------------------------------------------ create menu mapping -------------------------------------------------
noremenu <script> Plugin.Center\ Comment.Center\ Comment             <SID> centerCommentWrapper(0)
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Dash       <SID> centerCommentWrapper(0, '-')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Astrisk    <SID> centerCommentWrapper(0, '*')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Eq         <SID> centerCommentWrapper(0, '=')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Underscore <SID> centerCommentWrapper(0, '_')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Plus       <SID> centerCommentWrapper(0, '+')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Hash       <SID> centerCommentWrapper(0, '#')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ At         <SID> centerCommentWrapper(0, '@')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Bang       <SID> centerCommentWrapper(0, '!')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Dollar     <SID> centerCommentWrapper(0, '$')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Mod        <SID> centerCommentWrapper(0, '%')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Caret      <SID> centerCommentWrapper(0, '^')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ And        <SID> centerCommentWrapper(0, '&')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Question   <SID> centerCommentWrapper(0, '?')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Less       <SID> centerCommentWrapper(0, '<')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Greater    <SID> centerCommentWrapper(0, '>')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Dot        <SID> centerCommentWrapper(0, '.')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Comma      <SID> centerCommentWrapper(0, ',')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Tick       <SID> centerCommentWrapper(0, '`')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Tilde      <SID> centerCommentWrapper(0, '~')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Quote      <SID> centerCommentWrapper(0, '"')
noremenu <script> Plugin.Center\ Comment.Center\ Comment\ Apost      <SID> centerCommentWrapper(0, '\'')

" ------------------------------------------------- create keymapping --------------------------------------------------
if !hasmapto('<Plug>CenterComment')           | map <unique> <Leader>fch <Plug>CenterComment            | endif
if !hasmapto('<Plug>CenterCommentDash')       | map <unique> <Leader>fch- <Plug>CenterCommentDash       | endif
if !hasmapto('<Plug>CenterCommentAstrisk')    | map <unique> <Leader>fch* <Plug>CenterCommentAstrisk    | endif
if !hasmapto('<Plug>CenterCommentEq')         | map <unique> <Leader>fch= <Plug>CenterCommentEq         | endif
if !hasmapto('<Plug>CenterCommentUnderscore') | map <unique> <Leader>fch_ <Plug>CenterCommentUnderscore | endif
if !hasmapto('<Plug>CenterCommentPlus')       | map <unique> <Leader>fch+ <Plug>CenterCommentPlus       | endif
if !hasmapto('<Plug>CenterCommentHash')       | map <unique> <Leader>fch# <Plug>CenterCommentHash       | endif
if !hasmapto('<Plug>CenterCommentAt')         | map <unique> <Leader>fch@ <Plug>CenterCommentAt         | endif
if !hasmapto('<Plug>CenterCommentBang')       | map <unique> <Leader>fch! <Plug>CenterCommentBang       | endif
if !hasmapto('<Plug>CenterCommentDollar')     | map <unique> <Leader>fch$ <Plug>CenterCommentDollar     | endif
if !hasmapto('<Plug>CenterCommentMod')        | map <unique> <Leader>fch% <Plug>CenterCommentMod        | endif
if !hasmapto('<Plug>CenterCommentCaret')      | map <unique> <Leader>fch^ <Plug>CenterCommentCaret      | endif
if !hasmapto('<Plug>CenterCommentAnd')        | map <unique> <Leader>fch& <Plug>CenterCommentAnd        | endif
if !hasmapto('<Plug>CenterCommentQuestion')   | map <unique> <Leader>fch? <Plug>CenterCommentQuestion   | endif
if !hasmapto('<Plug>CenterCommentLess')       | map <unique> <Leader>fch< <Plug>CenterCommentLess       | endif
if !hasmapto('<Plug>CenterCommentGreater')    | map <unique> <Leader>fch> <Plug>CenterCommentGreater    | endif
if !hasmapto('<Plug>CenterCommentDot')        | map <unique> <Leader>fch. <Plug>CenterCommentDot        | endif
if !hasmapto('<Plug>CenterCommentComma')      | map <unique> <Leader>fch, <Plug>CenterCommentComma      | endif
if !hasmapto('<Plug>CenterCommentTick')       | map <unique> <Leader>fch` <Plug>CenterCommentTick       | endif
if !hasmapto('<Plug>CenterCommentTilde')      | map <unique> <Leader>fch~ <Plug>CenterCommentTilde      | endif
if !hasmapto('<Plug>CenterCommentQuote')      | map <unique> <Leader>fch" <Plug>CenterCommentQuote      | endif
if !hasmapto('<Plug>CenterCommentApost')      | map <unique> <Leader>fch' <Plug>CenterCommentApost      | endif

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
