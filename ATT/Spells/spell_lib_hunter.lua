local name, SPELLDB = ...
SPELLDB.HUNTER = {}
SPELLDB.HUNTER.BEASTMASTERY = {}
SPELLDB.HUNTER.MARKSMANSHIP = {}
SPELLDB.HUNTER.SURVIVAL = {}

SPELLDB.HUNTER.BEASTMASTERY.spells = {
	208683,
	186257 --[[Aspect of the Cheetah--]],       
	186265 --[[Aspect of the Turtle--]],       
	193530 --[[Aspect of the Wild--]],       
	19574 --[[Bestial Wrath--]],       
	193455 --[[Cobra Shot--]],       
	5116 --[[Concussive Shot--]],       
	147362 --[[Counter Shot--]],       
	120679 --[[Dire Beast--]],       
	6197 --[[Eagle Eye--]],       
	109304 --[[Exhilaration--]],       
	5384 --[[Feign Death--]],       
	1543 --[[Flare--]],       
	34026 --[[Kill Command--]],       
	34477 --[[Misdirection--]],       
	2643 --[[Multi-Shot--]],       
	115939 --[[Beast Cleave--]],       
	56315 --[[Kindred Spirits--]],       
	76657 --[[Mastery: Master of Beasts--]],       
	185789 --[[Wild Call--]],   
};

SPELLDB.HUNTER.MARKSMANSHIP.spells = {
	19434 --[[Aimed Shot--]],       
	185358 --[[Arcane Shot--]],       
	186257 --[[Aspect of the Cheetah--]],       
	186265 --[[Aspect of the Turtle--]],       
	186387 --[[Bursting Shot--]],       
	5116 --[[Concussive Shot--]],       
	147362 --[[Counter Shot--]],       
	6197 --[[Eagle Eye--]],       
	109304 --[[Exhilaration--]],       
	5384 --[[Feign Death--]],       
	1543 --[[Flare--]],       
	185901 --[[Marked Shot--]],       
	34477 --[[Misdirection--]],       
	2643 --[[Multi-Shot--]],       
	193526 --[[Trueshot--]],       
	35110 --[[Bombardment--]],       
	185987 --[[Hunter's Mark--]],       
	212658 --[[Hunting Party--]],       
	231554 --[[Marksman's Focus--]],       
	193468 --[[Mastery: Sniper Training--]],         
};

SPELLDB.HUNTER.SURVIVAL.spells = {
	186257 --[[Aspect of the Cheetah--]],       
	186289 --[[Aspect of the Eagle--]],       
	186265 --[[Aspect of the Turtle--]],       
	187708 --[[Carve--]],       
	6197 --[[Eagle Eye--]],       
	109304 --[[Exhilaration--]],       
	5384 --[[Feign Death--]],       
	202800 --[[Flanking Strike--]],       
	1543 --[[Flare--]],       
	190925 --[[Harpoon--]],       
	193265 --[[Hatchet Toss--]],       
	185855 --[[Lacerate--]],       
	190928 --[[Mongoose Bite--]],       
	187707 --[[Muzzle--]],       
	186270 --[[Raptor Strike--]],       
	195645 --[[Wing Clip--]],       
	191334 --[[Mastery: Hunting Companion--]],       
	164856 --[[Survivalist--]],       
	234955 --[[Waylay--]],
	187650 --[[Freezing Trap]],   
};

SPELLDB.HUNTER.BEASTMASTERY.talents = {
	273887 --[[Killer Instinct--]],
	267116 --[[Animal Companion--]],
	120679 --[[Dire Beast--]],
	193532 --[[Scent Of Blood--]],
	199528 --[[One with the pack--]],
	53209 --[[Chimaera Shot--]],
	231390 --[[Trailblazer--]],
	270581 --[[Natural Mending--]],
	199483 --[[Camouflage--]],
	257891 --[[Venomous Bite--]],
	257944 --[[Thrill of the Hunt--]],
	131894 --[[A Murder of Crows--]],
	266921 --[[Born To Be Wild--]],
	109215 --[[Posthaste--]],
	109248 --[[Binding Shot--]],
	199530 --[[Stomp--]],
	120360 --[[Barrage--]],
	201430 --[[Stampede--]],
	191384 --[[Aspect of the Beast--]],
	199532 --[[Killer Cobra--]],
	194407 --[[Spitting Cobra--]],
};
SPELLDB.HUNTER.MARKSMANSHIP.talents = {
	155228 --[[Lone Wolf--]],       
	193533 --[[Steady Focus--]],       
	53238 --[[Careful Aim--]],       
	194595 --[[Lock and Load--]],       
	194599 --[[Black Arrow--]],       
	199527 --[[True Aim--]],       
	109215 --[[Posthaste--]],       
	199523 --[[Farstrider--]],       
	199921 --[[Trailblazer--]],       
	212431 --[[Explosive Shot--]],       
	206817 --[[Sentinel--]],       
	234588 --[[Patient Sniper--]],       
	109248 --[[Binding Shot--]],       
	19386 --[[Wyvern Sting--]],       
	199483 --[[Camouflage--]],       
	131894 --[[A Murder of Crows--]],       
	120360 --[[Barrage--]],       
	194386 --[[Volley--]],       
	214579 --[[Sidewinders--]],       
	198670 --[[Piercing Shot--]],       
	199522 --[[Trick Shot--]],    
};
SPELLDB.HUNTER.SURVIVAL.talents = {
	204315 --[[Animal Instincts--]],       
	200163 --[[Throwing Axes--]],       
	201082 --[[Way of the Mok'Nathal--]],       
	206505 --[[A Murder of Crows--]],       
	201075 --[[Mortal Wounds--]],       
	201078 --[[Snake Hunter--]],       
	109215 --[[Posthaste--]],       
	781 --[[Disengage--]],       
	199921 --[[Trailblazer--]],       
	194277 --[[Caltrops--]],       
	236698 --[[Guerrilla Tactics--]],       
	162488 --[[Steel Trap--]],       
	191241 --[[Sticky Bomb--]],       
	200108 --[[Ranger's Net--]],       
	199483 --[[Camouflage--]],       
	212436 --[[Butchery--]],       
	194855 --[[Dragonsfire Grenade--]],       
	87935 --[[Serpent Sting--]],       
	194407 --[[Spitting Cobra--]],       
	199543 --[[Expert Trapper--]],       
	191384 --[[Aspect of the Beast--]],  
};

SPELLDB.HUNTER.BEASTMASTERY.pvpTalents = {
	208683 --[[Gladiator's Medallion--]],       
	214027 --[[Adaptation--]],       
	196029 --[[Relentless--]],       
	213538 --[[Quickshots--]],       
	213539 --[[Initiation--]],       
	213543 --[[Focused Fire--]],       
	202589 --[[Dragonscale Armor--]],       
	202624 --[[Catlike Reflexes--]],       
	202746 --[[Survival Tactics--]],       
	202797 --[[Viper Sting--]],       
	202900 --[[Scorpid Sting--]],       
	202914 --[[Spider Sting--]],       
	212668 --[[The Beast Within--]],       
	212669 --[[Separation Anxiety--]],       
	204190 --[[Wild Protector--]],       
	212670 --[[Go for the Throat--]],       
	208652 --[[Dire Beast: Hawk--]],       
	205691 --[[Dire Beast: Basilisk--]],  
};
SPELLDB.HUNTER.MARKSMANSHIP.pvpTalents = {
	208683 --[[Gladiator's Medallion--]],       
	214027 --[[Adaptation--]],       
	196029 --[[Relentless--]],       
	213538 --[[Quickshots--]],       
	213539 --[[Initiation--]],       
	213543 --[[Focused Fire--]],       
	202589 --[[Dragonscale Armor--]],       
	202624 --[[Catlike Reflexes--]],       
	202746 --[[Survival Tactics--]],       
	202797 --[[Viper Sting--]],       
	202900 --[[Scorpid Sting--]],       
	202914 --[[Spider Sting--]],       
	209793 --[[T.N.T.--]],       
	213691 --[[Scatter Shot--]],       
	236776 --[[Hi-Explosive Trap--]],       
	203129 --[[Trueshot Mastery--]],       
	203133 --[[Spray and Pray--]],       
	203155 --[[Sniper Shot--]],    
};
SPELLDB.HUNTER.SURVIVAL.pvpTalents = {
	208683 --[[Gladiator's Medallion--]],       
	214027 --[[Adaptation--]],       
	196029 --[[Relentless--]],       
	232047 --[[Hardiness--]],       
	232046 --[[Reinforced Armor--]],       
	232045 --[[Sparring--]],       
	202589 --[[Dragonscale Armor--]],       
	202624 --[[Catlike Reflexes--]],       
	202746 --[[Survival Tactics--]],       
	202797 --[[Viper Sting--]],       
	202900 --[[Scorpid Sting--]],       
	202914 --[[Spider Sting--]],       
	203235 --[[Hunting Pack--]],       
	212640 --[[Mending Bandage--]],       
	53271 --[[Master's Call--]],       
	203264 --[[Sticky Tar--]],       
	203340 --[[Diamond Ice--]],       
	212638 --[[Tracker's Net--]],  
};


































