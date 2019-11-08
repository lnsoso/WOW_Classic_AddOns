--[[
 Skillet: A tradeskill window replacement.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "frFR")
if not L then return end

L[" days"] = " jours"
L["About"] = "À propos"
L["ABOUTDESC"] = "Affiche les informations sur Skillet"
--[[Translation missing --]]
L["Add Recipe to Ignored List"] = "Add Recipe to Ignored List"
L["Add to Ignore Materials"] = "Ajouter aux matériaux ignorés"
L["alts"] = "alts"
L["Appearance"] = "Apparence"
L["APPEARANCEDESC"] = "Paramètres d'affichage de Skillet"
L["bank"] = "Banque"
L["Blizzard"] = "Blizzard"
L["Buy Reagents"] = "Acheter des réactifs"
L["buyable"] = "Achetable"
L["Buyout"] = "Buyout"
L["By Difficulty"] = "Par Difficulté"
L["By Item Level"] = "Par Niveau d'objet"
L["By Level"] = "Par Niveau"
L["By Name"] = "Par Nom"
L["By Quality"] = "Par Qualité"
L["By Skill Level"] = "Par Niveau de Compétence"
L["can be created by crafting reagents"] = "Peut être crée en fabriquant les composants"
L["can be created from reagents in your inventory"] = "Peut être créé à partir de réactifs dans votre inventaire"
--[[Translation missing --]]
L["can be created from reagents on all characters"] = "can be created from reagents on all characters"
L["can be created from reagents on other characters"] = "Peut être créé à partir de réactifs sur tous vos personnages"
L["can be created with reagents bought at vendor"] = "can be created with reagents bought at vendor"
L["Changing profession to"] = "Changer la profession en"
L["Clear"] = "Nettoyer"
--[[Translation missing --]]
L["Click"] = "Click"
L["click here to add a note"] = "Cliquez pour ajouter une note"
L["Click to toggle favorite"] = "Clique pour afficher favoris"
L["Collapse all groups"] = "Replier tous les groupes"
L["Config"] = "Configuration"
L["CONFIGDESC"] = "Ouvre la fenêtre de configuration de Skillet"
L["CONFIRMQUEUECLEARDESC"] = "Use Alt-left-click instead of left-click to clear the queue"
L["CONFIRMQUEUECLEARNAME"] = "Use Alt-click to clear queue"
--[[Translation missing --]]
L["Conflict with the addon TradeSkillMaster"] = "Conflict with the addon TradeSkillMaster"
L["Copy"] = "Copier"
L["Could not find bag space for"] = "Plus de place dans vos sacs pour"
L["craftable"] = "Réalisable"
L["Crafted By"] = "Créé par"
L["Create"] = "Créer"
L["Create All"] = "Créer Tous"
L["Cut"] = "Couper"
L["DBMarket"] = "DBMarket"
L["Delete"] = "Supprimer"
L["DISPLAYITEMLEVELDESC"] = "Si l'objet à fabriquer possède un niveau d'objet, l'afficher à côté de la recette"
L["DISPLAYITEMLEVELNAME"] = "Afficher le niveau d'objet"
L["DISPLAYREQUIREDLEVELDESC"] = "Si l'objet à créer a un niveau minimum requis, ce niveau sera affiché avec la recette"
L["DISPLAYREQUIREDLEVELNAME"] = "Afficher le niveau requis"
L["DISPLAYSHOPPINGLISTATAUCTIONDESC"] = "Afficher une liste d'achats d'objets nécessaires à la réalisation des recettes en file d'attente mais qui ne sont pas dans vos sacs."
L["DISPLAYSHOPPINGLISTATAUCTIONNAME"] = "Afficher liste d'achats à l'hôtel des ventes."
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Afficher une liste d'achats d'objet requis à la création des objets en file d'attente dont vous ne disposez pas"
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Afficher liste d'achats à la banque"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Afficher une liste d'achats d'objet requis à la création des objets en file d'attente dont vous ne disposez pas"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Afficher liste d'achats à la banque de guilde"
L["DISPLAYSHOPPINGLISTATMERCHANTDESC"] = "Montre une liste d'achats d'objets nécessaires à la création des recettes en attente mais qui ne sont pas dans vos sacs."
L["DISPLAYSHOPPINGLISTATMERCHANTNAME"] = "Montre la liste d'achats chez les marchands."
L["Draenor Engineering"] = "Ingénierie de Draenor"
L["Empty Group"] = "Groupe vide"
L["Enabled"] = "Activé"
L["Enchant"] = "Enchanter"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "Si activé, les noms de recettes auront un ou plusieurs '+' derrière leur nom pour indiquer la difficulté de la recette."
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Montrer la difficulté des recettes comme texte"
L["Expand all groups"] = "Développer tous les groupes"
L["Features"] = "Fonctionnalités"
L["FEATURESDESC"] = "Réglages optionnels qui peuvent être activés et désactivés"
L["Filter"] = "Filtrer"
--[[Translation missing --]]
L["Flat"] = "Flat"
L["Flush All Data"] = "Supprimer toutes les données"
L["Flush Recipe Data"] = "Vider les données de recettes"
L["FLUSHALLDATADESC"] = "Supprimer toutes les données de Skillet"
L["FLUSHRECIPEDATADESC"] = "Vider les données Skillet de recettes"
L["From Selection"] = "Depuis la sélection"
L["Glyph "] = "Glyphe "
L["Gold earned"] = "Or gagné"
L["Grouping"] = "Grouper"
L["has cooldown of"] = "A un temps de recharge de"
L["have"] = "Possession"
L["Hide trivial"] = "Cacher les triviaux"
L["Hide uncraftable"] = "Cacher les non-réalisables"
L["HIDEBLIZZARDFRAMEDESC"] = "Cacher la fenêtre de métier de Blizzard lorsque celle de Skillet est visible"
L["HIDEBLIZZARDFRAMENAME"] = "Cacher la fenêtre de Blizzard"
--[[Translation missing --]]
L["Ignore"] = "Ignore"
L["IGNORECLEARDESC"] = "Supprimer toutes les entrées de la liste des Matériaux Ignorés"
L["Ignored List"] = "Liste ignorée"
L["Ignored Materials Clear"] = "Vider les Matériaux Ignorés"
L["Ignored Materials List"] = "Liste des Matériaux Ignorés"
L["IGNORELISTDESC"] = "Ouvrir la liste des Matériaux Ignorés"
L["Illusions"] = "Illusions"
L["in your inventory"] = "in your inventory"
L["Include alts"] = "Inclure les alts"
L["Include bank"] = "Inclure la banque"
L["Include guild"] = "Inclure la guilde"
L["INCLUDEREAGENTSDESC"] = "Ajouter les réactifs au texte de l'objet recherché"
L["INCLUDEREAGENTSNAME"] = "Ajouter les réactifs dans la recherche"
L["Inventory"] = "Inventaire"
L["INVENTORYDESC"] = "Informations sur l'inventaire"
--[[Translation missing --]]
L["InvSlot"] = "InvSlot"
L["is now disabled"] = "est maintenant désactivé"
L["is now enabled"] = "est maintenant activé"
L["Learned"] = "Appris"
L["Library"] = "Librairie"
L["Link Recipe"] = "Liens de la recette"
L["LINKCRAFTABLEREAGENTSDESC"] = "Si vous pouvez créer un composant requis pour la recette actuelle, cliquer sur ce réactif vous emmènera à sa recette."
L["LINKCRAFTABLEREAGENTSNAME"] = "Rendre réactifs cliquables"
L["Load"] = "Charger"
--[[Translation missing --]]
L["Lock/Unlock"] = "Lock/Unlock"
L["Market"] = "Market"
L["Merge items"] = "Regrouper les objets"
L["Move Down"] = "Descendre"
L["Move to Bottom"] = "Déplacer à la fin"
L["Move to Top"] = "Déplacer au début"
L["Move Up"] = "Monter"
L["need"] = "Besoin"
--[[Translation missing --]]
L["New"] = "New"
L["New Group"] = "Nouveau groupe"
L["No Data"] = "Aucune donnée"
--[[Translation missing --]]
L["No headers, try again"] = "No headers, try again"
L["No such queue saved"] = "Aucune file d'attente correspondante sauvée"
L["None"] = "Aucun"
L["not yet cached"] = "Pas encore en cache"
L["Notes"] = "Notes"
L["Number of items to queue/create"] = "Nombre d'objets à créer/mettre en file d'attente"
L["Options"] = "Options"
L["Order by item"] = "Ordonner par objet"
L["Paste"] = "Coller"
L["Pause"] = "Pause"
L["Plugins"] = "Plugins"
--[[Translation missing --]]
L["Press"] = "Press"
--[[Translation missing --]]
L["Press Okay to continue changing professions"] = "Press Okay to continue changing professions"
L["Press Process to continue"] = "Cliquer sur Procéder pour continuer"
L["Process"] = "Traiter"
L["Purchased"] = "Achetés"
L["Queue"] = "Mettre en file"
L["Queue All"] = "Tout mettre en file"
L["Queue is empty"] = "La file d'attente est vide"
L["Queue is not empty. Overwrite?"] = "La file d'attente n'est pas vide. La remplacer ?"
L["Queue with this name already exsists. Overwrite?"] = "Une file d'attente avec ce nom existe déjà. La remplacer ?"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Si vous pouvez créer un composant dont vous manquez pour la recette actuelle, alors ce composant sera ajouté à la file."
L["QUEUECRAFTABLEREAGENTSNAME"] = "Mettre en file d'attente les composants réalisables"
L["QUEUEGLYPHREAGENTSDESC"] = "Si vous pouvez créer un composant dont vous manquez pour la recette actuelle, alors ce composant sera ajouté à la file. Cette option est séparée pour les glyphes uniquement."
L["QUEUEGLYPHREAGENTSNAME"] = "Mettre en file d'attente les composants pour glyphes"
L["QUEUEONLYVIEWDESC"] = "Show Standalone Queue Window only when set, show both Standalone Queue Window and Skillet Window when clear."
L["QUEUEONLYVIEWNAME"] = "Only show Standalone Queue"
L["Queues"] = "Files d'attente"
--[[Translation missing --]]
L["reagent id seems corrupt!"] = "reagent id seems corrupt!"
L["Reagents"] = "Composants"
L["reagents in inventory"] = "Réactifs dans l'inventaire"
L["Really delete this queue?"] = "Voulez-vous vraiment supprimer cette file d'attente ?"
L["Remove Favorite"] = "Retirer des favoris"
--[[Translation missing --]]
L["Remove Recipe from Ignored List"] = "Remove Recipe from Ignored List"
--[[Translation missing --]]
L["Rename"] = "Rename"
L["Rename Group"] = "Renommer le groupe"
L["Rescan"] = "Actualiser"
L["Reset"] = "Réinitialiser"
L["Reset Recipe Filter"] = "Reset Recipe Filter"
L["RESETDESC"] = "Réinitialiser la position de Skillet"
L["RESETRECIPEFILTERDESC"] = "Reset Recipe Filter"
L["Retrieve"] = "Récupérer"
L["Same faction"] = "Same faction"
L["Save"] = "Sauver"
L["Scale"] = "Échelle"
L["SCALEDESC"] = "Échelle de la fenêtre (1.0 par défaut)"
L["Scan completed"] = "Balayage terminé"
L["Scanning tradeskill"] = "Balayage en cours"
L["Search"] = "Recherche"
L["Select All"] = "Tout sélectionner"
L["Select None"] = "Ne rien sélectionner"
L["Select skill difficulty threshold"] = "Sélectionner le seuil de difficulté"
L["Selected Addon"] = "AddOn sélectionné"
L["Selection"] = "Sélection"
L["Sells for "] = "Se vend pour"
L["Set Favorite"] = "Mettre en favoris"
--[[Translation missing --]]
L["shift-click to link"] = "shift-click to link"
L["Shopping Clear"] = "Liste de courses effacée"
L["Shopping List"] = "Liste d'achats"
L["SHOPPINGCLEARDESC"] = "Vider la liste de course"
L["SHOPPINGLISTDESC"] = "Affiche la liste d'achats"
L["Show favorite recipes only. Click on a star on the left side of a recipe to set favorite."] = "Montre seulement la recette favorite. Clique sur une étoile sur le côté gauche d'une recette pour la mettre en favorite."
L["SHOWBANKALTCOUNTSDESC"] = "Lors du calcul et de l'affichage du nombre d'objets réalisables, inclure les objets de votre banque et de vos autres personnages"
L["SHOWBANKALTCOUNTSNAME"] = "Inclure le contenu de votre banque et de vos autres personnages"
L["SHOWCRAFTCOUNTSDESC"] = "Afficher le nombre de fois que vous pouvez réaliser une recette, et pas le nombre total d'objets possibles à fabriquer"
L["SHOWCRAFTCOUNTSNAME"] = "Afficher le nombre de réalisations possibles"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Afficher les autres personnages qui peuvent fabriquer un objet dans l'infobulle"
L["SHOWCRAFTERSTOOLTIPNAME"] = "Afficher les artisans dans les infobulles"
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Affiche une infobulle quand la souris survole les recettes dans le panneau de gauche"
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Afficher une infobulle pour les recettes"
L["SHOWFULLTOOLTIPDESC"] = "Afficher toutes les informations sur un objet à produire. Si vous le désactivez, vous ne verrez qu'une infobulle compacte (maintenez Ctrl pour l'infobulle complète)"
L["SHOWFULLTOOLTIPNAME"] = "Utiliser les infobulles classiques"
L["SHOWITEMNOTESTOOLTIPDESC"] = "Ajoute des notes que vous fournissez pour un objet dans son infobulle"
L["SHOWITEMNOTESTOOLTIPNAME"] = "Ajoute des notes de l'utilisateur dans l'infobulle"
L["SHOWITEMTOOLTIPDESC"] = "Afficher l'infobulle de l'objet réalisable au lieu de celui de la recette."
L["SHOWITEMTOOLTIPNAME"] = "Afficher l'infobulle de l'objet quand c'est possible"
L["SHOWMAXUPGRADEDESC"] = "When set, show upgradable recipes as \"(current/maximum)\". When not set, show as \"(current)\""
L["SHOWMAXUPGRADENAME"] = "Show upgradable recipes as (current/max)"
L["SHOWRECIPESOURCEFORLEARNEDDESC"] = "Montre les sources des recettes pour les recettes apprises"
L["SHOWRECIPESOURCEFORLEARNEDNAME"] = "Montre les sources des recettes pour les recettes apprises"
L["Skillet Trade Skills"] = "Skillet-Classique"
L["Skipping"] = "Sauter"
L["Sold amount"] = "Montant vendu"
L["SORTASC"] = "Trier la liste des patrons du plus élevé (haut) vers le plus faible (en bas)"
L["SORTDESC"] = "Trier la liste des patrons du plus faible (haut) vers le plus élevé (en bas)"
L["Sorting"] = "Tri"
L["Source:"] = "Source : "
L["STANDBYDESC"] = "Activer/désactiver le mode veille"
L["STANDBYNAME"] = "veille"
L["Start"] = "Commencer"
--[[Translation missing --]]
L["SubClass"] = "SubClass"
L["SUPPORTCRAFTINGDESC"] = "Inclure un support pour les professions (Nécessite de recharger)"
L["SUPPORTCRAFTINGNAME"] = "Supporter l'artisanat"
L["Supported Addons"] = "AddOns Compatibles"
L["SUPPORTEDADDONSDESC"] = "AddOns reconnus pouvant ou étant utilisés pour surveiller l'inventaire"
L["This merchant sells reagents you need!"] = "Ce marchand vend des réactifs dont vous avez besoin!"
L["Total Cost:"] = "Coût total :"
L["Total spent"] = "Total dépensé"
L["Trained"] = "Enseignée"
L["TRANSPARAENCYDESC"] = "Transparence de la fenêtre principale"
L["Transparency"] = "Transparence"
L["Unknown"] = "Inconnue"
L["Unlearned"] = "Non-appris"
L["USEALTCURRVENDITEMSDESC"] = "Vendor items bought with alternate currencies are considered vendor supplied."
L["USEALTCURRVENDITEMSNAME"] = "Use vendor items bought with alternate currencies"
L["USEBLIZZARDFORFOLLOWERSDESC"] = "Utiliser l'interface Blizzard pour les compétences de suivant de fief"
L["USEBLIZZARDFORFOLLOWERSNAME"] = "Utiliser l'interface Blizzard pour les suivants"
L["USEGUILDBANKASALTDESC"] = "Use the contents of the guildbank as if it was another alternate."
L["USEGUILDBANKASALTNAME"] = "Use guildbank as another alt"
L["Using Bank for"] = "Utilise la banque pour"
L["Using Reagent Bank for"] = "Utilise la banque de composants pour"
L["VENDORAUTOBUYDESC"] = "Si vous avez des recettes en file d'attente et que vous parlez à un vendeur proposant quelque chose de nécessaire à ces recettes, il sera automatiquement acheté."
L["VENDORAUTOBUYNAME"] = "Acheter les réactifs automatiquement"
L["VENDORBUYBUTTONDESC"] = "Afficher un bouton en parlant aux vendeurs qui vous permet d'acheter les réactifs nécessaires pour toutes les recettes en file d'attente."
L["VENDORBUYBUTTONNAME"] = "Montrer le bouton d'achat de réactifs chez les vendeurs"
L["View Crafters"] = "Voir Artisans"

