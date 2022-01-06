# Defined via `source`
function w --wraps='curl wttr.in' --description 'alias w curl wttr.in'
  curl wttr.in $argv; 
end
