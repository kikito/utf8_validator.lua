local utf8 = require 'utf8_validator'

describe('utf8_validator', function()
  it('exists', function()
    assert.is_truthy(utf8)
  end)

  local binary_str = assert(io.open('spec/banana.gif', "rb")):read("*all")

  local scenarios = {
    { desc = 'plain ascii', str = 'Hello word',        valid = true },
    { desc = 'utf8 stuff',  str = '¢€𤭢',              valid = true },
    { desc = 'mixed stuff', str = 'Pay in €. Thanks.', valid = true },
    { desc = 'binary',      str = binary_str,          valid = false }
  }

  describe('utf8_validator.validate', function()
    for _,scenario in ipairs(scenarios) do
      it(scenario.desc, function()
        local is_valid = utf8.validate(scenario.str)
        assert.equal(scenario.valid, is_valid)
      end)
    end
  end)

  describe('utf8_validator.validate shortcut version', function()
    for _,scenario in ipairs(scenarios) do
      it(scenario.desc, function()
        local is_valid = utf8(scenario.str)
        assert.equal(scenario.valid, is_valid)
      end)
    end
  end)


end)
