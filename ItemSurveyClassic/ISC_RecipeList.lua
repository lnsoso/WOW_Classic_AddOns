local MyAddonName, MyAddonTable = ...

MyAddonTable.RecipeList = {}
local this = MyAddonTable.RecipeList

--[[
This list contains all Recipe-Items in the game and provides additional information like the required skill-level and the ID of the crafted Item if applicable.
]]

this.Data =
{
	[129] = --First Aid
	{
		[0001] = { SkillLevel = 130,	RecipeItemID = 6454,	CraftedItemID = 6453,	PlayerSpellID = 7935	},		--Manual: Strong Anti-Venom
		[0002] = { SkillLevel = 180,	RecipeItemID = 16112,	CraftedItemID = 6451,	PlayerSpellID = 7929	},		--Manual: Heavy Silk Bandage
		[0003] = { SkillLevel = 210,	RecipeItemID = 16113,	CraftedItemID = 8544,	PlayerSpellID = 10840	},		--Manual: Mageweave Bandage
		[0004] = { SkillLevel = 300,	RecipeItemID = 19442,	CraftedItemID = 19440,	PlayerSpellID = 23787	}		--Formula: Powerful Anti-Venom
	},
	[185] = --Cooking
	{
		--LOTS (~74)
	},
	[356] = --Fishing
	{
		--none
	},
	[182] = --Herbalism
	{
		--none
	},
	[186] = --Mining
	{
		--none
	},
	[393] = --Skinning
	{
		--none
	},
	[164] = --Blacksmithing
	{
		--LOTS (~169)
	},
	[165] = --Leatherworking
	{
		--LOTS (~158)
	},
	[197] = --Tailoring
	{
		[0001] = { SkillLevel = 40,		RecipeItemID = 2598,	CraftedItemID = 2572,	PlayerSpellID = 2389	},		--Pattern: Red Linen Robe
		[0002] = { SkillLevel = 55,		RecipeItemID = 6270,	CraftedItemID = 6240,	PlayerSpellID = 7630	},		--Pattern: Blue Linen Vest
		[0003] = { SkillLevel = 55,		RecipeItemID = 6271,	CraftedItemID = 6239,	PlayerSpellID = 7629	},		--Pattern: Red Linen Vest
		[0004] = { SkillLevel = 70,		RecipeItemID = 6272,	CraftedItemID = 6242,	PlayerSpellID = 7633	},		--Pattern: Blue Linen Robe
		[0005] = { SkillLevel = 70,		RecipeItemID = 5771,	CraftedItemID = 5762,	PlayerSpellID = 6686	},		--Pattern: Red Linen Bag
		[0006] = { SkillLevel = 90,		RecipeItemID = 6273,	CraftedItemID = 6243,	PlayerSpellID = 7636	},		--Pattern: Green Woolen Robe
		[0007] = { SkillLevel = 95,		RecipeItemID = 4292,	CraftedItemID = 4241,	PlayerSpellID = 3758	},		--Pattern: Green Woolen Bag
		[0008] = { SkillLevel = 95,		RecipeItemID = 4345,	CraftedItemID = 4313,	PlayerSpellID = 3847	},		--Pattern: Red Woolen Boots
		[0009] = { SkillLevel = 100,	RecipeItemID = 6274,	CraftedItemID = 6263,	PlayerSpellID = 7639	},		--Pattern: Blue Overalls
		[0010] = { SkillLevel = 100,	RecipeItemID = 4346,	CraftedItemID = 4311,	PlayerSpellID = 3844	},		--Pattern: Heavy Woolen Cloak
		[0011] = { SkillLevel = 105,	RecipeItemID = 2601,	CraftedItemID = 2585,	PlayerSpellID = 2403	},		--Pattern: Gray Woolen Robe
		[0012] = { SkillLevel = 115,	RecipeItemID = 6275,	CraftedItemID = 6264,	PlayerSpellID = 7643	},		--Pattern: Greater Adept's Robe
		[0013] = { SkillLevel = 115,	RecipeItemID = 5772,	CraftedItemID = 5763,	PlayerSpellID = 6688	},		--Pattern: Red Woolen Bag
		[0014] = { SkillLevel = 120,	RecipeItemID = 6390,	CraftedItemID = 6384,	PlayerSpellID = 7892	},		--Pattern: Stylish Blue Shirt
		[0015] = { SkillLevel = 120,	RecipeItemID = 6391,	CraftedItemID = 6385,	PlayerSpellID = 7893	},		--Pattern: Stylish Green Shirt
		[0117] = { SkillLevel = 300,	RecipeItemID = 14508,	CraftedItemID = 14112,	PlayerSpellID = 18453,	}		--Pattern: Felcloth Shoulders
		-- ~140 more
	},
	[333] = --Enchanting
	{
		--LOTS (~91)
	},
	[171] = --Alchemy
	{
		--LOTS (~78)
	},
	[202] = --Engineering
	{
		--LOTS (~84)
	}
}
