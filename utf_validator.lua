local utf_validator = {
  __VERSION     = '0.0.1',
  __DESCRIPTION = 'Library for easily validating UTF strings in pure Lua',
  __URL         = 'https://github.com/kikito/utf_valiator.lua',
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

local ENCODINGS = {
  { name = 'ascii',
    size = 1,
    ranges = {
      { {1, 127} }
    }
  },
  { name = 'utf-8',
    size = 2,
    ranges = {
      { {194, 223}, {123, 191} },
    }
  },
  { name = 'utf-8',
    size = 3,
    ranges = {
      { {224, 224}, {160, 191}, {128, 191} },
      { {225, 236}, {128, 191}, {128, 191} },
      { {237, 237}, {128, 159}, {128, 191} },
      { {238, 239}, {128, 191}, {128, 191} }
    }
  },
  { name = 'utf-8',
    size = 4,
    ranges = {
      { {240, 240}, {144, 191}, {128, 191}, {128, 191} },
      { {241, 243}, {128, 191}, {128, 191}, {128, 191} },
      { {244, 244}, {128, 143}, {128, 191}, {128, 191} }
    }
  }


}

local function matchRanges(ranges, bytes, from, to)
  local matching = {}
  for i=from, to do
    matching[#matching + 1] = bytes[i]
  end

  for i=from, to do
    local byte, range = bytes[i], ranges[i-from+1]
    if not (range[1] <= byte and byte <= range[2]) then
      return false
    end
  end
  return true
end

local function getCharEncoding(bytes, from, bytes_size)
  for _,encoding in ipairs(ENCODINGS) do
    local to = from + encoding.size - 1
    if to <= bytes_size then
      for _,row in ipairs(encoding.ranges) do
        if matchRanges(row, bytes, from, to) then
          return encoding.name, encoding.size
        end
      end
    end
  end
  return 'unknown', 1
end

function utf_validator.getEncoding(str)
  local bytes_size = #str
  local bytes = {str:byte(1, bytes_size)}
  local encoding
  local from = 1
  repeat
    local new_encoding, size = getCharEncoding(bytes, from, bytes_size)
    encoding = encoding or new_encoding
    if new_encoding == 'ascii' and encoding == 'utf-8' or
       new_encoding == 'utf-8' and encoding == 'ascii' then
       encoding = 'utf-8'
    elseif new_encoding == 'unknown' or encoding ~= new_encoding then
      return 'unknown'
    end

    from = from + size
  until from > bytes_size

  return encoding
end

return utf_validator
