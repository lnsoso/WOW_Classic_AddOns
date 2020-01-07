-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

-- add assertions instead of using print

function TestThreat()
    -- CheckInteractDistance();
end

function TestLinkedList()
    local ll = LinkedList.new(function (self)
        self:add("This");
        self:add("is");
        self:add("a");
        self:add("test.");
    end);
    print("LinkedList-Init: "..ll:first().." "..ll:next().." "..ll:next().." "..ll:next().." "..ll:next())
    print("LinkedList-Init: "..ll:last().." "..ll:previous().." "..ll:previous().." "..ll:previous().." "..ll:previous())

    ll:first(); ll:next();
    local node = ll:currentNode();
    print("LinkedList-SelectedNode: "..ll:current());
    ll:remove(node);
    print("LinkedList-Init: "..ll:first().." "..ll:next().." "..ll:next().." "..ll:next().." "..ll:next())
end

function TestStack()
    local s = Stack.new(function (self)
        self:push("7");
        self:push("8");
        self:push("9");
    end);
    print("Stack: "..s:pop()..s:pop()..s:pop());
end

function TestQueue()
    local q = Queue.new(function (self)
        self:add("7");
        self:add("8");
        self:add("9");
    end);
    print("Queue: "..q:next()..q:next()..q:next());
end

function TestUndoStack()
    local undo = UndoStack.new();
    undo:add(function ()
        addon.Debug("ABCD!")
    end)
    undo:clear();
    undo:undo();
end

function TestObservable()
    local ob = Observable.new("Hello"); -- Create an Observable and set its initial value to argument 1
    local func1 = function (value) print("Function #1 - "..tostring(value)) end;
    local func2 = function (value) print("Function #2 - "..tostring(value)) end;
    local func3 = function (value) print("Function #3 - "..tostring(value)) end;
    ob:subscribe(func1);
    ob:subscribe(func2);
    ob:subscribe(func3);
    ob:unsubscribe(func2);
    ob:set("Bye");
end