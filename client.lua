-----------------------------------------------
------ Axio Blips Manager by Derass#4974 ------
-----------------------------------------------

local BLIP_INFO_DATA = {}
local Blips = {}
SavedKVP = {}

lib.locale()

--[[ ADVANCED FUNCTION ]]
function ensureBlipInfo(blip)
	if blip == nil then blip = 0 end
	SetBlipAsMissionCreatorBlip(blip, true)
	if not BLIP_INFO_DATA[blip] then BLIP_INFO_DATA[blip] = {} end
	if not BLIP_INFO_DATA[blip].title then BLIP_INFO_DATA[blip].title = "" end
	if not BLIP_INFO_DATA[blip].rockstarVerified then BLIP_INFO_DATA[blip].rockstarVerified = false end
	if not BLIP_INFO_DATA[blip].info then BLIP_INFO_DATA[blip].info = {} end
	if not BLIP_INFO_DATA[blip].money then BLIP_INFO_DATA[blip].money = "" end
	if not BLIP_INFO_DATA[blip].rp then BLIP_INFO_DATA[blip].rp = "" end
	if not BLIP_INFO_DATA[blip].dict then BLIP_INFO_DATA[blip].dict = "" end
	if not BLIP_INFO_DATA[blip].tex then BLIP_INFO_DATA[blip].tex = "" end
	return BLIP_INFO_DATA[blip]
end

function ResetBlipInfo(blip)
	BLIP_INFO_DATA[blip] = nil
end

function SetBlipInfoTitle(blip, title, rockstarVerified)
	local data = ensureBlipInfo(blip)
	data.title = title or ""
	data.rockstarVerified = rockstarVerified or false
end

function SetBlipInfoImage(blip, dict, tex)
	local data = ensureBlipInfo(blip)
	data.dict = dict or ""
	data.tex = tex or ""
end

function SetBlipInfoEconomy(blip, rp, money)
	local data = ensureBlipInfo(blip)
	data.money = tostring(money) or ""
	data.rp = tostring(rp) or ""
end

function SetBlipInfo(blip, info)
	local data = ensureBlipInfo(blip)
	data.info = info
end

function AddBlipInfoText(blip, leftText, rightText)
	local data = ensureBlipInfo(blip)
	if rightText then
		table.insert(data.info, {1, leftText or "", rightText or ""})
	else
		table.insert(data.info, {5, leftText or "", ""})
	end
end

function AddBlipInfoName(blip, leftText, rightText)
	local data = ensureBlipInfo(blip)
	table.insert(data.info, {3, leftText or "", rightText or ""})
end

function AddBlipInfoHeader(blip, leftText, rightText)
	local data = ensureBlipInfo(blip)
	table.insert(data.info, {4, leftText or "", rightText or ""})
end

function AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
	local data = ensureBlipInfo(blip)
	table.insert(data.info, {2, leftText or "", rightText or "", iconId or 0, iconColor or 0, checked or false})
end

--[[ FUNCTION FOR MENU PAUSE ]]
local Display = 1
function UpdateDisplay()
	if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
		PushScaleformMovieFunctionParameterInt(Display)
		PopScaleformMovieFunctionVoid()
	end
end

function SetColumnState(column, state)
	if PushScaleformMovieFunctionN("SHOW_COLUMN") then
		PushScaleformMovieFunctionParameterInt(column)
		PushScaleformMovieFunctionParameterBool(state)
		PopScaleformMovieFunctionVoid()
	end
end

function ShowDisplay(show)
	SetColumnState(Display, show)
end

function func_36(fParam0)
	BeginTextCommandScaleformString(fParam0)
	EndTextCommandScaleformString()
end

function SetIcon(index, title, text, icon, iconColor, completed)
	if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
		PushScaleformMovieFunctionParameterInt(Display)
		PushScaleformMovieFunctionParameterInt(index)
		PushScaleformMovieFunctionParameterInt(65)
		PushScaleformMovieFunctionParameterInt(3)
		PushScaleformMovieFunctionParameterInt(2)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(1)
		func_36(title)
		func_36(text)
		PushScaleformMovieFunctionParameterInt(icon)
		PushScaleformMovieFunctionParameterInt(iconColor)
		PushScaleformMovieFunctionParameterBool(completed)
		PopScaleformMovieFunctionVoid()
	end
end

function SetText(index, title, text, textType)
	if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
		PushScaleformMovieFunctionParameterInt(Display)
		PushScaleformMovieFunctionParameterInt(index)
		PushScaleformMovieFunctionParameterInt(65)
		PushScaleformMovieFunctionParameterInt(3)
		PushScaleformMovieFunctionParameterInt(textType or 0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		func_36(title)
		func_36(text)
		PopScaleformMovieFunctionVoid()
	end
end

local _labels = 0
local _entries = 0
function ClearDisplay()
	if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
		PushScaleformMovieFunctionParameterInt(Display)
	end
	PopScaleformMovieFunctionVoid()
	_labels = 0
	_entries = 0
end

function _label(text)
	local lbl = "LBL" .. _labels
	AddTextEntry(lbl, text)
	_labels = _labels + 1
	return lbl
end

function SetTitle(title, rockstarVerified, rp, money, dict, tex)
	if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
		PushScaleformMovieFunctionParameterInt(Display)
		func_36("")
		func_36(_label(title))
		PushScaleformMovieFunctionParameterInt(rockstarVerified)
		PushScaleformMovieFunctionParameterString(dict)
		PushScaleformMovieFunctionParameterString(tex)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		if rp == "" then
			PushScaleformMovieFunctionParameterBool(0)
		else
			func_36(_label(rp))
		end
		if money == "" then
			PushScaleformMovieFunctionParameterBool(0)
		else
			func_36(_label(money))
		end
	end
	PopScaleformMovieFunctionVoid()
end

function AddText(title, desc, style)
	SetText(_entries, _label(title), _label(desc), style or 1)
	_entries = _entries + 1
end

function AddIcon(title, desc, icon, color, checked)
	SetIcon(_entries, _label(title), _label(desc), icon, color, checked)
	_entries = _entries + 1
end

--[[ CREATE BLIPS ]]
local function createBlip(params)
	local blip = nil
	
	if params.group and params.group ~= nil then
		if not Blips[params.group] then Blips[params.group] = {} end
		
		local displayType = SavedKVP[params.group]
		if not displayType then  -- IF THE GROUP DOESN'T EXIST
			displayType = GetResourceKvpInt("hidden-blips-"..params.group)
			if displayType == 1 then  -- IF IS DISPLAY
				SetResourceKvpInt("hidden-blips-"..params.group, 1)
				displayType = 2
			end
			SavedKVP[params.group] = displayType
		end

		if params.advanced ~= nil then
			blip = createAdvancedBlip(params)
		else
			blip = createBasicBlip(params)
		end

		Blips[params.group][#Blips[params.group] + 1] = {blip = blip, resource = params.resource}
	else
		if params.advanced ~= nil then
			createAdvancedBlip(params)
		else
			createBasicBlip(params)
		end
	end
end
exports('createBlip', createBlip)

function createAdvancedBlip(params)
	local blip = nil

	blip = AddBlipForCoord(params.coords) 
	SetBlipSprite(blip, params.sprite)
	SetBlipScale(blip, params.scale or 0.8)
	SetBlipColour(blip, params.color or 0)

	for i=1, #params.advanced, 1 do
		if params.advanced[i].type == 'title' then
			SetBlipInfoTitle(blip, params.advanced[i][1], params.advanced[i][2])
		elseif params.advanced[i].type == 'infoText' then
			AddBlipInfoText(blip, params.advanced[i][1], params.advanced[i][2] or nil)
		elseif params.advanced[i].type == 'infoHeader' then
			AddBlipInfoHeader(blip, params.advanced[i][1], params.advanced[i][2] or nil)
		elseif params.advanced[i].type == 'image' then
			SetBlipInfoImage(blip, params.advanced[i][1], params.advanced[i][2])
		end
		-- ADD OTHER ADVANCED FUNCTION HERE
	end

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(params.text)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip, params.short or false)

	if GetResourceKvpInt("hidden-blips-".. params.group) == 1 then
		SetBlipDisplay(blip, 1)
	else
		SetBlipDisplay(blip, 2)
	end

	return blip
end

function createBasicBlip(params)
	local blip = nil

	blip = AddBlipForCoord(params.coords)    
	SetBlipSprite(blip, params.sprite)
	SetBlipScale(blip, params.scale or 0.8)
	SetBlipColour(blip, params.color or 0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(params.text)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip, params.short or false)

	if GetResourceKvpInt("hidden-blips-".. params.group) == 1 then
		SetBlipDisplay(blip, 1)
	else
		SetBlipDisplay(blip, 2)
	end

	return blip
end

--[[ TOGGLE ]]
function toggleBlipGroup(group)
	local new = 0
	if GetResourceKvpInt("hidden-blips-"..group) == 1 then
		SetResourceKvpInt("hidden-blips-"..group, 0)
		new = 2
	else
		SetResourceKvpInt("hidden-blips-"..group, 1)
		new = 1
	end

	SavedKVP[group] = new

	for k,v in pairs(Blips) do
		if k == group then
			for i=1, #Blips[k] do
				SetBlipDisplay(Blips[k][i].blip, SavedKVP[group])
			end
		end
	end

	if SavedKVP[group] == 1 then
		lib.notify({
			title = locale('title'),
			description  = locale('description', group, locale('hidden')),
			type = "success",
			position = 'top'
		})
	elseif SavedKVP[group] == 2 then
		lib.notify({
			title = locale('title'),
			description  = locale('description', group, locale('visible')),
			type = "success",
			position = 'top'
		})
	end

	return true
end
exports('toggleBlipGroup', toggleBlipGroup)


--[[ THREAD ]]
Citizen.CreateThread(function()
	local current_blip = nil

	RequestStreamedTextureDict("maps_blips", 1)
	while not HasStreamedTextureDictLoaded("maps_blips") do
		Wait(0)
	end

	while true do
		Wait(100)

		if N_0x3bab9a4e4f2ff5c7() then --Is Menu Open
			local blip = DisableBlipNameForVar()
			if N_0x4167efe0527d706e() then -- If blip selected on map
				if DoesBlipExist(blip) then
					if current_blip ~= blip then
						current_blip = blip
						if BLIP_INFO_DATA[blip] then
							local data = ensureBlipInfo(blip)
							N_0xec9264727eec0f28()
							ClearDisplay()
							SetTitle(data.title, data.rockstarVerified, data.rp, data.money, data.dict, data.tex)
							for _, info in next, data.info do
								if info[1] == 2 then
									AddIcon(info[2], info[3], info[4], info[5], info[6])
								else
									AddText(info[2], info[3], info[1])
								end
							end
							ShowDisplay(true)
							UpdateDisplay()
							N_0x14621bb1df14e2b2()
						else
							ShowDisplay(false)
						end
					end
				end
			else
				if current_blip then
					current_blip = nil
					ShowDisplay(false)
				end
			end
		end
	end
end)

--[[ Other Resource Stop ]]
AddEventHandler('onResourceStop', function(resourceName)
	for k,v in pairs(Blips) do
		if v.resource == resourceName then
			RemoveBlip(v.blip)
		end
	end
end)
