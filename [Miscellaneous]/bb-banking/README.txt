 ______     ______        ______     ______     __   __     __  __     __     __   __     ______   
/\  == \   /\  == \      /\  == \   /\  __ \   /\ "-.\ \   /\ \/ /    /\ \   /\ "-.\ \   /\  ___\  
\ \  __<   \ \  __<      \ \  __<   \ \  __ \  \ \ \-.  \  \ \  _"-.  \ \ \  \ \ \-.  \  \ \ \__ \ 
 \ \_____\  \ \_____\     \ \_____\  \ \_\ \_\  \ \_\\"\_\  \ \_\ \_\  \ \_\  \ \_\\"\_\  \ \_____\
  \/_____/   \/_____/      \/_____/   \/_/\/_/   \/_/ \/_/   \/_/\/_/   \/_/   \/_/ \/_/   \/_____/
                                                                                                   
    ESX Instructions.

1.  Install SQL:
    Inject "bb-banking > data.sql" Into your Database.
    Make sure it all went in without errors.

2.  Core edits:
    In order to get Statements fully working, you will have to add few lines to your core,
    Following the following steps carefully!

    es_extended >  server > classes > player.lua:
        
        ESX 1.2+ :
            Replace "self.setAccountMoney" functions with the following one:
                self.setAccountMoney = function(accountName, money, reason)
                    if money >= 0 then
                        local account = self.getAccount(accountName)

                        if account then
                            local prevMoney = account.money
                            local newMoney = ESX.Math.Round(money)
                            account.money = newMoney

                            exports['bb-banking']:RegisterNewAction(self.source, accountName, 'reset', money, (reason ~= nil and reason or 'Unknown'))
                            self.triggerEvent('esx:setAccountMoney', account)
                        end
                    end
                end

            Replace "self.addAccountMoney" functions with the following one:
                self.addAccountMoney = function(accountName, money, reason)
                    if money > 0 then
                        local account = self.getAccount(accountName)

                        if account then
                            local newMoney = account.money + ESX.Math.Round(money)
                            account.money = newMoney

                            exports['bb-banking']:RegisterNewAction(self.source, acc, 'deposit', money, (reason ~= nil and reason or 'Unknown'))
                            self.triggerEvent('esx:setAccountMoney', account)
                        end
                    end
                end

            Replace "self.removeAccountMoney" functions with the following one:
                self.removeAccountMoney = function(accountName, money, reason)
                    if money > 0 then
                        local account = self.getAccount(accountName)

                        if account then
                            local newMoney = account.money - ESX.Math.Round(money)
                            account.money = newMoney

                            exports['bb-banking']:RegisterNewAction(self.source, acc, 'withdraw', money, (reason ~= nil and reason or 'Unknown'))
                            self.triggerEvent('esx:setAccountMoney', account)
                        end
                    end
                end

        ESX 1.1 :
        Replace "self.setAccountMoney" functions with the following one:
            self.setAccountMoney = function(acc, money, reason)
                if money < 0 then
                    print(('es_extended: %s attempted exploiting! (reason: player tried setting -1 account balance)'):format(self.identifier))
                    return
                end

                local account   = self.getAccount(acc)
                local prevMoney = account.money
                local newMoney  = ESX.Math.Round(money)

                account.money = newMoney

                if acc == 'bank' then
                    self.set('bank', newMoney)
                end

                exports['bb-banking']:RegisterNewAction(self.source, acc, 'reset', money, (reason ~= nil and reason or 'Unknown'))
                TriggerClientEvent('esx:setAccountMoney', self.source, account)
            end

        Replace "self.addAccountMoney" functions with the following one:
            self.addAccountMoney = function(acc, money, reason)
                if money < 0 then
                    print(('es_extended: %s attempted exploiting! (reason: player tried adding -1 account balance)'):format(self.identifier))
                    return
                end

                local account  = self.getAccount(acc)
                local newMoney = account.money + ESX.Math.Round(money)

                account.money = newMoney

                if acc == 'bank' then
                    self.set('bank', newMoney)
                end

                exports['bb-banking']:RegisterNewAction(self.source, acc, 'deposit', money, (reason ~= nil and reason or 'Unknown'))
                TriggerClientEvent('esx:setAccountMoney', self.source, account)
            end

        Replace "self.removeAccountMoney" functions with the following one:
            self.removeAccountMoney = function(a, m, reason)
                if m < 0 then
                    print(('es_extended: %s attempted exploiting! (reason: player tried removing -1 account balance)'):format(self.identifier))
                    return
                end

                local account  = self.getAccount(a)
                local newMoney = account.money - m

                account.money = newMoney

                if a == 'bank' then
                    self.set('bank', newMoney)
                end

                exports['bb-banking']:RegisterNewAction(self.source, a, 'withdraw', m, (reason ~= nil and reason or 'Unknown'))
                TriggerClientEvent('esx:setAccountMoney', self.source, account)
            end

        Now, on your other scripts, if you are using one of this functions you can add the "reason" arg to get the statement display with that reason.
        For example: 
            es_extended > server > paycheck.lua is the file where we are getting salary from,
            We will search for "addAccountMoney" and will see 4 matches [Pic1: https://prnt.sc/1192nh9]
            We can add the reason for them "Salary", so we will see on the statements page "Salary" as the transaction reason.
            So it will look like [Pic2: https://prnt.sc/1192o7e] after the add.
            If you want, you can do it for every single function on your server, but i can't help you with all of them ;)

3.  Lang
    If you want to change the default English Lang >
    Open your fxmanifest and change 'locales/en.lua' to 'locales/<LOCALE_CODE>.lua', available locales can be found on the locales folder.

4.  Auth
    Join barbaronn scripts discord server in order to get your script activated - 
    barbaroNNs Scripts Discord - https://discord.gg/MunpyUPmxx
    ModIT Discord - https://discord.com/invite/8afXRrA

Best of luck!
barbaroNN.