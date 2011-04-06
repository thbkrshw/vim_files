" mpage.vim
"   Author: Charles E. Campbell, Jr.
"   Date:   Nov 05, 2010
"   Version: 1n	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("g:loaded_mpage")
 finish
endif
let g:loaded_mpage= "v1n"
let s:keepcpo      = &cpo
set cpo&vim
"DechoTabOn

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com! -bang -count=0 -nargs=?	MPage	call mpage#Pager((<bang>0)? -1 : (<q-args> + <count>))

" =====================================================================
"  Functions: {{{1

" ---------------------------------------------------------------------
" mpage#Pager: {{{2
fun! mpage#Pager(...)
"  call Dfunc("mpage#Pager() a:0=".a:0.((a:0 > 0)? " a:1<".a:1.">" : ""))
  let nsplits= (a:0 > 0)? a:1 : 1
  if a:0 == 1 && a:1 == ""
   let nsplits= 0
  endif
"  call Decho("nsplits=".nsplits)
  if !exists("#MPagerAutocmds")
"   call Decho("install ReSync on CursorMoved events")
   augroup MPagerAutocmds
    au!
    au CursorMoved	*	if exists("w:mpage")|call s:ReSync()|endif
    au CursorHold	*	if exists("w:mpage")|call s:ReSync()|endif
   augroup END
   call SaveUserMaps("n","<c-y>" ,"","MPage")
   call SaveUserMaps("n","<c-e>" ,"","MPage")
   call SaveUserMaps("n","z\<cr>","","MPage")
   call SaveUserMaps("n","zb"    ,"","MPage")
   call SaveUserMaps("n","zt"    ,"","MPage")
   call SaveUserMaps("n","z-"    ,"","MPage")
   call SaveUserMaps("n","z."    ,"","MPage")
   call SaveUserMaps("n","zz"    ,"","MPage")
   noremap <c-y>	<c-y>:call <SID>ReSync()<cr>
   noremap <c-e>	<c-e>:call <SID>ReSync()<cr>
   noremap z<cr>	z<cr>:call <SID>ReSync()<cr>
   noremap zb		zb:call <SID>ReSync()<cr>
   noremap zt		zt:call <SID>ReSync()<cr>
   noremap z-		z-:call <SID>ReSync()<cr>
   noremap z.		z.:call <SID>ReSync()<cr>
   noremap zz		zz:call <SID>ReSync()<cr>
  endif

  if nsplits == 0
   " turn MultiPager off in this tab
"   call Decho("turn MultiPager off in all windows in this tab")
   windo if exists("w:mpage")|unlet w:mpage|endif
   if exists("#MPagerAutocmds")
	augroup MPagerAutocmds
	 au!
	augroup END
	augroup! MPagerAutocmds
   endif
   call RestoreUserMaps("MPage")
"   call Dret("mpage#Pager")
   return
  elseif nsplits < 0
   if exists("w:mpage")
    " turn MultiPaging off for this window
"    call Decho(" turn MultiPaging OFF for this window")
    unlet w:mpage
    call s:ReSync()
   else
	" turn MultiPaging on for this window
"	call Decho(" turn MultiPaging ON for this window")
    let w:mpage= expand("%")
    call s:ReSync()
   endif
"   call Dret("mpage#Pager : turn multipaging off for current window only")
   return
  endif

  let keepea = &ea
  setlocal ea nofen noscb
  let curwin    = winnr()
  let ivsplit   = 1
  let linestart = line("w0")
  let page      = line("w$") - line("w0") + 1
  let w:mpage   = expand("%")
  while ivsplit < nsplits
   wincmd v
   let w:mpage   = expand("%")
   wincmd l
   let ivsplit= ivsplit + 1
  endwhile
  exe curwin."wincmd w"
  call s:ReSync()
"  call Dret("mpage#Pager")
endfun

" ---------------------------------------------------------------------
" s:ReSync: re-synchronize mpage windows in current tab {{{2
fun! s:ReSync()
"  call Dfunc("s:ReSync() mode<".mode().">")
  if !exists("w:mpage")
"   call Dret("s:ReSync")
   return
  endif
  if mode() =~ "[\<c-v>Vv]"
   " seems that RestoreWinPosn() doesn't work right in visual mode
"   call Dret("s:ReSync")
   return
  endif
  set lz
  let eikeep    = &ei
  set ei=CursorMoved
  let swp       = SaveWinPosn(0)
  let iwin      = winnr() - 1
  let curwin    = winnr()
  let curline   = line("w0")
  let linestart = line("w0")
  let mpage     = expand("%")

  " adjust earlier windows
"  call Decho("adjust earlier windows (curwin#".winnr().")")
  while iwin >= 1
   exe iwin."wincmd w"
   if !exists("w:mpage") || expand("%") != mpage
	let iwin = iwin - 1
	continue
   endif
   let page      = line("w$") - line("w0") + 1
"   call Decho("win#".winnr()." linestart= [linestart=".linestart."]-[page=".page."]=".(linestart-page))
   let linestart = linestart - page
   if linestart < 1
	let linestart= 1
   endif
   setlocal noscb
   exe "keepj norm! ".linestart."zt"
   let iwin = iwin - 1
  endwhile

  " adjust later windows
"  call Decho("adjust later windows (curwin#".winnr().")")
  exe curwin."wincmd w"
  let linestart = curline
  let iwin      = curwin + 1
  let prvpage   = line("w$") - line("w0") + 1
  while iwin <= winnr("$")
   exe iwin."wincmd w"
   if !exists("w:mpage") || expand("%") != mpage
	let iwin = iwin + 1
	continue
   endif
   let page   = prvpage
   let prvpage= line("w$") - line("w0") + 1
"   call Decho("win#".winnr()." linestart= [linestart=".linestart."]+[page=".page."]=".(linestart+page))
   let linestart = linestart + page
   if linestart >= line("$")
	let linestart= line("$")
   endif
   exe "keepj norm! ".linestart."zt"
   let iwin = iwin + 1
  endwhile
  
  " restore window and position in window
  exe curwin."wincmd w"
  call RestoreWinPosn(swp)
  let &ei= eikeep
  set nolz
"  call Dret("s:ReSync")
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
