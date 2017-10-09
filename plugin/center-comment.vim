fun! CustomCenter(width)
	let oldexpandtab = &expandtab
	set expandtab
	exe 'center '.a:width
	let &expandtab = oldexpandtab
endfun

fun! CenterComment(width, centerChar)
	exe "normal gmm0\"cyt\<space>0df\<space>"
	exe 'CustomCenter '.a:width
	exe "normal 0lvwhhr".a:centerChar."0\"cPA\<space>\<esc>A".a:centerChar."\<esc>".(a:width / 2).'.'
endfun

command! -nargs=1 CustomCenter call CustomCenter(<f-args>)

fun! CenterCommentWrapper(header, ...)
	let centerChar = a:0 > 0 ? a:1 : "\<space>"
	if (a:header > 0)
		call CenterHeaderComment(centerChar)
	else
		call CenterGeneralComment(centerChar)
	endif
endfun

fun! GetOriginalTextWidth()
	let originaltextwidth = &textwidth > 0 ? &textwidth : 80
	let &textwidth = 0
	return originaltextwidth
endfun

fun! CenterGeneralComment(centerChar)
	echo 'centering general comment'
	let originaltextwidth = GetOriginalTextWidth()
	let commentWidth = originaltextwidth - strlen(@c)
	call CenterComment(commentWidth, a:centerChar)
	exe "normal 'm$d".(originaltextwidth)."\<bar>"
	let &textwidth = originaltextwidth
endfun

fun! CenterHeaderComment(centerChar)
	echo 'centering header comment'
	let originaltextwidth = GetOriginalTextWidth()
	call CenterComment((originaltextwidth - strlen(@c) * 2), a:centerChar)
	exe "normal 'm$d".(originaltextwidth - strlen(@c) - 1)."\<bar>A\<space>\<esc>\"cp"
	let &textwidth = originaltextwidth
endfun

fun! CenterCommentCompletion(ArgLead, CmdLine, CursorPos)
	return ['-', '*', '<space>', '=', '_', '+', '#', '@', '!', '$', '%', '^', '&', '?', '<', '>', '.', ',', '`', '~', '"']
endfun

command! -nargs=* -complete=customlist,CenterCommentCompletion CenterHeaderComment call CenterCommentWrapper(1, <f-args>)

command! -nargs=* -complete=customlist,CenterCommentCompletion CenterComment call CenterCommentWrapper(0, <f-args>)


nnoremap <Leader>fch= :CenterHeaderComment =<CR>
nnoremap <Leader>fch- :CenterHeaderComment -<CR>
nnoremap <Leader>fch :CenterHeaderComment -<CR>
nnoremap <Leader>fc= :CenterComment =<CR>
nnoremap <Leader>fc- :CenterComment -<CR>
nnoremap <Leader>fc :CenterComment<CR>
