ExampleScene2 = {}
class("ExampleScene2").extends(NobleScene)
local scene = ExampleScene2

scene.baseColor = Graphics.kColorBlack

local background <const> = Graphics.image.new("assets/images/background2")
local logo <const> = Graphics.image.new("libraries/noble/assets/images/NobleRobotLogo")
local swipe_it <const> = Graphics.imagetable.new("assets/images/swipe")
local menu
local sequence

function scene:init()
	scene.super.init(self)

    menu = Noble.Menu.new(false, Noble.Text.ALIGN_LEFT, false, Graphics.kColorBlack, 4, 6, 0, Noble.Text.FONT_SMALL)
	menu:addItem("Dip To Black", function() Noble.transition(ExampleScene, 1, Noble.Transition.DipToBlack, nil, nil, Graphics.image.kDitherTypeDiagonalLine) end)
	menu:addItem("Dip To White", function() Noble.transition(ExampleScene, 1, Noble.Transition.DipToWhite, nil, nil, Graphics.image.kDitherTypeAtkinson) end)
	menu:addItem("Dip Metro Nexus", function() Noble.transition(ExampleScene, 2, Noble.Transition.DipMetroNexus) end)
	menu:addItem("Dip Widget Satchel", function() Noble.transition(ExampleScene, 2, Noble.Transition.DipWidgetSatchel, nil, Ease.outBounce) end)
	menu:addItem("Cross Dissolve", function() Noble.transition(ExampleScene, 2, Noble.Transition.CrossDissolve, nil, nil, Graphics.image.kDitherTypeVerticalLine) end)
	menu:addItem("Animation", function() Noble.transition(ExampleScene, 2, Noble.Transition.Animation, nil, nil, swipe_it) end)
    menu:addItem("Spotlight", function() Noble.transition(ExampleScene, 2.5, Noble.Transition.Spotlight, nil, Ease.inOutCirc, 325, 21, 107, 120) end)
	menu:addItem("Slide Off (Up)", function() Noble.transition(ExampleScene, 1.5, Noble.Transition.SlideOffUp) end)
	menu:addItem("Slide Off (Down)", function() Noble.transition(ExampleScene, 1.5, Noble.Transition.SlideOffDown) end)
	menu:addItem("Slide Off (Left)", function() Noble.transition(ExampleScene, 1.5, Noble.Transition.SlideOffLeft) end)
	menu:addItem("Slide Off (Right)", function() Noble.transition(ExampleScene, 1.5, Noble.Transition.SlideOffRight) end)
	menu:addItem(
		"Score",
		function()
			local newValue = math.random(100,99999)
			Noble.GameData.set("Score", newValue)
			menu:setItemDisplayName("Score", "Change Score: " .. newValue)
		end, nil,
		"Change Score: " .. Noble.GameData.get("Score")
	)

	local crankTick = 0

	scene.inputHandler = {
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

function scene:enter()
	scene.super.enter(self)

	sequence = Sequence.new():from(0):to(89, 1.5, Ease.outBounce)
	sequence:start();
end

function scene:start()
	scene.super.start(self)

	menu:activate()
	Noble.Input.setCrankIndicatorStatus(true)
end

function scene:drawBackground()
	scene.super.drawBackground(self)

	background:draw(0, 0)
end

function scene:update()
	scene.super.update(self)

	Graphics.setColor(Graphics.kColorWhite)
	Graphics.setDitherPattern(0.2, Graphics.image.kDitherTypeScreen)
	Graphics.fillRoundRect(15, (sequence:get()*0.75)+3, 185, 165, 15)
	menu:draw(30, sequence:get()-15 or 80-15)

	Graphics.setColor(Graphics.kColorBlack)
	Graphics.fillRoundRect(260, -20, 130, 65, 15)
	logo:setInverted(false)
	logo:draw(275, 8)
end

function scene:exit()
	scene.super.exit(self)

	Noble.Input.setCrankIndicatorStatus(false)
	sequence = Sequence.new():from(100):to(315, 0.25, Ease.inSine)
	sequence:start();

end

function scene:finish()
	scene.super.finish(self)
end
