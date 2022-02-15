local players = {}
local textAreaIds = {
    shopCloseButton = 1,
    shopPages = 2,
    shopTab1 = 3,
    shopTab2 = 4,
    shopTab3 = 5,
    shopTab4 = 6,
    shopInfo = 7,
    shopBuy = 8,
    shopCoin = 9
}
local items = {
    [1] = {
        {img = "17ee0479ad8.png", x = 135, y = 120, scale = 1, id = 142, price = 1}, 
        {img = "17ee0483361.png", x = 215 + 80, y = 110, scale = 1, id = 139, price = 2}, 
        {img = "17ee048cb5f.png", x = 265 + 80 * 2, y = 115, scale = 1, id = 109, price = 3},
        {img = "17ee0491764.png", x = 130, y = 150 + 60, scale = 1, id = 126, price = 4},
        {img = "17ee0496361.png", x = 215 + 80, y = 160 + 60, scale = 1, id = 140, price = 5},
        {img = "17ee04a945f.png", x = 275 + 80 * 2, y = 175 + 60, scale = 1, id = 107, price = 6},
        {img = "17ee0520164.png", x = 150, y = 130, scale = 1, id = 122, price = 7}
    },
    [2] = {
        {img = "17ee049af62.png", x = 145, y = 120, scale = 0.6, id = 212, price = 8}, 
        {img = "17ee049fbb2.png", x = 225 + 80, y = 120, scale = 0.6, id = 222, price = 9}, 
        {img = "17ee04ae061.png", x = 290 + 80 * 2, y = 125, scale = 0.6, id = 224, price = 10}, 
        {img = "17ee04b2c62.png", x = 157, y = 165 + 60, scale = 0.6, id = 219, price = 11}, 
        {img = "17ee04b785f.png", x = 215 + 80, y = 157 + 60, scale = 0.6, id = 230, price = 12}, 
        {img = "17ee04bc460.png", x = 285 + 80 * 2, y = 173 + 60, scale = 0.6, id = 241, price = 13}, 
        {img = "17ee04c5c61.png", x = 150, y = 115, scale = 0.6, id = 233, price = 14}, 
        {img = "17ee04d8c60.png", x = 220 + 80, y = 117, scale = 0.6, id = 244, price = 15}, 
        {img = "17ee04dd863.png", x = 295 + 80 * 2, y = 120, scale = 0.6, id = 246, price = 16}, 
        {img = "17ee04e7061.png", x = 300, y = 175 + 60, scale = 0.6, id = 240, price = 17}, 
        {img = "17ee0503961.png", x = 60 + 80, y = 170 + 60, scale = 0.6, id = 248, price = 18}, 
        {img = "17ee0524d64.png", x = 285 + 80 * 2, y = 170 + 60, scale = 0.6, id = 243, price = 19}, 
        {img = "17ee0487f63.png", x = 300, y = 113, scale = 0.6, id = 235, price = 20}, 
        {img = "17ee047e75f.png", x = 73 + 80, y = 127, scale = 0.6, id = 226, price = 21}
    },
    [3] = {
        {img = "17ee04c1063.png", x = 148, y = 110, scale = 0.8, id = 2818, price = 22},
        {img = "17ee04ca860.png", x = 215 + 80, y = 120, scale = 1, id = 2877, price = 23}, 
        {img = "17ee04cf463.png", x = 280 + 80 * 2, y = 113, scale = 1, id = 2825, price = 24}, 
        {img = "17ee04e2460.png", x = 145, y = 160 + 60, scale = 1, id = 2801, price = 25}, 
        {img = "17ee04ebc63.png", x = 200 + 80, y = 155 + 60, scale = 1, id = 2819, price = 26}, 
        {img = "17ee04f0861.png", x = 275 + 80 * 2, y = 153 + 60, scale = 1, id = 2832, price = 27}, 
        {img = "17ee04f5461.png", x = 135, y = 115, scale = 1, id = 2840, price = 28}, 
        {img = "17ee04fa16d.png", x = 197 + 80, y = 110, scale = 1, id = 2829, price = 29}, 
        {img = "17ee04fed61.png", x = 275  + 80 * 2, y = 100, scale = 1, id = 2841, price = 30}, 
        {img = "17ee050d162.png", x = 109, y = 145 + 60, scale = 1, id = 2837, price = 31}
    },
    [4] = {
        {img = "17ee0508560.png", x = 430, y = 135, scale = 0.7, id = 703, price = 32}, 
        {img = "17ee051b563.png", x = 208 + 80, y = 140, scale = 0.7, id = 707, price = 33}, 
        {img = "17ee0529961.png", x = -20  + 80 * 2, y = 140, scale = 0.7, id = 702, price = 34}, 
        {img = "17ee0511d62.png", x = 135, y = 170 + 65, scale = 0.650, id = 705, price = 35}
    }
}

eventNewPlayer = function(name)
    players[name] = {
        shopOpened = false,
        coinOrMap = 0,
        inventory = {},
        shopTab = 1,
        shopPage = 1,
        tempImgs = {}
    }
    system.bindKeyboard(name, 32, true, true)
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end

eventKeyboard = function(name, key)
    if players[name].shopOpened then
        removeShop(name)
    else
        displayShop(name)
    end
end
tfm.exec.newGame(1)
eventPlayerWon = function(name)
    players[name].coinOrMap = players[name].coinOrMap + 100
end

eventTextAreaCallback = function(id, name, event)
    for i = 1, #items do
        if event == "shopTab" .. i then
            players[name].shopTab = i
            players[name].shopPage = 1
            removeShop(name)
            displayShop(name)
        end
    end
    for i = 1, #items[players[name].shopTab] do
        if event == "shopButton" .. i then
            removeShop(name)
            displayShop(name)
            if players[name].inventory[items[players[name].shopTab][i].id] then
                return
            else
                ui.addTextArea(textAreaIds.shopInfo, "<p align='center'><font size='25'><font color='#ffff00'>\n" .. items[players[name].shopTab][i].price .. "</font></font></p>", name, 570, 155, 115, 115, 0x3f2c50, 0x000000, 0.5, true)
                ui.addTextArea(textAreaIds.shopBuy, "<p align='center'><a href='event:buyItem" .. i .. "'>SATIN AL</a></p>", name, 570, 250, 115, 20, 0x3f2c50, 0x000000, 0.5, true)
            end
        elseif event == "buyItem" .. i then
            if players[name].coinOrMap >= items[players[name].shopTab][i].price and not players[name].inventory[items[players[name].shopTab][i].id] then
                ui.updateTextArea(id, "<p align='center'><a href='event:shopButton" .. i .. "'>KULLAN</a></p>", name)
                players[name].coinOrMap = players[name].coinOrMap - items[players[name].shopTab][i].price
                players[name].inventory[items[players[name].shopTab][i].id] = true
                removeShop(name)
                displayShop(name)
            else
                ui.updateTextArea(id, "<p align='center'><font color='#ff0000'>YETERSIZ PARA</font></p>", name)
            end
        end
    end
    for i = 1, math.ceil(#items[players[name].shopTab] / 6) do
        if event == "shopPage" .. i then
            players[name].shopPage = i
            removeShop(name)
            displayShop(name)
        end
    end
    if event == "shopCloseButton" then
        removeShop(name)
    end
end

displayShop = function(name)
    players[name].shopImg = tfm.exec.addImage("17201a440b4.png", ":0", 400, 212.5, name, 1.25, 1.25, 0, 1, 0.5, 0.5)
    players[name].shopBackgorundImg = tfm.exec.addImage("166dc37c641.png", ":0", 400, 212.5, name, 0.79, 0.88, 0, 0.55, 0.5, 0.5)
    players[name].shopCloseButton = tfm.exec.addImage("1717a7b2c60.png", ":0", 705, 46, name, 1, 1, 0, 1, 0.5, 0.5)
    ui.addTextArea(textAreaIds.shopCloseButton, "<a href='event:shopCloseButton'>  </a>", name, 695, 43, 13, 13,
        0xf00000, 0xf00000, 0, true)
    ui.addTextArea(textAreaIds.shopCoin, "<p align='center'><font size='17'><font color='#ffff00'>" .. players[name].coinOrMap .. "</font></font></p>", name, 95, 45, 100, 25, 0x3f2c50, 0x000000, 0.5, true)        
    local tabAreaX = {145, 270, 420, 520}
    for i, j in next, {["shopTab1"] = {"Küçük Kutu", tabAreaX[1]}, ["shopTab2"] = {"Büyük Kutu", tabAreaX[2]}, ["shopTab3"] = {"Balon", tabAreaX[3]}, ["shopTab4"] = {"Trambolin", tabAreaX[4]}} do
        ui.addTextArea(textAreaIds[i], "<a href='event:" .. i .. "'>    " .. j[1] .. "</a>", name, j[2], 80, 100, 20,
        0xf00000, 0xf00000, 0, true)
    end
    for i = 1, #items do
        players[name].tempImgs[i] = tfm.exec.addImage(players[name].shopTab == i and "17272e2e9bd.png" or "17272e306ca.png", ":1", tabAreaX[i], 81, name, 1, 1, 0, 0.5, 0, 0)
    end

    local textAreaX, textAreaY = 150, 121
    for i = (players[name].shopPage - 1)* 6 + 1, players[name].shopPage * 6 > #items[players[name].shopTab] and #items[players[name].shopTab] or players[name].shopPage * 6 do
        players[name].tempImgs[#players[name].tempImgs + 1] = tfm.exec.addImage(items[players[name].shopTab][i].img, "&2", items[players[name].shopTab][i].x, items[players[name].shopTab][i].y, name, items[players[name].shopTab][i].scale, items[players[name].shopTab][i].scale, 0, 1, 0, 0, 0)
        textAreaIds[#textAreaIds + 1] = i + 9
        textAreaIds[#textAreaIds + 1] = (i + 9) * 2
        ui.addTextArea(i + 9, "", name, textAreaX, textAreaY, 79, 90, 0x3f2c50, 0x000000, 0.5, true)
        ui.addTextArea((i + 9) * 2 , "<p align='center'><a href='event:shopButton" .. i .. "'>" .. (players[name].inventory[items[players[name].shopTab][i].id] and "Kullan" or "BILGI") .. "</a></p>", name, textAreaX, textAreaY + 70, 80, 20, 0x3f2c50, 0x000000, 0.5, true)    
        textAreaX = textAreaX + 150
        if textAreaX == 600 then
            textAreaX = 150
            textAreaY = textAreaY + 110
        end
    end
    local pages = ""
    for i = 1, math.ceil(#items[players[name].shopTab] / 6) do
        pages = i == 1 and pages .. "<a href='event:shopPage" .. i .. "'>" .. i .. "</a>" or pages .. "  -  <a href='event:shopPage" .. i .. "'>" .. i .. "</a>"
    end

    ui.addTextArea(textAreaIds.shopPages, "<p align='center'><font size='15'>" .. pages .. "</font></p>", name, 90, 357, 620, 25, 0xf00000,
        0xf00000, 0, true)
    players[name].shopOpened = true
end

removeShop = function (name)
    for _, i in next, {'shopImg', 'shopCloseButton', 'shopBackgorundImg'} do
        tfm.exec.removeImage(players[name][i])
    end
    for i in next, textAreaIds do    
        ui.removeTextArea(textAreaIds[i], name)
    end
    for i = 1, #textAreaIds do
        textAreaIds[i] = nil
    end
    for i = 1, #players[name].tempImgs do
        tfm.exec.removeImage(players[name].tempImgs[i])
    end
    players[name].tempImgs = {}
    players[name].shopOpened = false
end
