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
        {img = "17ee0479ad8.png", x = 170, y = 130, scale = 1}, 
        {img = "17ee0483361.png", x = 280 + 80, y = 120, scale = 1}, 
        {img = "17ee048cb5f.png", x = 330 + 80 * 2, y = 125, scale = 1}, 
        {img = "17ee0491764.png", x = 165, y = 140 + 60, scale = 1}, 
        {img = "17ee0496361.png", x = 275 + 80, y = 150 + 60, scale = 1}, 
        {img = "17ee04a945f.png", x = 340 + 80 * 2, y = 165 + 60, scale = 1}, 
        {img = "17ee0520164.png", x = 185, y = 140, scale = 1}
    },
    [2] = {
        {img = "17ee049af62.png", x = 180, y = 135, scale = 0.6}, 
        {img = "17ee049fbb2.png", x = 290 + 80, y = 135, scale = 0.6}, 
        {img = "17ee04ae061.png", x = 360 + 80 * 2, y = 140, scale = 0.6}, 
        {img = "17ee04b2c62.png", x = 195, y = 160 + 60, scale = 0.6}, 
        {img = "17ee04b785f.png", x = 275 + 80, y = 150 + 60, scale = 0.6}, 
        {img = "17ee04bc460.png", x = 360 + 80 * 2, y = 165 + 60, scale = 0.6}, 
        {img = "17ee04c5c61.png", x = 185, y = 135, scale = 0.6}, 
        {img = "17ee04d8c60.png", x = 300 + 80, y = 140, scale = 0.6}, 
        {img = "17ee04dd863.png", x = 280 + 80 * 2, y = 140, scale = 0.6}, 
        {img = "17ee04e7061.png", x = 330, y = 140 + 60, scale = 0.6}, 
        {img = "17ee0503961.png", x = 165 + 80, y = 140 + 60, scale = 0.6}, 
        {img = "17ee0524d64.png", x = 275 + 80 * 2, y = 140 + 60, scale = 0.6}, 
        {img = "17ee0487f63.png", x = 340, y = 140, scale = 0.6}, 
        {img = "17ee047e75f.png", x = 185 + 80, y = 140, scale = 0.6}
    },
    [3] = {
        {img = "17ee04c1063.png", x = 180, y = 140, scale = 1},
        {img = "17ee04ca860.png", x = 180 + 80, y = 140, scale = 1}, 
        {img = "17ee04cf463.png", x = 180 + 80 * 2, y = 140, scale = 1}, 
        {img = "17ee04e2460.png", x = 180, y = 140 + 60, scale = 1}, 
        {img = "17ee04ebc63.png", x = 180 + 80, y = 140 + 60, scale = 1}, 
        {img = "17ee04f0861.png", x = 180 + 80 * 2, y = 140 + 60, scale = 1}, 
        {img = "17ee04f5461.png", x = 180, y = 140, scale = 1}, 
        {img = "17ee04fa16d.png", x = 180 + 80, y = 140, scale = 1}, 
        {img = "17ee04fed61.png", x = 180  + 80 * 2, y = 140, scale = 1}, 
        {img = "17ee050d162.png", x = 180, y = 140 + 60, scale = 1}
    },
    [4] = {
        {img = "17ee0508560.png", x = 180, y = 140, scale = 1}, 
        {img = "17ee051b563.png", x = 180 + 80, y = 140, scale = 1}, 
        {img = "17ee0529961.png", x = 180  + 80 * 2, y = 140, scale = 1}, 
        {img = "17ee0511d62.png", x = 180, y = 140 + 60, scale = 1}
    }
}


for name in next, tfm.get.room.playerList do
    players[name] = {
        shopOpened = false,
        inventory = {},
        shopTab = 1,
        shopPage = 1,
        tempImgs = {}
    }
    system.bindKeyboard(name, 32, true, true)
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

    ui.addTextArea(textAreaIds.shopTab1, "<a href='event:shopTab1'>    Küçük Kutu</a>", name, 165, 80, 100, 20,
        0xf00000, 0xf00000, 0, true)
    ui.addTextArea(textAreaIds.shopTab2, "<a href='event:shopTab2'>    Büyük Kutu</a>", name, 290, 80, 100, 20, 0xf00000,
        0xf00000, 0, true)
    ui.addTextArea(textAreaIds.shopTab3, "<a href='event:shopTab3'>    Balon</a>", name, 440, 80, 100, 20, 0xf00000,
        0xf00000, 0, true)
    ui.addTextArea(textAreaIds.shopTab4, "<a href='event:shopTab4'>    Trambolin</a>", name, 540, 80, 100, 20, 0xf00000,
        0xf00000, 0, true)

    local tabBoxX = {165, 290, 440, 540}

    for i = 1, #items do
        players[name].tempImgs[i] = tfm.exec.addImage(players[name].shopTab == i and "17272e2e9bd.png" or "17272e306ca.png", ":1", tabBoxX[i], 82, name, 1, 1, 0, 1, 0, 0)
    end

    local textAreaX, textAreaY = 210, 121
    for i = (players[name].shopPage - 1)* 6 + 1, players[name].shopPage * 6 > #items[players[name].shopTab] and #items[players[name].shopTab] or players[name].shopPage * 6 do
        players[name].tempImgs[#players[name].tempImgs + 1] = tfm.exec.addImage(items[players[name].shopTab][i].img, "&2", items[players[name].shopTab][i].x, items[players[name].shopTab][i].y, name, items[players[name].shopTab][i].scale, items[players[name].shopTab][i].scale, 0, 1, 0, 0, 0)
        textAreaIds[#textAreaIds + 1] = #textAreaIds + 1
        ui.addTextArea(math.random(100,9999), "", nil, textAreaX, textAreaY, 79, 85, 0x253942, 0x142529, 1, true)
        ui.addTextArea(math.random(100,9999), "AL GİTSİN", nil, textAreaX, textAreaY + 70, 80, 20, 0x253942, 0x142529, 1, true)    
        textAreaX = textAreaX + 150
        if textAreaX == 660 then
            textAreaX = 210
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
