local ClassCreator = require("classCreator")

local Class = ClassCreator({
	__init = function(self, value)
		self.value = value
	end,
	add = function(self, v)
		self.value = self.value + v
	end
})

local obj = Class(10)
print(obj.value)
obj.add(50)
print(obj.value)
