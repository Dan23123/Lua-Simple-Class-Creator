# Lua-Simple-Class-Creator
Lua Simple Class Creator.

Simple class example:
```lua
local ClassCreator = require("classCreator")

local Class = ClassCreator({
  __init = function(self, number)
    self.number = number
  end
})

local cls1 = Class(10)
print(cls1.number)
local cls2 = Class(20)
print(cls2.number)
print(cls1 == cls2)
```

Modificators:
```lua
local ClassCreator = require("classCreator")

local Class = ClassCreator({
  __init = function(self, number)
    self.number = number
  end
}, {constant = true})
-- Only constant modificator available for now

Class.a = 10 -- Error
```

Static properties:
```lua
local ClassCreator = require("classCreator")

local Class = ClassCreator({
  number = 10
}, {}, {"number"})

print(Class.number) -- 10
local cls = Class()
print(cls.number) -- nil
```
