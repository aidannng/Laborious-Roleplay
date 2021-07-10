AddEventHandler(triggerName("clothesUpdate"), function(clothes)
    TriggerServerEvent(triggerName("giveBackPack"), clothes["bags_1"] or 0)
end)