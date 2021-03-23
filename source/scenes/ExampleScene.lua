ExampleScene = {}
class("ExampleScene").extends(NobleScene)

ExampleScene.baseColor = Graphics.kColorWhite

local background = nil
local logo = nil

local menu = nil

local sequence = nil

function ExampleScene:init()
	ExampleScene.super.init(self)

	background = Graphics.image.new("assets/images/background1")
	logo = Graphics.image.new("libraries/noble/assets/images/NobleRobotLogo")

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
		"Difficulty: " .. Noble.Settings.get("Difficulty"),
	}
	local difficultyValues = { "Rare", "Medium", "Well Done" }
	local menuHandlers = {
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.DIP_TO_BLACK) end,
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.DIP_TO_WHITE) end,
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.DIP_METRO_NEXUS) end,
		function() Noble.transition(ExampleScene2, 1.5, Noble.TransitionType.DIP_WIDGET_SATCHEL) end,
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.CROSS_DISSOLVE) end,
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.SLIDE_OFF_UP) end,
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.SLIDE_OFF_DOWN) end,
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.SLIDE_OFF_LEFT) end,
		function() Noble.transition(ExampleScene2, 1, Noble.TransitionType.SLIDE_OFF_RIGHT) end,
		function()
			local newValue = math.ringInt(table.indexOfElement(difficultyValues, Noble.Settings.get("Difficulty"))+1, 1, 3)
			Noble.Settings.set("Difficulty", difficultyValues[newValue])
			menuItemKeys[10] = "Difficulty: " .. difficultyValues[newValue]
		end
	}

	menu = UI.gridview.new(190, 10)
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
			Graphics.setColor(Graphics.kColorWhite)
			Graphics.drawLine(x, y+6, x+45, y+6)
		end
		Graphics.setImageDrawMode(Graphics.kDrawModeFillWhite)
		Noble.Text.draw(menuItemKeys[row], x+50, y+2)
	end

	local crankTick = 0

	ExampleScene.inputHandler = {
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

function ExampleScene:enter()
	ExampleScene.super.enter(self)

	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start();

end

function ExampleScene:start()
	ExampleScene.super.start(self)

	menu:setSelectedRow(1)
	Noble.Input.activateCrankIndicator(true)

end

function ExampleScene:drawBackground()
	ExampleScene.super.drawBackground(self)

	background:draw(0, 0)
	Graphics.setColor(Graphics.kColorBlack)
	Graphics.fillRoundRect(15, (sequence:get()*0.75)+15, 185, 125, 15)

	Graphics.setColor(Graphics.kColorWhite)
	Graphics.fillRoundRect(260, -20, 130, 65, 15)
	logo:setInverted(true)
	logo:draw(275, 8)

end

function ExampleScene:update()
	ExampleScene.super.update(self)

	menu:drawInRect(15, sequence:get() or 100, 200, 110)

end

function ExampleScene:exit()
	ExampleScene.super.exit(self)

	Noble.Input.activateCrankIndicator(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();

end

function ExampleScene:finish()
	ExampleScene.super.finish(self)
end