function fish_prompt --description 'Informative prompt'
    # Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                  and set_color $fish_color_cwd_root
                                                  or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color --reset)
    else
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
        
        # This version sets everything from USER to HOSTNAME to bold red
        printf '[%s] %b%s@%s %b%s%s%b \n> ' \
            (date "+%H:%M:%S") \
            (set_color --bold red) $USER (prompt_hostname) \
            (set_color $fish_color_cwd) $PWD $pipestatus_string \
            (set_color --reset)
    end
end

