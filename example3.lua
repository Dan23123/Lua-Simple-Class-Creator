local ClassCreator = require("classCreator")

local Class = ClassCreator({
	objcount = 0,
	__init = function(self, value)
		self.value = value
		self.__base.objcount = self.__base.objcount + 1 -- self.__base = Class
	end
}, {}, {"objcount"}) -- objcount is now static property

print(Class.objcount)
for i = 1, 10 do
	Class(0)
end
print(Class.objcount)
local obj = Class(0)
print(obj.objcount) -- object doesn't have this attribute, only class
