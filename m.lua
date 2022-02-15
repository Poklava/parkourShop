local players = {}
local textAreaIds = {
    shopCloseButton = 1,
    shopPages = 2,
    shopTab1 = 3,
    shopTab2 = 4,
    shopTab3 = 5,
    shopTab4 = 6
}
local items = {
    [1] = {
        {img = "17ee0479ad8.png", x = 195, y = 120, scale = 1, id = 142}, 
        {img = "17ee0483361.png", x = 275 + 80, y = 110, scale = 1, id = 139}, 
        {img = "17ee048cb5f.png", x = 325 + 80 * 2, y = 115, scale = 1, id = 109}, 
        {img = "17ee0491764.png", x = 190, y = 150 + 60, scale = 1, id = 126}, 
        {img = "17ee0496361.png", x = 275 + 80, y = 160 + 60, scale = 1, id = 140}, 
        {img = "17ee04a945f.png", x = 340 + 80 * 2, y = 175 + 60, scale = 1, id = 107}, 
        {img = "17ee0520164.png", x = 210, y = 130, scale = 1, id = 122}
    },
    [2] = {
        {img = "17ee049af62.png", x = 205, y = 120, scale = 0.6, id = 212}, 
        {img = "17ee049fbb2.png", x = 285 + 80, y = 120, scale = 0.6, id = 222}, 
        {img = "17ee04ae061.png", x = 350 + 80 * 2, y = 125, scale = 0.6, id = 224}, 
        {img = "17ee04b2c62.png", x = 217, y = 165 + 60, scale = 0.6, id = 219}, 
        {img = "17ee04b785f.png", x = 275 + 80, y = 157 + 60, scale = 0.6, id = 230}, 
        {img = "17ee04bc460.png", x = 345 + 80 * 2, y = 173 + 60, scale = 0.6, id = 241}, 
        {img = "17ee04c5c61.png", x = 210, y = 115, scale = 0.6, id = 233}, 
        {img = "17ee04d8c60.png", x = 280 + 80, y = 117, scale = 0.6, id = 244}, 
        {img = "17ee04dd863.png", x = 355 + 80 * 2, y = 120, scale = 0.6, id = 246}, 
        {img = "17ee04e7061.png", x = 360, y = 175 + 60, scale = 0.6, id = 240}, 
        {img = "17ee0503961.png", x = 120 + 80, y = 170 + 60, scale = 0.6, id = 248}, 
        {img = "17ee0524d64.png", x = 345 + 80 * 2, y = 170 + 60, scale = 0.6, id = 243}, 
        {img = "17ee0487f63.png", x = 360, y = 113, scale = 0.6, id = 235}, 
        {img = "17ee047e75f.png", x = 133 + 80, y = 127, scale = 0.6, id = 226}
    },
    [3] = {
        {img = "17ee04c1063.png", x = 208, y = 110, scale = 0.8, id = 2818},
        {img = "17ee04ca860.png", x = 275 + 80, y = 120, scale = 1, id = 2877}, 
        {img = "17ee04cf463.png", x = 340 + 80 * 2, y = 113, scale = 1, id = 2825}, 
        {img = "17ee04e2460.png", x = 205, y = 160 + 60, scale = 1, id = 2801}, 
        {img = "17ee04ebc63.png", x = 260 + 80, y = 155 + 60, scale = 1, id = 2819}, 
        {img = "17ee04f0861.png", x = 335 + 80 * 2, y = 153 + 60, scale = 1, id = 2832}, 
        {img = "17ee04f5461.png", x = 195, y = 115, scale = 1, id = 2840}, 
        {img = "17ee04fa16d.png", x = 257 + 80, y = 110, scale = 1, id = 2829}, 
        {img = "17ee04fed61.png", x = 335  + 80 * 2, y = 100, scale = 1, id = 2841}, 
    },
    [4] = {
        {img = "17ee0508560.png", x = 490, y = 135, scale = 0.7, id = 703}, 
        {img = "17ee051b563.png", x = 268 + 80, y = 140, scale = 0.7, id = 707}, 
        {img = "17ee0529961.png", x = 40  + 80 * 2, y = 140, scale = 0.7, id = 702}, 
        {img = "17ee0511d62.png", x = 195, y = 170 + 65, scale = 0.650, id = 705}
    }
}

eventNewPlayer = function(name)
    players[name] = {
        shopOpened = false,
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
            if players[name].inventory[items[players[name].shopTab][i].id] then
                return
            else
                players[name].inventory[items[players[name].shopTab][i].id] = true
            end
            removeShop(name)
            displayShop(name)
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
    players[name].shopCloseButton = tfm.exec.addImage("1717a7b2c60.png", ":0", 705, 46, name, 1, 1, 0, 1, 0.5, 0.5)
    ui.addTextArea(textAreaIds.shopCloseButton, "<a href='event:shopCloseButton'>  </a>", name, 695, 43, 13, 13,
        0xf00000, 0xf00000, 0, true)

    for i, j in next, {["shopTab1"] = {"Küçük Kutu", 165}, ["shopTab2"] = {"Büyük Kutu", 290}, ["shopTab3"] = {"Balon", 440}, ["shopTab4"] = {"Trambolin", 540}} do
        ui.addTextArea(textAreaIds[i], "<a href='event:" .. i .. "'>    " .. j[1] .. "</a>", name, j[2], 80, 100, 20,
        0xf00000, 0xf00000, 0, true)
    end

    local tabAreaX = {165, 290, 440, 540}
    for i = 1, #items do
        players[name].tempImgs[i] = tfm.exec.addImage(players[name].shopTab == i and "17272e2e9bd.png" or "17272e306ca.png", ":1", tabAreaX[i], 82, name, 1, 1, 0, 1, 0, 0)
    end

    local textAreaX, textAreaY = 210, 121
    for i = (players[name].shopPage - 1)* 6 + 1, players[name].shopPage * 6 > #items[players[name].shopTab] and #items[players[name].shopTab] or players[name].shopPage * 6 do
        players[name].tempImgs[#players[name].tempImgs + 1] = tfm.exec.addImage(items[players[name].shopTab][i].img, "&2", items[players[name].shopTab][i].x, items[players[name].shopTab][i].y, name, items[players[name].shopTab][i].scale, items[players[name].shopTab][i].scale, 0, 1, 0, 0, 0)
        textAreaIds[#textAreaIds + 1] = i + 6
        textAreaIds[#textAreaIds + 1] = (i + 6) * 2
        ui.addTextArea(i + 6, "", name, textAreaX, textAreaY, 79, 85, 0x253942, 0x142529, 1, true)
        ui.addTextArea((i + 6) * 2 , "<p align='center'><a href='event:shopButton" .. i .. "'>" .. (players[name].inventory[items[players[name].shopTab][i].id] and "Kullan" or "Al gitsin") .. "</a></p>", name, textAreaX, textAreaY + 70, 80, 20, 0x253942, 0x142529, 1, true)    
        textAreaX = textAreaX + 150
        if textAreaX == 660 then
            textAreaX = 210
            textAreaY = textAreaY + 110
        end
    end
    print(#textAreaIds)
    local pages = ""
    for i = 1, math.ceil(#items[players[name].shopTab] / 6) do
        pages = i == 1 and pages .. "<a href='event:shopPage" .. i .. "'>" .. i .. "</a>" or pages .. "  -  <a href='event:shopPage" .. i .. "'>" .. i .. "</a>"
    end

    ui.addTextArea(textAreaIds.shopPages, "<p align='center'><font size='15'>" .. pages .. "</font></p>", name, 90, 357, 620, 25, 0xf00000,
        0xf00000, 0, true)
    players[name].shopOpened = true
end

removeShop = function (name)
    for _, i in next, {'shopImg', 'shopCloseButton'} do
        tfm.exec.removeImage(players[name][i])
    end
    for i in next, textAreaIds do
        ui.removeTextArea(textAreaIds[i], name)
    end
    for i = 1, #players[name].tempImgs do
        tfm.exec.removeImage(players[name].tempImgs[i])
    end
    players[name].tempImgs = {}
    players[name].shopOpened = false
end
