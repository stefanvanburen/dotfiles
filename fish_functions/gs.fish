# Defined in - @ line 1
function gs --wraps='git status' --wraps='git st' --description 'alias gs git st'
  git st $argv;
end
