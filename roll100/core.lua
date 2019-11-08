
local old = DEFAULT_CHAT_FRAME.AddMessage

DEFAULT_CHAT_FRAME.AddMessage = function(self, msg, ...) 

    local name = UnitName('player')
    for i = 1, 100 do
        if RANDOM_ROLL_RESULT:format(name, i, 1, 100) == msg then
            msg = RANDOM_ROLL_RESULT:format(name, 100, 1, 100)
            break
        end

    end

    old(self, msg, ...)
end