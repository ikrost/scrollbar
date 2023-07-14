Scrollbar = {}
local data = {}

function Scrollbar:create(x, y, widht, height, heightBar, colors, orientation, values, valuesVisible)

    assert(type(x) == 'number', 'x value must be in number format')
    assert(type(y) == 'number', 'y value must be in number format')
    assert(type(widht) == 'number', 'widht value must be in number format')
    assert(type(height) == 'number', 'height value must be in number format')
    assert(type(heightBar) == 'number', 'heightBar value must be in number format')
    assert(type(orientation) == 'string', 'orientation must be in string format')
    assert(orientation == 'vertical' or orientation == 'horizontal', "the orientation value must be 'vertical' or 'horizontal'")
    assert(type(values) == 'number', 'valuesVisible must be in number format')
    assert(type(valuesVisible) == 'number', 'values must be in number format')

    local scrolls = {}
    setmetatable(scrolls, { __index = self })

    scrolls.x = x
    scrolls.y = y
    scrolls.widht = widht
    scrolls.height = height
    scrolls.heightBar = heightBar
    scrolls.values = values
    scrolls.valuesVisible = valuesVisible
    scrolls.orientation = orientation
    scrolls.scrollOffset = (orientation == 'horizontal' and x or y)
    scrolls.lastOffset = y

    data[scrolls] = {}

    data[scrolls].colorBackground = colors.background
    data[scrolls].colorScroll = colors.scroll
    data[scrolls].tick = getTickCount()
    data[scrolls].smooth = false
    data[scrolls].durationAnim = 250
    data[scrolls].anim = {}

    return scrolls;

end

function Scrollbar:render()

    if data[self].smooth then
        data[self].anim = interpolateBetween(self.lastOffset, 0, 0, self.scrollOffset, 0, 0, (getTickCount() - data[self].tick) / data[self].durationAnim, 'Linear')
    end

    dxDrawRectangle(
        self.x, 
        self.y, 
        self.widht, 
        self.height,
        data[self].colorBackground
    )

    dxDrawRectangle(
        (self.orientation == 'vertical' and self.x or (data[self].smooth and data[self].anim or self.scrollOffset)), 
        (self.orientation == 'vertical' and (data[self].smooth and data[self].anim or self.scrollOffset) or self.y), 
        (self.orientation == 'vertical' and self.widht or self.heightBar), 
        (self.orientation == 'vertical' and self.heightBar or self.height),
        data[self].colorScroll
    )

end

function Scrollbar:updateScrollOffset(value)

    assert(type(value) == 'number', 'value must be in number format')

    if self.orientation == 'horizontal' then


        if data[self].smooth then
            self.lastOffset = self.scrollOffset
            data[self].tick = getTickCount()
        end

        local offset = value / (self.values - self.valuesVisible) * (self.heightBar - self.widht)
        self.scrollOffset = self.x - offset
    
    else    

        if data[self].smooth then
            self.lastOffset = self.scrollOffset
            data[self].tick = getTickCount()
        end

        local offset = value / (self.values - self.valuesVisible) * (self.heightBar - self.height)
        self.scrollOffset = self.y - offset
        
    end

end

function Scrollbar:setProperties(property, value)

    assert(property, 'define a property')
    assert(value, 'define a value')
    assert(data[self][property] ~= nil, 'property '..property..' does not exist')

    data[self][property] = value
    return true

end
