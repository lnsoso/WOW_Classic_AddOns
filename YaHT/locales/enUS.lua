if select(2,UnitClass("player")) ~= "HUNTER" then return end
local YaHT = select(2, ...)
local L = {
["Profiles"] = "Profiles",
["Overview"] = "Overview",
["Options"] = "Options",
["Lock"] = "Lock",
["Lock / Unlock the timer bar for drag."] = "Lock / Unlock the timer bar for drag.",
["Width"] = "Width",
["Set the width."] = "Set the width.",
["Height"] = "Height",
["Set the height."] = "Set the height.",
["Scale"] = "Scale",
["Set the scale."] = "Set the scale.",
["Alpha"] = "Alpha",
["Set the alpha."] = "Set the alpha.",
["Movement alpha"] = "Movement alpha",
["Set the alpha while moving."] = "Set the alpha while moving.",
["Bar options"] = "Bar options",
["Bar texture"] = "Bar texture",
["Bar border"] = "Bar border",
["Background options"] = "Background options",
["Background"] = "Background",
["Show a background."] = "Show a background.",
["Background texture"] = "Background Texture",
["Background Color"] = "Background Color",
["Border options"] = "Border options",
["Border"] = "Border",
["Show a border."] = "Show a border.",
["Border texture"] = "Border Texture",
["Border Color"] = "Border Color",
["Timer Color"] = "Timer Color",
["Draw Color"] = "Draw Color",
["Fill from middle"] = "Fill from middle",
["Extend the bar from the middle outwards."] = "Extend the bar from the middle outwards.",
["Castbar options"] = "Castbar options",
["Show this on the default castbar."] = "Show this on the default castbar.",
["Announce options"] = "Announce options",
["Announce %s"] = "Announce %s",
["Enable / disable the announcement."] = "Enable / disable the announcement.",
["Announce failed %s"] = "Announce failed %s",
["Announce in"] = "Announce in",
["The channel in which to announce."] = "The channel in which to announce.",
["Whisper"] = "Whisper",
["Channel"] = "Channel",
["Raid Warning"] = "Raid Warning",
["Say"] = "Say",
["Yell"] = "Yell",
["Party"] = "Party",
["Raid"] = "Raid",
["Channel/Playername"] = "Channel/Playername",
["Set the channel or player for whisper."] = "Set the channel or player for whisper.",
["Announce Message"] = "Announce Message",
["Announce Fail Message"] = "Announce Fail Message",
["Set the message to be broadcasted."] = "Set the message to be broadcasted.",
["announcemsg"] = "Tranq out on %s!",
["announcefailmsg"] = "Tranq failed on %s!",
}

YaHT.L = L
