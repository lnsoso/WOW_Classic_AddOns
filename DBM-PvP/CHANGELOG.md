# <DBM> PvP

## [r74](https://github.com/DeadlyBossMods/DBM-PvP/tree/r74) (2019-09-08)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-PvP/commits/r74)

- Don't need to ignore, prevented it from pushing. Using a global gitignore to prevent a git specific one.  
- don't package the logs folder  
- Comment out assaults for non-finished mods, incase it does throw errors  
- Temple of Kotmogu, done.  
- Completed Seething Shore  
- Remove nil checking, as they all have id's or are atlas now  
- Fix base checking values  
- Fix Arathi bg  
- Add ashran auto-quest. (Basically the only feature needed in Ashran)  
- Wintergrasp ID. Yeet  
- Start working on the new bg's. Fix eye of the storm tracking because I Don't know tables :P  
- Fix numbers, and colors  
- Use an ignored atlas table instead. We only want to ignore Eye of The Storm map, not Deepwind.  
- Some more updates  
    * Fix event name being POIS not POS  
    * Document icon names  
    * Dont start a bar for atlas types (as they're a cap bar, not cap timer)  
    * Remove unneeded args for flag carrier.  
    * Fix ID for Eye of The Storm on casual (now supports both casual and rated :D)  
- Bug fixes  
    * DBM-PvP mod was renamed to PvPGeneral (For GetModByName)  
    * Flag detection centralized  
    * Flag detection now working in Eye Of The Storm battleground  
    * Meep  
- A little code tweak-a-roo  
    * Make the score predictor a little more dynamic, so it can be used in other cases than just base captures (e.g. kotmogu where it uses orbs instead)  
    * Some little memory improvements  
    * Actually check the options for remaining timer  
    * Locale cleanup for en  
- Revert that change. Need to debug into these frames a bit better  
- Why did we have 2 frames? Just use the one.  
- Self usage  
- Ooft, atlas support, makes Eye of The Storm now work! (And others to come)  
- Update map id's  
- Re-hook up localized option text  
- Remove the nil, he says  
- Textures unused  
- ACTUALLY fix bool. This is why DBM needs documentation :(  
- Fix option name :P Thanks mystic  
- Fix boolean  
- Remove arena call in main file  
- CVar updates  
- eliminate redundant object. especially since there was bad logic behind it (a user could turn off time remaining, and even though timer for start was enabled it'd never show. Time remaining should be a single object anyways.  
    Also fixed invite timer showing under misc instead of timers and fixed shadow timer using locals (but not having any) when it should just use auto localized text.  
- elminate sub cat, no longer needed  
    Renamed general options. Having same name as core mod doesn't agree with me.  
    Fix local hookup, resolves several lua errors  
- Track for scenario, move timers out of start section  
- Arena can be merged. So we make it not arena/bg specific  
- Eh?  
- Register for instance  
- Fix ID's, stop arena timers on exit  
- Use file data Id  
- Few more works. Fix Gilneas ID's  
- Fix some self usage :D  
- Forgot a then  
- Bunch more work done. Null checking, code cleanup, etc.  
- Merge branch 'master' of github.com:DeadlyBossMods/DBM-PvP  
- Fix CVar  
- Fix missing locals, at least in english, so the options fully load, and timers will show instead of throw errors when started  
    In addition, adjusted mod sort order so other mods appear at bottom and not the top.  
- Fix load catagory so this no longe throws panel creation error  
- Enable classic alphas as well  
- while at it, why the hell is that being done manually, there is literally already a function that does that, so lets use it.  
- PVP sub mods should handle their own unscheduling, when needed, vs main BG mod handling for ALL mods ALL THE TIME (whether needed or not). This is much more efficient. Not to mention removes the completely silly overhead of importing a ton of mod tables into bg mod for no real reason.  
    In addition, BG mod should not be messing with "hideblizzardevents" function unless it needs to, it was currently always hiding and always unhiding regardless of whether it actually needed to.  
- Update README.md  
- Update README.md  
- Fix typo  
- Not sure how rest of statement was cutoff in a few mods  
- Restore classic Ids, add some basic classic compat checks to block loading of non relevant BGs in classic  
- Bunch more work. Adding a load of ID's  
- Phew, a load more work.  
- Forgot a comma  
- Locale updates.  
- Bunch more work. Fixed Warsong, working on other battlegrounds now.  
- Merge branch 'master' of github.com:DeadlyBossMods/DBM-PvP  
- Push updates before I go away.  
- Let packager automatically set version on toc  
- fix typo  
- Fix typo :)  
- Fix soulstone API. Replaced in 7.3.5  
- Fix warsongs widget id  
- Update Warsong  
- More reliable timer.  
- Migrate all textures to file data Ids  
    Plus a bunch of random stuff my editor automatically does i guess  
- Fix CurseForge link  
- Fix syntax for forum link  
- They don't use braces for standard links  
- Readme updates  
- Derp  
- Fix Lua errors  
- Oh, DBM has an inbuilt scheduler?? Cool!  
- Hey, we can localize more stuff ;D  
- More localization  
- TwinPeaks update (Plus add remaining timer. TODO: Flag carriers  
- Forgot to localise this.  
- Optimise lua ;3 squee  
- Re-implement invite timer, add start timer  
- Order alphabetically  
- Locale updates. Everything is now synced  
- adjust packager call  
- move to the BigWigs community packager  
- Not that it matters much, but remove invalid countdown object from here  
- Update README.md  
- Fixed WSG and TwinPeaks support (by stripping out stuff that's broken/obsolete)  
    Disabled support for all remaining Bgs since those still require total rewrites and not just pruning broken crap.  
- SetRevision updates  
- Create .travis.yml  
- Update README.md  
- Create README.md  
- Create .pkgmeta  
- Revision change  
- and these  
- More API updates, but no valid IDs yet  
- Some prelim alterac updates  
- Silence some nil errors, doesn’t really fix actual cause. something I just don’t have time/resolve to trouble shoot on soon to be discontinued pvp mods  
- disable non working.  
    Code Changes  
- Probably fix some lua errors  
- Restore gate health via infoframe  
- 8.x fix  
- Mod sort updates  
- Die BossHealth  
- Add a few more nil checks. not proper way to fix brawls really but I just don’t know enough about pvp to fix these properly. These honestly need  maintainer that actually PVPs  
- Bump TOCs  
- Some nil checks  
- Fix error. how did this even get passed validator?  
- Add loading condition for winter arathi, untested if that’s enough  
- Bump Toc  
- Update C\_WorldMap.GetMapLandmarkInfo for 7.2 compliance  
- toc  
- Spanish Update  