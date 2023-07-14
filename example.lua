scrollOffset = 0

local Texts = {
    "Text1",
    "Text2",
    "Text3",
    "Text4",
    "Text5",
    "Text6",
    "Text7",
    "Text8",
    "Text9",
    "Text10",
    "Text11",
    "Text12",
    "Text13",
    "Text14",
    "Text15",
    "Text16",
    "Text17",
    "Text18",
    "Text19",
    "Text20",
    "Text21",
    "Text22",
    "Text23",
    "Text24",
    "Text25",
    "Text26",
    "Text27",
    "Text28",
    "Text29",
    "Text30",
}

local vertical = Scrollbar:create(600, 300, 5, 220, 25, {background = tocolor(0, 0, 0, 255), scroll = tocolor(255, 255, 255, 255)}, 'vertical', #Texts, 7)
local horizontal = Scrollbar:create(740, 300, 270, 5, 25, {background = tocolor(0, 0, 0, 255), scroll = tocolor(255, 255, 255, 255)}, 'horizontal', #Texts, 7)

vertical:setProperties("smooth", true)
vertical:setProperties("colorBackground", tocolor(255, 0, 0))
vertical:setProperties("colorScroll", tocolor(0, 0, 0))

function render()

    for i = 1, 7 do

        dxDrawText(Texts[i + scrollOffset], 550, 270 + (i * 32), 100, 100)

    end

    for i = 1, 7 do

        dxDrawText(Texts[i + scrollOffset], 700 + (i * 40), 270, 100, 100)

    end

    vertical:render()
    horizontal:render()

end
render()
addEventHandler("onClientRender", root, render)

function scrollFunction(key, keyState)
    
    if key == "mouse_wheel_up" then

        if #Texts + scrollOffset > #Texts then

            scrollOffset = scrollOffset - 1

        end

    else
        
        if #Texts > scrollOffset + 7 then

            scrollOffset = scrollOffset + 1

        end

    end

    vertical:updateScrollOffset(scrollOffset)
    horizontal:updateScrollOffset(scrollOffset)

end
bindKey("mouse_wheel_up", "down", scrollFunction)
bindKey("mouse_wheel_down", "down", scrollFunction)