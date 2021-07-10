Citizen.CreateThread(function()

        interiorID = GetInteriorAtCoords(2863.121, 4457.024, 41.31067)


        if IsValidInterior(interiorID) then
        RefreshInterior(interiorID)
        EnableInteriorProp(interiorID, "weed_app")
        EnableInteriorProp(interiorID, "weed_staff_01")
        EnableInteriorProp(interiorID, "weed_staff_02")
        EnableInteriorProp(interiorID, "weed_update_lamp")
        EnableInteriorProp(interiorID, "weed_fan_update")
        EnableInteriorProp(interiorID, "weed_stock")
        EnableInteriorProp(interiorID, "weed_plant_v1")
        EnableInteriorProp(interiorID, "weed_plant_v7")
    
        RefreshInterior(interiorID)
    
    end
    
end) 

Citizen.CreateThread(function()

        interiorID = GetInteriorAtCoords(597.0066, -423.9165, 17.61975)


        if IsValidInterior(interiorID) then
        RefreshInterior(interiorID)
        EnableInteriorProp(interiorID, "light_stock")
        EnableInteriorProp(interiorID, "meth_app")
        EnableInteriorProp(interiorID, "meth_staff_01")
        EnableInteriorProp(interiorID, "meth_staff_02")
        EnableInteriorProp(interiorID, "meth_basic_lab_01")
        EnableInteriorProp(interiorID, "meth_basic_lab_02")
        EnableInteriorProp(interiorID, "meth_basic_lab_01_2")
        EnableInteriorProp(interiorID, "meth_basic_lab_02_2")
        EnableInteriorProp(interiorID, "meth_stock")
        
        RefreshInterior(interiorID)
        
    end
        
end) 

Citizen.CreateThread(function()

        interiorID = GetInteriorAtCoords(1395.165, -2090.69, 45.48938)


        if IsValidInterior(interiorID) then
        RefreshInterior(interiorID)
        EnableInteriorProp(interiorID, "coke_app")
        EnableInteriorProp(interiorID, "coke_staff_01")
        EnableInteriorProp(interiorID, "coke_staff_02")
        EnableInteriorProp(interiorID, "coke_stock")
        
        RefreshInterior(interiorID)
    
    end
    
end) 
