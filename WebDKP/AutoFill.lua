WebDKP_RarityTable={[0]=-1,[1]=0,[2]=1,[3]=2,[4]=3,[5]=4}local a={}function WebDKP_AwardItem_Event2(b,c,d)WebDKP_SelectPlayerOnly(c)local e=WebDKP_GetSelectedPlayers(1)if type(e)~='table'or e[0].name==""then WebDKP_Print(WebDKP.translations.Noplayer_Print)PlaySound(847)end;local f=0;local g=WebDKP_GetTableid()if strfind(b,"%%")then b=gsub(b,"%%","")b=tonumber(b)f=1 end;if b==nil or b==""then WebDKP_Print(WebDKP.translations.Noinput_Print)b=0 end;if f==1 then b=WebDKP_ROUND(-b/100*WebDKP_DkpTable[e[0].name]["dkp_"..g],2)else b=-b end;WebDKP_AddDKP(b,d,"true",e)WebDKP_AnnounceAwardItem(b,d,e[0]["name"])WebDKP_UpdateTableToShow()WebDKP_UpdateTable()end;function WebDKP_ShowAwardFrame(h,b,i,c,j)PlaySound(850)local k=CreateFrame("Frame","WebDKP_AwardFrame_"..tostring(time()),UIParent,"WebDKP_AwardFrameTemplate")k.title:SetText(WebDKP.translations.AwardFrameTitle)k.yes:SetText(WebDKP.translations.AwardFrameTitleYES)k.no:SetText(WebDKP.translations.AwardFrameTitleNO)k.player=c;k.link=i;k.title:SetText(h)k.cost:SetText(b or"")k.yes:SetScript("OnClick",function(self)k:Hide()local b=tonumber(k.cost:GetText())or 0;j(b,k.player,k.link)PlaySound(120)k=nil end)k.no:SetScript("OnClick",function(self)k:Hide()PlaySound(851)k=nil end)k:Show()end;local l=gsub(LOOT_ITEM,"%%s","(.+)")local m=gsub(LOOT_ITEM_SELF,"%%s","(.+)")function WebDKP_Loot_Taken(n,c)local o=select(8,GetInstanceInfo())if WebDKP.translations.BOSS_MAP[o]==nil then return end;if WebDKP_Options["AutofillEnabled"]==0 then return end;if not c then return end;if strfind(n,l)or strfind(n,m)then local p,i,q=GetItemInfo(n)if not p then return end;if WebDKP_RarityTable[q]<WebDKP_Options["AutofillThreshold"]then return end;if WebDKP_ShouldIgnoreItem(p)then return end;if p==WebDKP_lastBidItem or p==WebDKP_bidItem then WebDKP_lastBidItem=""return end;local b;if WebDKP_Loot~=nil then b=WebDKP_Loot[p]or 0 end;if WebDKP_Options["AutoAwardEnabled"]==1 then WebDKP_ShowAwardFrame(WebDKP.translations.ShowAwardtext..c.." "..i.." ，DKP: "..b..WebDKP.translations.ShowAwardtext2,b,i,c,WebDKP_AwardItem_Event2)end end end;function WebDKP_AutoFillCost()local r=WebDKP_AwardItem_FrameItemName:GetText()startingBid=WebDKP_GetLootTableCost(r)if startingBid~=nil then WebDKP_AwardItem_FrameItemCost:SetText(startingBid)else end end;function WebDKP_AutoFillDKP()if WebDKP_Options["AutofillEnabled"]==0 then return end;local s=WebDKP_AwardDKP_FrameReason:GetText()if WebDKP_Loot~=nil and s~=nil then local b=WebDKP_Loot[s]if b~=nil then WebDKP_AwardDKP_FramePoints:SetText(b)end end end