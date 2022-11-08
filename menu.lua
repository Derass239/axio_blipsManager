-----------------------------------------------
------ Axio Blips Manager by Derass#4974 ------
-----------------------------------------------

lib.locale()

RegisterKeyMapping('openBlipsManager', locale('keybind'), 'keyboard', "F12")

RegisterCommand('openBlipsManager', function()
	setup()
end)

local elements = {}

lib.registerMenu({
	id = "blipManager_menu",
	title = locale('title'),
	position = 'top-right',
	onCheck = function(selected, checked, args)
		toggleBlipGroup(elements[selected].label)
	end,
	options = {}
})

function setup()
	elements = {}

	for k, v in pairs(SavedKVP) do
		local state = GetResourceKvpInt("hidden-blips-"..k)
		local defaultIndex
		if state == 1 then defaultIndex = false else defaultIndex = true end
		
		table.insert(elements, {label = k, checked = defaultIndex})
	end

	if #elements > 0 then
		lib.setMenuOptions('blipManager_menu', elements)
		lib.showMenu('blipManager_menu')
	else
		lib.notify({
			title = locale('title'),
			description  = locale('noBlips'),
			type = "error",
			position = 'top'
		})
	end
end

