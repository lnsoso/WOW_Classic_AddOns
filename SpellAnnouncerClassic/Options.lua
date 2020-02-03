local config = LibStub("AceConfig-3.0")
local dialog = LibStub("AceConfigDialog-3.0")

local CHATCHANNELS = { ["BATTLEGROUND"] = "Battleground", ["RAID"] = "Raid", ["PARTY"] = "Party", ["YELL"] = "Yell", ["SAY"] = "Say", ["SYSTEM MESSAGE"] = "System Message" }
local CHATGROUPS = { ["BATTLEGROUNDS"] = "Battlegrounds", ["RAID"] = "Raid", ["PARTY"] = "Party", ["SOLO"] = "Solo" }
local PVPENEMY = { ["TARGET"] = "Target", ["ENEMIES"] = "All nearby enemies" }
local PVPFRIENDLY = { ["SELF"] = "Yourself", ["PARTY"] = "Party", ["ALLIES"] = "All nearby allies"}

function SAC:CreateOptions()
	
	SAC.Options = {
		name = "SpellAnnouncer Classic",
		handler = SAC,
		type = 'group',
		args = {
			version = {
				order = 0,
				type = 'description',
				fontSize = "medium",
				name = "Version" .. " " .. SAC.addonVersion .. ", Created by Pit @ Firemaw - EU",
				width = 'double',
			},
			welcomeEnable = {
				order = 1,
				type = 'toggle',
				name = 'Welcome Message',
				desc = 'Enable or disable the welcome message produced by this Addon when launching or reloading WoW.',
				set = 'Set',
				get = 'Get',
			},
			-- GROUP OPTIONS --
			header = {
				order = 2,
				type = 'header',
				name = "General",
			},
			chatGroup = {
				order = 3,
				name = "Select a group option:",
				desc = "Select a group option in the dropdown menu, and then select how you would like to announce when in specified raid/party/solo option.",
				type = 'select',
				values = CHATGROUPS,
				set = 'SetChatGroup',
				get = 'Get',
			},
			chatChangeAllGroups = {
				order = 4,
				type = 'toggle',
				name = 'Change all Groups',
				desc = 'When enabled changes made will be done to all groups (ONLY AFFECTS THE SETTINGS THAT ARE CHANGED). ',
				set = 'SetChatGroup',
				get = 'Get',
			},
			chatCopySettings = {
				order = 5,
				type = 'execute',
				name = 'Copy Current',
				desc = 'Copy current group options to all other groups (WILL AFFECT ALL SETTINGS).',
				confirmText = "Are you sure you want to overwrite all other group settings with the current one?",
				confirm = true,
				func = 'CopyCurrent',
			},
			chatChannels = {
				order = 6,
				name = "Then select how to announce:",
				type = 'group',
				guiInline = true,
				args = {
					battleground = {
						order = 0,
						type = 'toggle',
						name = "/battleground",
						disabled = 'ChatBGDisableCheck',
						hidden = 'ChatBGDisableCheck',
						set = 'SetChatToggle',
						get = 'GetChatToggle',
					},
					raid = {
						order = 1,
						type = 'toggle',
						name = "/raid",
						disabled = 'ChatRaidDisableCheck',
						hidden = 'ChatRaidDisableCheck',
						set = 'SetChatToggle',
						get = 'GetChatToggle',
					},
					party = {
						order = 2,
						type = 'toggle',
						name = "/party",
						disabled = 'ChatPartyDisableCheck',
						hidden = 'ChatPartyDisableCheck',
						set = 'SetChatToggle',
						get = 'GetChatToggle',
					},
					yell = {
						order = 3,
						type = 'toggle',
						name = "/yell",
						--disabled = true,
						set = 'SetChatToggle',
						get = 'GetChatToggle',
					},
					say = {
						order = 4,
						type = 'toggle',
						name = "/say",
						--disabled = true,
						set = 'SetChatToggle',
						get = 'GetChatToggle',
					},
					system = {
						order = 5,
						type = 'toggle',
						name = "System Message",
						set = 'SetChatToggle',
						get = 'GetChatToggle',
					},
				},
			},
			info = {
				order = 7,
				type = 'description',
				fontSize = "medium",
				name = "INFO: /say and /yell is now available again. Will only work if you are in an instance/battleground.",
			},

			-- AURAS --
			spacer0 = {
				order = 9,
				type = 'description',
				name = " ",
			},
			aurasHeader = {
				order = 10,
				type = 'header',
				name = "Auras",
			},
			auraDescription = {
				order = 11,
				type = 'description',
				name = "Options for spells that adds an aura to your character.",
			},
			auraAllEnable = {
				order = 12,
				type = 'toggle',
				name = 'Announce auras',
				desc = 'Enable or disable all announcements connected to an Aura',
				set = 'SetWithGroup',
				get = 'GetWithGroup',
			},
			auras = {
				order = 13,
				type = 'select',
				name = 'AuraName',
				values = SAC.aurasList,
				style = 'radio',
				set = 'SetAuraList',
				get = 'GetAuraList',
			},
			auraSettings = {
				order = 14,
				name = "",
				type = 'group',
				guiInline = true,
				--hidden = self.db.char.options[self.db.char.options.chatGroup].auraAllEnable,
				args = {
					announceStart = {
						order = 0,
						type = 'toggle',
						name = "Announce start",
						set = 'SetAuraToggle',
						get = 'GetAuraToggle',
					},
					announceEnd = {
						order = 1,
						type = 'toggle',
						name = "Announce end",
						set = 'SetAuraToggle',
						get = 'GetAuraToggle',
					},
					whisperTarget = {
						order = 2,
						type = 'toggle',
						name = "Whisper Target",
						desc = "When the selected buff is used on a player, inform the player with a whisper. You will not whisper yourself, and only works for players in your party/raid!",
						disabled = 'WhisperTargetDisableCheck',
						set = 'SetAuraToggle',
						get = 'GetAuraToggle',
					},
				},
			},

			-- SPELLS --
			spacer1 = {
				order = 29,
				type = 'description',
				name = " ",
			},
			spellHeader = {
				order = 30,
				type = 'header',
				name = "Spells",
			},
			spellDescription = {
				order = 31,
				type = 'description',
				name = "Options for spells that fail when casted on a target. This includes all forms of resists.",
			},
			spellAllEnable = {
				order = 32,
				type = 'toggle',
				name = 'Announce spells',
				desc = 'Enable or disable all announcements connected to a Spell',
				set = 'SetWithGroup',
				get = 'GetWithGroup',
				width = 'full',
			},
			successfulInterrupts = {
				order = 33,
				type = 'toggle',
				name = 'Successful interrupts',
				desc = 'Enable or disable announcement when an enemy spellcast is interrupted successfully.',
				set = 'SetWithGroup',
				get = 'GetWithGroup',
				width = 'full',
			},
			spells = {
				order = 40,
				type = 'select',
				name = 'SpellName',
				values = SAC.spellsList,
				style = 'radio',
				set = 'SetSpellsList',
				get = 'GetSpellsList',
			},
			spellSettings = {
				order = 41,
				name = "",
				type = 'group',
				guiInline = true,
				args = {
					spellAnnounceEnabled = {
						order = 0,
						type = 'toggle',
						name = "Announce Cast",
						set = 'SetSpellToggle',
						get = 'GetSpellToggle',
					},
					resistAnnounceEnabled = {
						order = 1,
						type = 'toggle',
						name = "Announce Resist",
						set = 'SetSpellToggle',
						get = 'GetSpellToggle',
					},
				},
			},

			-- PVP --
			spacer2 = {
				order = 50,
				type = 'description',
				name = " ",
			},
			pvpHeader = {
				order = 51,
				type = 'header',
				name = "PVP",
			},
			pvpDescription = {
				order = 52,
				type = 'description',
				name = "PVP related announcements.",
			},
			pvpAllEnable = {
				order = 53,
				type = 'toggle',
				name = 'Announce Pvp Events',
				desc = 'Enable or disable all announcements connected to a Pvp Event',
				set = 'SetWithGroup',
				get = 'GetWithGroup',
				width = 'full',
			},
			pvpFriendly = {
				order = 54,
				type = 'select',
				name = 'Scope of Friendlies',
				desc = 'Select who you should announce which friendly targets are affected by pvp spells.',
				values = PVPFRIENDLY,
				set = 'SetWithGroup',
				get = 'GetWithGroup',
			},
			pvpEnemy = {
				order = 55,
				type = 'select',
				name = 'Scope of Enemies',
				desc = 'Select who you should announce pvp spells for.',
				values = PVPENEMY,
				set = 'SetWithGroup',
				get = 'GetWithGroup',
			},
			pvp = {
				order = 56,
				type = 'select',
				name = 'PvpName',
				values = SAC.pvpAllList,
				style = 'radio',
				set = 'SetPvpList',
				get = 'GetPvpList',
			},
			pvpSettings = {
				order = 57,
				name = "",
				type = 'group',
				guiInline = true,
				args = {
					Enable = {
						order = 0,
						type = 'toggle',
						name = "Enable",
						set = 'SetPvpToggle',
						get = 'GetPvpToggle',
					},
				},
			},
		},
	}

	self:InitializeDefaultSettings()
	
	config:RegisterOptionsTable("SAC_Options", SAC.Options)
	self.optionsFrame = dialog:AddToBlizOptions("SAC_Options", SAC.Options.name)
	
	self:RegisterChatCommand("sac", "OpenOptions")
	self:RegisterChatCommand("spellannouncer", "OpenOptions")
	
	self.Options.args.auras.name = SAC:AuraName()
	self.Options.args.spells.name = SAC:SpellName()
	self.Options.args.pvp.name = SAC:PvpName()
end

-- Show the options for SpellAnnouncer Classic by using /sac
function SAC:OpenOptions(input)
	if not input or input:trim() == "" then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory("SpellAnnouncer Classic")
	end
end

-- Sets all default settings if not set before, and convert changes from old to new during development.
function SAC:InitializeDefaultSettings()

	if self.db.char.reset == nil or self.db.char.reset == false then
		if self.db.char.options ~= nil then
			self.db.char.options = nil
		end
		self.db.char.reset = true
	end

	if self.db.char.options == nil then
		self.db.char.options = {}
	end

	if self.db.char.options.welcomeEnable == nil then
		self.db.char.options.welcomeEnable = true
	end
	
	if self.db.char.options.chatGroup == nil then
		self.db.char.options.chatGroup = "SOLO"
	end

	-- Set this to default so its a cognitive desicion to actually turn it on.
	self.db.char.options.chatChangeAllGroups = false

	-- TODO: CONVERT self.db.char.options[p].raid and so on to self.db.char.options[p].chatGroups.raid
	for p in pairs(CHATGROUPS) do

		if self.db.char.options[p] == nil then
			self.db.char.options[p] = {}
		end
		if self.db.char.options[p].chatGroups == nil then
			self.db.char.options[p].chatGroups = {}
			if p == "SOLO" then
				self.db.char.options[p].chatGroups.yell = false
				self.db.char.options[p].chatGroups.say = false
				self.db.char.options[p].chatGroups.system = true
			end
			if p == "PARTY" then
				self.db.char.options[p].chatGroups.party = true
				self.db.char.options[p].chatGroups.yell = false
				self.db.char.options[p].chatGroups.say = false
				self.db.char.options[p].chatGroups.system = false
			end
			if p == "RAID" then
				self.db.char.options[p].chatGroups.raid = true
				self.db.char.options[p].chatGroups.party = false
				self.db.char.options[p].chatGroups.yell = false
				self.db.char.options[p].chatGroups.say = false
				self.db.char.options[p].chatGroups.system = false
			end
			if p == "BATTLEGROUNDS" then
				self.db.char.options[p].chatGroups.battleground = true
				self.db.char.options[p].chatGroups.yell = false
				self.db.char.options[p].chatGroups.say = false
				self.db.char.options[p].chatGroups.system = false
			end
		end

		-- Because of changes in Blizzards API Yell and Say is not allowed at the moment. May come back later. Removed in 1.13.3
		--self.db.char.options[p].chatGroups.yell = false
		--self.db.char.options[p].chatGroups.say = false
		
		-- Auras --
		if self.db.char.options[p].auraAllEnable == nil then
			self.db.char.options[p].auraAllEnable = true
		end
	
	
		for k,v in ipairs(self.aurasList) do
			
			local found = false
			for x in pairs(self.db.char.options[p]) do
				if v == x then
					found = true
				end
			end
			-- Set up everything from scratch if no data is found about the given aura.
			if not found then
				self.db.char.options[p][v] = {}
				self.db.char.options[p][v].announceStart = true
				self.db.char.options[p][v].announceEnd = false
				self.db.char.options[p][v].isSelfBuff = SpellIsSelfBuff(self.classAuraIDs[k])
				self.db.char.options[p][v].whisperTarget = false
			end
		end

		-- Spells --	
		if self.db.char.options[p].spellAllEnable == nil then
			self.db.char.options[p].spellAllEnable = true
		end

		if self.db.char.options[p].successfulInterrupts == nil then
			self.db.char.options[p].successfulInterrupts = true
		end

		for k,v in pairs(self.spellsList) do
			
			local found = false
			for x in pairs(self.db.char.options[p]) do
				if v == x then
					found = true
				end
			end
			if not found then
				self.db.char.options[p][v] = {}
				self.db.char.options[p][v].spellAnnounceEnabled = false
				self.db.char.options[p][v].resistAnnounceEnabled = true
			end
			
		end

		-- PVP --
		if self.db.char.options[p].pvpAllEnable == nil then
			self.db.char.options[p].pvpAllEnable = true
		end

		if self.db.char.options[p].pvpFriendly == nil then
			self.db.char.options[p].pvpFriendly = "SELF"
		end

		if self.db.char.options[p].pvpEnemy == nil then
			self.db.char.options[p].pvpEnemy = "TARGET"
		end

		for k,v in pairs(self.pvpAllList) do
			
			local found = false
			for x in pairs(self.db.char.options[p]) do
				if v == x then
					if self.db.char.options[p][v].Enable ~= nil then
						found = true
					end
				end
			end
			if not found then
				if self.db.char.options[p][v] == nil then
					self.db.char.options[p][v] = {}
				end
				self.db.char.options[p][v].Enable = true
			end
		end
	end

	-- Set default selection in menues if none has earlier been selected.
	if self.db.char.options.auras == nil then
		self.db.char.options.auras = 1
	end
	
	if self.db.char.options.spells == nil then
		self.db.char.options.spells = 1
	end

	if self.db.char.options.pvp == nil then
		self.db.char.options.pvp = GetSpellInfo(self.pvpSpellIDs[1])
	end	

end


-- Copy all current group options to the other groups.
function SAC:CopyCurrent()
	selectedGroup = self.db.char.options.chatGroup

	for p in pairs(CHATGROUPS) do
		if p ~= selectedGroup then
			
			self.db.char.options[p].auraAllEnable = self.db.char.options[selectedGroup].auraAllEnable
			
			for k, v in pairs(self.aurasList) do
				for x in pairs(self.db.char.options[p]) do
					if v == x then
						self.db.char.options[p][v].announceStart = self.db.char.options[selectedGroup][v].announceStart
						self.db.char.options[p][v].announceEnd = self.db.char.options[selectedGroup][v].announceEnd
						self.db.char.options[p][v].isSelfBuff = self.db.char.options[selectedGroup][v].isSelfBuff
						self.db.char.options[p][v].whisperTarget = self.db.char.options[selectedGroup][v].whisperTarget 
					end
				end
			end

			self.db.char.options[p].spellAllEnable = self.db.char.options[selectedGroup].spellAllEnable
			self.db.char.options[p].successfulInterrupts = self.db.char.options[selectedGroup].successfulInterrupts

			for k, v in pairs(self.spellsList) do
				for x in pairs(self.db.char.options[p]) do
					if v == x then
						self.db.char.options[p][v].spellAnnounceEnabled = self.db.char.options[selectedGroup][v].spellAnnounceEnabled
						self.db.char.options[p][v].resistAnnounceEnabled = self.db.char.options[selectedGroup][v].resistAnnounceEnabled
					end
				end
			end

			self.db.char.options[p].pvpAllEnable = self.db.char.options[selectedGroup].pvpAllEnable
			self.db.char.options[p].pvpFriendly = self.db.char.options[selectedGroup].pvpFriendly
			self.db.char.options[p].pvpEnemy = self.db.char.options[selectedGroup].pvpEnemy

			for k, v in pairs(self.pvpAllList) do
				for x in pairs(self.db.char.options[p]) do
					if v == x then
						self.db.char.options[p][v].Enable = self.db.char.options[selectedGroup][v].Enable
					end
				end
			end
		end
	end
end

function SAC:AuraName()
	return 'Auras - ' .. CHATGROUPS[self.db.char.options.chatGroup]
end

function SAC:SpellName()
	return 'Spells - ' .. CHATGROUPS[self.db.char.options.chatGroup]
end

function SAC:PvpName()
	return 'PVP - ' .. CHATGROUPS[self.db.char.options.chatGroup]
end

-- Disables menuoptions based on what party option is selected.
function SAC:ChatBGDisableCheck() 
	if (self.db.char.options.chatGroup == "SOLO") or (self.db.char.options.chatGroup == "PARTY") or (self.db.char.options.chatGroup == "RAID") then 
		return true
	else
		return false
	end
end

-- Disables menuoptions based on what party option is selected.
function SAC:ChatRaidDisableCheck() 
	if (self.db.char.options.chatGroup == "SOLO") or (self.db.char.options.chatGroup == "PARTY") or (self.db.char.options.chatGroup == "BATTLEGROUNDS") then 
		return true
	else
		return false
	end
end


-- Disables menuoptions based on what party option is selected.
function SAC:ChatPartyDisableCheck() 
	if (self.db.char.options.chatGroup == "SOLO") then 
		return true
	else
		return false
	end
end


function SAC:WhisperTargetDisableCheck()
	return self.db.char.options[self.db.char.options.chatGroup][self.lastSelectedAura].isSelfBuff
end


function SAC:SetAuraList(info, val)

	self.db.char.options[info[#info]] = val
	self.lastSelectedAura = info["option"]["values"][val]
	self.Options.args.auraSettings.name = self.lastSelectedAura
	
end


function SAC:GetAuraList(info)

	-- Set the correct name for the Aura settings box.
	if self.Options.args.auraSettings.name == "" then
		self.Options.args.auraSettings.name = self.aurasList[self.db.char.options[info[#info]]]
	end
	
	return self.db.char.options[info[#info]]
	
end


function SAC:SetSpellsList(info, val)

	self.db.char.options[info[#info]] = val
	self.lastSelectedSpell = info["option"]["values"][val]
	self.Options.args.spellSettings.name = self.lastSelectedSpell
	
end


function SAC:GetSpellsList(info)
	
	-- Set the correct name for the Resist settings box.
	if self.Options.args.spellSettings.name == "" then
		self.Options.args.spellSettings.name = self.spellsList[self.db.char.options[info[#info]]]
	end
	
	return self.db.char.options[info[#info]]
end


function SAC:SetPvpList(info, val)

	self.db.char.options[info[#info]] = val
	self.lastSelectedPvp = info["option"]["values"][val]
	self.Options.args.pvpSettings.name = self.lastSelectedPvp
	
end


function SAC:GetPvpList(info)
	
	-- Set the correct name for the Resist settings box.
	if self.Options.args.pvpSettings.name == "" then
		self.Options.args.pvpSettings.name = self.pvpAllList[self.db.char.options[info[#info]]]
	end
	
	return self.db.char.options[info[#info]]
end


function SAC:SetAuraToggle(info, val)

	if self.db.char.options.chatChangeAllGroups then
		for p in pairs(CHATGROUPS) do
			self.db.char.options[p][self.lastSelectedAura][info[#info]] = val
		end
	else
		self.db.char.options[self.db.char.options.chatGroup][self.lastSelectedAura][info[#info]] = val
	end
	
end


function SAC:GetAuraToggle(info)

	-- Set the correct last selected aura.
	if self.lastSelectedAura == nil then
		self.lastSelectedAura = self.aurasList[self.db.char.options.auras]
	end
		
	return self.db.char.options[self.db.char.options.chatGroup][self.lastSelectedAura][info[#info]]
	
end


function SAC:SetSpellToggle(info, val)

	if self.db.char.options.chatChangeAllGroups then
		for p in pairs(CHATGROUPS) do
			self.db.char.options[p][self.lastSelectedSpell][info[#info]] = val
		end
	else
		self.db.char.options[self.db.char.options.chatGroup][self.lastSelectedSpell][info[#info]] = val
	end
	
end


function SAC:GetSpellToggle(info)

	-- Set the correct last selected spell.
	if self.lastSelectedSpell == nil then
		self.lastSelectedSpell = self.spellsList[self.db.char.options.spells]
	end
	
	return self.db.char.options[self.db.char.options.chatGroup][self.lastSelectedSpell][info[#info]]
	
end


function SAC:SetPvpToggle(info, val)

	if self.db.char.options.chatChangeAllGroups then
		for p in pairs(CHATGROUPS) do
			self.db.char.options[p][self.lastSelectedPvp][info[#info]] = val
		end
	else
		self.db.char.options[self.db.char.options.chatGroup][self.lastSelectedPvp][info[#info]] = val
	end

end


function SAC:GetPvpToggle(info)

	-- Set the correct last selected spell.
	if self.lastSelectedPvp == nil then
		self.lastSelectedPvp = self.pvpAllList[self.db.char.options.pvp]
	end

	return self.db.char.options[self.db.char.options.chatGroup][self.lastSelectedPvp][info[#info]]
	
end


function SAC:SetChatToggle(info, val)

	if self.db.char.options.chatChangeAllGroups then
		for p in pairs(CHATGROUPS) do
			self.db.char.options[p].chatGroups[info[#info]] = val
		end
	else
		self.db.char.options[self.db.char.options.chatGroup].chatGroups[info[#info]] = val
	end
	
end


function SAC:GetChatToggle(info)

	return self.db.char.options[self.db.char.options.chatGroup].chatGroups[info[#info]]
	
end

function SAC:SetChatGroup(info, val)
	
	self.db.char.options[info[#info]] = val

	local name = ""
	if self.db.char.options.chatChangeAllGroups then
		name = "All"
	else
		name = CHATGROUPS[self.db.char.options.chatGroup]
	end

	self.Options.args.auras.name = "Auras - " .. name
	self.Options.args.spells.name = "Spells - " .. name
	self.Options.args.pvp.name = "PVP - " .. name


end


function SAC:SetWithGroup(info, val)

	if self.db.char.options.chatChangeAllGroups then
		for p in (CHATGROUPS) do
			self.db.char.options[p][info[#info]] = val
		end
	else
		self.db.char.options[self.db.char.options.chatGroup][info[#info]] = val
	end
	
end


function SAC:GetWithGroup(info)
		
	return self.db.char.options[self.db.char.options.chatGroup][info[#info]]
	
end

function SAC:Set(info, val)

	self.db.char.options[info[#info]] = val
	
end


function SAC:Get(info)
		
	return self.db.char.options[info[#info]]
	
end
