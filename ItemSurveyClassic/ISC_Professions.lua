local MyAddonName, MyAddonTable = ...

local Chat	= MyAddonTable.Utility.Chat
local Table	= MyAddonTable.Utility.Table
local Spell	= MyAddonTable.Utility.Spell

--[[
All Profession-Related Skills and Recipes use internal SpellIDs; every profession level has one, every recipe has one. While i have not yet found a way to actually
get those SpellIDs from the API, one can easily look them up on WoWHead. If you know the SpellIDs, you can get all Profession-Info you need very easily from
IsPlayerSpell(). IsSpellKnown() works for the Profession-Spells, but it does NOT work for the Recipe-SpellIDs. IsPlayerSpell() works for both.

Events that we need to track:
1) Learning a new Skill/Profession
	tested: fires SKILL_LINES_CHANGED 3times; works for enchanting, too	
2) Unlearning a Skill/Profession
	tested: fires SKILL_LINES_CHANGED 2times; works for enchanting, too
3) Increasing the Rank of an already learned Profession (Expert, Artisan etc.)
	tested: fires SKILL_LINES_CHANGED once
			Also applies to skill-increases by books - those do NOT fire NEW_RECIPE_LEARNED!
4) Increasing a Skill
	tested: fires SKILL_LINES_CHANGED 2times; 
5) Learning a new Recipe
	tested: fires NEW_RECIPE_LEARNED once with the correct SpellID that we need to check the learned state
6) Learning a Specialisation
	untested; assume same behaviour as (3)
	
Behaviour:
1)	On Login / Reload
		1. All Data is reset and all learnable Recipes are checked.
		2. Add ProfessionID to ALL Recipe tables
		3. Create RecipeItemID lookup table containing ALL recipes
		4. Create SpellIDToRecipeID lookup table for ALL recipes
		
		5. Get current Profeesion+Skill+Spec Data
		6. Create PlayerSpellearned-Tables for each profession, containing ALL recipes of the profession
			- init Recipes below the current skill and allowed by current spec to 0
			- init Recipes above the current skill or not allowed by current spec with false
			- Start Callback loop for all "0" entries and have them checked with the PlayerSpellID
		UPDATE: We simply link in the RecipeList tables and add the IsLearned field.
		
2)	On Event: SKILL_LINES_CHANGED
		1. Get Current Profession+Skill+Spec Data but do not overwrite stored data, yet
			If the data matches completely: return; the event was caused by something else
			For each current profession, check if PlayerSpellLearned exists and remove tables for professions that might have been unlearned
				New tables need not undergo the callback-loop as the profession skill should be (1) and no recipe item requires skill 1 (confirmation needed)				
	On Event: NEW_RECIPE_LEARNED
		use global SpellIDToRecipeID table to find out if this was a profession recipe item. If it was, check the profession ID and use it to set our PlayerSpellLearned field to true
		
	On Event: Logout
		Use PlayerSpellearned-Tables to create one single RecipeLearned table containing all the recipes <= current skill and allowed by current specialisation
		that the character has NOT LEARNED (=false)
		
3) When checking recipes on other characters....

		1. If the character does not have the profession at all, do nothing
		2. If the character does have the profession but an incompatible spec, display red text: Spec-Name
		3. If the character does have the profession but either his skill is too low or is missing the required spec (but it is compatible!), display orange text: skill number and/or spec-name
		4. none of the above: The character could have actually already learned it. Check the stored MissingRecipes table.
			If contained, diplay yellow text: skill
			If not contained, display green text: "spell_known"
	
]]

MyAddonTable.Professions = {}
local this = MyAddonTable.Professions
this.Events = {}

this.Data =
{
	[129] = --First Aid
	{
		[1] = 3273,
		[2] = 3274,
		[3] = 7924,
		[4] = 10846,
		["SpecialisationSpellIDs"] = {}
	},
	[185] = --Cooking
	{
		[1] = 2550,
		[2] = 3102,
		[3] = 3413,
		[4] = 18260,
		["SpecialisationSpellIDs"] = {}
	},
	[356] = --Fishing
	{
		[1] = 7620,
		[2] = 7731,
		[3] = 7732,
		[4] = 18248,
		["SpecialisationSpellIDs"] = {}
	},
	[182] = --Herbalism
	{
		[1] = 2366,
		[2] = 2368,
		[3] = 3570,
		[4] = 11993,
		["SpecialisationSpellIDs"] = {}
	},
	[186] = --Mining
	{
		[1] = 2575,
		[2] = 2576,
		[3] = 3564,
		[4] = 10248,
		["SpecialisationSpellIDs"] = {}
	},
	[393] = --Skinning
	{
		[1] = 8613,
		[2] = 8617,
		[3] = 8618,
		[4] = 10768,
		["SpecialisationSpellIDs"] = {}
	},
	[164] = --Blacksmithing
	{
		[1] = 2018,
		[2] = 3100,
		[3] = 3538,
		[4] = 9785,
		["SpecialisationSpellIDs"] =
		{
			[1] = 17039,	--Weapon: Sword
			[2] = 17040, 	--Weapon: Hammer
			[3] = 17041,	--Weapon: Axe
			[4] = 9787,		--Weapon
			[5] = 9788		--Armor
		}
	},
	[165] = --Leatherworking
	{
		[1] = 2108,
		[2] = 3104,
		[3] = 3811,
		[4] = 10662,
		["SpecialisationSpellIDs"] =
		{
			[1] = 10656,	--Dragonscale
			[2] = 10658,	--Elemental
			[3] = 10660		--Tribal
		}
	},
	[197] = --Tailoring
	{
		[1] = 3908,
		[2] = 3909,
		[3] = 3910,
		[4] = 12180,
		["SpecialisationSpellIDs"] = {}
	},
	[333] = --Enchanting
	{
		[1] = 7411,
		[2] = 7412,
		[3] = 7413,
		[4] = 13920,
		["SpecialisationSpellIDs"] = {}
	},
	[171] = --Alchemy
	{
		[1] = 2259,
		[2] = 3101,
		[3] = 3464,
		[4] = 11611,
		["SpecialisationSpellIDs"] = {}
	},
	[202] = --Engineering
	{
		[1] = 4036,
		[2] = 4037,
		[3] = 4038,
		[4] = 12656,
		["SpecialisationSpellIDs"] =
		{
			[1] = 20220,	--Gnomish
			[2] = 20221		--Goblin
		}
	}
}

--DEBUG function
function this:PrintSummary(Professions)
	
	for ProfID, ProfData in pairs(Professions) do
		print("["..ProfID.."]"..ProfData.Name..": "..ProfData.SkillLevel)
	end
	
	return
end

function this:IsRecipeItemID(ItemID)
	return (self.LookUp.RecipeDataByRecipeItemID[ItemID] ~= nil)
end

function this:GetRecipeDataByRecipeItemID(RecipeItemID)
	return self.LookUp.RecipeDataByRecipeItemID[RecipeItemID]
end

function this:GetCraftedItemID(RecipeItemID)
	if(self.LookUp.RecipeDataByRecipeItemID[RecipeItemID] ~= nil) then
		return self.LookUp.RecipeDataByRecipeItemID[RecipeItemID].CraftedItemID
	end
		
	Chat:Error("ItemID did not specify Recipe.")
	return
end

function this:DoesSpecialisationMatch(ExistingSpecialisationSpellID, RequiredSpecialisationSpellID)
	
	if(RequiredSpecialisationSpellID == nil) then
		return true
	end
	
	if(ExistingSpecialisationSpellID == nil) then
		return false
	end
	
	if(RequiredSpecialisationSpellID == LearnedProfessions) then
		return true
	end
	
	if(RequiredSpecialisationSpellID == 9787) then --general weapon spec
		if((ExistingSpecialisationSpellID == 17039) or (ExistingSpecialisationSpellID == 17040) or (ExistingSpecialisationSpellID == 17041)) then	--specific weapon specs
			return true
		end
	end
	
	return false
end

function this:IsSpecialisationStillLearnable(ExistingSpecialisationSpellID, RequiredSpecialisationSpellID)

	if(RequiredSpecialisationSpellID == nil) then
		return true
	end

	if(ExistingSpecialisationSpellID == nil) then
		return true
	end
	
	if(ExistingSpecialisationSpellID == 9787) then --general weapon spec
		if((RequiredSpecialisationSpellID == 17039) or (RequiredSpecialisationSpellID == 17040) or (RequiredSpecialisationSpellID == 17041)) then --specific weapon specs
			return true
		end
	end
	
	return false
end

function this:IsRecipeLearnable(ExistingProfessionID, ExistingSkillLevel, ExistingSpecialisationSpellID, RecipeData)
	
	if(ExistingProfessionID ~= RecipeData.ProfessionID) then
		return false
	end
	
	if(ExistingSkillLevel < RecipeData.SkillLevel) then
		return false
	end
	
	if(self:DoesSpecialisationMatch(ExistingSpecialisationSpellID, RecipeData.RequiredSpecialisationSpellID)== false) then
		--our specialisation does not match
		return false
	end
	
	--everything seems to be fine!
	return true
end

function this:PlayerSpellReadyCallback(MySpell)
	local IsLearned = (IsPlayerSpell(MySpell:GetSpellID()) == true)
	self.LookUp.RecipeDataByPlayerSpellID[MySpell:GetSpellID()].IsLearned = IsLearned
	print(Chat:AddonMessage("testing learned state for: "..MySpell:GetSpellName()..": "..tostring(IsLearned)))	
	return
end

function this:CheckProfessionRecipesLearnedState(ProfessionID, SkillLevel, SpecialisationSpellID)

	for _, RecipeData in pairs(MyAddonTable.RecipeList.Data[ProfessionID]) do
		if(self:IsRecipeLearnable(ProfessionID, SkillLevel, SpecialisationSpellID, RecipeData) == false) then
			RecipeData.IsLearned = false
		else
			MyAddonTable.Utility.Spell.GetSpellInfoByID(RecipeData.PlayerSpellID, function(MySpell)
				self:PlayerSpellReadyCallback(MySpell)
				return
			end)
		end
	end
	
	return
end

function this:CheckAllRecipesLearnedState(Professions)

	for ProfessionID, ProfessionData in pairs(Professions) do
		self:CheckProfessionRecipesLearnedState(ProfessionID, ProfessionData.SkillLevel, ProfessionData.SpecialisationSpellID)
	end
	
	return
end

function this:GetCurrentProfessions()

	local CurrentProfessions = {}
	local SkillLineNamesToSkillLevel = {}

	--build a lookup-table of our learned skill-lines
	for i = 1, GetNumSkillLines() do
		local SkillName, IsHeader, _, SkillRank = GetSkillLineInfo(i)
		if(not IsHeader) then
			SkillLineNamesToSkillLevel[SkillName] = SkillRank
			--print("storing: \""..SkillName.."\"")
		end
	end
	
	--find the names of our professions using SpellIDs
	for ProfessionID, Spells in pairs(this.Data) do
		for i = 1, 4 do
			if(IsPlayerSpell(Spells[i]) == true) then
				local Name = GetSpellInfo(Spells[i])
				local SkillLevel = 1
				if(SkillLineNamesToSkillLevel[Name] == nil) then
					--IMPORTANT: the very first SKILL_LINES_CHANGED event when learning a new profession is fired before the skillline has been added but the SpellID is already learned.
					--This means that at this point in time we will not be able to find a matching skill-line. the only thing we can do to check for this case is that it has be the
					--SpellID[1] that was found and that this profession is not present in self.LearnedProfessions
					
					if((i ~= 1) or ((self.LearnedProfessions ~= nil) and (self.LearnedProfessions[ProfessionID] ~= nil))) then
						Chat:Error("unable to match profession to skill-line.")
						return
					end
				else
					SkillLevel = SkillLineNamesToSkillLevel[Name]
				end
					
				CurrentProfessions[ProfessionID] =
				{
					SpellID 		= Spells[i],
					Name			= Name,
					SkillLevel		= SkillLevel
				}
				
				--test for specialisations; note the use of ipairs - we test the specific weapon specs first for blacksmithing before we test general weapon spec, this way we will only store the "deepest spec"
				for _, SpecialisationSpellID in ipairs(Spells.SpecialisationSpellIDs) do
					if(IsPlayerSpell(SpecialisationSpellID) == true) then
						CurrentProfessions[ProfessionID].SpecialisationSpellID = SpecialisationSpellID
						break --we stop after finding one spec!
					end
				end
				
				break
			end
		end
	end
	
	return CurrentProfessions
end



function this:Update()
	--find out which professions our current character has learned and at which level they are
	local CurrentProfessions = self:GetCurrentProfessions()
	
	--the only changes we are interested in are the learning of a new profession and the unlearning of an old profession. Anything else is handled by Init() and NewRecipeLearned()
	--simple skillups do not bother us at all; not even learning a specialisation or upgrading a skill. We will store this information, but it does not have any meaningful impact here.
	
	for ProfessionID, ProfessionData in pairs(CurrentProfessions) do
		if(self.LearnedProfessions[ProfessionID] == nil) then
			--this is a new profession
			print("Picked up a new Profession: "..ProfessionData.Name)
			self.LearnedProfessions[ProfessionID] = ProfessionData
			self:CheckProfessionRecipesLearnedState(ProfessionID, ProfessionData.SkillLevel, ProfessionData.SpecialisationSpellID)
		else
			--just make the stored data current for the sake of it - we di not really use it after init
			self.LearnedProfessions[ProfessionID] = ProfessionData
			--we do not have to update Recipes, because even if the skill in a profession increased and made new 
		end
	end
	
	for ProfessionID, ProfessionData in pairs(self.LearnedProfessions) do
		if(CurrentProfessions[ProfessionID] == nil) then
			--this profession has been unlearned!
			print("Unlearned a Profession: "..ProfessionData.Name)
			self.LearnedProfessions[ProfessionID] = nil
		end
	end
	
	return
end

function this:Init()

	self.LearnedProfessions = self:GetCurrentProfessions()
	
	self.LookUp = {}
	self.LookUp.RecipeDataByRecipeItemID = {}
	self.LookUp.RecipeDataByPlayerSpellID = {}
		
	for ProfessionID, Recipes in pairs(MyAddonTable.RecipeList.Data) do
		for _, RecipeData in pairs(Recipes) do
			--add Profession ID to RecipeData
			RecipeData.ProfessionID = ProfessionID
			
			--add to complete recipe Lookup table + check for collisions
			if(self.LookUp.RecipeDataByRecipeItemID[RecipeData.RecipeItemID] ~= nil) then
				Chat:Error("RecipeItemID-Collision while creating Lookup-Table: "..RecipeData.RecipeItemID)
				return
			end
			self.LookUp.RecipeDataByRecipeItemID[RecipeData.RecipeItemID] = RecipeData
			
			--add to SpellID > ItemID Lookup table + check for collisions
			if(self.LookUp.RecipeDataByPlayerSpellID[RecipeData.PlayerSpellID] ~= nil) then
				Chat:Error("PlayerSpellID-Collision while creating Lookup-Table: "..RecipeData.PlayerSpellID)
				return
			end
			self.LookUp.RecipeDataByPlayerSpellID[RecipeData.PlayerSpellID] = RecipeData
		end
	end
	
	self:CheckAllRecipesLearnedState(self.LearnedProfessions)
	
	return
end

function this.Events:SkillLinesChanged()
	print("---SkillLinesUpdate---")
	this:Update()
	this:PrintSummary(this.LearnedProfessions)
	return
end

function this.Events:NewRecipeLearned(SpellID)
	print("NewRecipeLearned: "..SpellID)
	if(this.LookUp.RecipeDataByPlayerSpellID[SpellID] ~= nil) then --the LearnedSpellID can also be a non-item and therefore not in our table
		this.LookUp.RecipeDataByPlayerSpellID[SpellID].IsLearned = true
	end
	
	return
end
