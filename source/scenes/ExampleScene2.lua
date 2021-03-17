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
	logo = Graphics.image.new("noble/assets/images/NobleRobotLogo")

	local menuItemKeys = {
		Noble.TransitionType.DIP_TO_BLACK,
		Noble.TransitionType.DIP_TO_WHITE,
		Noble.TransitionType.DIP_METRO_NEXUS,
		Noble.TransitionType.DIP_WIDGET_SATCHEL,
		Noble.TransitionType.CROSS_DISSOLVE,
		Noble.TransitionType.SLIDE_OFF_UP,
		Noble.TransitionType.SLIDE_OFF_DOWN,
		Noble.TransitionType.SLIDE_OFF_LEFT,
		Noble.TransitionType.SLIDE_OFF_RIGHT,
		"Change Score: " .. Noble.GameData.get("Score"),
	}
	local menuHandlers = {
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.DIP_TO_BLACK) end,
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.DIP_TO_WHITE) end,
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.DIP_METRO_NEXUS) end,
		function() Noble.transition(ExampleScene, 1.5, Noble.TransitionType.DIP_WIDGET_SATCHEL) end,
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.CROSS_DISSOLVE) end,
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_UP) end,
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_DOWN) end,
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_LEFT) end,
		function() Noble.transition(ExampleScene, 1, Noble.TransitionType.SLIDE_OFF_RIGHT) end,
		function()
			local newValue = math.random(100,99999)
			Noble.GameData.set("Score", newValue)
			menuItemKeys[10] = "Change Score: " .. newValue
		end
	}

	menu = UI.gridview.new(200, 10)
	menu:setNumberOfColumns(1)
	menu:setNumberOfRows(10)
	menu:setCellPadding(0, 0, 0, 0)
	menu.changeRowOnColumnWrap = false
	menu:setSelectedRow(0)

	function menu:drawCell(section, row, column, selected, x, y, width, height)
		Noble.Text.setFont(Noble.Text.small)
		if selected then
			Graphics.setPattern({0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55})
			Graphics.setLineWidth(5)
			Graphics.drawLine(x, y+6, x+45, y+6)
			Graphics.setLineWidth(1)
			Graphics.setColor(Graphics.kColorBlack)
			Graphics.drawLine(x, y+6, x+45, y+6)
		end
		Graphics.setImageDrawMode(Graphics.kDrawModeFillBlack)
		Noble.Text.draw(menuItemKeys[row], x+50, y+2)
	end

	local crankTick = 0

	ExampleScene2.inputHandler = {
		upButtonDown = function()
			menu:selectPreviousRow(true, false, false)
		end,
		downButtonDown = function()
			menu:selectNextRow(true, false, false)
		end,
		cranked = function(change, acceleratedChange)
			crankTick = crankTick + change
			if (crankTick > 30) then
				crankTick = 0
				menu:selectNextRow(true, false, false)
			elseif (crankTick < -30) then
				crankTick = 0
				menu:selectPreviousRow(true, false, false)
			end
		end,
		AButtonDown = function()
			menuHandlers[menu.selectedRow]()
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
	Noble.showCrankIndicator(true)

end

function ExampleScene2:drawBackground()
	ExampleScene2.super.drawBackground(self)

	background:draw(0, 0)
	Graphics.setColor(Graphics.kColorWhite)
	Graphics.fillRoundRect(15, (sequence:get()*0.75)+15, 185, 125, 15)

	Graphics.setColor(Graphics.kColorBlack)
	Graphics.fillRoundRect(260, -20, 130, 65, 15)
	logo:draw(275, 8)

end

function ExampleScene2:update()
	ExampleScene2.super.update(self)

	menu:drawInRect(15, sequence:get() or 100, 200, 110)

end

function ExampleScene2:exit()
	ExampleScene2.super.exit(self)

	Noble.showCrankIndicator(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();

end

function ExampleScene2:finish()
	ExampleScene2.super.finish(self)
end