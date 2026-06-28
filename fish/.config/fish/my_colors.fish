# ── Fish theme ──────────────────────────────────
#   Frozen from fish default theme.
#   fish_config theme changes IGNORED — edit below instead.
#   Colors: black red green yellow blue magenta cyan white
#           brblack brred brgreen bryellow brblue brmagenta brcyan brwhite
#   Flags:  --bold --italics --underline --reverse --reset
#           --background=<color>

# ── Syntax highlighting ─────────────────────────
set -g fish_color_normal --reset # non-special text
set -g fish_color_command ff5555 # command names (ls, git, echo...)
set -g fish_color_quote yellow # quoted strings "hello"
set -g fish_color_redirection cyan --bold # > >> < << | 2>
set -g fish_color_end green # & (background) ; (separator)
set -g fish_color_error brred # invalid command, syntax err
set -g fish_color_param cyan # command parameters
set -g fish_color_comment red # comments # like this
set -g fish_color_match white --background=brblack --bold # matching bracket/quote
set -g fish_color_selection white --background=brblack --bold # selected text
set -g fish_color_search_match white --background=brblack --bold # history search hits
set -g fish_color_history_current --bold # current history entry
set -g fish_color_operator brcyan # && || ! $ (param expansion)
set -g fish_color_escape brcyan # escaped chars \n \t
set -g fish_color_autosuggestion brblack # ghost text predictions
set -g fish_color_cwd green # current directory in prompt
set -g fish_color_cwd_root red # cwd when root user
set -g fish_color_user brgreen # username in prompt (fish default)
set -g fish_color_host --reset # hostname in prompt (local)
set -g fish_color_host_remote yellow # hostname in prompt (remote/SSH)
set -g fish_color_cancel --reverse # ^C cancel indicator
set -g fish_color_valid_path --underline # valid file path underline
set -g fish_color_status red # command exit ≠ 0 (also in prompt)

# ── Pager (tab-completion list) ─────────────────
set -g fish_pager_color_description yellow --italics
set -g fish_pager_color_prefix --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan --bold
set -g fish_pager_color_selected_background --reverse

# ── Pure prompt theme (preserved) ───────────────
set -g pure_color_at_sign pure_color_mute
set -g pure_color_aws_profile pure_color_warning
set -g pure_color_command_duration pure_color_warning
set -g pure_color_current_directory pure_color_primary
set -g pure_color_danger red
set -g pure_color_dark black
set -g pure_color_exit_status pure_color_danger
set -g pure_color_git_branch pure_color_mute
set -g pure_color_git_dirty pure_color_mute
set -g pure_color_git_stash pure_color_info
set -g pure_color_git_unpulled_commits pure_color_info
set -g pure_color_git_unpushed_commits pure_color_info
set -g pure_color_hostname pure_color_mute
set -g pure_color_info cyan
set -g pure_color_jobs pure_color_normal
set -g pure_color_k8s_context pure_color_success
set -g pure_color_k8s_namespace pure_color_primary
set -g pure_color_k8s_prefix pure_color_info
set -g pure_color_light ebdbb2
set -g pure_color_mute 595959
set -g pure_color_nixdevshell_prefix pure_color_info
set -g pure_color_nixdevshell_symbol pure_color_mute
set -g pure_color_normal normal
set -g pure_color_prefix_root_prompt pure_color_danger
set -g pure_color_primary blue
set -g pure_color_prompt_on_error pure_color_danger
set -g pure_color_prompt_on_success pure_color_success
set -g pure_color_success magenta
set -g pure_color_system_time pure_color_light
set -g pure_color_username_normal pure_color_mute
set -g pure_color_username_root pure_color_light
set -g pure_color_virtualenv pure_color_mute
set -g pure_color_warning yellow
