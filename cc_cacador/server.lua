--[ SCRIPT DESENVOLVIDO POR CARIOCA - Discord: discord.gg/cariocacommunity]---------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp = {}
Tunnel.bindInterface("cc_cacador",emp)

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

RegisterServerEvent('cc_cacador:permissao')
AddEventHandler('cc_cacador:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	TriggerClientEvent('cc_cacador:permissao',player)
end)


function emp.checkWeight(mochila)
	local source = source
	local user_id = vRP.getUserId(source)
	if true then
		if user_id then
			numCouro = math.random(1,6)
			numCarne = math.random(1,14)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("couro")*numCouro+vRP.getItemWeight("carne")*numCarne <= vRP.getInventoryMaxWeight(user_id) then
				return true
			else
				return false
			end
		end
	end
end

RegisterServerEvent('cc_cacador:abaterpronto')
AddEventHandler('cc_cacador:abaterpronto',function(abaterpronto)
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if true then
	vRP.giveInventoryItem(user_id,"carne",numCarne)
	TriggerClientEvent("itensNotify",source,"sucesso","Coletou","carne",numCarne,vRP.format(vRP.getItemWeight("carne")*parseInt(numCarne)))

    vRP.giveInventoryItem(user_id,"couro",numCouro)
	TriggerClientEvent("itensNotify",source,"sucesso","Coletou","couro",numCouro,vRP.format(vRP.getItemWeight("couro")*parseInt(numCouro)))
	end
end)

RegisterServerEvent('cc_cacador:enviarordens')
AddEventHandler('cc_cacador:enviarordens',function()
	local source = source
	local user_id = vRP.getUserId(source)

	vRP.giveInventoryItem(user_id,"wbody|WEAPON_MUSKET",1)
	TriggerClientEvent("itensNotify",source,"sucesso","Coletou","wbody|WEAPON_MUSKET",1,vRP.format(vRP.getItemWeight("wbody|WEAPON_MUSKET")*parseInt(1)))

    vRP.giveInventoryItem(user_id,"wammo|WEAPON_MUSKET",20)
	TriggerClientEvent("itensNotify",source,"sucesso","Coletou","wammo|WEAPON_MUSKET",1,vRP.format(vRP.getItemWeight("wammo|WEAPON_MUSKET")*parseInt(20)))

	vRP.giveInventoryItem(user_id,"wbody|WEAPON_KNIFE",1)
	TriggerClientEvent("itensNotify",source,"sucesso","Coletou","wbody|WEAPON_KNIFE",1,vRP.format(vRP.getItemWeight("wbody|WEAPON_KNIFE")*parseInt(1)))
	
end)

RegisterServerEvent('cc_cacador:coletararmas')
AddEventHandler('cc_cacador:coletararmas',function()
	local source = source
	local user_id = vRP.getUserId(source)
	vRPclient.replaceWeapons(source,{})
	vRP.tryGetInventoryItem(user_id,"wammo|WEAPON_MUSKET",20)
	vRP.tryGetInventoryItem(user_id,"wbody|WEAPON_KNIFE",1)
	vRP.tryGetInventoryItem(user_id,"wbody|WEAPON_MUSKET",1)
end)

function emp.checkCrimeRecord()
	local source = source
	local user_id = vRP.getUserId(source)
		if checagemCriminal == 1 then 
			 if user_id then
			 local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			 local tempo = json.decode(value)
				 if tempo ~= nil then
					 TriggerClientEvent("Notify",source,"negado","Não contratamos pessoas com <b>Ficha Criminal</b>.",10000)
					 return false
				 else
					 return true
				 end
			 end
		else
			return true
		end
 end
