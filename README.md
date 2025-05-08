# Custom Neovim Configuration

## Getting Started
1. Install Neovim
2. Install the following prerequisites
   1. `fzf`
   2. `gcc` (may already be available depending on OS)
   3. `lazygit`
   4. `ripgrep`
4. Clone this repository: `git clone https://github.com/jamesbury3/nvim-config ~/.config/nvim`
5. Install `nvm`, `npm`, and `node`.
6. Install `Go`
7. Add the following to ~/.zprofile:
```
# Neovim
source ~/.config/nvim/.zprofile
```

## Formatters
### Python
1. Create a python virtual environment in `~/.config/nvim/formatters` using `requirements.txt`. This will be used for all formatters installed using `pip`.
```
cd ~/.config/nvim/formatters/python
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Prettier (JS, Yaml, JSON, etc.)
1. Install `prettier` globally using `npm`
2. Install `prettier-plugin-java` using `npm`
3. Paste [.prettierrc](./formatters/.prettierrc) into `~/.prettierrc`

### Go
1. Install `Go`. This will include `gofmt` automatically

### Lua
1. Install `stylua` using package manager

## LSPs
1. Install the following LSPs using package manager
   1. `gopls`
   2. `lua-language-server`
   3. `pyright`

## Debugging

### Go
1. Install `dlv` using `go install`
