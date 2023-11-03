ExampleScene2 = {}
class("ExampleScene2").extends(ExampleScene)
local scene = ExampleScene2

function scene:setValues()
	scene.super.setValues(self)
	self.background = Graphics.image.new("assets/images/background2")
	self.color1 = Graphics.kColorWhite
	self.color2 = Graphics.kColorBlack
	self.menuX = 200
end

function scene:setupMenu(__menu)
	__menu:addItem(Noble.Transition.MetroNexus.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.MetroNexus) end)
	__menu:addItem(Noble.Transition.WidgetSatchel.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.WidgetSatchel) end)
	__menu:addItem(Noble.Transition.SlideOffUp.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOffUp) end)
	__menu:addItem(Noble.Transition.SlideOffDown.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOffDown) end)
	__menu:addItem(Noble.Transition.SlideOffLeft.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOffLeft) end)
	__menu:addItem(Noble.Transition.SlideOffRight.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOffRight) end)
	__menu:addItem(Noble.Transition.SlideOnUp.name,				function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOnUp) end)
	__menu:addItem(Noble.Transition.SlideOnDown.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOnDown) end)
	__menu:addItem(Noble.Transition.SlideOnLeft.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOnLeft) end)
	__menu:addItem(Noble.Transition.SlideOnRight.name,			function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOnRight) end)
	__menu:addItem(Noble.Transition.SlideOff.name.." (Custom)",	function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOff, {
		x = 400,
		y = 150,
		rotation = 45
	}) end)
	__menu:addItem(Noble.Transition.SlideOn.name.." (Custom)",	function() Noble.transition(ExampleScene, nil, Noble.Transition.SlideOn, {
		x = -400,
		y = -150,
		rotation = 45
	}) end)

end

function scene:drawLogo()
	Graphics.setColor(self.color2)
	Graphics.fillRoundRect(10, 240-45, 130, 65, 15)
	self.logo:setInverted(false)
	self.logo:draw(25, 240-27-10)
end