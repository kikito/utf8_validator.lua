utf_validator.lua
=================

This Lua library can be used to validate UTF strings.

Usage:

    local utf_validator = require 'utf_validator'

    local is_valid             = utf_validator.validate('This is valid')
    local encoding, endianness = utf_validator.getEncoding('some string')

`utf_validator.validate` returns `true` or `false`.

`encoding` can be `'ascii'`, `'utf-8'`, `'utf-16'`, `'utf-32'` or `'unknown'`.

`endianness` can be `'little'`, `'big'` or `nil`.

Installation
============

Just copy the `utf_validator.lua` file wherever you need it and `require` it.

License
=======

This library is MIT-licensed.

Specs
=====

This library uses [busted](http://olivinelabs.com/busted) for its specs. In order to run them, install `busted` and then:

    cd path/where/the/spec/folder/is
    busted




