function gt --wraps "go test" --description 'Run go test with optional tparse formatting'
    # https://github.com/mfridman/tparse
    if command -q tparse
        go test -json $argv | tparse
    else
        go test $argv
    end
end
