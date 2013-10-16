utf8_validator.lua
=================

This Lua function can be used to validate UTF-8 strings.

Usage:

    local utf8_validator = require 'utf8_validator'

    local is_valid  = utf_validator.validate('This is valid')

    -- you can also use the shortcut syntax:
    local is_valid2 = utf_validator('This is also valid')

If a string is not valid utf8, then `validate` will also return the position of the first byte that makes it non-valid:

    local is_valid, error_position = utf_validator(a_binary_blob)
    if not is_valid then print('non-utf8 sequence detected at position ' .. tostring(error_position))

For valid utf8 strings, `error_position` is always `nil`.


Installation
============

Just copy the `utf8_validator.lua` file wherever you need it and `require` it.

License
=======

This library is MIT-licensed.

Specs
=====

This library uses [busted](http://olivinelabs.com/busted) for its specs. In order to run them, install `busted` and then:

    cd path/where/the/spec/folder/is
    busted




