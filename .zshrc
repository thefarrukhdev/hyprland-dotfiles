# =============================================================================
# ZSH Configuration - Master Architect Edition
# =============================================================================

# History Config
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups

# Emacs bindings
bindkey -e

# =============================================================================
# ALIASLAR (Super Developer Commands)
# =============================================================================
# Eza (ls o'rniga zamonaviy va chiroyli ikonkalik ro'yxat)
alias ls="eza -a --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias l="eza -l --icons --group-directories-first"
alias tree="eza --tree --icons"

# Tezkor harakatlanish
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd="z"
alias cdi="zi"

# Dasturchilar uchun
alias vim="nvim"
alias c="clear"
alias grep="grep --color=auto"
alias myip="curl http://ipecho.net/plain; echo"

# Tizimni yangilash (Parolni kiritmasdan tezkor update)
alias update="sudo pacman -Syu"

# Git uchun tezkor aliaslar
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

# =============================================================================
# Plugins & Initialization
# =============================================================================
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Initialize Zoxide (Smarter cd)
eval "$(zoxide init zsh)"

# Initialize Starship (Cross-shell prompt)
eval "$(starship init zsh)"

# Terminal ochilganda Arch logotipi bilan tizim ma'lumotlarini chiqarish
fastfetch

# =============================================================================
# TUI Qurollari (Professional Workflow)
# =============================================================================
alias lg="lazygit"
alias ld="lazydocker"

# Standart quruq "cat" o'rniga rangli va tartibli "bat" ni ulaymiz
alias cat="bat --style=plain --paging=never"

# FZF yordamida tezkor qidiruv va faylning ichini yon tomonda (preview) ko'rish
alias f="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# FZF klaviatura qisqartmalari (Ctrl+R = tarixni qidirish, Ctrl+T = fayllarni qidirish)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f ~/.zshrc_custom ] && source ~/.zshrc_custom
export RENDER_API_KEY="rnd_p64I2SPt0HbMWCymfPyToVr1O3Ly"
export PATH="$HOME/.local/bin:$PATH"
