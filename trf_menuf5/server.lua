ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local vip = {
    'steam:1100001412a23ba'
}

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(vip) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterServerEvent('chekvip')
AddEventHandler('chekvip', function()
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("setgroup", source)
	end
end)


ESX.RegisterServerCallback('trf_ff5f5:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)