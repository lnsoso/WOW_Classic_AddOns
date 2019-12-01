local TOCNAME,Addon = ...
Addon.Options=Addon.Options or {}
local Options=Addon.Options

local function Options_CheckButtonRightClick(self,button)
	if button=="RightButton" then
		self:Lib_GPI_rclick()
	end
end

function Options.Init(doOk,doCancel,doDefault)
	Options.Prefix=TOCNAME.."O_"
	Options._DoOk=doOk
	Options._DoCancel=doCancel
	Options._DoDefault=doDefault

	
	Options.Panel={}
	Options.Frames={}
	Options.CBox={}
	Options.Btn={}
	Options.Edit={}
	Options.Vars={}
	Options.Index={}
	
	Options.Frames.count=0

	Options.scale=1
end
		
function Options.DoOk()
	for name,cbox in pairs(Options.CBox) do
		if Options.Vars[name .. "_db"]~=nil and Options.Vars[name]~=nil then
			Options.Vars[name .. "_db"] [Options.Vars[name]] = cbox:GetChecked()
		end
	end
	for name,edit in pairs(Options.Edit) do
		if Options.Vars[name .. "_onlynumbers"] then 
			Options.Vars[name .. "_db"] [Options.Vars[name]] = edit:GetNumber()
		else
			if Options.Vars[name.."_suggestion"] and Options.Vars[name.."_suggestion"]~="" then
				if edit:GetText()==Options.Vars[name.."_suggestion"] then
					Options.Vars[name .. "_db"] [Options.Vars[name]] = ""
				else
					Options.Vars[name .. "_db"] [Options.Vars[name]] = edit:GetText()
				end
			else
				Options.Vars[name .. "_db"] [Options.Vars[name]] = edit:GetText()
			end
		end
	end
end
	
function Options.DoCancel()
	for name,cbox in pairs(Options.CBox) do
		if Options.Vars[name .. "_db"]~=nil and Options.Vars[name]~=nil then
			cbox:SetChecked( Options.Vars[name .. "_db"] [Options.Vars[name]] )
		end
	end
	for name,edit in pairs(Options.Edit) do
		if Options.Vars[name .. "_onlynumbers"] then 
			edit:SetNumber( Options.Vars[name .. "_db"] [Options.Vars[name]] )
		else
			edit:SetText( Options.Vars[name .. "_db"] [Options.Vars[name]] )
			Options.__EditBoxLostFocus(edit)
		end		
	end
end
	
function Options.DoDefault()
	for name,cbox in pairs(Options.CBox) do
		if Options.Vars[name .. "_db"]~=nil and Options.Vars[name]~=nil then
			Options.Vars[name .. "_db"] [Options.Vars[name]]= Options.Vars[name .. "_init"]
		end
	end
	for name,edit in pairs(Options.Edit) do
		Options.Vars[name .. "_db"] [Options.Vars[name]]= Options.Vars[name .. "_init"]
	end
	Options:DoCancel()
end
	
function Options.SetScale(x)
	Options.scale=x
end

function Options.AddPanel(Title,noheader,scrollable)
	local c=#Options.Panel +1
	local FrameName=Options.Prefix.."OptionFrame"..c
		
	Options.Panel[c] = CreateFrame( "Frame",FrameName , UIParent )
	Options.Panel[c].name = Title
	if c==1 then 
		Options.Panel[c].okay = Options._DoOk
		Options.Panel[c].cancel = Options._DoCancel
		Options.Panel[c].refresh = Options._DoCancel
		Options.Panel[c].default = Options._DoDefault
	else
		Options.Panel[c].parent = Options.Panel[1].name
	end
	
	InterfaceOptions_AddCategory(Options.Panel[c])
	Options.CurrentPanel=Options.Panel[c]		
	
	if scrollable then
		
		Options.Panel["scroll"..c]=CreateFrame("ScrollFrame", FrameName.."Scroll", Options.CurrentPanel,"UIPanelScrollFrameTemplate")
		Options.Panel["scroll"..c]:SetPoint("TOPLEFT",0, -10) 
		Options.Panel["scroll"..c]:SetPoint("BOTTOMRIGHT", -30, 10) 
		Options.Panel["scrollChild"..c] = CreateFrame("Frame",FrameName.."ScrollChild") 
		Options.Panel["scroll"..c]:SetScrollChild(Options.Panel["scrollChild"..c])
		
		Options.Panel["scrollChild"..c]:SetSize(Options.CurrentPanel:GetWidth()-1,100)
		Options.CurrentPanel=Options.Panel["scrollChild"..c]
	end
	
	
	Options.Frames["title_"..c] = Options.CurrentPanel:CreateFontString(FrameName.."_Title", "OVERLAY", "GameFontNormalLarge")
	if noheader==true then
		Options.Frames["title_"..c]:SetHeight(1)
	else
		Options.Frames["title_"..c]:SetText(Title)
	end
	Options.Frames["title_"..c]:SetPoint("TOPLEFT", 10, -10)
	Options.Frames["title_"..c]:SetScale(Options.scale)
	
	Options.NextRelativ=FrameName.."_Title"
	Options.NextRelativX=25
	Options.NextRelativY=0
	
	return Options.CurrentPanel
end
	
function Options.Indent(width)
	if width==nil then width=10 end
	Options.NextRelativX = Options.NextRelativX + width
end
	
function Options.InLine()
	Options.inLine=true
	Options.LineRelativ=nil
end

function Options.EndInLine()
	Options.inLine=false
	Options.LineRelativ=nil
end	
	
function Options.SetRightSide(w)
	Options.NextRelativ=Options.Prefix.."OptionFrame".. #Options.Panel .."_Title"
	Options.NextRelativX=310 / Options.scale
	Options.NextRelativY=0
end
	
function Options.AddVersion(version)
	local i="version_"..#Options.Panel
	Options.Frames[i] = Options.CurrentPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	Options.Frames[i]:SetText(version)
	Options.Frames[i]:SetPoint("BOTTOMRIGHT", -10, 10)
	Options.Frames[i]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	return Options.Frames[i]
end
	
function Options.AddCategory(Text)
	local c=Options.Frames.count+1
	Options.Frames.count=c		
	local CatName=Options.Prefix .. "Cat" .. c
	Options.Frames[CatName] = Options.CurrentPanel:CreateFontString(CatName, "OVERLAY", "GameFontNormal")
	Options.Frames[CatName]:SetText('|cffffffff' .. Text .. '|r')
	Options.Frames[CatName]:SetPoint("TOPLEFT",Options.NextRelativ,"BOTTOMLEFT", Options.NextRelativX, Options.NextRelativY-10)
	Options.Frames[CatName]:SetFontObject("GameFontNormalLarge")
	Options.Frames[CatName]:SetScale(Options.scale)
	Options.NextRelativ=CatName
	Options.NextRelativX=0
	Options.NextRelativY=0
	return Options.Frames[CatName]
end
function Options.EditCategory(cat,Text)
	local c=Options.Frames.count+1
	cat:SetText('|cffffffff' .. Text .. '|r')	
end
	
function Options.AddButton(Text,func)
	local c=Options.Frames.count+1
	Options.Frames.count=c	
	local ButtonName=Options.Prefix .."BUTTON_"..c
			
	Options.Btn[ButtonName] = CreateFrame("Button", ButtonName, Options.CurrentPanel, "UIPanelButtonTemplate")
	Options.Btn[ButtonName]:ClearAllPoints()
	
	if Options.inLine~=true or Options.LineRelativ ==nil then
		Options.Btn[ButtonName]:SetPoint("TOPLEFT", Options.NextRelativ,"BOTTOMLEFT", Options.NextRelativX, Options.NextRelativY)
		Options.NextRelativ=ButtonName
		Options.LineRelativ=ButtonName
		Options.NextRelativX=0
		Options.NextRelativY=0
	else
		Options.Btn[ButtonName]:SetPoint("TOP", Options.LineRelativ,"TOP", 0, 0)
		Options.Btn[ButtonName]:SetPoint("LEFT", Options.LineRelativ.."Text","RIGHT", 10, 0)
		Options.LineRelativ=ButtonName
	end
	
	Options.Btn[ButtonName]:SetScale(Options.scale)
	Options.Btn[ButtonName]:SetScript("OnClick", func)
	Options.Btn[ButtonName]:SetText(Text)
	Options.Btn[ButtonName]:SetWidth( Options.Btn[ButtonName]:GetTextWidth()+20 )
	return Options.Btn[ButtonName]
end

local function CheckBox_OnRightClick(self,func)
	self.Lib_GPI_rclick=func
	self:SetScript("OnMouseDown",Options_CheckButtonRightClick)
end	

function Options.AddCheckBox(DB,Var,Init,Text,width)
	local c=Options.Frames.count+1
	Options.Frames.count=c	
	local ButtonName=Options.Prefix .."CBOX_"..c
	
	if Init==nil then
		Init=false
	end
	
	Options.Index[c]=ButtonName	
	
	Options.Vars[ButtonName]=Var
	Options.Vars[ButtonName.."_init"]=Init
	Options.Vars[ButtonName.."_db"]=DB
	
	if DB~=nil and Var~=nil then
		if DB[Var] == nil then DB[Var]=Init end
	end
	
	Options.CBox[ButtonName] = CreateFrame("CheckButton", ButtonName, Options.CurrentPanel, "ChatConfigCheckButtonTemplate")
	_G[ButtonName .. "Text"]:SetText(Text)
	if width then
		_G[ButtonName .. "Text"]:SetWidth(width)
		_G[ButtonName .. "Text"]:SetNonSpaceWrap(false)
		_G[ButtonName .. "Text"]:SetMaxLines(1)
		Options.CBox[ButtonName]:SetHitRectInsets(0, -width, 0,0)
	else
		Options.CBox[ButtonName]:SetHitRectInsets(0, -_G[ButtonName.."Text"]:GetStringWidth()-2, 0,0)
	end
	
	Options.CBox[ButtonName]:ClearAllPoints()
	
	if Options.inLine~=true or Options.LineRelativ ==nil then
		Options.CBox[ButtonName]:SetPoint("TOPLEFT", Options.NextRelativ,"BOTTOMLEFT", Options.NextRelativX, Options.NextRelativY)
		Options.NextRelativ=ButtonName
		Options.LineRelativ=ButtonName
		Options.NextRelativX=0
		Options.NextRelativY=0
	else
		Options.CBox[ButtonName]:SetPoint("TOP", Options.LineRelativ,"TOP", 0, 0)
		Options.CBox[ButtonName]:SetPoint("LEFT", Options.LineRelativ.."Text","RIGHT", 10, 0)			
		Options.LineRelativ=ButtonName
	end
	
	Options.CBox[ButtonName]:SetScale(Options.scale)
	if DB~=nil and Var~=nil then 
		Options.CBox[ButtonName]:SetChecked(DB[Var])
	else
		Options.CBox[ButtonName]:Hide()
	end
	
	Options.CBox[ButtonName].OnRightClick=CheckBox_OnRightClick
	
	return Options.CBox[ButtonName]
end

function Options.EditCheckBox(toEdit,DB,Var,Init,Text,width)
	local ButtonName=toEdit:GetName()
	
	if Init==nil then
		Init=false
	end
	Options.Vars[ButtonName]=Var
	Options.Vars[ButtonName.."_init"]=Init
	Options.Vars[ButtonName.."_db"]=DB
	
	if DB~=nil and Var~=nil then
		if DB[Var] == nil then DB[Var]=Init end
	end
	
	_G[ButtonName .. "Text"]:SetText(Text)
	if width then
		_G[ButtonName .. "Text"]:SetWidth(width)
		_G[ButtonName .. "Text"]:SetNonSpaceWrap(false)
		_G[ButtonName .. "Text"]:SetMaxLines(1)
		Options.CBox[ButtonName]:SetHitRectInsets(0, -width, 0,0)
	else
		Options.CBox[ButtonName]:SetHitRectInsets(0, -_G[ButtonName.."Text"]:GetStringWidth()-2, 0,0)
	end
	
	if DB~=nil and Var~=nil then 
		Options.CBox[ButtonName]:SetChecked(DB[Var])
		Options.CBox[ButtonName]:Show()
	else
		Options.CBox[ButtonName]:Hide()
	end
end

function Options.AddText(TXT,width,centre)
	local textbox
			
	textbox= Options.CurrentPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	textbox:SetText(TXT)
	textbox:SetPoint("TOPLEFT",Options.NextRelativ,"BOTTOMLEFT", Options.NextRelativX, Options.NextRelativY-2)
	textbox:SetScale(Options.scale)
	
	
	
	if width==nil or width==0 then 
		textbox:SetWidth(textbox:GetStringWidth())
	elseif width<0 then
		if string.sub(Options.CurrentPanel:GetName(),  -11)== "ScrollChild" then
			textbox:SetPoint("RIGHT",Options.CurrentPanel:GetParent():GetParent(),"RIGHT",width,0)
		else
			textbox:SetPoint("RIGHT",width,0)
		end
		if not centre then 
			textbox:SetJustifyH("LEFT")
			textbox:SetJustifyV("TOP")
		end
	else
		textbox:SetWidth(width)
		if not centre then 
			textbox:SetJustifyH("LEFT")
			textbox:SetJustifyV("TOP")
		end
	end
	Options.NextRelativ=textbox
	Options.NextRelativX=0
	Options.NextRelativY=0
	return textbox
end
function Options.EditText(textbox,TXT,width,centre)
	textbox:SetText(TXT)
	if width==nil or width==0 then 
		textbox:SetWidth(textbox:GetStringWidth())
	elseif width<0 then
		textbox:SetPoint("RIGHT",width,0)
		if not centre then 
			textbox:SetJustifyH("LEFT")
			textbox:SetJustifyV("TOP")
		end
	else
		textbox:SetWidth(width)
		if not centre then 
			textbox:SetJustifyH("LEFT")
			textbox:SetJustifyV("TOP")
		end
	end
	
end

function Options.__EditBoxTooltipShow(self)
	local name=self:GetName().."_tooltip"
	if self.GPI_Options and self.GPI_Options.Vars and self.GPI_Options.Vars[name] then 
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0,0	)
		GameTooltip:SetMinimumWidth(self:GetWidth())
		GameTooltip:ClearLines()
		GameTooltip:AddLine(self.GPI_Options.Vars[name],0.9,0.9,0.9,true)
		GameTooltip:Show()
	end		
end

function Options.__EditBoxTooltipHide(self)
	GameTooltip:Hide()
end

function Options.__EditBoxGetFocus(self)
	local name=self:GetName().."_suggestion"
	if self.GPI_Options and self.GPI_Options.Vars and self.GPI_Options.Vars[name] then 
		if self:GetText()==self.GPI_Options.Vars[name] then
			self:SetText("")
			self:SetTextColor(1,1,1)				
		end
	end	
end

function Options.__EditBoxLostFocus(self)
	local name=self:GetName().."_suggestion"
	if self.GPI_Options and self.GPI_Options.Vars and self.GPI_Options.Vars[name] then 
		if self:GetText()=="" then
			self:SetTextColor(0.6,0.6,0.6)
			self:SetText(self.GPI_Options.Vars[name])
			self:HighlightText(0,0) 
			self:SetCursorPosition(0)
		end
	end	
end

function Options.__EditBoxOnEnterPressed(self)
	self:ClearFocus()
end

function Options.AddEditBox(DB,Var,Init,TXTLeft,width,widthLeft,onlynumbers,tooltip,suggestion)
	if width==nil then width=200 end
	local c=Options.Frames.count+1
	Options.Frames.count=c	

	local ButtonName= Options.Prefix .."Edit_"..c.. Var
	local CatName = ButtonName.."_Text"
			
	Options.Frames[CatName] = Options.CurrentPanel:CreateFontString(CatName, "OVERLAY", "GameFontNormal")
	Options.Frames[CatName]:SetText('|cffffffff' .. TXTLeft .. '|r')
	Options.Frames[CatName]:SetPoint("TOPLEFT",Options.NextRelativ,"BOTTOMLEFT", Options.NextRelativX, Options.NextRelativY-2)
	Options.Frames[CatName]:SetScale(Options.scale)
	if widthLeft==nil or widthLeft==0 then 
		Options.Frames[CatName]:SetWidth(Options.Frames[CatName]:GetStringWidth())
	else
		Options.Frames[CatName]:SetWidth(widthLeft)
		Options.Frames[CatName]:SetJustifyH("LEFT")
		Options.Frames[CatName]:SetJustifyV("TOP")
	end
	
	
	
	Options.Vars[ButtonName]=Var
	Options.Vars[ButtonName.."_db"]=DB
	Options.Vars[ButtonName.."_init"]=Init
	Options.Vars[ButtonName.."_onlynumbers"]=onlynumbers
	
	
	if DB[Var] == nil then DB[Var]=Init end

	Options.Edit[ButtonName] = CreateFrame("EditBox", ButtonName, Options.CurrentPanel, "InputBoxTemplate")
	Options.Edit[ButtonName]:SetPoint("TOPLEFT", Options.Frames[CatName],"TOPRIGHT",5 ,5)
	Options.Edit[ButtonName]:SetScale(Options.scale)
	Options.Edit[ButtonName]:SetWidth(width)
	Options.Edit[ButtonName]:SetHeight(20)
	
	Options.Edit[ButtonName]:SetScript("OnEnterPressed",Options.__EditBoxOnEnterPressed)
	
	Options.Edit[ButtonName].GPI_Options=Options
			
	if onlynumbers then
		Options.Edit[ButtonName]:SetNumeric(true)
		Options.Edit[ButtonName]:SetNumber(DB[Var])
	else
		Options.Edit[ButtonName]:SetText(DB[Var])
	end
	
	Options.Edit[ButtonName]:SetCursorPosition(0)
	Options.Edit[ButtonName]:HighlightText(0,0) 
	Options.Edit[ButtonName]:SetAutoFocus(false)
	Options.Edit[ButtonName]:ClearFocus() 
	if tooltip and tooltip~="" then 
		Options.Edit[ButtonName]:SetScript("OnEnter",Options.__EditBoxTooltipShow)
		Options.Edit[ButtonName]:SetScript("onLeave",Options.__EditBoxTooltipHide)
		Options.Vars[ButtonName.."_tooltip"]=tooltip
	end
	
	if suggestion and suggestion~="" then 
		Options.Edit[ButtonName]:SetScript("OnEditFocusGained",Options.__EditBoxGetFocus)
		Options.Edit[ButtonName]:SetScript("OnEditFocusLost",Options.__EditBoxLostFocus)
		Options.Vars[ButtonName.."_suggestion"]=suggestion			
	end
	
	Options.Frames[CatName]:SetHeight(Options.Edit[ButtonName]:GetHeight()-10)
	
	Options.NextRelativ=CatName
	Options.NextRelativX=0
	Options.NextRelativY=-10
	
	return Options.Edit[ButtonName]
end

function Options.AddSpace()
	Options.NextRelativY=Options.NextRelativY-20
end

function Options.Open(panel)
	if panel==nil or panel > #Options.Panel then panel = 1 end
	InterfaceOptionsFrame_OpenToCategory(Options.Panel[#Options.Panel])
	InterfaceOptionsFrame_OpenToCategory(Options.Panel[#Options.Panel])
	InterfaceOptionsFrame_OpenToCategory(Options.Panel[panel])
end

