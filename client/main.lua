local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local voice = {default = 15.0, shout = 30.0, whisper = 3.0, police = 15.0, current = 0, level = nil}

ESX                           = nil
local PlayerData              = {}
local Busy 					  = false
local Nearby                  = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function drawLevel(ped, r, g, b, a)
	SetTextFont(4)
	SetTextScale(0.4, 0.4)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(_U('voice', voice.level))
	if IsPedInAnyVehicle(ped, false) then
		EndTextCommandDisplayText(0.170, 0.850)
	else
		EndTextCommandDisplayText(0.930, 0.964)
	end
	
end

function drawPolice(ped, string,r, g, b, a)
	SetTextFont(4)
	SetTextScale(0.4, 0.4)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(string)
	if IsPedInAnyVehicle(ped, false) then
		EndTextCommandDisplayText(0.170, 0.820)
	else
		EndTextCommandDisplayText(0.930, 0.934)
	end
end


function drawAmbulance(ped, string,r, g, b, a)
	SetTextFont(4)
	SetTextScale(0.4, 0.4)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(string)
	if IsPedInAnyVehicle(ped, false) then
		EndTextCommandDisplayText(0.170, 0.820)
	else
		EndTextCommandDisplayText(0.930, 0.934)
	end
end

AddEventHandler('onClientMapStart', function()
	if voice.current == 0 then
		NetworkSetTalkerProximity(voice.default)
	elseif voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
	elseif voice.current == 3 then
		NetworkSetTalkerProximity(voice.police)
	elseif voice.current == 4 then
		NetworkSetTalkerProximity(voice.ambulance)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if IsControlJustPressed(1, Keys['H']) and IsControlPressed(1, Keys['LEFTSHIFT']) then
			voice.current = (voice.current + 1) % 3
			if voice.current == 0 then
				NetworkSetTalkerProximity(voice.default)
				voice.level = _U('normal')
			elseif voice.current == 1 then
				NetworkSetTalkerProximity(voice.shout)
				voice.level = _U('shout')
			elseif voice.current == 2 then
				NetworkSetTalkerProximity(voice.whisper)
				voice.level = _U('whisper')
			end
		end

		if voice.current == 0 then
			voice.level = _U('normal')
		elseif voice.current == 1 then
			voice.level = _U('shout')
		elseif voice.current == 2 then
			voice.level = _U('whisper')
		end

		local playerped = GetPlayerPed(-1)

		if NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(playerped, 41, 128, 185, 255)
		elseif not NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(playerped, 185, 185, 185, 255)
		end
	end
end)

-- THREADS

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        --if IsControlPressed(2, Keys["Z"]) and GetLastInputMethod(2) and Busy == false and PlayerData.job.name ~= nil and PlayerData.job.name == "police" then
                --TriggerServerEvent("policerad:playSoundWithinDistanceServer", 10, "copradiooff", 0.7) 
            -- Aktiviere policerad Talkie
        --elseif not IsControlPressed(2, Keys["Z"]) and GetLastInputMethod(2) and Busy == true and PlayerData.job.name ~= nil and PlayerData.job.name == "police" then
            -- Deaktiviere policerad Talkie
                --TriggerServerEvent("policerad:playSoundWithinDistanceServer", 10, "copradiooff", 0.7) 
		--else	
		--end

		if IsControlJustPressed(2, Keys["Z"]) and GetLastInputMethod(2) and PlayerData.job.name ~= nil and PlayerData.job.name == "police" then
			if Busy == true then
				TriggerServerEvent("policerad:stopActionB") -- Aktion für andere Personen stoppen
                EnableActions(GetPlayerPed(-1))
                TriggerEvent("policerad:stopAnim", source)
				Busy = false
			else
				TriggerServerEvent("policerad:startActionB") -- Aktion für andere Personen starten
                DisableActions(GetPlayerPed(-1))
                TriggerEvent("policerad:startAnim", source)
				Busy = true
			end
		end

		local playerped = GetPlayerPed(-1)

		if PlayerData.job and PlayerData.job.name == "police" then
			if Busy == true then
				if not NetworkIsPlayerTalking(PlayerId()) then
					drawPolice(playerped,"Radio [ON]",125,128,185,255)
				elseif NetworkIsPlayerTalking(PlayerId()) then
					drawPolice(playerped,"Radio [Talking]", 41,128,185,255)
				end
			else
				drawPolice(playerped,"Radio [OFF]",175,227,217,185)
			end
		end
    end
end)

-- THREADS

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

		if IsControlJustPressed(2, Keys["Z"]) and GetLastInputMethod(2) and PlayerData.job.name ~= nil and PlayerData.job.name == "ambulance" then
			if Busy == true then
				TriggerServerEvent("ambulancerad:stopActionB") -- Aktion für andere Personen stoppen
                EnableActions(GetPlayerPed(-1))
                TriggerEvent("ambulancerad:stopAnim", source)
				Busy = false
			else
				TriggerServerEvent("ambulancerad:startActionB") -- Aktion für andere Personen starten
                DisableActions(GetPlayerPed(-1))
                TriggerEvent("ambulancerad:startAnim", source)
				Busy = true
			end
		end

		local playerped = GetPlayerPed(-1)

		if PlayerData.job and PlayerData.job.name == "ambulance" then
			if Busy == true then
				if not NetworkIsPlayerTalking(PlayerId()) then
					drawPolice(playerped,"Radio [ON]",125,128,185,255)
				elseif NetworkIsPlayerTalking(PlayerId()) then
					drawPolice(playerped,"Radio [Talking]", 41,128,185,255)
				end
			else
				drawPolice(playerped,"Radio [OFF]",175,227,217,185)
			end
		end
    end
end)
-- FUNCTIONS

function EnableActions(ped)
	EnableControlAction(1, 140, true)
	EnableControlAction(1, 141, true)
	EnableControlAction(1, 142, true)
	EnableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, false) -- Disable weapon firing
end

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

-- EVENTS

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    Citizen.Wait(5000)
end)

RegisterNetEvent("policerad:startActionB") -- Aktion Person B
AddEventHandler("policerad:startActionB", function()
    NetworkSetTalkerProximity(0.00) -- Sprachreichweite wird unbegrenzt
end)

RegisterNetEvent("policerad:stopActionB") -- Aktion Person B
AddEventHandler("policerad:stopActionB", function()
    NetworkSetTalkerProximity(6.00) -- Sprachreichweite wird 6 Meter
end)

RegisterNetEvent("policerad:startAnim") -- Event, um andere Personen Animation starten zu lassen
AddEventHandler("policerad:startAnim", function(player)
    Citizen.CreateThread(function()
    	if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        RequestAnimDict("random@arrests")
        while not HasAnimDictLoaded( "random@arrests") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(GetPlayerPed(-1), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
    end
    end)
end)
RegisterNetEvent("policerad:stopAnim")
AddEventHandler("policerad:stopAnim", function(player)
    Citizen.CreateThread(function()
        Citizen.Wait(1)
        ClearPedTasks(GetPlayerPed(-1))
    end)
    --TriggerServerEvent("policerad:playSoundWithinDistanceServer",10.0, 'copradiooff', 0.7)
end)

RegisterNetEvent('policerad:playSoundWithinDistanceClient')
AddEventHandler('policerad:playSoundWithinDistanceClient', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)


----------------------------


RegisterNetEvent("ambulancerad:startActionB") -- Aktion Person B
AddEventHandler("ambulancerad:startActionB", function()
    NetworkSetTalkerProximity(0.00) -- Language range is unlimited
end)

RegisterNetEvent("ambulancerad:stopActionB") -- Aktion Person B
AddEventHandler("ambulancerad:stopActionB", function()
    NetworkSetTalkerProximity(6.00) -- Speech range is 6 meters
end)

RegisterNetEvent("ambulancerad:startAnim") -- Event, um andere Personen Animation starten zu lassen
AddEventHandler("ambulancerad:startAnim", function(player)
    Citizen.CreateThread(function()
    	if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        RequestAnimDict("random@arrests")
        while not HasAnimDictLoaded( "random@arrests") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(GetPlayerPed(-1), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
    end
    end)
end)
RegisterNetEvent("ambulancerad:stopAnim")
AddEventHandler("ambulancerad:stopAnim", function(player)
    Citizen.CreateThread(function()
        Citizen.Wait(1)
        ClearPedTasks(GetPlayerPed(-1))
    end)
    --TriggerServerEvent("policerad:playSoundWithinDistanceServer",10.0, 'copradiooff', 0.7)
end)

RegisterNetEvent('ambulancerad:playSoundWithinDistanceClient')
AddEventHandler('ambulancerad:playSoundWithinDistanceClient', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)