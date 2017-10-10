# center-text.vim

center-text.vim is all about formating comments.  The plugin provides mappings to easily center comments padded with
most punctuation chars.

It's easiest to explain with examples.

In a Javascript file press `\fch` inside

```javascript
// some comment
```

to change it to

```javascript
//                                some comment                                //
```

In a bash file press `\fch-` inside

```bash
# some comment
```

to change it to

```bash
# ------------------------------- some comment ------------------------------- #
```

In a vim file press `\fch*` inside

```vim
" some comment
```

to change it to


```vim
" ******************************* some comment ******************************* "
```


This plugin is great for breaking files into sections.

## Installation

### Via Plugin Manager (Recommended)

#### [Vim-Plug](https://github.com/junegunn/vim-plug)

1. Add `Plug 'jtbairdsr/vim-center-comment'` to your vimrc file.
2. Reload your vimrc or restart
3. Run `:PlugInstall`

#### [Vundle](https://github.com/VundleVim/Vundle.vim) or similar

1. Add `Plugin 'jtbairdsr/vim-center-comment'` to your vimrc file.
2. Reload your vimrc or restart
3. Run `:BundleInstall`

#### [NeoBundle](https://github.com/Shougo/neobundle.vim)

1. Add `NeoBundle 'jtbairdsr/vim-center-comment'` to your vimrc file.
2. Reload your vimrc or restart
3. Run `:NeoUpdate`

#### [Pathogen](https://github.com/tpope/vim-pathogen)

```sh
cd ~/.vim/bundle
git clone https://github.com/jtbairdsr/vim-center-comment.git
```

### Manual Installation

#### Unix

(For Neovim, change `~/.vim/` to `~/.config/nvim/`.)

```sh
curl -fLo ~/.vim/plugin/center-comment.vim --create-dirs \
https://raw.githubusercontent.com/jtbairdsr/center-comment/master/plugin/center-comment.vim
curl -fLo ~/.vim/doc/center-comment.txt --create-dirs \
https://raw.githubusercontent.com/jtbairdsr/center-comment/master/doc/center-comment.txt
```

#### Windows (PowerShell)

```powershell
md ~\vimfiles\plugin
md ~\vimfiles\doc
$pluguri = 'https://raw.githubusercontent.com/jtbairdsr/center-comment/master/plugin/center-comment.vim'
$docsuri = 'https://raw.githubusercontent.com/jtbairdsr/center-comment/master/doc/center-comment.txt'
(New-Object Net.WebClient).DownloadFile($pluguri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\plugin\center-comment.vim"))
(New-Object Net.WebClient).DownloadFile($docsuri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\doc\center-comment.txt"))
```
Once help tags have been generated, you can view the manual with
`:help center-comment`.

## License

Copyright (c) Jonathan Baird.  Distributed under the same terms as Vim itself.
See `:help license`.
