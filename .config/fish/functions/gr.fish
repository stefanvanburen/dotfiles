function gr --description "Open diffs.nvim Greview for a branch or PR number"
    if test (count $argv) -eq 0
        echo "usage: gr <branch|pr-number>"
        return 1
    end

    set target $argv[1]
    set base (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse HEAD)

    if string match -qr '^\d+$' $target
        set target (gh pr view $target --json headRefName --jq .headRefName 2>/dev/null)
        if test -z "$target"
            echo "gr: could not resolve PR #$argv[1] to a branch"
            return 1
        end
    end

    # Create a worktree for the target branch so we diff from its perspective
    # (Greview diffs base→HEAD, so checking out the target and reviewing against
    # our base branch gives the correct direction)
    set worktree (mktemp -d)
    if not git worktree add --detach $worktree $target 2>/dev/null
        # Branch may only exist remotely; try fetching first
        git fetch origin $target 2>/dev/null
        if not git worktree add --detach $worktree origin/$target 2>/dev/null
            echo "gr: could not create worktree for $target"
            command rm -rf $worktree
            return 1
        end
    end

    pushd $worktree
    set merge_base (git merge-base HEAD $base 2>/dev/null)
    if test -z "$merge_base"
        echo "gr: could not find merge base between $base and $target"
        popd
        git worktree remove --force $worktree
        return 1
    end
    $EDITOR -c "Greview $merge_base" -c only
    popd

    git worktree remove --force $worktree
end
