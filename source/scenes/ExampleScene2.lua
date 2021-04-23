ExampleScene2 = {}
class("ExampleScene2").extends(NobleScene)

ExampleScene2.baseColor = Graphics.kColorBlack

local background = nil
local logo = nil

local menu = nil
local sequence = nil

function ExampleScene2:init()
	ExampleScene2.super.init(self)

	background = Graphics.image.new("assets/images/background2")
	logo = Graphics.image.new("libraries/noble/assets/images/NobleRobotLogo")

	menu = Noble.Menu.new(true, Noble.Text.ALIGN_LEFT, false, Graphics.kColorBlack, 4,6,0, Noble.Text.FONT_SMALL)

	menu:addItem(Noble.TransitionType.DIP_TO_BLACK, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.DIP_TO_BLACK) end)
	menu:addItem(Noble.TransitionType.DIP_TO_WHITE, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.DIP_TO_WHITE) end)
	menu:addItem(Noble.TransitionType.DIP_METRO_NEXUS, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.DIP_METRO_NEXUS) end)
	menu:addItem(Noble.TransitionType.DIP_WIDGET_SATCHEL, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.DIP_WIDGET_SATCHEL) end)
	menu:addItem(Noble.TransitionType.CROSS_DISSOLVE, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.CROSS_DISSOLVE) end)
	menu:addItem(Noble.TransitionType.SLIDE_OFF_UP, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_UP) end)
	menu:addItem(Noble.TransitionType.SLIDE_OFF_DOWN, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_DOWN) end)
	menu:addItem(Noble.TransitionType.SLIDE_OFF_LEFT, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_LEFT) end)
	menu:addItem(Noble.TransitionType.SLIDE_OFF_RIGHT, function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_RIGHT) end)
	menu:addItem(
		"Change Score: " .. Noble.GameData.get("Score"),
		function()
			local newValue = math.random(100,99999)
			Noble.GameData.set("Score", newValue)
			menuItemKeys[10] = "Change Score: " .. newValue
		end
	)

	menu:activate()

	local crankTick = 0

	ExampleScene2.inputHandler = {
		upButtonDown = function()
			menu:selectPrevious()
		end,
		downButtonDown = function()
			menu:selectNext()
		end,
		cranked = function(change, acceleratedChange)
			crankTick = crankTick + change
			if (crankTick > 30) then
				crankTick = 0
				menu:selectNext()
			elseif (crankTick < -30) then
				crankTick = 0
				menu:selectPrevious()
			end
		end,
		AButtonDown = function()
			menu:click()
		end
	}

end

function ExampleScene2:enter()
	ExampleScene2.super.enter(self)

	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start();

end

function ExampleScene2:start()
	ExampleScene2.super.start(self)

	menu:setSelectedRow(1)
	Noble.Input.activateCrankIndicator(true)

end

function ExampleScene2:drawBackground()
	ExampleScene2.super.drawBackground(self)

	background:draw(0, 0)
end

function ExampleScene2:update()
	ExampleScene2.super.update(self)

	Graphics.setColor(Graphics.kColorWhite)
	Graphics.setDitherPattern(0.2, Graphics.image.kDitherTypeScreen)
	Graphics.fillRoundRect(15, (sequence:get()*0.75)+3, 185, 145, 15)
	menu:draw(30, sequence:get()-15 or 100-15)

	Graphics.setColor(Graphics.kColorBlack)
	Graphics.fillRoundRect(260, -20, 130, 65, 15)
	logo:setInverted(false)
	logo:draw(275, 8)

end

function ExampleScene2:exit()
	ExampleScene2.super.exit(self)

	Noble.Input.activateCrankIndicator(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();

end

function ExampleScene2:finish()
	ExampleScene2.super.finish(self)
end