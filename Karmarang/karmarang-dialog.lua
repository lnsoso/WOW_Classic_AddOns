-- scope stuff
karmarang = karmarang or {};
local c = karmarang;

c.DIALOG_COMMENT = "KAMERANG_COMMENT";
c.DIALOG_RESET = "KAMERANG_RESET";

function c:PrepareDialogs()
	StaticPopupDialogs[c.DIALOG_COMMENT] = {
		text = "%s" .. c:GetText("\n\n Comment (optional):"),
		button1 = c:GetText("Apply"),
		button2 = c:GetText("Cancel"),
		hasEditBox = true,
		maxLetters = c.COMMENT_MAXLENGTH,
		EditBoxOnEnterPressed = function (self, data, data2)
			local parent = self:GetParent();
			c:AddKarma(parent.data, parent.data2, c:Trim(self:GetText()))
			parent:Hide();
		end,
		EditBoxOnEscapePressed = function (self)
			self:GetParent():Hide();
		end,
		OnAccept = function(self, data, data2)
			c:AddKarma(data, data2, c:Trim(self.editBox:GetText()));
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3
	  };

	StaticPopupDialogs[c.DIALOG_RESET] = {
		text = "%s",
		button1 = c:GetText("Reset"),
		button2 = c:GetText("Cancel"),
		OnEscapePressed = function ()
			this:Hide();
		end,
		OnAccept = function(self, data)
			c:Reset(data);
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3
	  };
end
