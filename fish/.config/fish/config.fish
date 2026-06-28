# ── Welcome ──────────────────────────────────────
function fish_greeting
    fastfetch --config ~/.config/fastfetch/config.jsonc
end

# ── Theme Colors ──────────────────────────────────
if status is-interactive
    source ~/.config/fish/my_colors.fish
end

# ── LS_COLORS + eza aliases ──────────────────────
if status is-interactive
    if command -v vivid &>/dev/null
        set -gx LS_COLORS (vivid generate one-dark)
    end

    if command -v eza &>/dev/null
        alias ls="eza -l --icons=always --color=always --group-directories-first"
        alias ll="eza -la --icons=always --color=always --group-directories-first"
        alias lt="eza -aT --color=always --group-directories-first --icons"
        alias la="eza -a --color=always --group-directories-first --icons"
    end
end

# ── PATH ──────────────────────────────────────────
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# ── Useful aliases ────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias please="sudo"
alias update="sudo pacman -Syu"
alias cleanup="sudo pacman -Rns (pacman -Qtdq)"

# ── Git prompt styling ────────────────────────────
set -g __fish_git_prompt_prefix "("
set -g __fish_git_prompt_suffix ")"
set -g __fish_git_prompt_color_branch F14E32
set -g __fish_git_prompt_color_prefix F14E32
set -g __fish_git_prompt_color_suffix F14E32
set -g __fish_git_prompt_color F14E32

# ── Prompt ────────────────────────────────────────
function fish_prompt
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status

    set -l venv_prompt ""
    if set -q VIRTUAL_ENV
        set -l venv_name (basename "$VIRTUAL_ENV")
        set venv_prompt (set_color cyan)"[$venv_name]"(set_color normal)
    end

    set -l rust_prompt ""
    if type -q cargo; and cargo locate-project --quiet >/dev/null 2>&1
        set rust_prompt (set_color ffa500)"(Rust)"(set_color normal)
    end

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                          and set_color $fish_color_cwd_root
                                                          or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color --reset)
    else
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        set -l vcs_string (fish_vcs_prompt)
        if test -z "$vcs_string"; and test -n "$venv_prompt$rust_prompt"
            set vcs_string " "
        end

        printf '[%s] %b%s%b@%b%s %b%s%s%b%s%s%s%s\n> ' \
            (date "+%H:%M:%S") \
            (set_color --bold red) $USER (set_color normal) (set_color --bold red) (prompt_hostname) \
            (set_color $fish_color_cwd) $PWD $pipestatus_string \
            (set_color --reset) $vcs_string $venv_prompt $rust_prompt
    end
end

# ── History ───────────────────────────────────────
function history
    builtin history --show-time="%F %T "
end

# ── Bang-bang (!! and !$) ─────────────────────────
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end
