ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('setgroup')
AddEventHandler('setgroup', function()
    group = true
end)    

Citizen.CreateThread(function()
    while true do
        Citizen.Wait( 2000 )

        if NetworkIsSessionStarted() then
            TriggerServerEvent( "chekvip")
        end
    end
end )

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('five_society:getSocietyMoney', function(money)
			societymoney = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job.name)
	end
end
Citizen.CreateThread(function()
    ESX.TriggerServerCallback('trf_ff5f5:getUsergroup', function(group)
        playergroup = group
    end)
end)
Admin = {
    showcoords = false,
    showcrosshair = false,
    ghostmode = false,
    godmode = false,
    showName = false,
    gamerTags = {},
    ItemSelected = {},
    weapontr = {}
}





function menu()




    local ped1 = {
        gang = {
            "Families 1",
            "Families 2",
            "Ballas 1",
            "Ballas 2",
            "Ballas 3",
            "Vagos 1",
            "Vagos 2",
            "Vagos 3",
            "Biker 1",
            "Biker 2",
            "Biker 3",
            "Marabunta 1",
            "Marabunta 2",
            "Marabunta 3",
            "Cartel 1",
            "Cartel 2",
            "Cartel 3",
            "Cartel 4",
            "Cartel 5"
        },

        list = 1,


    }





    local ped2 = {

        autre = {
            "Black ops",
            "Clown",
            "Cosmonaute",
            "camionneur",
            "Costume",
            "Prisonnier 1",
            "Prisonnier 2",
            "pnj 1",
            "pnj 2",
            "Lester",
            "Pretre",
            "Coach Tennis",
            "Grosse tete",
            "je sais pas",
            "buzz l'éclair de wish",
            "mani",
            "porage",
            "Mexicain des plages",
            "cirque man",
            "Secretaire",
            "Tony Price"



        },
        list = 1,

    }

    local ped3 = {

        gta = {
            "Franklin",
            "Michael",
            "Trevor"




        },
        list = 1,

    }


    local Menu = {
        gs = {
            "30 km/h",
            "50 km/h",
            "80 km/h",
            "120 km/h",
            "Désactiver"
        },
    
        list = 1,
    }
    local Menu2 = {
        gs = {
            "Avant Gauche",
            "Avant Droite",
            "Arrière Gauche",
            "Arrière Droite"
        },
    
        list = 1,
    }
    
    local Menu3 = {
        gs = {
            "Avant Gauche",
            "Avant Droite",
            "Arrière Gauche",
            "Arrière Droite"
        },
    
        list = 1,
    }
    


    local menuf5 = RageUI.CreateMenu(Config.namserv, "Menu Personel", 0, 10, 'commonmenu', 'interaction_bgd', 255, 0, 0, 0)
    local portefeuil = RageUI.CreateSubMenu(menuf5, Config.namserv,"Portefeuille")
    local gsveh = RageUI.CreateSubMenu(menuf5, Config.namserv,"Gestion Vehicule")
    local gestion = RageUI.CreateSubMenu(menuf5, Config.namserv,"Gestion")
    local inventory = RageUI.CreateSubMenu(gestion, Config.namserv,"Gestion")
    local arme = RageUI.CreateSubMenu(gestion, Config.namserv,"Arme")
    local armeg = RageUI.CreateSubMenu(arme, Config.namserv,"Arme")
    local jetdo = RageUI.CreateSubMenu(inventory, Config.namserv, "Interaction")
    local menuvip = RageUI.CreateSubMenu(menuf5, Config.namserv, "VIP")
    local menuped = RageUI.CreateSubMenu(menuvip, Config.namserv, "Différent ped")
    local menuprops = RageUI.CreateSubMenu(menuvip, Config.namserv, "Différent props")
    local suppr = RageUI.CreateSubMenu(menuprops, Config.namserv, "Vous permet de supprimer un objet")
    local admin = RageUI.CreateSubMenu(menuf5, Config.namserv, "Administration")
    local donne = RageUI.CreateSubMenu(portefeuil, Config.namserv, "Donne de l'argent")
    local donnesal = RageUI.CreateSubMenu(portefeuil, Config.namserv, "Donne de l'argent sal")
    local anim = RageUI.CreateSubMenu(menuf5, Config.namserv, "Différentes interaction")
    local vet = RageUI.CreateSubMenu(menuf5, Config.namserv, "Interaction vetement")


    



    ItemSelected = {}

    object = {}
    OtherItems = {}


    local Ped = GetPlayerPed(-1)
    local GetSourcevehicle = GetVehiclePedIsIn(Ped, false)
    local Vengine = GetVehicleEngineHealth(GetSourcevehicle)/10
    local Vengine = math.floor(Vengine)
    local fuel = GetVehicleFuelLevel(GetSourcevehicle)





    RageUI.Visible(menuf5, not RageUI.Visible(menuf5))

    while menuf5 do
        
        Citizen.Wait(0)



        RageUI.IsVisible(menuf5,true,true,true,function()

            RageUI.Separator("____________________")


            RageUI.ButtonWithStyle("Portefeuil",nil ,{},true, function(Hovered, Active, Selected)
            end, portefeuil)



            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                RageUI.ButtonWithStyle('Gestion', "Gestion de votre inventaire / Arme", {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
                    if (Selected) then
                    end 
                end)
            
            else
                RageUI.ButtonWithStyle("Gestion ","Gestion de votre inventaire / Arme" ,{},true, function(Hovered, Active, Selected)
                end, gestion)

            end

            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                RageUI.ButtonWithStyle('Vetement', nil, {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
                    if (Selected) then
                    end 
                end)
            
            else
                RageUI.ButtonWithStyle("Vetement ",nil ,{},true, function(Hovered, Active, Selected)
                end, vet)

            end
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                RageUI.ButtonWithStyle("Animation",nil ,{RightBadge = RageUI.BadgeStyle.Lock},false, function(Hovered, Active, Selected)
                end)
            else
                RageUI.ButtonWithStyle("Animation ",nil ,{},true, function(Hovered, Active, Selected)
                end, anim)
            end


            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                RageUI.ButtonWithStyle("Gestion Vehicule",nil ,{},true, function(Hovered, Active, Selected)
                end, gsveh)
            else
                RageUI.ButtonWithStyle('Gestion Vehicule', nil, {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
                    if (Selected) then
                    end 
                end)
            end

            if group == true then  
                RageUI.ButtonWithStyle("Menu ViP ",nil ,{},true, function(Hovered, Active, Selected)
                end, menuvip)
            else
                RageUI.ButtonWithStyle('Menu vip', nil, {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
                    if (Selected) then
                    end 
                end)
            end 


            if playergroup == "admin" or playergroup == "superadmin" or playergroup == "mod" or playergroup == "_dev" then
                RageUI.ButtonWithStyle("Menu Admin ",nil ,{},true, function(Hovered, Active, Selected)
                end, admin)
            else
                RageUI.ButtonWithStyle('Menu Administration', nil, {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
                    if (Selected) then
                    end 
                end)
            end  




        end, function()
        end)


        
        RageUI.IsVisible(portefeuil,true,true,true,function()

            for i=1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == "bank" then
                    bank = ESX.PlayerData.accounts[i].money
                end
            end

            for i=1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == "black_money" then
                    black_money = ESX.PlayerData.accounts[i].money
                end
            end

            RageUI.Separator( '~g~Vous etes : '..ESX.PlayerData.job.label .." "..ESX.PlayerData.job.grade_label)

            RageUI.Separator( '~g~ organisations : '..ESX.PlayerData.job2.label .." "..ESX.PlayerData.job2.grade_label)



            RageUI.ButtonWithStyle("Argent sur vous",nil,{RightLabel = "~g~$" ..ESX.PlayerData.money},true, function(Hovered, Active, Selected)
            end,donne)

            RageUI.ButtonWithStyle("Argent en Banque",nil,{RightLabel = "~g~$"..bank},true, function(Hovered, Active, Selected)
            end)

            RageUI.ButtonWithStyle("Argent sale",nil,{RightLabel = "~g~$"..black_money},true, function(Hovered, Active, Selected)
            end,donnesal)

            RageUI.ButtonWithStyle('Regarder sa carte d\'identité', nil, {RightLabel = nil }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId())) 
                end
                
            end)

            RageUI.ButtonWithStyle('Montrer sa carte d\'identité', nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 2.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
					else
						ESX.ShowNotification('Aucun joueur à qui montrer  !')
					end
				end
			end)



            RageUI.ButtonWithStyle('Regarder son permis de conduire', nil, {RightLabel = nil }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), "driver") 

                end
    
            end)


            RageUI.ButtonWithStyle('Montrer son permis de conduire', nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 2.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), "driver")
					else
						ESX.ShowNotification('Aucun joueur à qui montrer  !')
					end
				end
			end)


            RageUI.ButtonWithStyle('Montrer son ppa', nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 2.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), "weapon")
					else
						ESX.ShowNotification('Aucun joueur à qui montrer  !')
					end
				end
			end)


            RageUI.ButtonWithStyle('Regarder son ppa', nil, {RightLabel = nil }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), "weapon") 

                end
    
            end)
        end, function()
        end)

        RageUI.IsVisible(gsveh,true,true,true,function()

            RageUI.Separator("État du Vehicule~s~ : ~b~ "..Vengine.."%")

            RageUI.Separator("Niveau d'éssence : ~b~"..math.ceil(fuel).." %")

            RageUI.Checkbox("Eteindre/Allumer Le moteur",nil , moteur,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    moteur = Checked
                    if Checked then
                        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), false, false, true)
                        SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), false)                        
                    else
                        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), true, false, true)
                        SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), false)

                    end
                end
            end)


            RageUI.Checkbox("Ouvrir/Fermer le coffre",nil , coffre,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    coffre = Checked
                    if Checked then
                        SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                    else
                        SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                    end
                end
            end)

            RageUI.Checkbox("Ouvrir/Fermer le Capot",nil , capot,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    capot = Checked
                    if Checked then
                        SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                    else
                        SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                    end
                end
            end)


            RageUI.List('Limitateur', Menu.gs, Menu.list, nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Active) then
                    if Selected then
                        if Index == 1 then
                            SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 8.1)
                        elseif Index == 2 then
                            SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 13.7)
                        elseif Index == 3 then
                            SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 22.0)
                        elseif Index == 4 then
                            SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 33.2)
                        elseif Index == 5 then
                            SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)

                        end
                    end
                end
                    Menu.list = Index;
            end)

            RageUI.List('Ouvrir/Fermer les Fenêtres', Menu2.gs, Menu2.list, nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Active) then
                    if Selected then
                        if Index == 1 then
                            if not trff then
                                trff = true
                                RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 0) 
                            elseif trff then
                                trff = false
                                RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 0) 
                            end                       
                         elseif Index == 2 then
                            if not trff2 then
                                trff2 = true
                                RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 1) 
                            elseif trff2 then
                                trff2 = false
                                RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 1) 
                            end                        
                        elseif Index == 3 then
                            if not trff3 then
                                trff3 = true
                                RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 2) 
                            elseif trff3 then
                                trff3 = false
                                RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 2) 
                            end                        
                        elseif Index == 4 then
                            if not trff4 then
                                trff4 = true
                                RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 3) 
                            elseif trff4 then
                                trff4 = false
                                RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 3) 
                            end                        


                        end
                    end
                end
                    Menu2.list = Index;
            end)



            RageUI.List('Ouvrir/Fermer les Portes', Menu3.gs, Menu3.list, nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Active) then
                    if Selected then
                        if Index == 1 then
                            if not trfp then
                                trfp = true
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                            elseif trfp then
                                trfp = false
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                            end                     
                         elseif Index == 2 then
                            if not trfp2 then
                                trfp2 = true
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                            elseif trfp2 then
                                trfp2 = false
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                            end                      
                        elseif Index == 3 then
                            if not trfp3 then
                                trfp3 = true
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                            elseif trfp3 then
                                trfp3 = false
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                            end                       
                        elseif Index == 4 then
                            if not four then
                                four = true
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                            elseif four then
                                four = false
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                            end                     


                        end
                    end
                end
                    Menu3.list = Index;
            end)



         
        end, function()
        end)
        RageUI.IsVisible(gestion, true, true, true, function()
            RageUI.ButtonWithStyle("Inventaire", nil, {}, true, function(Hovered, Active, Selected)
            end, inventory)

            RageUI.ButtonWithStyle("Arme", nil, {}, true, function(Hovered, Active, Selected)
            end, arme)
        end, function()
        end)

        RageUI.IsVisible(inventory, true, true, true, function()
            ESX.PlayerData = ESX.GetPlayerData()
            for i = 1, #ESX.PlayerData.inventory do
                if ESX.PlayerData.inventory[i].count > 0 then
                    RageUI.ButtonWithStyle('' ..ESX.PlayerData.inventory[i].count.. ' - ' ..ESX.PlayerData.inventory[i].label, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                            ItemSelected = ESX.PlayerData.inventory[i]
                        end 
                    end, jetdo)
                end
            end
        end, function()
        end)

        RageUI.IsVisible(arme, true, true, true, function()
            local armefdp = ESX.GetWeaponList()
            for i = 1, #armefdp, 1 do
                local armehash = GetHashKey(armefdp[i].name)
                local mm = GetAmmoInPedWeapon(PlayerPedId(), armehash)
                if HasPedGotWeapon(PlayerPedId(), armehash, false) and armefdp[i].name ~= 'WEAPON_UNARMED' then
                    RageUI.ButtonWithStyle("["..mm.."] - "..armefdp[i].label, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            Admin.weapontr = armefdp[i]
                            Admin.weapontr.hash = armehash
                        end
                    end, armeg)
                end
            end
            
        end, function()
        end)

        RageUI.IsVisible(armeg, true, true, true, function()

            RageUI.ButtonWithStyle("Jeter l'arme", nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, function(Hovered, Active, Selected)
                if Selected then
                    if IsPedOnFoot(PlayerPedId()) then
                        TriggerServerEvent('esx:removeInventoryItem', 'item_weapon', Admin.weapontr.name)
                    end
                end
            end)

            RageUI.ButtonWithStyle("Donner l'arme", nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local quantity = trf_menuadminKeyboardInput("Nombres", "", 50)
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    local pPed = GetPlayerPed(-1)
                    local coords = GetEntityCoords(pPed)
                    local x,y,z = table.unpack(coords)
                    DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)

                    if tonumber(quantity) then
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            local closestPed = GetPlayerPed(closestPlayer)

                            if IsPedOnFoot(closestPed) then
                                    TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_weapon', ItemSelected.name, tonumber(quantity))
                                else
                                    ESX.ShowNotification("Nombres d'items invalid !")
                                end
                        else
                            ESX.ShowNotification('Aucun joueur ~r~proche !')
                            end
                        end
                    end
                end)


        end, function()
        end)


        RageUI.IsVisible(jetdo, true, true, true, function()
            RageUI.ButtonWithStyle("Utiliser", nil, {RightBadge = RageUI.BadgeStyle.Heart}, true, function(Hovered, Active, Selected)
                if (Selected) then
                 if ItemSelected.usable then
                     TriggerServerEvent('esx:useItem', ItemSelected.name)
                    else
                        ESX.ShowNotification('l\'items n\'est pas utilisable', ItemSelected.label)
                    end
                end
            end) 


            RageUI.ButtonWithStyle("Jeter", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    if ItemSelected.canRemove then
                        local quantity = trf_menuadminKeyboardInput("Nombres", '', 50)
                        if tonumber(quantity) then
                            TriggerServerEvent('esx:removeInventoryItem', 'item_standard', ItemSelected.name, tonumber(quantity))
                        else
                            ESX.ShowNotification("Nombres d'items invalid !")
                        end
                    end
                end
            end)

            RageUI.ButtonWithStyle("Donner", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local quantity = trf_menuadminKeyboardInput("Nombres", "", 50)
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    local pPed = GetPlayerPed(-1)
                    local coords = GetEntityCoords(pPed)
                    local x,y,z = table.unpack(coords)
                    DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)

                    if tonumber(quantity) then
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            local closestPed = GetPlayerPed(closestPlayer)

                            if IsPedOnFoot(closestPed) then
                                    TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', ItemSelected.name, tonumber(quantity))
                                else
                                    ESX.ShowNotification("Nombres d'items invalid !")
                                end
                        else
                            ESX.ShowNotification("Aucun à qui donner !")
                            end
                        end
                    end
                end)

            

        end, function()
        end)


        RageUI.IsVisible(menuvip, true, true, true, function()


            RageUI.ButtonWithStyle("Menu Ped", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end, menuped)

            RageUI.ButtonWithStyle("Menu Props", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end, menuprops)



        end, function()
        end)

        RageUI.IsVisible(menuped,true,true,true,function()


            RageUI.ButtonWithStyle("Reprendre son apparence", "Pour se remettre en normal", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0


                    TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                            TriggerEvent('esx:restoreLoadout')
                    end)
                    end)
                    end)
            end
            end)





            RageUI.List('Gang', ped1.gang, ped1.list, nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Active) then
                    if Selected then
                        if Index == 1 then
                            createped(GetHashKey('g_m_y_famca_01'))
                        elseif Index == 2 then
                            createped(GetHashKey('g_m_y_famdnf_01'))
                        elseif Index == 3 then
                            createped(GetHashKey('g_m_y_ballaeast_01'))
                        elseif Index == 4 then
                            createped(GetHashKey('g_m_y_ballaorig_01'))
                        elseif Index == 5 then
                            createped(GetHashKey('g_m_y_ballasout_01'))
                        elseif Index == 6 then
                            createped(GetHashKey('g_m_y_mexgoon_01'))
                        elseif Index == 7 then
                            createped(GetHashKey('g_m_y_mexgoon_02'))
                        elseif Index == 8 then
                            createped(GetHashKey('g_m_y_mexgoon_03'))
                        elseif Index == 9 then
                            createped(GetHashKey('g_m_y_lost_01'))
                        elseif Index == 10 then
                            createped(GetHashKey('g_m_y_lost_02'))
                        elseif Index == 11 then
                            createped(GetHashKey('g_m_y_lost_03'))
                        elseif Index == 12 then
                            createped(GetHashKey('g_m_y_salvaboss_01'))
                        elseif Index == 13 then
                            createped(GetHashKey('g_m_y_salvagoon_01'))
                        elseif Index == 14 then
                            createped(GetHashKey('g_m_y_salvagoon_02'))
                        elseif Index == 15 then
                            createped(GetHashKey('g_m_m_armboss_01'))
                        elseif Index == 16 then
                            createped(GetHashKey('g_m_m_armgoon_01'))
                        elseif Index == 17 then
                            createped(GetHashKey('g_m_m_armlieut_01'))
                        elseif Index == 18 then
                            createped(GetHashKey('g_m_m_chigoon_01'))
                        elseif Index == 19 then
                            createped(GetHashKey('g_m_m_korboss_01'))
                        elseif Index == 20 then
                            createped(GetHashKey('g_m_m_mexboss_01'))
                        end
                    end
                end
                ped1.list = Index;
            end)

           

            

            RageUI.List('Autre', ped2.autre, ped2.list, nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Active) then
                    if Selected then
                        if Index == 1 then
                            createped(GetHashKey('s_m_y_blackops_03'))
                        elseif Index == 2 then
                            createped(GetHashKey('s_m_y_clown_01'))
                        elseif Index == 3 then
                            createped(GetHashKey('s_m_m_movspace_01'))
                        elseif Index == 4 then
                            createped(GetHashKey('s_m_m_trucker_01'))
                        elseif Index == 5 then
                            createped(GetHashKey('s_m_y_devinsec_01'))
                        elseif Index == 6 then
                            createped(GetHashKey('s_m_y_prismuscl_01'))
                        elseif Index == 7 then
                            createped(GetHashKey('s_m_y_prisoner_01'))
                        elseif Index == 8 then
                            createped(GetHashKey('ig_andreas'))
                        elseif Index == 9 then
                            createped(GetHashKey('ig_djsoljakob'))
                        elseif Index == 10 then
                            createped(GetHashKey('ig_lestercrest_2'))
                        elseif Index == 11 then
                            createped(GetHashKey('ig_priest'))
                        elseif Index == 12 then
                            createped(GetHashKey('ig_tenniscoach'))
                        elseif Index == 13 then
                            createped(GetHashKey('u_m_m_streetart_01'))
                        elseif Index == 14 then
                            createped(GetHashKey('u_m_y_juggernaut_01'))
                        elseif Index == 15 then
                            createped(GetHashKey('u_m_y_rsranger_01'))
                        elseif Index == 16 then
                            createped(GetHashKey('u_m_y_mani'))
                        elseif Index == 17 then
                            createped(GetHashKey('u_m_y_imporage'))
                        elseif Index == 18 then
                            createped(GetHashKey('u_m_m_partytarget'))
                        elseif Index == 19 then
                            createped(GetHashKey('u_m_m_griff_01'))
                        elseif Index == 20 then
                            createped(GetHashKey('u_f_m_casinoshop_01'))
                        elseif Index == 21 then
                            createped(GetHashKey('ig_tonyprince'))

                        end
                    end
                end
                    ped2.list = Index;
            end)

            RageUI.List('Michael, Francklin, Trevor', ped3.gta, ped3.list, nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Active) then
                    if Selected then
                        if Index == 1 then
                            createped(GetHashKey('player_one'))
                        elseif Index == 2 then
                            createped(GetHashKey('player_zero'))
                        elseif Index == 3 then
                            createped(GetHashKey('player_two'))
                        elseif Index == 4 then
                        end
                    end
                end
                    ped3.list = Index;
            end)



           
         
        end, function()
        end)


        RageUI.IsVisible(menuprops, true,true,true, function()
        
            
            for k, v in pairs(Config.Props) do
                RageUI.ButtonWithStyle(""..v.label.."", nil, {}, true, function(Hovered,Active,Selected)
                    if (Selected) then
                        SpawnObj(v.name, v.label)
                    end
                end)
            end

            RageUI.ButtonWithStyle("Supprimer", nil, {}, true, function(Hovered,Active,Selected)
            end,suppr)



        end, function()
        end)



        RageUI.IsVisible(suppr,true,true,true, function()

            for k,v in pairs(object) do
                if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                RageUI.ButtonWithStyle("Object: "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        local entity = NetworkGetEntityFromNetworkId(v)
                        local ObjCoords = GetEntityCoords(entity)
                        DrawMarker(0, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                    end
                    if Selected then
                        RemoveObj(v, k)
                    end
                end)
            end

        end, function()
        end)



        RageUI.IsVisible(admin, true,true,true, function()
        


            if playergroup == "admin" then
                RageUI.Separator("Vous etes ~r~[Administrateur] ")
            elseif playergroup == "superadmin" then
                RageUI.Separator("Vous etes ~r~[SuperAdmin] ")
            elseif playergroup == "_dev" then
                RageUI.Separator("Vous etes ~r~[Developpeur] ")
            elseif playergroup == "mod" then
                RageUI.Separator("Vous etes ~r~[Moderateur] ")
            end


            RageUI.Separator("Treifa il est bg oublie pas ")

            RageUI.ButtonWithStyle("Teleporter un jouer à vous", nil, {}, true, function(Hovered,Active,Selected)
                if (Selected) then
                    tpj()
                end
            end)

            RageUI.ButtonWithStyle("Téléporter sur joueur", nil, {}, true, function(Hovered,Active,Selected)
                if (Selected) then
                    tpv()
                end
            end)

            RageUI.Checkbox("God mode", description, Admin.godmode,{},function(Hovered,Ative,Selected,Checked)
                if (Selected) then       
                    godmod()
                end
            end)

            RageUI.Checkbox("Mode invisible", description, Admin.ghostmode,{},function(Hovered,Ative,Selected,Checked)
                if (Selected) then       
                    invi()
                end
            end)

            RageUI.Checkbox("Afficher les id", description, Admin.showName,{},function(Hovered,Ative,Selected,Checked)
                if (Selected) then   
                    Admin.showName = not Admin.showName

			        if not showname then
				        for k, v in pairs(Admin.gamerTags) do
					        RemoveMpGamerTag(v)
					        Admin.gamerTags[k] = nil
				        end
			        end  
                end      
            end)





            RageUI.Separator("Vehicule")



            RageUI.ButtonWithStyle("Spawn un vehicule", nil, {}, true, function(Hovered,Active,Selected)
                if (Selected) then
                    carv()
                end
            end)


            
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                RageUI.ButtonWithStyle("Supprimer un vehicule", nil, {}, true, function(Hovered,Active,Selected)
                    if (Selected) then
                        ExecuteCommand("dv")
                    end
                end)
            else
                RageUI.ButtonWithStyle("Supprimer un vehicule", "Vous devez etre dans un vehicule", {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered,Active,Selected)
                    if (Selected) then
                    end
                end)
            end

            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                RageUI.ButtonWithStyle("changer votre plaque", nil, {}, true, function(Hovered,Active,Selected)
                    if (Selected) then
                        plque()
                    end
                end)
            else
                RageUI.ButtonWithStyle("changer votre plaque", "Vous devez etre dans un vehicule", {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered,Active,Selected)
                end)
            end


        end, function()
        end)


        RageUI.IsVisible(donne, true,true,true, function()
            RageUI.ButtonWithStyle("Donner", nil, {RightBadge = RageUI.BadgeStyle.Cash}, true, function(Hovered,Active,Selected)
                if Selected then
                    local cash = trf_menuadminKeyboardInput("Somme d'argent que vous voulez donner", '', 30)
                        if tonumber(cash) then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        local closestPed = GetPlayerPed(closestPlayer)

                        if not IsPedSittingInAnyVehicle(closestPed) then
                            TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_money', 'rien', tonumber(cash))
                        else
                           ESX.ShowNotification('t\'es dans un vehicule ta cru quoi')
                        end
                    else
                       ESX.ShowNotification('Aucun joueur proche !')
                    end
                else
                    ESX.ShowNotification('Sa existe pas espece de fou')
                end
            end
            end)


            RageUI.ButtonWithStyle("Jeter", nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                if Selected then
                    local quantity = trf_menuadminKeyboardInput("Somme d'argent que vous voulez jeter", "", 25)
                    if tonumber(quantity) then
                        if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                            TriggerServerEvent('esx:removeInventoryItem', 'item_money', 'rien', tonumber(quantity))
                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification('t\'es dans un vehicule ta cru quoi')
                        end
                    else
                        ESX.ShowNotification('Sa existe pas espece de fou')
                    end
                end
            end)

        end, function()
        end)

        RageUI.IsVisible(donnesal, true,true,true, function()
            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'black_money' then
                    RageUI.ButtonWithStyle("Donner", nil, {RightBadge = RageUI.BadgeStyle.Cash}, true, function(Hovered,Active,Selected)
                        if Selected then
                            local quantity = trf_menuadminKeyboardInput("Somme d'argent que vous voulez jeter", "", 25)
                            if tonumber(quantity) then
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                            if closestDistance ~= -1 and closestDistance <= 3 then
                                local closestPed = GetPlayerPed(closestPlayer)

                                if not IsPedSittingInAnyVehicle(closestPed) then
                                    TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', ESX.PlayerData.accounts[i].name, tonumber(quantity))
                                else
                                    ESX.ShowNotification('t\'es dans un vehicule ta cru quoi')
                                end
                            else
                               ESX.ShowNotification('Aucun joueur proche !')
                            end
                        else
                            ESX.ShowNotification('Sa existe pas espece de fou')
                        end
                    end
                end)


                RageUI.ButtonWithStyle("Jeter", nil, {RightBadge = RageUI.BadgeStyle.Star}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local quantity = trf_menuadminKeyboardInput("Somme d'argent que vous voulez jeter", "", 25)
                        if tonumber(quantity) then
                            if not IsPedSittingInAnyVehicle(PlayerPed) then
                                TriggerServerEvent('esx:removeInventoryItem', 'item_account', ESX.PlayerData.accounts[i].name, tonumber(quantity))
                            else 
                                ESX.ShowNotification('t\'es dans un vehicule ta cru quoi')
                            end
                        else  
                            ESX.ShowNotification('Sa existe pas espece de fou')
                        end

                    end
                end)
            end
            end
            
        




        end, function()
        end)

        RageUI.IsVisible(anim, true,true,true, function()
            

            RageUI.ButtonWithStyle("Montrer c'est muscle", nil, {} , true, function(Hovered,Active,Selected)
                if Selected then
                    anims('amb@world_human_muscle_flex@arms_at_side@base', 'base')
                end
            end)

            RageUI.ButtonWithStyle("Barre de musculation", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('amb@world_human_muscle_free_weights@male@barbell@base', 'base')
                end
            end)
            RageUI.ButtonWithStyle("Faire des pompes", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('amb@world_human_push_ups@male@base', 'base')
                end
            end)
            RageUI.ButtonWithStyle("Faire des abdos", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('amb@world_human_sit_ups@male@base', 'base')
                end
            end)
            RageUI.ButtonWithStyle("Faire du yoga", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('amb@world_human_yoga@male@base', 'base_a')
                end
            end)

            RageUI.ButtonWithStyle("Saluer", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('gestures@m@standing@casual', 'gesture_hello')
                end
            end)
            RageUI.ButtonWithStyle("Serrer la main", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('mp_common', 'givetake1_a')
                end
            end)
            RageUI.ButtonWithStyle("Tchek", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('mp_ped_interaction', 'handshake_guy_a')
                end
            end)
            RageUI.ButtonWithStyle("Salut ", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('mp_ped_interaction', 'hugs_guy_a')
                end
            end)
            RageUI.ButtonWithStyle("Salut Militaire", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('mp_player_int_uppersalute', 'mp_player_int_salute')
                end
            end)



            RageUI.ButtonWithStyle("Dj", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('anim@mp_player_intcelebrationmale@dj', 'dj')
                end
            end)
            RageUI.ButtonWithStyle("Boire une biere", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    startScenario('WORLD_HUMAN_DRINKING')
                end
            end)

            RageUI.ButtonWithStyle("Air Guitar", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('anim@mp_player_intcelebrationmale@air_guitar', 'air_guitar')
                end
            end)
            RageUI.ButtonWithStyle("Air Shagging", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('anim@mp_player_intcelebrationfemale@air_shagging', 'air_shagging')
                end
            end)
            RageUI.ButtonWithStyle("Rock'n'roll", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('mp_player_int_upperrock', 'mp_player_int_rock')
                end
            end)

            RageUI.ButtonWithStyle("Bourré sur place", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('amb@world_human_bum_standing@drunk@idle_a', 'idle_a')
                end
            end)
            RageUI.ButtonWithStyle("Vomir en voiture", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    anims('oddjobs@taxi@tie', 'vomit_outside')
                end
            end)

            
        end, function()
        end)

        RageUI.IsVisible(vet, true, true, true, function()


            RageUI.ButtonWithStyle("Haut", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active,Selected)
                if (Selected) then
                    haut()
                end
            end)

            RageUI.ButtonWithStyle("Pantalon", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active,Selected)
                if (Selected) then
                    bas()
                end
            end)

            RageUI.ButtonWithStyle("chaussure", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active,Selected)
                if (Selected) then
                    chaus()
                end
            end)

            RageUI.ButtonWithStyle("Sac", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active,Selected)
                if (Selected) then
                    sac()
                end
            end)

            RageUI.ButtonWithStyle("Gillet par balles", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active,Selected)
                if (Selected) then
                    gpb()

                end
            end)

            RageUI.ButtonWithStyle("Mask", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active,Selected)
                if (Selected) then
                    msk()
                end
            end)

            
       

        end, function()
        end)


        if not RageUI.Visible(menuf5) and not RageUI.Visible(portefeuil) and not RageUI.Visible(gsveh) and not RageUI.Visible(gestion) and not RageUI.Visible(inventory) and not RageUI.Visible(jetdo) and not RageUI.Visible(menuvip) and not RageUI.Visible(menuped) and not RageUI.Visible(menuprops) and not RageUI.Visible(menuveh) and not RageUI.Visible(suppr) and not RageUI.Visible(admin) and not RageUI.Visible(donne) and not RageUI.Visible(donnesal) and not RageUI.Visible(anim) and not RageUI.Visible(vet) and not RageUI.Visible(arme) and not RageUI.Visible(armeg) then
            menuf5=RMenu:DeleteType("treifa", true)
        end

    end

end

Keys.Register('f5', 'f5', 'touche pour ouvrir le menu touche', function() 
    menu()
end)


function invi()
    Admin.ghostmode = not Admin.ghostmode
     
    if Admin.ghostmode then
        SetEntityVisible(PlayerPedId(), false, false)
        ESX.ShowNotification('Mode invisible Activer')
    else
        SetEntityVisible(PlayerPedId(), true, false)
        ESX.ShowNotification('Mode invisible desactiver')
    end
end


function godmod()
    Admin.godmode = not Admin.godmode
     
    if Admin.godmode then
        SetEntityInvincible(PlayerPedId(), true)
        ESX.ShowNotification('God Mode ~g~Activer')
    else
        SetEntityInvincible(PlayerPedId(), false)
        ESX.ShowNotification('God mode ~r~desactiver')
    end
end

function anims(lib, anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    end)

end


function tpv()
    local tpv = trf_menuadminKeyboardInput("ID", "", 20)
    ExecuteCommand("goto "..tpv)
    ESX.ShowNotification("~b~Vous venez de vous téléporter à l\'ID : ~s~ " ..tpv)
end

function tpj()
    local tpj = trf_menuadminKeyboardInput("ID", "", 20)
    ExecuteCommand("bring "..tpj)
    ESX.ShowNotification("~b~Vous venez de téléporter l\'ID :~s~ " ..tpj.. " ~b~à vous~s~ !")
end
function plque()
    local plque = trf_menuadminKeyboardInput("Changer Votre plaque", "", 20)
    SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false) , plque)
    ESX.ShowNotification("Vous vener Changer votre plque par ~r~"..plque.."~w~")
end



function carv()
    local veh = trf_menuadminKeyboardInput("Entrez le nom du vehicule", "", 20)
    ExecuteCommand("car "..veh)
    ESX.ShowNotification("Vous vener de faire spawn une ~r~"..veh.."~w~")
end




function trf_menuadminKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end



function createped(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do 
        Wait(0) 
    end
    SetPlayerModel(PlayerId(), hash)
    SetModelAsNoLongerNeeded(hash)
end




function SpawnObj(obj)
    local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local coordobj = (coords + forward * 1.0)
    local trf = nil

    SpawnObject(obj, coordobj, function(obj)
        SetEntityCoords(obj, coordobj, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        trf = obj
        Wait(10)
    end)
    Wait(1)
    while trf == nil do Wait(1) end
    SetEntityHeading(trf, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(trf)
    local pos = false
    while not pos do
        Citizen.Wait(1)
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local coordobj = (coords + forward * 2.0)
        SetEntityCoords(trf, coordobj, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(trf, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(trf)

        if IsControlJustReleased(1, 38) then
            pos = true
        end
    end

    local NetId = NetworkGetNetworkIdFromEntity(trf)
    table.insert(object, NetId)

end


function RemoveObj(id, k)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            TriggerServerEvent("DeleteEntity", NetworkGetNetworkIdFromEntity(entity))
            DeleteEntity(entity)
            DeleteObject(entity)
            if not DoesEntityExist(entity) then 
                table.remove(object, k)
            end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end

function GoodName(hash)

    return hash


end



function SpawnObject(model, coords, cb)
	local model = GetHashKey(model)

	Citizen.CreateThread(function()
		RequestModels(model)
        Wait(1)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end


function RequestModels(modelHash)
	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		if Admin.showName then
			for k, v in ipairs(ESX.Game.GetPlayers()) do
				local otherPed = GetPlayerPed(v)

				if otherPed ~= plyPed then
					if #(GetEntityCoords(plyPed, false) - GetEntityCoords(otherPed, false)) < 5000.0 then
						Admin.gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
					else
						RemoveMpGamerTag(Admin.gamerTags[v])
						Admin.gamerTags[v] = nil
					end
				end
			end
		end

		Citizen.Wait(100)
	end
end)



function haut()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.torso_1 ~= skinb.torso_1 then
                vethaut = true
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = skina.torso_1, ['torso_2'] = skina.torso_2, ['tshirt_1'] = skina.tshirt_1, ['tshirt_2'] = skina.tshirt_2, ['arms'] = skina.arms})
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
                vethaut = false
            end
        end)
    end)
end

function bas()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtrousers', 'try_trousers_neutral_c'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.pants_1 ~= skinb.pants_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = skina.pants_1, ['pants_2'] = skina.pants_2})
                vetbas = true
            else
                vetbas = false
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 15, ['pants_2'] = 0})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 61, ['pants_2'] = 1})
                end
            end
        end)
    end)
end


function chaus()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingshoes', 'try_shoes_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.shoes_1 ~= skinb.shoes_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = skina.shoes_1, ['shoes_2'] = skina.shoes_2})
                vetch = true
            else
                vetch = false
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 35, ['shoes_2'] = 0})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 34, ['shoes_2'] = 0})
                end
            end
        end)
    end)
end

function sac()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bags_1 ~= skinb.bags_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = skina.bags_1, ['bags_2'] = skina.bags_2})
                vetsac = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = 0, ['bags_2'] = 0})
                vetsac = false
            end
        end)
    end)
end


function gpb()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bproof_1 ~= skinb.bproof_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = skina.bproof_1, ['bproof_2'] = skina.bproof_2})
                vetgilet = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = 0, ['bproof_2'] = 0})
                vetgilet = false
            end
        end)
    end)
end

function msk()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.mask_1 ~= skinb.mask_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = skina.mask_1, ['mask_2'] = skina.mask_2})
                vetmask = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = 0, ['mask_2'] = 0})
                vetmask = false
            end
        end)
    end)
end