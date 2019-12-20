-- scope stuff
karmarang = karmarang or {};
karmarang.localizations = karmarang.localizations or {};
karmarang.localizations["deDE"] = karmarang.localizations["deDE"] or {};

-- keys
local L = karmarang.localizations["deDE"];
L["AddOn loaded: Version %s. Type /karma for options."] 										    = "AddOn geladen: Version %s. Tippe /karma für Optionen.";
L["Database validation complete."]                                                                  = "Datenbank-Validierung abgeschlossen.";
L["Error while validating database. In order for Karmarang to work properly, it needed to be reset. We are sorry. :("] = "Fehler während der Datenbank-Validierung. Damit Karmarang weiterhin funktioniert, musste die Datenbank zurückgesetzt werden. Es tut uns leid. :(";
L["Module loaded."] 											                                    = "Modul geladen.";
L["yes"] 																			                = "ja";
L["no"] 																			                = "nein";
L["Unknown command. Possible parameters are: /karma ..."] 							                = "Unbekannter Befehl. Mögliche Parameter sind: /karma ...";
L["Apply"] 																			                = "Annehmen";
L["Cancel"] 																		                = "Abbrechen";
L["Reset"] 																		                    = "Zurücksetzen";
L["Database has been reset successfully."]                                                          = "Datenbank erfolgreich zurückgesetzt.";
L["... and %s further results."]                                                                    = "... und %s weitere Ergebnisse.";
L["cacheonstart -> Toggles database caching on startup."]                                           = "cacheonstart -> Schaltet Datenbank-Caching beim Start ein oder aus.";
L["get [text] -> Searches the database for player names containing [text]."]                        = "get [text] -> Sucht in der Datenbank nach Spielernamen, die [text] enthalten.";
L["pref -> Toggles whether your own comments are preferred for tooltips or not."]                   = "pref -> Schaltet um, ob deine eigenen Kommentare in den Tooltips priorisiert werden oder nicht.";
L["resetdb -> Resets the Karmarang database."]                                                      = "resetdb -> Setzt die Karmarang-Datenbank zurück.";
L["Karma"]                                                                                          = "Karma";
L["You are about to\n|cff00ff00UPVOTE|r\nthe player \"%s\"."]                                       = "Du bist dabei, den Spieler \"%s\" zu\n|cff00ff00UPVOTEN|r.";
L["You are about to\n|cffff0000DOWNVOTE|r\nthe player \"%s\"."]                                     = "Du bist dabei, den Spieler \"%s\" zu\n|cffff0000DOWNVOTEN|r.";
L["You are about to rate the player \"%s\" neutrally."]                                             = "Du bist dabei, den Spieler \"%s\" neutral zu bewerten.";
L["unknown"]                                                                                        = "unbekannt";
L["comm -> Toggles Karma broadcasts (automatically joins the Karma_Broadcast channel if active)."]  = "comm -> Schaltet um, ob du an Karma broadcasts teilnimmst (tritt automatisch dem Karma_Broadcast-Channel bei wenn aktiv).";
L["Participating in Karma broadcasts: "]                                                            = "Teilnahme an Karma broadcasts: ";
L["Your own comments are preferred for tooltips."]                                                  = "Eigene Kommentare werden für Tooltips bevorzugt.";
L["Your own comments are NOT preferred for tooltips."]                                              = "Eigene Kommentare werden NICHT für Tooltips bevorzugt.";
L["No players found for: \"%s\"."]                                                                  = "Keine Spieler gefunden für: \"%s\".";
L["Broadcast channel joined. You are participating in Karma broadcasts."]                           = "Broadcast-Channel beigetreten. Du nimmst an Karma broadcasts teil.";
L["Attention: You are not participating in Karma broadcasts. Type \"/karma comm\" to enable Karma broadcasts."] = "Achtung: Du nimmst nicht an Karma broadcasts teil. Tippe \"/karma comm\", um Karma broadcasts zu aktivieren.";
L["Broadcast channel left. You are no longer participating in Karma broadcasts."]                   = "Broadcast-Channel verlassen. Du nimmst nicht länger an Karma broadcasts teil.";
L["Warning: Joining Karma broadcast channel failed."]                                               = "Warnung: Beitritt des Karma broadcast channels fehlgeschlagen.";
L["\"%s\" recently received Karma!"]                                                                = "\"%s\" hat kürzlich bereits Karma erhalten!";
L["|cff00ff00Upvote and comment|r"]                                                                 = "|cff00ff00Upvoten und kommentieren|r";
L["Neutral (comment only)"]                                                                         = "Neutral (nur Kommentar)";
L["|cffff0000Downvote and comment|r"]                                                               = "|cffff0000Downvoten und kommentieren|r";
L["\n\n Comment (optional):"]                                                                       = "\n\n Kommentar (optional):"
L["Your Karma: "]                                                                                   = "Dein Karma: ";
L["Database caching on startup: "]                                                                  = "Datenbank-Caching beim Start: "
L["Database synchronization on startup: "]                                                          = "Datenbank-Synchronisation beim Start: "
L["synconstart -> Toggles database synchronization on startup."]                                    = "synconstart -> Schaltet Datenbank-Synchronisation beim Start ein oder aus.";
L["Synchronization request sent. This can take a few moments..."]                                   = "Synchronisations-Anfrage gesendet. Dies kann einen Augenblick dauern...";
L["Synchronization is still in progress. You cannot send another request until it is finished."]    = "Es findet gerade eine Synchronisation statt. Du kannst keine weitere Anfrage stellen, bis sie abgeschlossen ist.";
L["sync -> Sends a synchronization request to other Karmarang users."]                              = "sync -> Sendet eine Synchronisations-Anfrage an andere Karmarang-Nutzer.";
L["Error: Synchronization request could not be sent."]                                              = "Fehler: Synchronisations-Anfrage konnte nicht gesendet werden.";
L["Error: BNet Tag hash mismatch. Your database needs to be reset.\n\nPlease confirm."]             = "Fehler: BNet Tag-Hash stimmt nicht überein. Deine Datenbank muss zurückgesetzt werden\n\nBitte bestätige.";
L["Warning: You are not connected to the BNet Service. Karmarang initialization aborted."]          = "Warnung: Du bist nicht mit dem BNet Service verbunden. Karmarang-Initialiserung abgebrochen.";
L["resetall -> Resets Karmarang to defaults (database and settings)."]                              = "resetall -> Setzt Karmarang auf Werkseinstellungen zurück (Datenbank und Einstellungen).";
L["This will reset Karmarang completely (database and settings). \n\nAre you sure?"]                = "Dies wird die Karmarang auf Werkseinstellungen zurücksetzen (Datenbak und Einstellungen).\n\nSind Sie sicher?";
L["Karmarang has been reset to defaults. AddOn will be re-initialized..."]                          = "Karmarang wurde auf Werkseinstellungen zurückgesetzt. AddOn wird neu initialisiert...";
L["Realm has been reset successfully."]                                                             = "Realm erfolgreich zurückgesetzt.";
L["Karmarang cannot be reset while synchronization is pending. Please try again once progress is finished."] = "Karmarang kann nicht zurückgesetzt werden, während die Synchronisation läuft. Bitte versuche es noch einmal, sobald der Prozess abgeschlossen ist.";
L["defaults -> Resets Karmarang to defaults."]                                                      = "defaults -> Setzt Karmarang auf Werkseinstellungen zurück.";
L["You are not allowed to send Karma to \"%s\"."]                                                   = "Du darfst kein Karma an \"%s\" senden.";
L["Karmarang is running on a new version. Some changes to your database need to be performed. Please wait..."] = "Karmarang wurde mit einer neuen Version geladen. Einige Änderungen an der Datenbank sind notwendig. Bitte warten...";
L["Karmarang version update complete. Current version: %s"]                                         = "Karmarang Versions-Update abgeschlossen. Aktuelle Version: %s";
L["Another player is using a newer Karmarang version than you: %s. Please visit \"https://www.curseforge.com/wow/addons/karmarang\" to update."] = "Ein anderer Spieler nutzt eine neuere Version von Karmarang als du: %s. Bitte besuche \"https://www.curseforge.com/wow/addons/karmarang\", um ein Update herunterzuladen.";
L["Cooldown: %s"]                                                                                   = "Abklingzeit: %s";
L["Time left: %s"]                                                                                  = "Zeit übrig: %s";
L["This will reset the Karmarang database (all realms).\n\nAre you sure?"]                          = "Dies wird die Karmarang-Datenbank zurücksetzen (alle Realms).\n\nSind Sie sicher?";
L["This will reset the Karmarang database (current realm only).\n\nAre you sure?"]                  = "Dies wird die Karmarang-Datenbank zurücksetzen (nur aktueller Realm).\n\nSind Sie sicher?";
L["For updates, additional information and current Karma rules, visit \"https://www.curseforge.com/wow/addons/karmarang\"."] = "Für Updates, weitere Information und aktuelle Karma-Regeln, besuche \"https://www.curseforge.com/wow/addons/karmarang\".";
L["The AddOn has not been initialized due to an error. Please relog and try again."]                = "Das AddOn wurde aufgrund eines Fehlers nicht initialisiert. Bitte logge dich neu ein und versuche es erneut.";