local utf8_validator = {
  __VERSION     = '0.0.1',
  __DESCRIPTION = 'Library for easily validating UTF-8 strings in pure Lua',
  __URL         = 'https://github.com/kikito/utf8_validator.lua',
  __LICENSE     = [[
    MIT LICENSE

    Copyright (c) 2013 Enrique García Cota

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}

-- Taken from table 3-7 in www.unicode.org/versions/Unicode6.2.0/UnicodeStandard-6.2.pdf
local VALID_RANGES = {
  { {1, 127},                                       size=1 },
  { {194, 223}, {123, 191},                         size=2 },
  { {224, 224}, {160, 191}, {128, 191},             size=3 },
  { {225, 236}, {128, 191}, {128, 191},             size=3 },
  { {237, 237}, {128, 159}, {128, 191},             size=3 },
  { {238, 239}, {128, 191}, {128, 191},             size=3 },
  { {240, 240}, {144, 191}, {128, 191}, {128, 191}, size=4 },
  { {241, 243}, {128, 191}, {128, 191}, {128, 191}, size=4 },
  { {244, 244}, {128, 143}, {128, 191}, {128, 191}, size=4 }
}

local function matchesRow(row, str, from, to)
  for i=from, to do
    local byte = str:byte(i,i)
    local range = row[i-from+1]
    if range[2] < byte or byte < range[1] then
      return false
    end
  end
  return true
end

local function validateChar(str, from, bytes_size)
  for _,row in ipairs(VALID_RANGES) do
    local to = from + row.size - 1
    if to <= bytes_size then
      if matchesRow(row, str, from, to) then
        return true, row.size
      end
    end
  end
  return false, 1
end

function utf8_validator.validate(str)
  local bytes_size = #str
  local from = 1

  repeat
    local is_valid, size = validateChar(str, from, bytes_size)
    if not is_valid then return false, from end
    from = from + size
  until from > bytes_size

  return true
end

setmetatable(utf8_validator, {__call = function(_, ...) return utf8_validator.validate(...) end})

return utf8_validator
