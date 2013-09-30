local utf = require 'utf_validator'

describe('utf_validator', function()
  it('exists', function()
    assert.is_truthy(utf)
  end)

  describe('utf_validator.getEncoding', function()
    it('returns ascii, nil for ascii', function()
      local e,n = utf.getEncoding('Hello word')
      assert.equal(e, 'ascii')
      assert.is_nil(n)
    end)
  end)
end)
