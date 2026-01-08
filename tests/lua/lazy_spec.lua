-- Basic test for the lazy module
local lazy = require("nobbz.lazy")

describe("nobbz.lazy", function()
  it("should have a finish function", function()
    assert.is_function(lazy.finish)
  end)

  it("should have a packadd function", function()
    assert.is_function(lazy.packadd)
  end)

  it("should have a load_once function", function()
    assert.is_function(lazy.load_once)
  end)

  it("should have an add_specs function", function()
    assert.is_function(lazy.add_specs)
  end)
end)
