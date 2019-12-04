-- scope stuff
karmarang = karmarang or {};
karmarang.localizations = karmarang.localizations or {};

-- locales
local currentLocale = GetLocale();

function karmarang:GetText(key, ...)
	if karmarang.localizations[currentLocale] and karmarang.localizations[currentLocale][key] then
		return string.format(karmarang.localizations[currentLocale][key], ...);
	end
	return string.format(key, ...);
end