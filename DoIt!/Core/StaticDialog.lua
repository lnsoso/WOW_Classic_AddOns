-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

addon.StaticDialog = {
    new = function (name, txt, btn1, btn2, acceptCallback, cancelCallback, to)
        return addon.createInstance(addon.StaticDialog, function (self)
            self.Name = name;
            StaticPopupDialogs[name] = {
                text = txt or "Are you sure?",
                button1 = btn1 or "Yes",
                button2 = btn2 or "No",
                OnAccept = acceptCallback or function() end,
                OnCancel = cancelCallback or function() end,
                timeout = to or 0,
                whileDead = true,
                showAlert = true,
                hideOnEscape = true,
                preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
              }
        end);
    end,
    Show = function (self)
        StaticPopup_Show(self.Name);
    end,
    Hide = function (self)
        StaticPopup_Hide(self.Name);
    end,
    GetText = function (self)
        return StaticPopupDialogs[self.Name].text;
    end,
    SetText = function (self, text)
        StaticPopupDialogs[self.Name].text = text;
    end,
    GetTimeout = function (self)
        return StaticPopupDialogs[self.Name].timeout;
    end,
    SetTimeout = function (self, timeout)
        StaticPopupDialogs[self.Name].timeout = timeout;
    end,
    GetWhileDead = function (self)
        return StaticPopupDialogs[self.Name].whileDead;
    end,
    SetWhileDead = function (self, whileDead)
        StaticPopupDialogs[self.Name].whileDead = whileDead;
    end,
    GetOnAccept = function (self)
        return StaticPopupDialogs[self.Name].OnAccept;
    end,
    SetOnAccept = function (self, onAccept)
        StaticPopupDialogs[self.Name].OnAccept = onAccept;
    end,
    GetOnCancel = function (self)
        return StaticPopupDialogs[self.Name].OnCancel;
    end,
    SetOnCancel = function (self, onCancel)
        StaticPopupDialogs[self.Name].OnCancel = onCancel;
    end,
    GetShowAlert = function (self)
        return StaticPopupDialogs[self.Name].OnCancel;
    end,
    SetShowAlert = function (self, showAlert)
        StaticPopupDialogs[self.Name].showAlert = showAlert;
    end,
    GetHideOnEscape = function (self)
        return StaticPopupDialogs[self.Name].hideOnEscape;
    end,
    SetHideOnEscape = function (self, hideOnEscape)
        StaticPopupDialogs[self.Name].hideOnEscape = hideOnEscape;
    end,
}

-- Export
DoIt.StaticDialog = addon.StaticDialog;