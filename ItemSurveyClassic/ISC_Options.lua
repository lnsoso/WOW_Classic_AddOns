local MyAddonName, MyAddonTable = ...

local Templates = MyAddonTable.Templates
local Chat = MyAddonTable.Utility.Chat

--[[
Manages the Options-Frame
]]

MyAddonTable.Options = {}
local this	= MyAddonTable.Options

this.Main = {}
this.Notifications = {}
this.Tooltip = {}

function this:Init(AccSV)

	--init options table in SVs
	AccSV.Options = AccSV.Options or {}
	self.Options = AccSV.Options
	this.Notifications:Init()
	this.Tooltip:Init()
	
	self.Main:CreateFrame()
	self.Notifications:CreateFrame(self.Main.Frame)
	self.Tooltip:CreateFrame(self.Main.Frame)
	
	return
end

function this:Show()
	--print("DEBUG: showing options frame!")
	
	self.Main.Frame:Show()
	
	return
end

function this:GetSetting(Label)
	if(self.Options == nil) then
		Chat:Error("Options-table not available!")
	end
	
	if(self.Options[Label] == nil) then
		Chat:Error("Invalid Option-Setting requested!")
	end
	
	return self.Options[Label]
end

function this.Main:CreateFrame()

	--this function may be called again as part of a data reset, in which case the frames are still there
	if(self.Frame ~= nil) then
		return
	end

	self.Frame = Templates.OptionsFrame:new()
	function self.Frame:Refresh()
		this.Notifications.Frame:Refresh()
		this.Tooltip.Frame:Refresh()
		return
	end
	function self.Frame:Okay()
		this.Notifications.Frame:Okay()
		this.Tooltip.Frame:Okay()
		return
	end
	function self.Frame:Default()
		this.Notifications.Frame:Default()
		this.Tooltip.Frame:Default()
		return
	end
	
	self.Frame:Create(MyAddonName)	
	
	self.TitleFS = Templates.Label:new()
	self.TitleFS.FrameTemplate = "GameFontNormalHuge"
	self.TitleFS.LabelPosX = 20
	self.TitleFS.LabelPosY = -20
	self.TitleFS.LabelText = GetAddOnMetadata(MyAddonName, "Title")
	self.TitleFS:Create(self.Frame)
	
	self.TitleFS = Templates.Label:new()
	self.TitleFS.FrameTemplate = "GameFontWhiteSmall"
	self.TitleFS.LabelPosX = 20
	self.TitleFS.LabelPosY = -45
	self.TitleFS.LabelText = GetAddOnMetadata(MyAddonName, "Notes")
	self.TitleFS:Create(self.Frame)
	
	self.TitleFS = Templates.Label:new()
	self.TitleFS.FrameTemplate = "GameFontNormal"
	self.TitleFS.LabelPosX = 40
	self.TitleFS.LabelPosY = -100
	self.TitleFS.LabelText = "Version:"
	self.TitleFS:Create(self.Frame)
	
	self.TitleFS = Templates.Label:new()
	self.TitleFS.FrameTemplate = "GameFontWhite"
	self.TitleFS.LabelPosX = 120
	self.TitleFS.LabelPosY = -100
	self.TitleFS.LabelText = GetAddOnMetadata(MyAddonName, "Version")
	self.TitleFS:Create(self.Frame)
	
	self.TitleFS = Templates.Label:new()
	self.TitleFS.FrameTemplate = "GameFontNormal"
	self.TitleFS.LabelPosX = 40
	self.TitleFS.LabelPosY = -120
	self.TitleFS.LabelText = "Author:"
	self.TitleFS:Create(self.Frame)
	
	self.TitleFS = Templates.Label:new()
	self.TitleFS.FrameTemplate = "GameFontWhite"
	self.TitleFS.LabelPosX = 120
	self.TitleFS.LabelPosY = -120
	self.TitleFS.LabelText = GetAddOnMetadata(MyAddonName, "Author")
	self.TitleFS:Create(self.Frame)
	
	return
end

function this.Notifications:Init()
	local Options = this.Options
	
	--Chat:Debug("setting defaults for Notifications")
	
	if(Options.LastLoginWarning == nil) then
		Options.LastLoginWarning = true
	end
	
	if(Options.LastMailboxWarning == nil) then
		Options.LastMailboxWarning = true
	end
	
	if(Options.LastBankWarning == nil) then
		Options.LastBankWarning = true
	end
		
	if(Options.MailSoonReturnWarning == nil) then
		Options.MailSoonReturnWarning = true
	end
	
	if(Options.MailSoonDeleteWarning == nil) then
		Options.MailSoonDeleteWarning = true
	end
	
	if(Options.MailLostReturnedWarning == nil) then
		Options.MailLostReturnedWarning = true
	end
	
	if(Options.MailLostDeletedWarning == nil) then
		Options.MailLostDeletedWarning = true
	end
	
	if(Options.MailReceivedTransitWarning == nil) then
		Options.MailReceivedTransitWarning = true
	end
	
	if(Options.MailReceivedReturnWarning == nil) then
		Options.MailReceivedReturnWarning = true
	end
	
	return
end

function this.Notifications:Default()
	local Options = this.Options
	
	--Chat:Debug("setting defaults for Notifications")
	
	Options.LastLoginWarning			= true
	Options.LastMailboxWarning			= true
	Options.LastBankWarning				= true
		
	Options.MailSoonReturnWarning		= true
	Options.MailSoonDeleteWarning		= true
	Options.MailLostReturnedWarning		= true
	Options.MailLostDeletedWarning		= true
	Options.MailReceivedTransitWarning	= true
	Options.MailReceivedReturnWarning	= true
	
	return
end

function this.Notifications:CreateFrame(Parent)

	--this function may be called again as part of a data reset, in which case the frames are still there
	if(self.Frame ~= nil) then
		return
	end

	self.Frame = MyAddonTable.OptionsFrame:new()
	function self.Frame:Default()
		this.Notifications:Default()
		--self.Frame.Frame.refresh()
		return
	end	
	self.Frame:Create("Notifications", Parent)
	
	self.Frame:AddOptionsCheckButton(this.Options, "LastLoginWarning", 5, -5, "Login outdated", "Print a message for characters who have not been logged in for more than 31 days.")
	self.Frame:AddOptionsCheckButton(this.Options, "LastMailboxWarning", 5, -40, "Mailbox outdated", "Print a message for characters who have not visited their mailbox in more than 31 days/never.")
	self.Frame:AddOptionsCheckButton(this.Options, "LastBankWarning", 5, -75, "Bank outdated", "Print a message for characters who have not visited their bank in more than 31 days/never.")
	self.Frame:AddOptionsCheckButton(this.Options, "MailSoonReturnWarning", 5, -110, "Mail returned soon", "Print a message for characters who have mail that will be returned upon expiry in less than 4 days.")
	self.Frame:AddOptionsCheckButton(this.Options, "MailSoonDeleteWarning", 5, -145, "Mail deleted soon", "Print a message for characters who have mail that will be deleted upon expiry in less than 4 days.")
	self.Frame:AddOptionsCheckButton(this.Options, "MailLostReturnedWarning", 5, -180, "Mail was returned", "Print a message for characters who lost mail which was returned back to sender since your last login.")
	self.Frame:AddOptionsCheckButton(this.Options, "MailLostDeletedWarning", 5, -215, "Mail was deleted", "Print a message for characters who lost mail which was deleted since your last login.")
	self.Frame:AddOptionsCheckButton(this.Options, "MailReceivedTransitWarning", 5, -250, "Transit-Mail received", "Print a message for characters who received mail which was in the 1-hour-transit-window from one of your Alts.")
	self.Frame:AddOptionsCheckButton(this.Options, "MailReceivedReturnWarning", 5, -285, "Returned mail received", "Print a message for characters who received mail which was returned to them because it expired on one of your Alts.")

	return
end

function this.Tooltip:Init()
	local Options = this.Options
	
	if(Options.TooltipShowItemID == nil) then 
		Options.TooltipShowItemID = true
	end
	
	if(Options.TooltipShowItemLvL == nil) then
		Options.TooltipShowItemLvL = true
	end
	
	if(Options.TooltipShowVendorValue == nil) then
		Options.TooltipShowVendorValue = true
	end
	
	if(Options.TooltipDisableListingForUniqueItems == nil) then
		Options.TooltipDisableListingForUniqueItems = false
	end
	
	if(Options.TooltipNoSeparateContainers == nil) then
		Options.TooltipNoSeparateContainers = false
	end
	
	return
end

function this.Tooltip:Default()
	local Options = this.Options
	
	Options.TooltipShowItemID					= true
	Options.TooltipShowItemLvL					= true
	Options.TooltipShowVendorValue				= true
		
	Options.TooltipDisableListingForUniqueItems	= false
	Options.TooltipNoSeparateContainers			= false
	
	return
end

function this.Tooltip:CreateFrame(Parent)

	--this function may be called again as part of a data reset, in which case the frames are still there
	if(self.Frame ~= nil) then
		return
	end

	self.Frame = MyAddonTable.OptionsFrame:new()
	function self.Frame:Default()
		this.Tooltip:Default()
		--self.Frame.Frame.refresh()
		return
	end
	
	self.Frame:Create("Tooltip", Parent)
	
	self.Frame:AddOptionsCheckButton(this.Options, "TooltipShowItemID", 5, -5, "Include ItemID", nil)
	self.Frame:AddOptionsCheckButton(this.Options, "TooltipShowItemLvL", 5, -40, "Include Item level", nil)
	self.Frame:AddOptionsCheckButton(this.Options, "TooltipShowVendorValue", 5, -75, "Include Item vendor sell value", nil)
	self.Frame:AddOptionsCheckButton(this.Options, "TooltipDisableListingForUniqueItems", 5, -110, "No \"Total: 1\"-Line for unique Items", "Do not add a separate Total-Line under the character-listing if you only possess one copy of an item.")
	self.Frame:AddOptionsCheckButton(this.Options, "TooltipNoSeparateContainers", 5, -145, "No separate containers", "Enable this option to compact the item-count per character to a single number instead of the whole container-listing. If any of these items are in transit for the character this number will be "..Chat:Red("red")..". If none are in transit the number will be "..Chat:Green("green")..".")
	
	return
end
