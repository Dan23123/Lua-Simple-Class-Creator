local tablefind = table.find or function(t, i)
	for j, v in pairs(t) do
		if j == i then
			return v	
		end
	end
end

local ClassCreator = {}

function new(pattern, modificators, staticproperties)
	modificators = modificators or {}
	staticproperties = staticproperties or {}
	
	local class = {}
	local classmeta = {}
	local constructor = pattern.__init or function() end
	for idx, value in pairs(pattern) do
		class[idx] = value
	end
	
	if modificators.constant then
		classmeta.__newindex = function()
			error("ERROR: You can't modify this class (constant modificator)")
		end
	end
	
	classmeta.__call = function(self, ...)
		local obj = {__base = class}
		for idx, value in pairs(pattern) do
			if (idx ~= "__init" and not tablefind(staticproperties, idx)) then
				if (type(value) == "function") then
					obj[idx] = function(...)
						return value(obj, ...)
					end
				else
					obj[idx] = value
				end
			end
		end

		constructor(obj, ...)

		return obj
	end

	setmetatable(class, classmeta)
	return class
end

setmetatable(ClassCreator, {
	__call = function(self, ...)
		return new(...)
	end
})

return ClassCreator
