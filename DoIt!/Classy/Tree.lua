-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

TreeNode = {
    new = function (value)
        return addon.createInstance(TreeNode, function (self)
            self._value = Observable.new(value)
        end)
    end,

    constructor = function(self, ...)
        self._children = LinkedList.new()
    end,

    get = function (self, child)
        if (child) then
            return self._children.findAll(child)
        end
        return self._children
    end,

    add = function(self, child)
        -- if child is not in a Tree (has Tree._children), then wrap value provided in a Tree first
        if (child._children) then
            self._children:add(child)
        else
            self._children:add(TreeNode.new(child))
        end
    end,

    delete = function(self, child)

    end,
}

Tree = {
    new = function (rootValue)
        return addon.createInstance(Tree, function (self)
            self._root = TreeNode.new(rootValue)
        end)
    end,

    constructor = function(self, ...)
        
    end,
}