------------------------------------------------------------------------------------------------- Blacklist peds -----------------------------------------------------------------------------------------------
local Blacklisted = {
    Peds = {
      [`g_m_y_lost_01`] = true,
      [`g_m_y_lost_02`] = true,
      [`g_m_y_lost_03`] = true,
      [`g_f_y_lost_01`] = true,
    },
    Vehicles = {},
    Props = {}
  }
  
  AddEventHandler("entityCreating", function(entity) -- Onesync event
      local type = GetEntityType(entity)
      if type == 1 then -- peds
          if Blacklisted.Peds[GetEntityModel(entity)] ~= nil then -- You need to create a table with your blacklisted peds
              --print("^1"..GetEntityModel(entity).." has been deleted^0", ) -- log in console
              CancelEvent() -- Cancel the entity
          end
      elseif type == 2 then -- vehicles
          if Blacklisted.Vehicles[GetEntityModel(entity)] ~= nil then -- You need to create a table with your blacklisted vehicles
              --print("^1"..GetEntityModel(entity).." has been deleted^0", )
              CancelEvent()
          end
      elseif type == 3 then -- props
          if  Blacklisted.Props[GetEntityModel(entity)] ~= nil then -- You need to create a table with your blacklisted props
              --print("^1"..GetEntityModel(entity).." has been deleted^0", )
              CancelEvent()
          end
      end
  end)