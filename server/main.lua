ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterNetEvent("policerad:startActionB")
AddEventHandler("policerad:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("policerad:startActionB", xPlayer.source) -- Client Event auf Aktionen start
			end
		end
end)

ESX.RegisterServerCallback('policerad:getItemAmount', function(source, cb, item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterNetEvent("policerad:stopActionB")
AddEventHandler("policerad:stopActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("policerad:stopActionB", xPlayer.source) -- Client Event auf Aktionen start
			end
		end
end)

RegisterServerEvent('policerad:playSoundWithinDistanceServer')
AddEventHandler('policerad:playSoundWithinDistanceServer', function(maxDistance, soundFile, soundVolume)
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name == "police" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent('policerad:playSoundWithinDistanceClient', xPlayer.source, -1, maxDistance, soundFile, soundVolume)
			end
		end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------



RegisterNetEvent("ambulancerad:startActionB")
AddEventHandler("ambulancerad:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "ambulance" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("ambulancerad:startActionB", xPlayer.source) -- Client Event auf Aktionen start
			end
		end
end)

ESX.RegisterServerCallback('ambulancerad:getItemAmount', function(source, cb, item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterNetEvent("ambulancerad:stopActionB")
AddEventHandler("ambulancerad:stopActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "ambulance" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("ambulancerad:stopActionB", xPlayer.source) -- Client Event auf Aktionen start
			end
		end
end)

RegisterServerEvent('ambulancerad:playSoundWithinDistanceServer')
AddEventHandler('ambulancerad:playSoundWithinDistanceServer', function(maxDistance, soundFile, soundVolume)
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name == "ambulance" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent('ambulancerad:playSoundWithinDistanceClient', xPlayer.source, -1, maxDistance, soundFile, soundVolume)
			end
		end
end)



