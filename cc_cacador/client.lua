--[ SCRIPT DESENVOLVIDO POR CARIOCA - Discord: https://discord.gg/78sERGaWQm ]---------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------

emp = Tunnel.getInterface("cc_cacador")

--[ VARIAVEIS ]-----------------------------------------------------------------------------------------------------------------

local process = false

local animaisEntity = {}

local faca = 0
local abaterpronto = 0
local deletarentidade = false
local mochila = false

local source = source
local user_id = vRP.getUserId(source)
local player = vRP.getUserSource(user_id)

emservico = false

local posicoesAnimais = {
	[1] = { ['id'] = 1, ['x'] = -1505.2, ['y'] = 4887.39, ['z'] = 78.38 },
	[2] = { ['id'] = 2, ['x'] = -1164.68, ['y'] = 4806.76, ['z'] = 223.11 },
	[3] = { ['id'] = 3, ['x'] = -1410.63, ['y'] = 4730.94, ['z'] = 44.0369 },
	[4] = { ['id'] = 4, ['x'] = -1377.29, ['y'] = 4864.31, ['z'] = 134.162 },
	[5] = { ['id'] = 5, ['x'] = -1697.63, ['y'] = 4652.71, ['z'] = 22.2442 },
	[6] = { ['id'] = 6, ['x'] = -1259.99, ['y'] = 5002.75, ['z'] = 151.36 },
	[7] = { ['id'] = 7, ['x'] = -960.91, ['y'] = 5001.16, ['z'] = 183.0 },
}

--[ PERMISSAO ]-----------------------------------------------------------------------------------------------------------------

RegisterNetEvent('cc_cacador:permissao')
AddEventHandler('cc_cacador:permissao',function()
	if true then
		emservico = true
		parte = 0
		destino = math.random(1,16)
		TriggerEvent("Notify","sucesso","Voce entrou em <b>Serviço</b>!")
	end
end)

--[ CANCELANDO ]-----------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		if not servico then
		--print('threadcancelar')
			if IsControlJustPressed(0,168) and emservico then
				TriggerEvent('cc_cacador:cancelar')
			end
		end
	Citizen.Wait(1)
	end
end)

RegisterNetEvent('cc_cacador:cancelar')
AddEventHandler('cc_cacador:cancelar',function()
	local source = source
	if nveh then
		TriggerServerEvent("trydeleteveh",VehToNet(nveh))
		nveh = nil
		end
		for i = 1,#animaisEntity do
			DeletePed(animaisEntity[i])
		end
		animaisEntity = {}
		emservico = false
		TriggerServerEvent('cc_cacador:coletararmas')
		TriggerEvent('cancelando',false)
		RemoveBlip(AnimalBlip)
		vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
		TriggerEvent("Notify","negado","Voce <b>saiu</b> de serviço!")
		parte = 0
end)

--[ THREAD ]----------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if emservico == false then
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			if Vdist(CoordenadaX,CoordenadaY,CoordenadaZ,x,y,z) < 5.1 then
				idle = 5
					DrawMarker(23, CoordenadaX, CoordenadaY, CoordenadaZ-0.98, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				if Vdist(CoordenadaX,CoordenadaY,CoordenadaZ,x,y,z) <= 1.2 then
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CoordenadaX,CoordenadaY,CoordenadaZ, true ) <= 1.1  then
						DrawText3D(CoordenadaX,CoordenadaY,CoordenadaZ, "Pressione [~p~E~w~] para coletar seus equipamentos de ~p~CAÇA~w~.")
					end
					if IsControlJustPressed(1,38) then
						mochila = true
						if emp.checkCrimeRecord() then
							if emp.checkWeight(mochila) then
								if not process then
								faca = 1
								abaterpronto = 1
								mochila = true
								deletarentidade = true
								process = true
								TriggerEvent('cancelando',true)
								TriggerEvent("progress",8000,"Coletando")
								FreezeEntityPosition(ped,true)
								vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									SetTimeout(8000,function()
									process = false
									TriggerEvent('cancelando',false)
									FreezeEntityPosition(ped,false)
									TriggerServerEvent('cc_cacador:enviarordens')
									vRP._stopAnim(false)
									Fade(1200)
									TriggerServerEvent('cc_cacador:permissao')
									emservico = true
									TriggerEvent("Notify","sucesso","Pegue a <b>Motocicleta</b> no estacionamento, e vá <b>caçar</b>!")
									spawnBlazer()
									TriggerEvent('cc_cacador:spawnanimal')
									end)
								end
							else
								TriggerEvent("Notify","negado","<b>Mochila</b> cheia ou <b>itens insuficientes</b> para o trabalho.",10000)
							end
						end
					end
				end
			end
		end
	end
		Citizen.Wait(idle)
	end
end)

RegisterNetEvent('cc_cacador:spawnanimal')
AddEventHandler('cc_cacador:spawnanimal',function()
	if true then
	modelRequest("a_c_deer")
		for i = 1,7 do
		Animal = CreatePed(5, GetHashKey('a_c_deer'), posicoesAnimais[i].x,posicoesAnimais[i].y,posicoesAnimais[i].z, 0.0, true, false)
		TaskWanderStandard(Animal, true, true)
		SetEntityAsMissionEntity(Animal, true, true)
		local AnimalBlip = AddBlipForEntity(Animal)
		SetBlipSprite(AnimalBlip, 9)
		SetBlipColour(AnimalBlip, 1)
		SetBlipAlpha(AnimalBlip, 30)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Deer - Animal')
		EndTextCommandSetBlipName(AnimalBlip)
		table.insert(animaisEntity,i,Animal)
		TriggerEvent('cc_cacador:abater')
	end
end
end)

local carioca = true

Citizen.CreateThread(function()
	while true do
		local idle = 750
		if emservico then
			for i = 1,#animaisEntity do
				CdsAnimal = GetEntityCoords(animaisEntity[i])
				vidaAnimal = GetEntityHealth(animaisEntity[i])
				local user_id = vRP.getUserId(source)
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
				local distanciaanimal = GetDistanceBetweenCoords(x,y,z,CdsAnimal.x,CdsAnimal.y,CdsAnimal.z,false)
				if distanciaanimal <= 1.3 and vidaAnimal <= 0 then
					if not IsPedInAnyVehicle(ped) then
						print("AAAAAAAAA")
						idle = 5

						DrawText3Ds(CdsAnimal.x,CdsAnimal.y,CdsAnimal.z+0.35,"Pressione [~p~E~w~] para ~p~ABATER~w~ o veado.")
						if IsControlJustPressed(0,38) then
							idle = 750
							TriggerEvent('cancelando',false)
							if DoesEntityExist(animaisEntity[i]) == 1 then
								if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
									if emp.checkWeight(mochila) then
									SetEntityAsMissionEntity(animaisEntity[i], false, false)
										if DoesEntityExist(animaisEntity[i]) then
											deletarentidade = true
										end
										vRP._playAnim(false,{{"amb@medic@standing@kneel@base","base"}},true)
										vRP._playAnim(false,{{"anim@gangops@facility@servers@bodysearch@","player_search"}},true)
										SetTimeout(6000,function()
										vRP._stopAnim(false)
										if abaterpronto == 1 then
											TriggerServerEvent("cc_cacador:abaterpronto",abaterpronto)
											abaterpronto = 0
										end
											TriggerEvent("cc_cacador:deletarentidade",animaisEntity[i])
											if deletarentidade == true then
												table.remove(animaisEntity,i)
												deletarentidade = false
												mochila = true
												carioca = true
												SetTimeout(1000,function()
												abaterpronto = 1
												end)
											end
										end)
									elseif not mochila == false then
										TriggerEvent("Notify","negado","<b>Mochila</b> cheia ou <b>itens insuficientes</b> para o trabalho.",10000)
										mochila = false
									end
								elseif faca == 1 then
									TriggerEvent("Notify","negado","Você precisa pegar uma <b>Faca</b>!")
									faca = 0
								end
							end
						end	
					end
				elseif distanciaanimal > 1700 then
					TriggerEvent("Notify","negado","Você está se <b>distanciando</b> dos animais!")
					if distanciaanimal > 1800 then
						TriggerEvent('cc_cacador:cancelar')
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

RegisterNetEvent("cc_cacador:deletarentidade")
AddEventHandler("cc_cacador:deletarentidade", function(Entity)
	if deletarentidade == true then
		DeletePed(Entity)
	end
end)

function Fade(time)
	DoScreenFadeOut(800)
	Wait(time)
	DoScreenFadeIn(800)
end

--[ VEICULO ]-----------------------------------------------------------------------------------------------------------

function spawnBlazer()
	local mhash = "blazer"
	if not nveh then
	 while not HasModelLoaded(mhash) do
	  RequestModel(mhash)
		Citizen.Wait(10)
	 end
		local ped = PlayerPedId()
		local x,y,z = vRP.getPosition()
		nveh = CreateVehicle(mhash,-777.22, 5590.62, 33.49+0.5,258.31,true,false)
		SetVehicleIsStolen(nveh,false)
		SetVehicleOnGroundProperly(nveh)
		SetVehicleAsNoLongerNeeded(nveh)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehicleDirtLevel(nveh,0.0)
		SetVehRadioStation(nveh,"OFF")
		SetVehicleNeedsToBeHotwired(nveh,false)
		SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
		SetModelAsNoLongerNeeded(mhash)
		SetVehicleFuelLevel(nveh, 50.0)
	end
end


--[ FUNÇÃO TEXTO ]-----------------------------------------------------------------------------------------------------------

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 20)
end

function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(10)
	end
end

--[ SCRIPT DESENVOLVIDO POR CARIOCA - Discord: https://discord.gg/78sERGaWQm ]---------------------------------------------------
