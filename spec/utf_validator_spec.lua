local utf = require 'utf_validator'

describe('utf_validator', function()
  it('exists', function()
    assert.is_truthy(utf)
  end)

  describe('utf_validator.getEncoding', function()

    it('detects ascii', function()
      local e,n = utf.getEncoding('Hello word')
      assert.equal(e, 'ascii')
      assert.is_nil(n)
    end)

    it('#focus detects utf8', function()
      local e,n = utf.getEncoding('¢€𤭢')
      assert.equal(e, 'utf-8')
      assert.is_nil(n)
    end)

    it('returns utf8 if ascii is merged with utf8', function()
      local e,n = utf.getEncoding('I will pay in €. Thank you.')
      assert.equal(e, 'utf-8')
      assert.is_nil(n)
    end)
  end)
end)
