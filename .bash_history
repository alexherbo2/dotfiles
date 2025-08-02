git clone https://github.com/raiguard/kak-one.git ~/.local/share/github.com/raiguard/kak-one
git clone https://github.com/FelixKratz/JankyBorders.git ~/.local/share/github.com/FelixKratz/JankyBorders
git clone https://github.com/FelixKratz/dotfiles.git ~/.local/share/github.com/FelixKratz/dotfiles
git clone https://github.com/FelixKratz/SketchyBar.git ~/.local/share/github.com/FelixKratz/SketchyBar
git clone https://github.com/FelixKratz/SketchyVim.git ~/.local/share/github.com/FelixKratz/SketchyVim
git clone https://github.com/natecraddock/zf.git ~/.local/share/github.com/natecraddock/zf
git clone https://github.com/ajeetdsouza/zoxide.git ~/.local/share/github.com/ajeetdsouza/zoxide
git clone https://github.com/jdx/rtx.git ~/.local/share/github.com/jdx/rtx
foot --config=/dev/null -o colors.alpha=0.9
batch -e 'kak' -f 'iconv -f "UTF-8" -t "ASCII//TRANSLIT//IGNORE"' -f 'tr -s " '"'"'" "-"' -f 'tr -d "!,?"' -p ':' -M 'mkdir -vp -- "$(dirname -- "$2")" && mv -vi -- "$1" "$2"' -d 'rm -vi --'
pastel lighten 0.3 | pastel format hex
pastel lighten 0.1 | pastel format hex
pastel darken 0.1 | pastel format hex
alacritty --config-file=/dev/null -o 'window.option_as_alt="Both"' -o 'window.opacity=0.9'
alacritty msg config "$(cat ~/.config/alacritty/colors/macos_dark.toml)" -w -1
alacritty msg config 'window.opacity=0.9'
alacritty msg config 'window.opacity=0.9' -w -1
alacritty msg config 'window.option_as_alt="Both"'
alacritty msg config 'window.option_as_alt="Both"' -w -1
alacritty msg config "$(find -L ~/.local/share/github.com/alacritty/alacritty-theme -type f -name '*.toml' | fzy | xargs cat)" -w -1
alacritty msg config "$(find -L ~/.local/share/github.com/alacritty/alacritty-theme -type f -name '*.toml' | fzy | xargs cat)"
alacritty msg config -r
alacritty msg config -r -w -1
alacritty msg config "$(find -L ~/.config/alacritty/colors -type f -name '*.toml' | fzy | xargs cat)" -w -1
alacritty msg config "$(find -L ~/.config/alacritty/colors -type f -name '*.toml' | fzy | xargs cat)"
kak -s megumin -e 'rename-client chomusuke'
kak -c megumin
git clone https://github.com/zed-industries/zed.git ~/.local/share/github.com/zed-industries/zed
git clone https://github.com/maaslalani/slides.git ~/.local/share/github.com/maaslalani/slides
git clone https://github.com/charmbracelet/glow.git ~/.local/share/github.com/charmbracelet/glow
go install github.com/charmbracelet/crush@latest
git clone https://github.com/charmbracelet/gum.git ~/.local/share/github.com/charmbracelet/gum
git clone https://github.com/charmbracelet/mods.git ~/.local/share/github.com/charmbracelet/mods
git clone https://github.com/fish-shell/fish-shell.git ~/.local/share/github.com/fish-shell/fish-shell
git clone https://github.com/possatti/pokemonsay.git ~/.local/share/github.com/possatti/pokemonsay
git clone https://github.com/watzon/arg_parser.git ~/.local/share/github.com/watzon/arg_parser
git clone https://github.com/phaazon/kak-tree-sitter.git ~/.local/share/github.com/phaazon/kak-tree-sitter
git clone https://git.sr.ht/~hadronized/kak-tree-sitter ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter
git clone https://git.sr.ht/~hadronized/config ~/.local/share/git.sr.ht/~hadronized/config
cd ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter
cd ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter/kak-tree-sitter
cd ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter/ktsctl
git clone https://github.com/phaazon/kak-tree-sitter.git ~/.local/share/github.com/phaazon/kak-tree-sitter
cd ~/.local/share/github.com/phaazon/kak-tree-sitter/kak-tree-sitter
ktsctl fetch -a
ktsctl compile -a
ktsctl install -a
ktsctl sync -a
ktsctl query -a
cd ~/.local/share/github.com/phaazon/kak-tree-sitter/ktsctl
cd ~/.local/share/github.com/phaazon/kak-tree-sitter
git clone https://github.com/refined-github/refined-github.git ~/.local/share/github.com/refined-github/refined-github
cd ~/.local/share/github.com/refined-github/refined-github
git clone https://github.com/gorhill/uBlock.git ~/.local/share/github.com/gorhill/uBlock
cd ~/.local/share/github.com/gorhill/uBlock
git clone https://github.com/kakoune-lsp/kakoune-lsp.git ~/.local/share/github.com/kakoune-lsp/kakoune-lsp
cd ~/.local/share/github.com/kakoune-lsp/kakoune-lsp
install ~/.cargo/bin/kak-lsp /opt/homebrew/bin
install ~/.cargo/bin/kak-tree-sitter /opt/homebrew/bin
install ~/.cargo/bin/ktsctl /opt/homebrew/bin
git clone https://github.com/zellij-org/zellij.git ~/.local/share/github.com/zellij-org/zellij
git clone https://github.com/cantino/mcfly.git ~/.local/share/github.com/cantino/mcfly
git clone https://github.com/doomemacs/doomemacs.git ~/.local/share/github.com/doomemacs/doomemacs
git clone https://github.com/hlissner/dotfiles.git ~/.local/share/github.com/hlissner/dotfiles
git clone https://github.com/topisani/sidetree.git ~/.local/share/github.com/topisani/sidetree
cargo install sidetree
cargo install pepper
cargo install pepper-plugin-lsp
git clone https://github.com/watzon/ngrok.cr.git ~/.local/share/github.com/watzon/ngrok.cr
git clone https://github.com/crystal-lang/crystal-book.git ~/.local/share/github.com/crystal-lang/crystal-book
git clone https://github.com/GoogleChrome/chrome-extensions-samples.git ~/.local/share/github.com/GoogleChrome/chrome-extensions-samples
cd ~/.local/share/github.com/GoogleChrome/chrome-extensions-samples
git clone https://github.com/mdn/webextensions-examples.git ~/.local/share/github.com/mdn/webextensions-examples
git clone https://codeberg.org/dnkl/foot.git ~/.local/share/codeberg.org/dnkl/foot
git clone https://git.sr.ht/~chambln/dots ~/.local/share/git.sr.ht/~chambln/dots
git clone https://git.sr.ht/~emersion/dotfiles ~/.local/share/git.sr.ht/~emersion/dotfiles
git clone https://git.sr.ht/~lessa/pepper ~/.local/share/git.sr.ht/~lessa/pepper
cd ~/.local/share/git.sr.ht/~lessa/pepper
git clone https://git.sr.ht/~krobelus/dotfiles ~/.local/share/git.sr.ht/~krobelus/dotfiles
git clone https://git.sr.ht/~sircmpwn/dotfiles ~/.local/share/git.sr.ht/~sircmpwn/dotfiles
git clone https://github.com/71/dotfiles.git ~/.local/share/github.com/71/dotfiles
git clone https://github.com/archseer/dotfiles.git ~/.local/share/github.com/archseer/dotfiles
git clone https://github.com/Delapouite/dot-in-the-sky.git ~/.local/share/github.com/Delapouite/dot-in-the-sky
git clone https://github.com/dmulholl/dotfiles.git ~/.local/share/github.com/dmulholl/dotfiles
git clone https://github.com/fabi1cazenave/dotFiles.git ~/.local/share/github.com/fabi1cazenave/dotFiles
git clone https://github.com/garybernhardt/dotfiles.git ~/.local/share/github.com/garybernhardt/dotfiles
git clone https://github.com/ifreund/dotfiles.git ~/.local/share/github.com/ifreund/dotfiles
git clone https://github.com/koekeishiya/dotfiles.git ~/.local/share/github.com/koekeishiya/dotfiles
git clone https://github.com/lydell/dotfiles.git ~/.local/share/github.com/lydell/dotfiles
git clone https://github.com/nekonako/dotfiles.git ~/.local/share/github.com/nekonako/dotfiles
hg clone https://hg.stevelosh.com/dotfiles ~/.local/share/hg.stevelosh.com/dotfiles
git clone https://github.com/topisani/dotfiles.git ~/.local/share/github.com/topisani/dotfiles
git clone https://gitlab.com/vbauerster/dotfiles.git ~/.local/share/gitlab.com/vbauerster/dotfiles
git clone https://github.com/tekumara/typos-lsp.git ~/.local/share/github.com/tekumara/typos-lsp
cd ~/.local/share/github.com/tekumara/typos-lsp
cd ~/.local/share/github.com/tekumara/typos-lsp/crates/typos-lsp
git clone https://github.com/mawww/config.git ~/.local/share/github.com/mawww/config
git clone https://github.com/occivink/config.git ~/.local/share/github.com/occivink/config
git clone https://github.com/phaazon/config.git ~/.local/share/github.com/phaazon/config
git clone https://git.sr.ht/~emersion/grim ~/.local/share/git.sr.ht/~emersion/grim
git clone https://git.sr.ht/~emersion/kanshi ~/.local/share/git.sr.ht/~emersion/kanshi
git clone https://github.com/alacritty/alacritty.git ~/.local/share/github.com/alacritty/alacritty
cd ~/.local/share/github.com/alacritty/alacritty
git clone https://github.com/alacritty/alacritty-theme.git ~/.local/share/github.com/alacritty/alacritty-theme
cd ~/.local/share/github.com/alacritty/alacritty-theme
git clone https://github.com/ianyh/Amethyst.git ~/.local/share/github.com/ianyh/Amethyst
git clone https://github.com/taupiqueur/batch.git ~/.local/share/github.com/taupiqueur/batch
git clone https://github.com/Blacksmoke16/oq.git ~/.local/share/github.com/Blacksmoke16/oq
git clone https://github.com/Canop/broot.git ~/.local/share/github.com/Canop/broot
git clone https://github.com/codemirror/dev.git ~/.local/share/github.com/codemirror/dev
git clone https://github.com/crystal-lang/crystal.git ~/.local/share/github.com/crystal-lang/crystal
git clone https://github.com/ziglang/zig.git ~/.local/share/github.com/ziglang/zig
git clone https://github.com/rust-lang/rust.git ~/.local/share/github.com/rust-lang/rust
git clone https://github.com/elixir-lang/elixir.git ~/.local/share/github.com/elixir-lang/elixir
git clone https://github.com/jhawthorn/fzy.git ~/.local/share/github.com/jhawthorn/fzy
git clone https://github.com/jmacdonald/amp.git ~/.local/share/github.com/jmacdonald/amp
git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
git clone https://github.com/rabite0/hunter.git ~/.local/share/github.com/rabite0/hunter
git clone https://github.com/i3/i3.git ~/.local/share/github.com/i3/i3
git clone https://github.com/stedolan/jq.git ~/.local/share/github.com/stedolan/jq
git clone https://github.com/mawww/kakoune.git ~/.local/share/github.com/mawww/kakoune
git clone https://github.com/lydell/browser-tweaks.git ~/.local/share/github.com/lydell/browser-tweaks
cd ~/.local/share/github.com/lydell/browser-tweaks
git clone https://github.com/lydell/LinkHints.git ~/.local/share/github.com/lydell/LinkHints
cd ~/.local/share/github.com/lydell/LinkHints
git clone https://github.com/emersion/mako.git ~/.local/share/github.com/emersion/mako
git clone https://github.com/mpv-player/mpv.git ~/.local/share/github.com/mpv-player/mpv
git clone https://github.com/taupiqueur/mpv-clip.git ~/.local/share/github.com/taupiqueur/mpv-clip
git clone https://github.com/neovim/neovim.git ~/.local/share/github.com/neovim/neovim
git clone https://github.com/jarun/nnn.git ~/.local/share/github.com/jarun/nnn
git clone https://github.com/atlas-engineer/nyxt.git ~/.local/share/github.com/atlas-engineer/nyxt
git clone https://github.com/ocaml/ocaml.git ~/.local/share/github.com/ocaml/ocaml
git clone https://github.com/Morganamilo/paru.git ~/.local/share/github.com/Morganamilo/paru
git clone https://github.com/microsoft/playwright.git ~/.local/share/github.com/microsoft/playwright
git clone https://github.com/taupiqueur/pw.git ~/.local/share/github.com/taupiqueur/pw
git clone https://github.com/ranger/ranger.git ~/.local/share/github.com/ranger/ranger
git clone https://github.com/rxhanson/Rectangle.git ~/.local/share/github.com/rxhanson/Rectangle
git clone https://github.com/refined-github/refined-github.git ~/.local/share/github.com/refined-github/refined-github
git clone https://github.com/riverwm/river.git ~/.local/share/github.com/riverwm/river
git clone https://github.com/lusakasa/saka-key.git ~/.local/share/github.com/lusakasa/saka-key
git clone https://github.com/lusakasa/saka.git ~/.local/share/github.com/lusakasa/saka
git clone https://github.com/jan-warchol/selenized.git ~/.local/share/github.com/jan-warchol/selenized
git clone https://github.com/taupiqueur/chrome-shortcuts.git ~/.local/share/github.com/taupiqueur/chrome-shortcuts
git clone https://github.com/taupiqueur/chrome-shell.git ~/.local/share/github.com/taupiqueur/chrome-shell
git clone https://github.com/taupiqueur/chrome-dmenu.git ~/.local/share/github.com/taupiqueur/chrome-dmenu
git clone https://github.com/taupiqueur/chrome-mpv.git ~/.local/share/github.com/taupiqueur/chrome-mpv
git clone https://github.com/taupiqueur/chrome-nano.git ~/.local/share/github.com/taupiqueur/chrome-nano
git clone https://github.com/taupiqueur/chrome-pandoc.git ~/.local/share/github.com/taupiqueur/chrome-pandoc
git clone https://github.com/taupiqueur/taupiqueur.github.io.git ~/.local/share/github.com/taupiqueur/taupiqueur.github.io
git clone https://github.com/taupiqueur/taupiqueur-notes.git ~/.local/share/github.com/taupiqueur/taupiqueur-notes
git clone https://github.com/taupiqueur/taupiqueur-shorts.git ~/.local/share/github.com/taupiqueur/taupiqueur-shorts
git clone https://github.com/emersion/slurp.git ~/.local/share/github.com/emersion/slurp
git clone https://github.com/starship/starship.git ~/.local/share/github.com/starship/starship
git clone https://github.com/swaywm/sway.git ~/.local/share/github.com/swaywm/sway
git clone https://github.com/swaywm/sway.wiki.git ~/.local/share/github.com/swaywm/sway.wiki
git clone https://github.com/helix-editor/helix.wiki.git ~/.local/share/github.com/helix-editor/helix.wiki
git clone https://github.com/tmux/tmux.git ~/.local/share/github.com/tmux/tmux
git clone https://github.com/gorhill/uBlock.git ~/.local/share/github.com/gorhill/uBlock
git clone https://github.com/philc/vimium.git ~/.local/share/github.com/philc/vimium
git clone https://github.com/dmulholl/vimv.git ~/.local/share/github.com/dmulholl/vimv
git clone https://github.com/WayfireWM/wayfire.git ~/.local/share/github.com/WayfireWM/wayfire
git clone https://github.com/wez/wezterm.git ~/.local/share/github.com/wez/wezterm
cd ~/.local/share/github.com/wez/wezterm
git clone https://github.com/sayanarijit/xplr.git ~/.local/share/github.com/sayanarijit/xplr
git clone https://github.com/occivink/advent2021.git ~/.local/share/github.com/occivink/advent2021
git clone https://github.com/HertzDevil/advent-of-code.git ~/.local/share/github.com/HertzDevil/advent-of-code
git clone https://github.com/asterite/adventofcode2015.git ~/.local/share/github.com/asterite/adventofcode2015
git clone https://github.com/asterite/adventofcode2016.git ~/.local/share/github.com/asterite/adventofcode2016
git clone https://github.com/asterite/adventofcode2017.git ~/.local/share/github.com/asterite/adventofcode2017
git clone https://github.com/asterite/adventofcode2018.git ~/.local/share/github.com/asterite/adventofcode2018
git clone https://github.com/asterite/adventofcode2019.git ~/.local/share/github.com/asterite/adventofcode2019
git clone https://github.com/asterite/adventofcode2020.git ~/.local/share/github.com/asterite/adventofcode2020
git clone https://github.com/asterite/adventofcode2021.git ~/.local/share/github.com/asterite/adventofcode2021
git clone https://github.com/asterite/adventofcode2022.git ~/.local/share/github.com/asterite/adventofcode2022
git remote add origin git@github.com:taupiqueur/chrome-shortcuts.git
git remote add origin git@github.com:taupiqueur/chrome-shell.git
git remote add origin git@github.com:taupiqueur/chrome-dmenu.git
git remote add origin git@github.com:taupiqueur/chrome-mpv.git
git remote add origin git@github.com:taupiqueur/chrome-nano.git
git remote add origin git@github.com:taupiqueur/chrome-pandoc.git
git remote add origin git@github.com:taupiqueur/batch.git
git remote add origin git@github.com:taupiqueur/pw.git
git remote add origin git@github.com:taupiqueur/taupiqueur.github.io.git
git remote add origin git@github.com:taupiqueur/taupiqueur-notes.git
git remote add origin git@github.com:taupiqueur/taupiqueur-shorts.git
git remote add origin git@github.com:taupiqueur/mpv-clip.git
git clone git@github.com:taupiqueur/chrome-shortcuts.git
git clone git@github.com:taupiqueur/chrome-shell.git
git clone git@github.com:taupiqueur/chrome-dmenu.git
git clone git@github.com:taupiqueur/chrome-mpv.git
git clone git@github.com:taupiqueur/chrome-nano.git
git clone git@github.com:taupiqueur/chrome-pandoc.git
git clone git@github.com:taupiqueur/batch.git
git clone git@github.com:taupiqueur/pw.git
git clone git@github.com:taupiqueur/mpv-clip.git
git clone git@github.com:taupiqueur/taupiqueur.github.io.git
git clone git@github.com:taupiqueur/taupiqueur-notes.git
git clone git@github.com:taupiqueur/taupiqueur-shorts.git
git clone git@github.com:taupiqueur/chrome-shortcuts.git chrome-shortcuts.website
git clone git@github.com:taupiqueur/chrome-shell.git chrome-shell.website
git clone git@github.com:taupiqueur/chrome-dmenu.git chrome-dmenu.website
git clone git@github.com:taupiqueur/chrome-mpv.git chrome-mpv.website
git clone git@github.com:taupiqueur/chrome-nano.git chrome-nano.website
git clone git@github.com:taupiqueur/chrome-pandoc.git chrome-pandoc.website
git clone git@github.com:taupiqueur/batch.git batch.website
git clone git@github.com:taupiqueur/pw.git pw.website
git clone git@github.com:taupiqueur/chrome-shortcuts.git chrome-shortcuts.assets
git clone git@github.com:taupiqueur/chrome-shell.git chrome-shell.assets
git clone git@github.com:taupiqueur/chrome-dmenu.git chrome-dmenu.assets
git clone git@github.com:taupiqueur/chrome-mpv.git chrome-mpv.assets
git clone git@github.com:taupiqueur/chrome-nano.git chrome-nano.assets
git clone git@github.com:taupiqueur/chrome-pandoc.git chrome-pandoc.assets
git clone git@github.com:taupiqueur/batch.git batch.assets
git clone git@github.com:taupiqueur/pw.git pw.assets
git push git@github.com:alexherbo2/taupiqueur.github.io.git
git push git@github.com:alexherbo2/taupiqueur.github.io.git -f
git push git@github.com:alexherbo2/chrome-shortcuts.git
git push git@github.com:alexherbo2/chrome-shortcuts.git -f
git push git@github.com:alexherbo2/chrome-shell.git
git push git@github.com:alexherbo2/chrome-shell.git -f
git push git@github.com:alexherbo2/chrome-dmenu.git
git push git@github.com:alexherbo2/chrome-dmenu.git -f
git push git@github.com:alexherbo2/chrome-mpv.git
git push git@github.com:alexherbo2/chrome-mpv.git -f
git push git@github.com:alexherbo2/chrome-nano.git
git push git@github.com:alexherbo2/chrome-nano.git -f
git push git@github.com:alexherbo2/chrome-pandoc.git
git push git@github.com:alexherbo2/chrome-pandoc.git -f
git push git@github.com:alexherbo2/pw.git
git push git@github.com:alexherbo2/pw.git -f
git push git@github.com:alexherbo2/batch.git
git push git@github.com:alexherbo2/batch.git -f
git push git@github.com:alexherbo2/taupiqueur-notes.git
git push git@github.com:alexherbo2/taupiqueur-shorts.git
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-shortcuts.website/manual.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-shortcuts.website/style.css
cp ~/code/chrome-shortcuts/extra/website/card.html ~/code/chrome-shortcuts.website/card.html
ln -s ~/dotfiles~/.ssh ~
ln -s ~/dotfiles~/.hushlogin ~
ln -s ~/dotfiles~/.hushlogin ~
ln -s ~/dotfiles~/.bash_profile ~
ln -s ~/dotfiles~/.inputrc ~
ln -s ~/dotfiles~/.bash_history ~/.bash_history~
ln -s ~/dotfiles~/.bashrc ~
ln -s ~/dotfiles~/Applications/* ~/Applications
ln -s ~/dotfiles~/.config/* ~/.config
ln -s ~/dotfiles~/.local/bin/* ~/.local/bin
ln -s ~/dotfiles~/.local/share/* ~/.local/share
ls -l ~/Applications
ls -l ~/.config
ls -l ~/.local
ls -l ~/.local/bin
ls -l ~/.local/share
ln -s ../comments.html
ln -s ../favicon.svg
ln -s ../manual.css
ln -s ../manual.js
ln -s ../messages.js
ln -s ../card.css
ln -s ../style.css
ln -s ../sitemap.html
cd ./fr/
cp ~/code/chrome-shortcuts/extra/website/comments.html ~/code/chrome-shortcuts.website/comments.html
cp ~/code/chrome-shortcuts/extra/website/sitemap.html ~/code/chrome-shortcuts.website/sitemap.html
cp ~/code/chrome-shortcuts/extra/website/card.fr.html ~/code/chrome-shortcuts.website/fr/card.html
cp ~/code/chrome-shortcuts/extra/website/card.css ~/code/chrome-shortcuts.website/card.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-dmenu/src/manual/manual.css
cp ~/code/chrome-shortcuts/src/options/options.css ~/code/chrome-dmenu/src/options/options.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-dmenu/extra/website/style.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-dmenu.website/manual.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-dmenu.website/style.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-mpv/src/manual/manual.css
cp ~/code/chrome-shortcuts/src/options/options.css ~/code/chrome-mpv/src/options/options.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-mpv/extra/website/style.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-mpv.website/manual.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-mpv.website/style.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-nano/src/manual/manual.css
cp ~/code/chrome-shortcuts/src/options/options.css ~/code/chrome-nano/src/options/options.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-nano/extra/website/style.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-nano.website/manual.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-nano.website/style.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-pandoc/src/manual/manual.css
cp ~/code/chrome-shortcuts/src/options/options.css ~/code/chrome-pandoc/src/options/options.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-pandoc/extra/website/style.css
cp ~/code/chrome-shortcuts/src/manual/manual.css ~/code/chrome-pandoc.website/manual.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-pandoc.website/style.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-shell/extra/website/chrome-shell.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/chrome-shell.website/chrome-shell.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/batch/extra/website/batch.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/batch.website/batch.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/pw/extra/website/pw.css
cp ~/code/chrome-shortcuts/extra/website/style.css ~/code/pw.website/pw.css
for dir in ~/code/chrome-shortcuts ~/code/chrome-shell ~/code/chrome-dmenu ~/code/chrome-mpv ~/code/chrome-nano ~/code/chrome-pandoc ~/code/batch ~/code/pw ~/code/chrome-shortcuts.website ~/code/chrome-shell.website ~/code/chrome-dmenu.website ~/code/chrome-mpv.website ~/code/chrome-nano.website ~/code/chrome-pandoc.website ~/code/batch.website ~/code/pw.website; do cd "$dir" && git add . && git commit -m 'Update shared styles'; done && cd
cp ~/code/chrome-shortcuts/package.json ~/code/chrome-dmenu/package.json
cp ~/code/chrome-shortcuts/package.json ~/code/chrome-mpv/package.json
cp ~/code/chrome-shortcuts/package.json ~/code/chrome-nano/package.json
cp ~/code/chrome-shortcuts/package.json ~/code/chrome-pandoc/package.json
for dir in ~/code/chrome-shortcuts ~/code/chrome-dmenu ~/code/chrome-mpv ~/code/chrome-nano ~/code/chrome-pandoc; do cd "$dir" && git add . && git commit -m 'Bump all dependencies'; done && cd
for dir in ~/code/chrome-shortcuts ~/code/chrome-dmenu ~/code/chrome-mpv ~/code/chrome-nano ~/code/chrome-pandoc; do cd "$dir" && git push; done && cd
for dir in ~/code/chrome-shortcuts ~/code/chrome-shortcuts.website; do cd "$dir" && git push; done && cd
cp ~/code/chrome-shortcuts/src/recent_tabs_manager.js ~/code/chrome-dmenu/src/recent_tabs_manager.js
cp ~/code/chrome-shortcuts/src/lib/mru.js ~/code/chrome-dmenu/src/lib/mru.js
cp ~/code/chrome-shortcuts/src/lib/linked_list.js ~/code/chrome-dmenu/src/lib/linked_list.js
cp ~/code/chrome-shortcuts/src/suggestion_engine/suggestion_engine.js ~/code/chrome-dmenu/src/suggestion_engine/suggestion_engine.js
cp ~/code/chrome-shortcuts/src/suggestion_engine/suggestion_providers.js ~/code/chrome-dmenu/src/suggestion_engine/suggestion_providers.js
hx
cp ~/code/chrome-shortcuts/extra/website/index.html ~/code/chrome-shortcuts.website/index.html
cp ~/code/chrome-shortcuts/extra/website/index.fr.html ~/code/chrome-shortcuts.website/fr/index.html
cp ~/code/chrome-dmenu/extra/website/index.html ~/code/chrome-dmenu.website/index.html
cp ~/code/chrome-mpv/extra/website/index.html ~/code/chrome-mpv.website/index.html
cp ~/code/chrome-nano/extra/website/index.html ~/code/chrome-nano.website/index.html
cp ~/code/chrome-pandoc/extra/website/index.html ~/code/chrome-pandoc.website/index.html
cp ~/code/chrome-shell/extra/website/chrome-shell.html ~/code/chrome-shell.website/chrome-shell.html
cp ~/code/batch/extra/website/batch.html ~/code/batch.website/batch.html
cp ~/code/pw/extra/website/pw.html ~/code/pw.website/pw.html
sway
cp ~/code/chrome-dmenu/src/manual/manual.js ~/code/chrome-mpv/src/manual/manual.js
cp ~/code/chrome-dmenu/src/manual/manual.js ~/code/chrome-nano/src/manual/manual.js
cp ~/code/chrome-dmenu/src/manual/manual.js ~/code/chrome-pandoc/src/manual/manual.js
brew install kakoune-lsp/kakoune-lsp/kakoune-lsp
brew install possatti/possatti/pokemonsay
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
echo '%admin ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
csrutil enable --without fs --without debug --without nvram
csrutil status
csrutil disable
csrutil enable
sudo nvram boot-args=-arm64e_preview_abi
yabai --start-service
skhd --start-service
yabai --restart-service
skhd --restart-service
brew install FelixKratz/formulae/borders
brew services start borders
git clone https://github.com/koekeishiya/yabai.git ~/.local/share/github.com/koekeishiya/yabai
git clone https://github.com/koekeishiya/skhd.git ~/.local/share/github.com/koekeishiya/skhd
git clone https://github.com/koekeishiya/dotfiles.git ~/.local/share/github.com/koekeishiya/dotfiles
brew link --overwrite node
brew link --force curl
brew link --force ncurses
alacritty msg create-window
rsync 'host:Library/Application Support/Google/Chrome/.' .config/chromium
open .
open /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts
open target/release
npm update
npm update -g
brew-update
brew-install
brew-install-head
brew-reinstall
brew-uninstall
brew-clean
yay
yay-update
yay-install
yay-uninstall
yay-clean
apk-update
apk-install
apk-uninstall
apk-clean
rm .DS_Store
sudo DS_Store
DS_Store
pbcopy < /dev/null
wl-copy --clear
tldr -u
rustup update
rustup toolchain list
rustup toolchain install nightly
rustup default nightly
rustup default stable
export LIBGL_ALWAYS_SOFTWARE=1
export WLR_RENDERER=pixman
export WLR_NO_HARDWARE_CURSORS=1
eval "$(starship init bash)"
rm ~/docs/bookmarks_*_*_*.html
mv ~/Documents/bookmarks_*_*_*.html ~/docs
ln ~/docs/chrome_extensions/*.png ~/code/chrome-shortcuts.assets
fd '\Ascreenshot_\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2}(@\d{4}x\d{3}px)?\.png\z'
fd '\Ascreenshot_\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2}(@\d{4}x\d{3}px)?\.png\z' ~/docs/chrome_extensions
fd '\Ascreenshot_\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2}(@\d{4}x\d{3}px)?\.png\z' ~/code/chrome-shortcuts.assets
weechat
rm -R .config/weechat .local/share/weechat .cache/weechat
pw --length=10 strongly-typed-thoughts.net taupiqueur
passwd taupiqueur
tmux
tmux attach-session
pw --length=10 kanto taupiqueur
pw --length=10 google.com taupiqueur.kanto
pw --length=10 github.com taupiqueur
pw --length=10 stripe.com taupiqueur.kanto@gmail.com
pw --length=10 apple.com taupiqueur.kanto@gmail.com
pw --length=10 kobo.com taupiqueur.kanto@gmail.com
pw --length=10 lichess.org taupiqueur
pw --length=10 news.ycombinator.com taupiqueur
pw --length=10 lobste.rs taupiqueur
pw --length=10 paragon-software.com taupiqueur.kanto@gmail.com
pw --length=10 paypal.com taupiqueur.kanto@gmail.com
pw --length=10 libera.chat taupiqueur
pw --length=10 amazon.com taupiqueur.kanto@gmail.com
kak ~/docs/todo.txt
cat ~/docs/todo.txt
kak ~/docs/notes.txt
cat ~/docs/notes.txt
kak ~/anime/list.txt
kak ~/series/list.txt
kak ~/movies/list.txt
kak ~/storage/movies/list.txt
kak ~/games/info.txt
kak ~/youtube/music/info.txt
kak ~/youtube/videos/info.txt
kak ~/youtube/channels/joueur-du-grenier/list.txt
kak ~/youtube/channels/bazar-du-grenier/list.txt
kak
kak -n
kak -l
nnn
cd ~/docs/notes
cd ~/Downloads
cd ~/storage/photos
cd ~/storage/pictures
cd ~/storage/downloads
nnn ~/Downloads
nnn ~/storage/downloads
nnn ~/Documents
ls ~/docs
nnn ~/docs
nnn ~/tmp
nnn ~/data
nnn ~/Desktop
nnn ~/.local/share/git.sr.ht
nnn ~/.local/share/github.com
nnn ~/.local/share/codeberg.org
nnn ~/.local/share/gitlab.com
nnn ~/.local/share/hg.stevelosh.com
ls ~/code
cd ~/code
cd ~/config
cd ~/data
cd ~/tmp
xattr -rc ~/docs/chrome_extensions
sudo xattr -rc ~/docs/chrome_extensions
xattr -rc ~/code/chrome-shortcuts.assets
sudo xattr -rc ~/code/chrome-shortcuts.assets
find ~/code/chrome-shortcuts.assets -name '*.DS_Store'
xattr -rc ~/code/chrome-shortcuts.website
sudo xattr -rc ~/code/chrome-shortcuts.website
find ~/code/chrome-shortcuts.website -name '*.DS_Store'
xattr -rc ~/code/chrome-shortcuts
sudo xattr -rc ~/code/chrome-shortcuts
find ~/code/chrome-shortcuts -name '*.DS_Store'
xattr -rc ~/code/chrome-shell
sudo xattr -rc ~/code/chrome-shell
find ~/code/chrome-shell -name '*.DS_Store'
xattr -rc ~/code/chrome-dmenu
sudo xattr -rc ~/code/chrome-dmenu
find ~/code/chrome-dmenu -name '*.DS_Store'
xattr -rc ~/code/chrome-mpv
sudo xattr -rc ~/code/chrome-mpv
find ~/code/chrome-mpv -name '*.DS_Store'
xattr -rc ~/code/chrome-nano
sudo xattr -rc ~/code/chrome-nano
find ~/code/chrome-nano -name '*.DS_Store'
xattr -rc ~/code/chrome-pandoc
sudo xattr -rc ~/code/chrome-pandoc
find ~/code/chrome-pandoc -name '*.DS_Store'
xattr -rc ~/code/batch
sudo xattr -rc ~/code/batch
find ~/code/batch -name '*.DS_Store'
xattr -rc ~/code/pw
sudo xattr -rc ~/code/pw
find ~/code/pw -name '*.DS_Store'
cd ~/code/taupiqueur.github.io
cd ~/code/chrome-shortcuts
cd ~/code/chrome-shell
cd ~/code/chrome-dmenu
cd ~/code/chrome-mpv
cd ~/code/chrome-nano
cd ~/code/chrome-pandoc
cd ~/code/batch
cd ~/code/pw
cd ~/code/mpv-clip
cd ~/docs/chrome_extensions
cd ~/code/chrome-shortcuts.assets
cd ~/code/chrome-shortcuts.website
cd ~/code/chrome-shell.website
cd ~/code/chrome-dmenu.website
cd ~/code/chrome-mpv.website
cd ~/code/chrome-nano.website
cd ~/code/chrome-pandoc.website
cd ~/code/batch.website
cd ~/code/pw.website
caffeinate -d
tmux new-session caffeinate -d
caffeinate-lid
decaffeinate-lid
nginx
ifconfig | grep 192.168
ip addr | grep 192.168
tmux new-session sudo nginx -c /etc/nginx/nginx.conf
rm -R .config/mpv/watch_later
git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
git clone https://github.com/mawww/kakoune.git ~/.local/share/github.com/mawww/kakoune
git clone https://github.com/elbywan/crystalline.git ~/.local/share/github.com/elbywan/crystalline
cd ~/.local/share/github.com/elbywan/crystalline
brew link --force llvm
shards install
cd ~/home
cd ~/storage
mkdir fonts
cd ~/home/fonts
mkdir ~/.local/share/fonts
cd ~/.local/share/fonts
unzip ~/shared/kanto/home/fonts/IBM_Plex_Sans.zip
unzip ~/shared/kanto/home/fonts/IBM_Plex_Mono.zip
unzip ~/shared/kanto/home/fonts/Galdeano.zip
mkdir bin
crystal build src/crystalline.cr -o bin/crystalline --release --no-debug --progress -Dpreview_mt
install bin/crystalline ~/.local/bin
cd ~/.local/share/github.com/mawww/kakoune
install src/kak.opt ~/.local/bin/kak
install ~/.local/bin/kak /opt/homebrew/bin
mpv https://twitch.tv/joueur_du_grenier
mpv https://twitch.tv/randomwatchertv
mpv https://twitch.tv/kayanetv
cd ~/.local/share/github.com/helix-editor/helix
cargo build --release
cargo install --locked --path helix-term
install ~/.cargo/bin/hx /opt/homebrew/bin
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_alexherbo2'
git config set core.sshCommand 'ssh -i ~/.ssh/id_ed25519_alexherbo2'
git config set user.email alexherbo2@gmail.com
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_mathieuablasou'
git config set core.sshCommand 'ssh -i ~/.ssh/id_ed25519_mathieuablasou'
git config set user.email mathieu.ablasou@cashbee.fr
export EDITOR='kak -n'
export TERM='xterm-256color'
unset TERM
unset GIT_SSH_COMMAND
rm .git/COMMIT_EDITMSG
rm .git/gitui
sudo kak /private/var/db/dhcpd_leases
find /private/var/folders -name '*icon*' -print -exec rm -Ri -- {} +
ssh host
ssh guest
ssh mawww
ssh phaazon
uname -a
uname -m
curl -O https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
tar xvf ffmpeg-git-amd64-static.tar.xz
ssh phaazon -t tmux attach-session
xattr -rc ~/shorts
sudo xattr -rc ~/shorts
find ~/shorts -name '*.DS_Store'
scp -r ~/storage/shorts phaazon:
mkdir docs
scp ~/docs/notes.txt phaazon:docs
rsync --exclude=.git/ ~/storage/shorts phaazon:
git remote add origin git@phaazon:shorts.git
mkdir bin
install ffmpeg-git-20240629-amd64-static/ffmpeg bin
export PATH=~/bin:$PATH
rsync home guest:
sshfs host: shared/kanto
ngrok tcp 22
ngrok http 80
ssh taupiqueur@7.tcp.eu.ngrok.io -p 14378
swaymsg reload
swaymsg output eDP-1 disable
chmod go= ~/.ssh/id_ed25519
chown -R taupiqueur:users home storage shared
chown -R taupiqueur:staff home storage shared
sudo chown -R taupiqueur:users home storage shared
sudo chown -R taupiqueur:staff home storage shared
doas chown -R taupiqueur:taupiqueur /home/taupiqueur
xattr -rc home storage shared
sudo xattr -rc home storage shared
mkdir -p mnt/Disk
mkdir -p mnt/USB
sudo mount /dev/disk/by-label/Disk mnt/Disk
sudo mount /dev/disk/by-label/USB mnt/USB
sudo umount /dev/disk/by-label/Disk
sudo umount /dev/disk/by-label/USB
doas mount /dev/disk/by-label/Disk mnt/Disk
doas mount /dev/disk/by-label/USB mnt/USB
doas umount mnt/Disk
doas umount mnt/USB
rsync home storage shared guest:mnt/Disk
rsync home shared guest:mnt/USB
rsync home storage shared /Volumes/Disk
rsync home shared /Volumes/USB
rm -R /Volumes/Disk/.fseventsd
rm -R /Volumes/USB/.fseventsd
shutdown now
doas poweroff
doas modprobe fuse
doas rc-service sshd start
doas rc-service sshd stop
rc-service sshd status
doas rc-update add sshd
doas rc-update delete sshd
rc-update show
rc-status
rc-status -s
chsh -s /bin/bash
su
setup-alpine
setup-desktop
apk update
apk upgrade
reboot
gh repo view --web
gh repo fork
rm -R Movies/TV
rm -R Music/Music
nnn ~/anime
nnn ~/series
nnn ~/movies
nnn ~/storage/movies
nnn ~/games
nnn ~/youtube
mpv ~/anime/one-piece/06
mpv ~/series/stargate/stargate-sg-1/french/01
mpv ~/anime/nicky-larson/01
mpv ~/sounds/waves.opus
mpv --shuffle ~/shorts
cd ~/shorts
kamux ytdlp_list.sh
sh ytdlp_list.sh
sh <(curl -L https://nixos.org/nix/install)
du -sh ~/shorts
xattr -rc ~/manga
find ~/manga -name '*.DS_Store'
sh ~/shorts/twitch.sh
find -L ~/shorts -type f -name '*.mp4' -exec printf "file '%s'\\n" {} + | shuf > /tmp/shorts.ffconcat
kak -n -e "set-option global indentwidth 2; map global normal <ret> :; map global normal <c-a> ga; map global normal <c-s> :write<ret>" /tmp/shorts.ffconcat
vim /tmp/shorts.ffconcat
ffmpeg -stream_loop -1 -f concat -safe 0 -i /tmp/shorts.ffconcat -c:v libx264 -f flv "rtmp://live.twitch.tv/app/$TWITCH_STREAM_KEY"
git stash
git stash pop
git stash list
git branch
git branch -d master
git branch -d assets
git branch -d website
git switch --orphan assets
git switch assets
git switch --orphan website
git switch website
git switch master
git init
git log --pretty='[%h][%s][%b]'
git log --pretty='[%h][%s][%b]' | rg -F ''
git log --pretty='[%h][%s][%b]' --author='taupiqueur.kanto@gmail.com'
git clone https://github.com/raiguard/kak-mark.git ~/.local/share/github.com/raiguard/kak-mark
cd ~/.local/share/github.com/raiguard/kak-mark
git rebase -i 'c879d5592e5aba983cb1e2a9ca804d26c5fefe68^'
git rebase -i ''
git rebase --continue
git rebase --abort
git add .
git push
git push -u origin master
git push -u origin website
git push -u origin assets
git pull
git pull upstream master
date "+%F %T" | git commit -F -
git commit --amend --no-edit
git commit --amend --reset-author --no-edit
git commit --amend --author='Mathieu Ablasou <alexherbo2@gmail.com>' --no-edit
git rebase --root --autostash -x 'git commit --amend --author="Mathieu Ablasou <alexherbo2@gmail.com>" --no-edit'
git commit --amend
git commit -m 'Initial commit'
git commit -m 'Bump version to 0.1.0'
git commit -m 'Bump all dependencies'
git remote add origin git@github.com:taupiqueur/taupiqueur.git
git remote add origin git@github.com:alexherbo2/alexherbo2.git
git remote add upstream git@github.com:taupiqueur/taupiqueur.git
git remote add upstream git@github.com:alexherbo2/alexherbo2.git
make release name=chrome-shell version=nightly target=aarch64-apple-darwin
gh release upload nightly releases/chrome-shell-nightly-aarch64-apple-darwin.tar.xz
docker build -t chrome-shell .
docker run -v .:/app -w /app chrome-shell make static=yes release name=chrome-shell version=nightly target=aarch64-unknown-linux-musl
gh release upload nightly releases/chrome-shell-nightly-aarch64-unknown-linux-musl.tar.xz
make release name=batch version=nightly target=aarch64-apple-darwin
gh release upload nightly releases/batch-nightly-aarch64-apple-darwin.tar.xz
docker build -t batch .
docker run -v .:/app -w /app batch make static=yes release name=batch version=nightly target=aarch64-unknown-linux-musl
gh release upload nightly releases/batch-nightly-aarch64-unknown-linux-musl.tar.xz
make release name=pw version=nightly target=aarch64-apple-darwin
gh release upload nightly releases/pw-nightly-aarch64-apple-darwin.tar.xz
docker build -t pw .
docker run -v .:/app -w /app pw make static=yes release name=pw version=nightly target=aarch64-unknown-linux-musl
gh release upload nightly releases/pw-nightly-aarch64-unknown-linux-musl.tar.xz
git add .
git tag -l
git tag -d nightly
git rebase -i HEAD^
gh repo create
@host
@guest
@phaazon
clear
kitty -o allow_remote_control=yes
kamux
kamux .bash_history
_ssh
ggc
br
broot
gitui
xattr -c alpine-standard-3.21.2-aarch64.iso
shasum -a 256 alpine-standard-3.21.2-aarch64.iso
echo alpine-standard-3.21.2-aarch64.iso 8aaf23ac55a0b2576c54d3bb8ad48fe81bd14bdc4def2da2f2d9a8113c66328e
sudo mkfs.ext4 /dev/sda
sudo wipefs -a /dev/sda
sudo dd if=alpine-standard-3.21.2-aarch64.iso of=/dev/sda
sudo mkfs.ext4 /dev/sdb
sudo wipefs -a /dev/sdb
sudo dd if=alpine-standard-3.21.2-aarch64.iso of=/dev/sdb
doas mkfs.ext4 /dev/sda
doas wipefs -a /dev/sda
doas dd if=alpine-standard-3.21.2-aarch64.iso of=/dev/sda
doas mkfs.ext4 /dev/sdb
doas wipefs -a /dev/sdb
doas dd if=alpine-standard-3.21.2-aarch64.iso of=/dev/sdb
exa
eza
ls
ls -l
ls -a
ls -la
cd
cd -
cd ~
vi
vim
pwd
nmtui
exit 0
exit 1
exit
