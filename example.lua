local ClassCreator = require("classCreator")

local Class = ClassCreator.new({
  __init = function(self, value) -- Constructor
    self.value = value
  end,
  copy = function(self)
    return self.base(self.value)
  end
})

local obj = Class(2)
print(obj.value)
local clone = obj.copy()
print(clone.value)
