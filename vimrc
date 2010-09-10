" File: .vimrc

" Author: Harold Leboulanger <harold@leboulanger.org>
" Last modified: Ven nov 06, 2009  08:53

" Configuration pathogen {
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
" }

" Général {
set nocompatible " On quitte le mode VI compatible
"set autochdir " Le pwd correspond au répertoire qui contient le fichier édité
set autoread " Recharge le fichier s'il a été modifié ailleurs
set backspace=indent,eol,start " Rend backspace un peu plus flexible

" Met en évidence les caractères qui dépassent la limite des 80 caractères
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/


"set textwidth=80 " Définit la largeur du texte
set backup " Génère des fichiers de backups
set backupdir=~/.vim/backup " Dossier d'enregistrement des backups
set directory=~/.vim/backup " Dossier des fichiers swap

set noerrorbells " Pas de bip lors des erreurs
set novisualbell " L'écran ne clignote pas lors d'une erreur
set vb

set whichwrap=b,s,h,l,<,>,~,[,]
set wildignore=doc/*,*.xib,*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png " Ignore ces extensions
set wildmenu " Auto complétion des menus
set wildmode=list:longest " Active le wild menu pour de longues listes

set iskeyword+=_,$,@,%,# " Aucun de ces caractères n'est un diviseur de mots

set encoding=utf-8 " On utilise uniquement UTF-8

set incsearch "Recherhe au fur et à mesure
set hlsearch "Mise en évidence pendant la recherche
set ignorecase

"au FocusLost * :wa " Enregistre les fichiers quand le focus est perdu
" }

" Filetype {
filetype plugin indent on
"au FileType objc ru after/syntax/objc_enhanced.vim
" }


" Raccourcis {
let mapleader = "," " Définit une touche de raccourcis générale
let g:mapleader = ","

" Change pwd to the current file directory
map <leader>cd :cd %:p:h<CR>

" Write a file with superuser privilege
command W w !sudo tee % > /dev/null

" Rechargement rapide du .vimrc 
map <leader>s :source ~/.vimrc
" Édition rapide du .vimrc
map <leader>ev :e! ~/.vimrc

" Navigation à travers les fenêtres
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
map - <C-W>-
map + <C-W>+
map <C-<> <C-W><
map <C->> <C-W>>



" Mise en route rapide de la vérification orthographique
function! SpellCheck( )
    set spell
    set spelllang=fr
endfunction

nmap ,sc :call SpellCheck()<CR>

" Font Inconsolata
function! Inconsolata() 
    set guifont=Inconsolata:h14
endfunction

nmap ,fi :call Inconsolata()<CR>


map <leader>b <ESC>:make<CR>
map <Leader><Space> <ESC>:call ToggleHeader()<CR>

function! ToggleHeader() 
    write
    :A
endfunction

map <space> /
map <c-space> ?

"Tab configuration {
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

map <down> <ESC>:tabprev<RETURN>
map <right> <ESC>:Tlist<RETURN>
map <left> <ESC>:NERDTreeToggle<RETURN>
map <up> <ESC>:tabnext<RETURN>
" }
" }

" Interface {
syntax on " Mise en évidence de la syntaxe

set cursorline " Surligne la ligne éditée

set showmode " Affiche le mode courant
set rnu
"set nu " Numérotation des lignes
set ruler " Affiche la bande d'infos en bas de la fenêtre

"set lazyredraw " Ne pas rafraichir l'écran lors des macros

set scrolloff=5 " Maintient 5 lignes d'écart avant que le curseur travese l'écran

set showmatch " Affiche les paranthèses correspondantes
set matchtime=5 " Dixième de seconde  de mise en évidence de la parenthèse

set shortmess=atI " Réduit le prompt  "Press ENTER...

"set list " On veut afficher les espaces en fin de ligne et les tabs
"set listchars=tab:>-,trail:- " Affiche les tabs et les espaces


if (&t_Co == 256 || has("gui_running"))
    colorscheme wombat256
else
    colorscheme wombat256
endif

set mouse=a

" GUI {
if has("gui_macvim")
    "set guioptions=-T " Suppression de la barre d'outils
    set guioptions=egmrtendif
    "colorscheme wombat256
    "hi CursorLine ctermbg=DarkGray " Colore la ligne éditée
    "set columns=100
    "set lines=50
    "set guifont=Inconsolata:h14
    "set guifont=DejaVuSansMono
    set guifont=Terminus
    set guifont=ProggyClean:h11
    set guifont=ProggyOpti:h11
    "set guifont=ANonymous\ Pro
    "set guifont=Monaco:h9
    "set antialias
    set mousehide " Cache le curseur lorsqu'on édite
endif

if has("gui_gnome")
    set guifont=Inconsolata
endif

" }

" Status line {
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\ [%{strlen(&ft)?&ft:'none'}] " file type
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k 
set statusline+=%*
set statusline+=%=                           " right align remainder
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position
" }
" }

" Folding {
set foldenable
set foldmarker={,}
set foldmethod=marker
set foldlevel=100
set foldopen=block,hor,mark,percent,quickfix,tag
" }

" Formatage du texte {
set completeopt=menu,longest " Améliore la complétion

set expandtab " Espaces à la place des tabulations
set shiftround " Nombre pair pour les tabulations

set shiftwidth=2
set softtabstop=2
set tabstop=2

set nowrap " Pas de retour à la ligne automatique

" }

" Plugins {

" errormarkser {
" Fait la distinction entre les erreurs et les warnings de GCC
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
" }"


" obviousmode {
let g:obviousModeInsertHi = 'term=reverse ctermbg=52 guibg=#820000' 
let g:obviousModeCmdwinHi = 'term=reverse ctermbg=22 guibg=#820000' 
" }

" Syntastic {
"let g:syntastic_auto_loc_list=1
"let g:syntastic_enable_signs=1
"let g:syntastic_disabled_filetypes = ['cpp']
"nmap ,se :SyntasticEnable<CR>
"nmap ,sd :SyntasticDisable<CR>
" }

" NERD Tree {
map <Leader>n :NERDTreeToggle<CR>
map <Leader>nb :NERDTreeFromBookmark 
map <Leader>nab :Bookmark 
" }

" Tag List {
let Tlist_Use_Right_Window=1 
let Tlist_Enable_Fold_Column=0 
let Tlist_Show_One_File=1   " especially with this one 
let Tlist_Compact_Format=1 
set updatetime=1000 
"let Tlist_Ctags_Cmd="etags"
let Tlist_Use_SingleClick=1

"let Tlist_Auto_Open=1 " let the tag list open automagically
let Tlist_Exit_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 1 " fold closed other trees
"let Tlist_Sort_Type = "name" " order by
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always) read my functions

let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
let tlist_make_settings  = 'make;m:makros;t:targets'

" }

" FuzzyFinderConf {
nnoremap <silent> <C-b> :FufBuffer<CR>
nnoremap <silent> <C-f> :FufFileWithCurrentBufferDir<CR>
" }

" SnipMate {
nmap ,rr :call ResetAllSnippets()

let g:snips_author = "Harold Leboulanger"
" }"
"
" CommantT {
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif
map <leader>y :CommandT<CR>
" }


" }

" Abbréviations {
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname Harold Leboulanger
iab xmail <harold@leboulanger.org>
iab xmoi Harold Leboulanger <harold@leboulanger.org>
iab xoli Olivier Brizai <olivier.brizai@ecole.ensicaen.fr>
" }
"
" Templates {
    au bufNewFile *.py 0r ~/.vim/templates/python
    au bufNewFile *.pl 0r ~/.vim/templates/perl
    au bufNewFile *.tex 0r ~/.vim/templates/latex
" }



function! StripTrailingWhitespace()
    normal mz
    normal Hmy
    exec '%s/\s*$//g'
    normal 'yz<cr>
    normal `z
endfunction

map <F2> :call StripTrailingWhitespace()<CR>
map <F5> :%!/opt/local/bin/tidy -i -q --tidy-mark 0 2>/dev/null<CR>


