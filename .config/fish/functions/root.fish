function root --description 'Change directory to the root of a git repository'
    set git_root (git rev-parse --show-toplevel)

    if test $status -eq 0
        cd $git_root
    end
end
