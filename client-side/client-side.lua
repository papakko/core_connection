local internet = true -- Váriavel que vai gerenciar se o jogador tem internet ou não.
local keys = {22,37,45,80,140,250,263,310,140,141,257,142,143,24,25,58} -- Teclas que vão ser desabilitadas quando a internet cair, verificar em https://docs.fivem.net/docs/game-references/controls/

function block()
    Citizen.CreateThread( function()
        while not internet do
            local ped = PlayerPedId()
            for k,v in pairs(keys) do 
                DisableControlAction(0, v, true) -- Nativa para desabilitar as teclas
            end
                DisablePlayerFiring(ped, true) -- Desativa o tiro
            Citizen.Wait(sleep)
        end
    end)
end

RegisterNUICallback("lock",function(data,cb) -- Callback quando a internet cai
    if not internet then
        return
    end
    internet = false -- Seta a váriavel de internet como false
    TriggerEvent('core_connection:close') -- Evento a ser disparado pra a alguns scripts para fechar a nui, como inventário e coisas do gênero! 
    local ped = PlayerPedId()
    FreezeEntityPosition(ped,true) --  Freeza o jogador
    block() -- ativa a thread pra bloquear teclas 
    cb('ok')
end)

RegisterNUICallback("unlock",function(data,cb) -- Callback quando a internet volta
    if internet then
        return
    end
    internet = true -- Seta a váriavel de internet como true
    local ped = PlayerPedId()
    FreezeEntityPosition(ped,false) -- Remove o freeze do jogador
    cb('ok')
end)


