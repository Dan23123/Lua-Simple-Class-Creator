local ClassCreator = require("ClassCreator")

local Class = ClassCreator({
	__init = function(self, value)
		self.value = value
	end
}, {constant = true})

local obj = Class(100)
print(obj.value)
Class.newvar = 100 -- ERROR: You can't modify this class (constant modificator)
