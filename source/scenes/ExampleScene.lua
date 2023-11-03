ExampleScene = {}
class("ExampleScene").extends(NobleScene)
local scene = ExampleScene

function scene:setValues()
	self.background = Graphics.image.new("assets/images/background1")

	self.color1 = Graphics.kColorBlack
	self.color2 = Graphics.kColorWhite

	self.menu = nil
	self.sequence = nil

	self.menuX = 15

	self.menuYFrom = -50
	self.menuY = 15
	self.menuYTo = 240
end

function scene:init()
	scene.super.init(self)

	self.logo = Graphics.image.new("libraries/noble/assets/images/NobleRobotLogo")

	self:setValues()

	self.menu = Noble.Menu.new(false, Noble.Text.ALIGN_LEFT, false, self.color2, 4,6,0, Noble.Text.FONT_SMALL)

	self:setupMenu(self.menu)

	local crankTick = 0

	self.inputHandler = {
		upButtonDown = function()
			self.menu:selectPrevious()
		end,
		downButtonDown = function()
			self.menu:selectNext()
		end,
		cranked = function(change, acceleratedChange)
			crankTick = crankTick + change
			if (crankTick > 30) then
				crankTick = 0
				self.menu:selectNext()
			elseif (crankTick < -30) then
				crankTick = 0
				self.menu:selectPrevious()
			end
		end,
		AButtonDown = function()
			self.menu:click()
		end
	}

end

function scene:enter()
	scene.super.enter(self)
	self.sequence = Sequence.new():from(self.menuYFrom):to(self.menuY, 1.5, Ease.outBounce):start()
end

function scene:start()
	scene.super.start(self)

	self.menu:activate()
end

function scene:drawBackground()
	scene.super.drawBackground(self)

	self.background:draw(0, 0)
end

function scene:update()
	scene.super.update(self)

	Graphics.setColor(self.color1)
	Graphics.setDitherPattern(0.2, Graphics.image.kDitherTypeScreen)
	Graphics.fillRoundRect(self.menuX, self.sequence:get() or self.menuY, 185, 200, 15)
	self.menu:draw(self.menuX+15, self.sequence:get() + 8 or self.menuY+8)

	self:drawLogo()

	Graphics.setColor(Graphics.kColorBlack)

end

function scene:exit()
	scene.super.exit(self)
	self.sequence = Sequence.new():from(self.menuY):to(self.menuYTo, 0.5, Ease.inSine)
	self.sequence:start();
end

function scene:setupMenu(__menu)
	__menu:addItem(Noble.Transition.Cut.name,						function() Noble.transition(ExampleScene2, nil, Noble.Transition.Cut) end)
	__menu:addItem(Noble.Transition.CrossDissolve.name,				function() Noble.transition(ExampleScene2, nil, Noble.Transition.CrossDissolve) end)
	__menu:addItem(Noble.Transition.DipToBlack.name,				function() Noble.transition(ExampleScene2, nil, Noble.Transition.DipToBlack) end)
	__menu:addItem(Noble.Transition.DipToWhite.name,				function() Noble.transition(ExampleScene2, nil, Noble.Transition.DipToWhite) end)
	__menu:addItem(Noble.Transition.Imagetable.name.." (Bolt)",		function() Noble.transition(ExampleScene2, nil, Noble.Transition.Imagetable) end)
	__menu:addItem(Noble.Transition.Imagetable.name.." (Curtain)",	function() Noble.transition(ExampleScene2, nil, Noble.Transition.Imagetable, {
		imagetable = Graphics.imagetable.new("libraries/noble/assets/images/ImagetableTransition"),
		rotateExit = true
	}) end)
	__menu:addItem(Noble.Transition.ImagetableMask.name,			function() Noble.transition(ExampleScene2, nil, Noble.Transition.ImagetableMask, {
		imagetable = Graphics.imagetable.new("libraries/noble/assets/images/ImagetableTransition")
	}) end)
	__menu:addItem(Noble.Transition.Spotlight.name,					function() Noble.transition(ExampleScene2, nil, Noble.Transition.Spotlight, {
		invert = true, xEnterStart = 50, yEnterStart = 50, xEnterEnd = 250, yEnterEnd = 200,
	}) end)
	__menu:addItem(Noble.Transition.SpotlightMask.name,				function() Noble.transition(ExampleScene2, nil, Noble.Transition.SpotlightMask, {
		invert = true
	}) end)
end

function scene:drawLogo()
	Graphics.setColor(self.color2)
	Graphics.fillRoundRect(260, -20, 130, 65, 15)
	self.logo:setInverted(true)
	self.logo:draw(275, 8)
end