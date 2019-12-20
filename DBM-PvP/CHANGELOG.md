# <DBM> PvP

## [r77](https://github.com/DeadlyBossMods/DBM-PvP/tree/r77) (2019-12-18)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-PvP/compare/r76...r77)

- Merge pull request #8 from venuatu/master  
    alterac: use a single timer and fix snowfall cap faction change  
- alterac: move poi timer up and call stop on that  
- alterac: use a single timer and fix snowfall cap faction change  
- Fix stupid. Minutes to seconds is x 60 not / 60  
- handle C\_AreaPoiInfo.GetAreaPOITimeLeft() returning nil  
- Classic doesn't have GetAreaPOISecondsLeft, but it does have GetAreaPOITimeLeft  
    This should hopefully fix in progress cap timers to get correct time.  
- This probably doesn't matter, but uniformity and all  
- Some tweak to AV support.  
     - Only request uiMap id once instead of every time POI updates.  
     - Changed the prints to DBM debug code so it can be enabled by any power user looking to contribute/help find the missing POI ids. Remember DBM debug mode can always be enabled via /dbm debug and disabled the same way. Debug level can be set with "/dbm debuglevel <number>" . the debug level of pvp events is 2, so "/dbm debuglevel 2" would cover it.  
- Merge pull request #6 from venuatu/master  
    alterac/classic: add timers  
- alterac: Add timers from areapoi apis  
- Send addon messages with correct DBM prefix in classic wow  
- Disabled queue pop timer, it's redundant since core does it (and has for many years)  
- Fix TimerTracker error on classic  
- Don't cache player faction, since it can change (on retail at least).  This is correct way to do it for classic compat  
- More fixes  
- Update packager script now that it supports 1.13.3  
- Fixed lua error with quest tooltip creation in AV, quest tooltips not supported in classic client. Closes #4  
    Fixed lua error with all BGs in classic caused by using wrong faction function in classic client. Closes #3  
- Bump Classic TOC  
- Allow loading in AV event  
