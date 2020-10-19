function diff
    # If not exactly two arguments, write out usage
    if test (count $argv) -ne 2
        echo "Usage: diff file1 file2" >&2
        return 1
    end

    git diff --no-index $argv[1] $argv[2]
end
