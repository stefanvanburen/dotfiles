complete -c gr -f -a "(git branch -a --format='%(refname:short)' 2>/dev/null | string replace -r '^origin/' '' | sort -u | string match -v 'HEAD')"

complete -c gr -f -a "(gh pr list --json number,title --jq '.[] | (.number | tostring) + \"\t\" + .title' 2>/dev/null)"
