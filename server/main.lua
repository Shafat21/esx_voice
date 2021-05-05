
-- 𝐃𝐨𝐧'𝐭 𝐄𝐝𝐢𝐭 𝐮𝐧𝐥𝐞𝐬𝐬 𝐘𝐨𝐮 𝐤𝐧𝐨𝐰 𝐰𝐡𝐚𝐭 𝐚𝐫𝐞 𝐲𝐨𝐮 𝐝𝐨𝐢𝐧𝐠.

-- 𝗗𝗼𝗻'𝘁 𝗘𝗱𝗶𝘁 𝘂𝗻𝗹𝗲𝘀𝘀 𝗬𝗼𝘂 𝗸𝗻𝗼𝘄 𝘄𝗵𝗮𝘁 𝗮𝗿𝗲 𝘆𝗼𝘂 𝗱𝗼𝗶𝗻𝗴.

-- 𝘋𝘰𝘯'𝘵 𝘌𝘥𝘪𝘵 𝘶𝘯𝘭𝘦𝘴𝘴 𝘠𝘰𝘶 𝘬𝘯𝘰𝘸 𝘸𝘩𝘢𝘵 𝘢𝘳𝘦 𝘺𝘰𝘶 𝘥𝘰𝘪𝘯𝘨.

-- 𝘿𝙤𝙣'𝙩 𝙀𝙙𝙞𝙩 𝙪𝙣𝙡𝙚𝙨𝙨 𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙬𝙝𝙖𝙩 𝙖𝙧𝙚 𝙮𝙤𝙪 𝙙𝙤𝙞𝙣𝙜.

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- 𝐃𝐨𝐧'𝐭 𝐄𝐝𝐢𝐭 𝐮𝐧𝐥𝐞𝐬𝐬 𝐘𝐨𝐮 𝐤𝐧𝐨𝐰 𝐰𝐡𝐚𝐭 𝐚𝐫𝐞 𝐲𝐨𝐮 𝐝𝐨𝐢𝐧𝐠.

-- 𝗗𝗼𝗻'𝘁 𝗘𝗱𝗶𝘁 𝘂𝗻𝗹𝗲𝘀𝘀 𝗬𝗼𝘂 𝗸𝗻𝗼𝘄 𝘄𝗵𝗮𝘁 𝗮𝗿𝗲 𝘆𝗼𝘂 𝗱𝗼𝗶𝗻𝗴.

-- 𝘋𝘰𝘯'𝘵 𝘌𝘥𝘪𝘵 𝘶𝘯𝘭𝘦𝘴𝘴 𝘠𝘰𝘶 𝘬𝘯𝘰𝘸 𝘸𝘩𝘢𝘵 𝘢𝘳𝘦 𝘺𝘰𝘶 𝘥𝘰𝘪𝘯𝘨.

-- 𝘿𝙤𝙣'𝙩 𝙀𝙙𝙞𝙩 𝙪𝙣𝙡𝙚𝙨𝙨 𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙬𝙝𝙖𝙩 𝙖𝙧𝙚 𝙮𝙤𝙪 𝙙𝙤𝙞𝙣𝙜.

RegisterNetEvent("policerad:startActionB")
AddEventHandler("policerad:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("policerad:startActionB", xPlayer.source) -- Client Event on Actions Start
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
				TriggerClientEvent("policerad:stopActionB", xPlayer.source) -- Client Event on Actions Start
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

RegisterNetEvent("ambulancerad:startActionB")
AddEventHandler("ambulancerad:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "ambulance" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("ambulancerad:startActionB", xPlayer.source) -- Client Event on Actions Start
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
				TriggerClientEvent("ambulancerad:stopActionB", xPlayer.source) -- Client Event on Actions Start
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



