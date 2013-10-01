utf8_validator.lua
=================

This Lua function can be used to validate UTF-8 strings.

Usage:

    local utf8_validator = require 'utf8_validator'

    local is_valid  = utf_validator.validate('This is valid')

    -- you can also use the shortcut syntax:
    local is_valid2 = utf_validator('This is also valid')


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




