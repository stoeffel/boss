function fish_prompt
    set -l status_copy $status
    set -l color

    if test "$status_copy" -ne 0
        set color (set_color $fish_color_error)
    end

    if test 0 -eq (id -u "$USER")
        echo -sn "$color#: "
    end

    if test "$PWD" = ~
        echo -sn "$color~"
    else
        echo -sn "$color"(basename "$PWD")
    end

    if set branch_name (git_branch_name)
        set -l git_glyph

        if git_is_staged
            if git_is_dirty
                set git_glyph "*"
            else
                set git_glyph "+"
            end
        else if git_is_dirty
            set git_glyph "*"

        else if git_is_touched
            set git_glyph "*"
        end

        set -l git_ahead (git_ahead "↑" "↓" "↑↓")

        if test "$branch_name" = "master"
            set branch_name
        else
            set branch_name " $branch_name"
        end

        echo -sn "$git_glyph$branch_name$git_ahead"
    end

    echo -sn "$color_normal "
end
