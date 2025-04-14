# Custom Neovim Configuration

## Getting Started
1. Install Neovim and all prerequisites for LazyVim following steps in [Custom Ubuntu Configuration](https://github.com/jamesbury3/ubuntu)
2. Clone this repository into `~/.config/nvim/`
3. Install `nvm`, `npm`, and `node`.
4. Install `Go`

## Formatters
### Python
1. Create a python virtual environment in `~/.config/nvim/formatters` using `requirements.txt`. This will be used for all formatters installed using `pip`.
2. Within that virtual environment, install black with `pip install black`

### Prettier (JS, Yaml, JSON, etc.)
1. Install `prettier` globally using `npm`

### Go
1. Install `Go`. This will include `gofmt` automatically

## LSPs
1. Use `MasonInstall` to install each LSP listed in `~/.config/nvim/lua/plugins/mason.lua` (example: `MasonInstall pyright`)

