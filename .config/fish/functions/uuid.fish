function uuid --description 'Creates a UUID'
    uuidgen | tr '[:upper:]' '[:lower:]'
end
