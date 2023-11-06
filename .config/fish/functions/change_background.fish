function change_background --argument mode_setting
    set -l mode light # default value
    if test -z $mode_setting
        set -l val (defaults read -g AppleInterfaceStyle) >/dev/null
        if test $status -eq 0
            set mode dark
        end
    else
        switch $mode_setting
            case light
                osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
                set mode light
            case dark
                osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
                set mode dark
        end
    end

    # change fish
    switch $mode
        case dark
            fish_config theme save 'Rosé Pine'
        case light
            fish_config theme save 'Rosé Pine Dawn'
    end

    # change kitty
    switch $mode
        case dark
            kitty +kitten themes --reload-in=all --config-file-name=themes.conf 'Rosé Pine'
        case light
            kitty +kitten themes --reload-in=all --config-file-name=themes.conf 'Rosé Pine Dawn'
    end
end
