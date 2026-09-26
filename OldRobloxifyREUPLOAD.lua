game.CoreGui.TopBarApp:Destroy()
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")

local connections = {}

local function connect(signal, callback)
	local connection = signal:Connect(callback)
	table.insert(connections, connection)
	return connection
end

local function hideGuiObject(object)
	if not object or not object:IsA("GuiObject") then
		return
	end

	pcall(function()
		object.Visible = false
	end)

	pcall(function()
		object.Active = false
	end)

	pcall(function()
		object.Selectable = false
	end)

	pcall(function()
		object.AutoButtonColor = false
	end)

	pcall(function()
		object.BackgroundTransparency = 1
	end)

	pcall(function()
		object.ImageTransparency = 1
	end)

	pcall(function()
		object.TextTransparency = 1
	end)
end

local function hideNativeSettingsMenu()
	local robloxGui = CoreGui:FindFirstChild("RobloxGui")
	if not robloxGui then
		return
	end

	local shield = robloxGui:FindFirstChild("SettingsClippingShield")
	if not shield then
		return
	end

	hideGuiObject(shield)

	for _, object in ipairs(shield:GetDescendants()) do
		hideGuiObject(object)
	end
end

local hookedObjects = {}

local function hookGuiObject(object)
	if not object then
		return
	end

	if not object:IsA("GuiObject") then
		return
	end

	if hookedObjects[object] then
		return
	end

	hookedObjects[object] = true

	connect(object:GetPropertyChangedSignal("Visible"), function()
		if object.Visible then
			hideNativeSettingsMenu()
		end
	end)

	if object.Visible then
		hideGuiObject(object)
	end
end

local function hookSettingsShield(shield)
	if not shield then
		return
	end

	hideNativeSettingsMenu()

	hookGuiObject(shield)

	for _, object in ipairs(shield:GetDescendants()) do
		hookGuiObject(object)
	end

	connect(shield.DescendantAdded, function(object)
		hookGuiObject(object)

		task.defer(function()
			hideGuiObject(object)
			hideNativeSettingsMenu()
		end)
	end)
end

local function hookRobloxGui()
	local robloxGui = CoreGui:FindFirstChild("RobloxGui")

	if not robloxGui then
		robloxGui = CoreGui:WaitForChild("RobloxGui", 10)
	end

	if not robloxGui then
		return
	end

	local shield = robloxGui:FindFirstChild("SettingsClippingShield")

	if shield then
		hookSettingsShield(shield)
	end

	connect(robloxGui.ChildAdded, function(child)
		if child.Name == "SettingsClippingShield" then
			task.defer(function()
				hookSettingsShield(child)
			end)
		end
	end)

	connect(robloxGui.DescendantAdded, function(object)
		local currentShield =
			robloxGui:FindFirstChild("SettingsClippingShield")

		if currentShield and object:IsDescendantOf(currentShield) then
			hookGuiObject(object)

			task.defer(function()
				hideGuiObject(object)
			end)
		end
	end)
end

local function blockEscapeMenu(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		hideNativeSettingsMenu()

		task.defer(function()
			hideNativeSettingsMenu()
		end)
	end

	return Enum.ContextActionResult.Sink
end

-- Try Roblox's CoreAction API first.
local bound = pcall(function()
	ContextActionService:BindCoreActionAtPriority(
		"RBXEscapeMainMenu",
		blockEscapeMenu,
		false,
		10000,
		Enum.KeyCode.Escape,
		Enum.KeyCode.ButtonStart
	)
end)

-- Fallback.
if not bound then
	bound = pcall(function()
		ContextActionService:BindCoreAction(
			"RBXEscapeMainMenu",
			blockEscapeMenu,
			false,
			Enum.KeyCode.Escape,
			Enum.KeyCode.ButtonStart
		)
	end)
end

-- Final fallback if CoreAction isn't available.
if not bound then
	ContextActionService:BindActionAtPriority(
		"RBXEscapeMainMenu",
		blockEscapeMenu,
		false,
		10000,
		Enum.KeyCode.Escape,
		Enum.KeyCode.ButtonStart
	)
end

hookRobloxGui()

hideNativeSettingsMenu()

task.defer(function()
	hideNativeSettingsMenu()
end)

local G2L = {};

-- StarterGui.RobloxGui
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["DisplayOrder"] = 10;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
G2L["1"]["Name"] = [[RobloxGui]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;


-- StarterGui.RobloxGui.LoadingScreen
G2L["2"] = Instance.new("LocalScript", G2L["1"]);
G2L["2"]["Name"] = [[LoadingScreen]];


-- StarterGui.RobloxGui.Topbar
G2L["3"] = Instance.new("LocalScript", G2L["1"]);
G2L["3"]["Name"] = [[Topbar]];


-- StarterGui.RobloxGui.Modules
G2L["4"] = Instance.new("Folder", G2L["1"]);
G2L["4"]["Name"] = [[Modules]];


-- StarterGui.RobloxGui.Modules.BackpackScript
G2L["5"] = Instance.new("ModuleScript", G2L["4"]);
-- [ERROR] cannot convert Capabilities, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"
G2L["5"]["Name"] = [[BackpackScript]];
G2L["5"]["Sandboxed"] = true;


-- StarterGui.RobloxGui.Modules.TenFootInterface
G2L["6"] = Instance.new("ModuleScript", G2L["4"]);
G2L["6"]["Name"] = [[TenFootInterface]];


-- StarterGui.RobloxGui.Modules.PlayerPermissionsModule
G2L["7"] = Instance.new("ModuleScript", G2L["4"]);
G2L["7"]["Name"] = [[PlayerPermissionsModule]];


-- StarterGui.RobloxGui.Modules.PlayerlistModule
G2L["8"] = Instance.new("ModuleScript", G2L["4"]);
G2L["8"]["Name"] = [[PlayerlistModule]];


-- StarterGui.RobloxGui.Modules.PlayerDropDown
G2L["9"] = Instance.new("ModuleScript", G2L["4"]);
G2L["9"]["Name"] = [[PlayerDropDown]];


-- StarterGui.RobloxGui.Modules.Chat
G2L["a"] = Instance.new("ModuleScript", G2L["4"]);
G2L["a"]["Name"] = [[Chat]];


-- StarterGui.RobloxGui.Modules.Settings
G2L["b"] = Instance.new("Folder", G2L["4"]);
G2L["b"]["Name"] = [[Settings]];


-- StarterGui.RobloxGui.Modules.Settings.SettingsPageFactory
G2L["c"] = Instance.new("ModuleScript", G2L["b"]);
G2L["c"]["Name"] = [[SettingsPageFactory]];


-- StarterGui.RobloxGui.Modules.Settings.Utility
G2L["d"] = Instance.new("ModuleScript", G2L["b"]);
G2L["d"]["Name"] = [[Utility]];


-- StarterGui.RobloxGui.Modules.Settings.SettingsHub
G2L["e"] = Instance.new("ModuleScript", G2L["b"]);
G2L["e"]["Name"] = [[SettingsHub]];


-- StarterGui.RobloxGui.Modules.Settings.Pages
G2L["f"] = Instance.new("Folder", G2L["b"]);
G2L["f"]["Name"] = [[Pages]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.GameSettings
G2L["10"] = Instance.new("ModuleScript", G2L["f"]);
G2L["10"]["Name"] = [[GameSettings]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.Help
G2L["11"] = Instance.new("ModuleScript", G2L["f"]);
G2L["11"]["Name"] = [[Help]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.Home
G2L["12"] = Instance.new("ModuleScript", G2L["f"]);
G2L["12"]["Name"] = [[Home]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.LeaveGame
G2L["13"] = Instance.new("ModuleScript", G2L["f"]);
G2L["13"]["Name"] = [[LeaveGame]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.ResetCharacter
G2L["14"] = Instance.new("ModuleScript", G2L["f"]);
G2L["14"]["Name"] = [[ResetCharacter]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.Record
G2L["15"] = Instance.new("ModuleScript", G2L["f"]);
G2L["15"]["Name"] = [[Record]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.Players
G2L["16"] = Instance.new("ModuleScript", G2L["f"]);
G2L["16"]["Name"] = [[Players]];


-- StarterGui.RobloxGui.Modules.Settings.Pages.ReportAbuseMenu
G2L["17"] = Instance.new("ModuleScript", G2L["f"]);
G2L["17"]["Name"] = [[ReportAbuseMenu]];


-- StarterGui.RobloxGui.ControlFrame
G2L["18"] = Instance.new("Frame", G2L["1"]);
G2L["18"]["BorderSizePixel"] = 0;
G2L["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["18"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["18"]["Name"] = [[ControlFrame]];
G2L["18"]["BackgroundTransparency"] = 1;


-- StarterGui.RobloxGui.ControlFrame.BottomLeftControl
G2L["19"] = Instance.new("Frame", G2L["18"]);
G2L["19"]["Size"] = UDim2.new(0, 130, 0, 46);
G2L["19"]["Position"] = UDim2.new(0, 0, 1, -46);
G2L["19"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["19"]["Name"] = [[BottomLeftControl]];
G2L["19"]["BackgroundTransparency"] = 1;


-- StarterGui.RobloxGui.ControlFrame.BottomRightControl
G2L["1a"] = Instance.new("Frame", G2L["18"]);
G2L["1a"]["Size"] = UDim2.new(0, 130, 0, 46);
G2L["1a"]["Position"] = UDim2.new(1, -130, 1, -46);
G2L["1a"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["1a"]["Name"] = [[BottomRightControl]];
G2L["1a"]["BackgroundTransparency"] = 1;


-- StarterGui.RobloxGui.ControlFrame.TopLeftControl
G2L["1b"] = Instance.new("Frame", G2L["18"]);
G2L["1b"]["Size"] = UDim2.new(0, 130, 0, 46);
G2L["1b"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["1b"]["Name"] = [[TopLeftControl]];
G2L["1b"]["BackgroundTransparency"] = 1;


-- Require G2L wrapper
local G2L_REQUIRE = require;
local G2L_MODULES = {};
local function require(Module:ModuleScript)
    local ModuleState = G2L_MODULES[Module];
    if ModuleState then
        if not ModuleState.Required then
            ModuleState.Required = true;
            ModuleState.Value = ModuleState.Closure();
        end
        return ModuleState.Value;
    end;
    return G2L_REQUIRE(Module);
end

G2L_MODULES[G2L["5"]] = {
Closure = function()
    local script = G2L["5"];--!nocheck

-- Backpack Version 5.1
-- OnlyTwentyCharacters, SolarCrane

local BackpackScript = {}
BackpackScript.OpenClose = nil -- Function to toggle open/close
BackpackScript.IsOpen = false
BackpackScript.StateChanged = Instance.new('BindableEvent') -- Fires after any open/close, passes IsNowOpen

BackpackScript.ModuleName = "Backpack"
BackpackScript.KeepVRTopbarOpen = true
BackpackScript.VRIsExclusive = true
BackpackScript.VRClosesNonExclusive = true

local ICON_SIZE = 60
local FONT_SIZE = Enum.FontSize.Size14
local ICON_BUFFER = 5

local BACKGROUND_FADE = 0.50
local BACKGROUND_COLOR = Color3.new(31/255, 31/255, 31/255)

local VR_FADE_TIME = 1
local VR_PANEL_RESOLUTION = 100

local SLOT_DRAGGABLE_COLOR = Color3.new(49/255, 49/255, 49/255)
local SLOT_EQUIP_COLOR = Color3.new(90/255, 142/255, 233/255)
local SLOT_EQUIP_THICKNESS = 0.1 -- Relative
local SLOT_FADE_LOCKED = 0.50 -- Locked means undraggable
local SLOT_BORDER_COLOR = Color3.new(1, 1, 1) -- Appears when dragging

local TOOLTIP_BUFFER = 6
local TOOLTIP_HEIGHT = 16
local TOOLTIP_OFFSET = -25 -- From top

local ARROW_IMAGE_OPEN = 'rbxasset://textures/ui/Backpack_Open.png'
local ARROW_IMAGE_CLOSE = 'rbxasset://textures/ui/Backpack_Close.png'
local ARROW_SIZE = UDim2.new(0, 14, 0, 9)
local ARROW_HOTKEY = Enum.KeyCode.Backquote.Value --TODO: Hookup '~' too?
local ARROW_HOTKEY_STRING = '`'
local ARROW_HOVER_COLOR = Color3.new(0,162/255,1)

local HOTBAR_SLOTS_FULL = 10
local HOTBAR_SLOTS_VR = 6
local HOTBAR_SLOTS_MINI = 3
local HOTBAR_SLOTS_WIDTH_CUTOFF = 1024 -- Anything smaller is MINI
local HOTBAR_OFFSET_FROMBOTTOM = -30 -- Offset to make room for the Health GUI

local INVENTORY_ROWS_FULL = 4
local INVENTORY_ROWS_VR = 3
local INVENTORY_ROWS_MINI = 2
local INVENTORY_HEADER_SIZE = 40
local INVENTORY_ARROWS_BUFFER_VR = 40

local SEARCH_BUFFER = 5
local SEARCH_WIDTH = 200
local SEARCH_TEXT = "   Search"

local SEARCH_TEXT_OFFSET_FROMLEFT = 0
local SEARCH_BACKGROUND_COLOR = Color3.new(0.37, 0.37, 0.37)
local SEARCH_BACKGROUND_FADE = 0.15

local DOUBLE_CLICK_TIME = 0.5

local ZERO_KEY_VALUE = Enum.KeyCode.Zero.Value
local DROP_HOTKEY_VALUE = Enum.KeyCode.Backspace.Value

local GAMEPAD_INPUT_TYPES =
{
	[Enum.UserInputType.Gamepad1] = true;
	[Enum.UserInputType.Gamepad2] = true;
	[Enum.UserInputType.Gamepad3] = true;
	[Enum.UserInputType.Gamepad4] = true;
	[Enum.UserInputType.Gamepad5] = true;
	[Enum.UserInputType.Gamepad6] = true;
	[Enum.UserInputType.Gamepad7] = true;
	[Enum.UserInputType.Gamepad8] = true;
}

local PlayersService = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local StarterGui = game:GetService('StarterGui')
local GuiService = game:GetService('GuiService')
local CoreGui = script.Parent.Parent.Parent
local ContextActionService = game:GetService('ContextActionService')
local VRService = game:GetService("VRService")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local EquipToolEvent = ReplicatedStorage:WaitForChild('BackpackEquipTool', 10)
local RobloxGui = CoreGui:WaitForChild('RobloxGui')
local IsTenFootInterface = GuiService:IsTenFootInterface()

local FFlagRobloxGuiSiblingZindexs = false

local FFlagTapAwayToCloseBackpack = false

pcall(function()
	local LocalizationService = game:GetService("LocalizationService")
	local CorescriptLocalization = LocalizationService:GetCorescriptLocalizations()[1]
	SEARCH_TEXT = CorescriptLocalization:GetString(
		LocalizationService.RobloxLocaleId,
		"BACKPACK_SEARCH"
	)
end)

local TopbarEnabled = true

if IsTenFootInterface then
	ICON_SIZE = 100
	FONT_SIZE = Enum.FontSize.Size24
end

local GamepadActionsBound = false

local IS_PHONE = UserInputService.TouchEnabled and workspace.CurrentCamera.ViewportSize.X < HOTBAR_SLOTS_WIDTH_CUTOFF

local Player = PlayersService.LocalPlayer

local MainFrame = nil
local HotbarFrame = nil
local OpenInventoryButton = nil
local CloseInventoryButton = nil
local InventoryFrame = nil
local VRInventorySelector = nil
local ScrollingFrame = nil
local UIGridFrame = nil
local UIGridLayout = nil
local ScrollUpInventoryButton = nil
local ScrollDownInventoryButton = nil

local Character = nil
local Humanoid = nil
local Backpack = nil

local Slots = {} -- List of all Slots by index
local LowestEmptySlot = nil
local SlotsByTool = {} -- Map of Tools to their assigned Slots
local HotkeyFns = {} -- Map of KeyCode values to their assigned behaviors
local Dragging = {} -- Only used to check if anything is being dragged, to disable other input
local FullHotbarSlots = 0 -- Now being used to also determine whether or not LB and RB on the gamepad are enabled.
local ActiveHopper = nil -- NOTE: HopperBin
local StarterToolFound = false -- Special handling is required for the gear currently equipped on the site
local WholeThingEnabled = false
local TextBoxFocused = false -- ANY TextBox, not just the search box
local ViewingSearchResults = false -- If the results of a search are currently being viewed
local HotkeyStrings = {} -- Used for eating/releasing hotkeys
local CharConns = {} -- Holds character connections to be cleared later
local GamepadEnabled = false -- determines if our gui needs to be gamepad friendly
local TimeOfLastToolChange = 0

local IsVR = VRService.VREnabled -- Are we currently using a VR device?
local NumberOfHotbarSlots = IsVR and HOTBAR_SLOTS_VR or (IS_PHONE and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL) -- Number of slots shown at the bottom
local NumberOfInventoryRows = IsVR and INVENTORY_ROWS_VR or (IS_PHONE and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL) -- How many rows in the popped-up inventory
local BackpackPanel = nil

local lastEquippedSlot = nil

local function EvaluateBackpackPanelVisibility(enabled)
	return enabled and TopbarEnabled and VRService.VREnabled
end

local function ShowVRBackpackPopup()
	if BackpackPanel and EvaluateBackpackPanelVisibility(true) then
		BackpackPanel:ForceShowForSeconds(2)
	end
end

local function NewGui(className, objectName)
	local newGui = Instance.new(className)
	newGui.Name = objectName
	newGui.BackgroundColor3 = Color3.new(0, 0, 0)
	newGui.BackgroundTransparency = 1
	newGui.BorderColor3 = Color3.new(0, 0, 0)
	newGui.BorderSizePixel = 0
	newGui.Size = UDim2.new(1, 0, 1, 0)
	if className:match('Text') then
		newGui.TextColor3 = Color3.new(1, 1, 1)
		newGui.Text = ''
		newGui.Font = Enum.Font.SourceSans
		newGui.FontSize = FONT_SIZE
		newGui.TextWrapped = true
		if className == 'TextButton' then
			newGui.Font = Enum.Font.SourceSansBold
			newGui.BorderSizePixel = 1
		end
	end
	return newGui
end

local function FindLowestEmpty()
	for i = 1, NumberOfHotbarSlots do
		local slot = Slots[i]
		if not slot.Tool then
			return slot
		end
	end
	return nil
end

local function isInventoryEmpty()
	for i = NumberOfHotbarSlots + 1, #Slots do
		local slot = Slots[i]
		if slot and slot.Tool then
			return false
		end
	end
	return true
end

local function UseGazeSelection()
	return UserInputService.VREnabled
end

local function AdjustHotbarFrames()
	local inventoryOpen = InventoryFrame.Visible -- (Show all)
	local visualTotal = (inventoryOpen) and NumberOfHotbarSlots or FullHotbarSlots
	local visualIndex = 0
	local hotbarIsVisible = (visualTotal >= 1)

	for i = 1, NumberOfHotbarSlots do
		local slot = Slots[i]
		if slot.Tool or inventoryOpen then
			visualIndex = visualIndex + 1
			slot:Readjust(visualIndex, visualTotal)
			slot.Frame.Visible = true
		else
			slot.Frame.Visible = false
		end
	end

	OpenInventoryButton.Visible = not inventoryOpen and (hotbarIsVisible or not isInventoryEmpty())
	OpenInventoryButton.Position = UDim2.new(0.5, -15, 1, hotbarIsVisible and -110 or -50)
end

local function UpdateScrollingFrameCanvasSize()
	local countX = math.floor(ScrollingFrame.AbsoluteSize.X/(ICON_SIZE + ICON_BUFFER))
	local maxRow = math.ceil((#UIGridFrame:GetChildren() - 1)/countX)
	local canvasSizeY = maxRow*(ICON_SIZE + ICON_BUFFER) + ICON_BUFFER
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, canvasSizeY)
end

local function AdjustInventoryFrames()
	for i = NumberOfHotbarSlots + 1, #Slots do
		local slot = Slots[i]
		slot.Frame.LayoutOrder = slot.Index
		slot.Frame.Visible = (slot.Tool ~= nil)
	end
	UpdateScrollingFrameCanvasSize()
end

local function UpdateBackpackLayout()
	HotbarFrame.Size = UDim2.new(0, ICON_BUFFER + (NumberOfHotbarSlots * (ICON_SIZE + ICON_BUFFER)), 0, ICON_BUFFER + ICON_SIZE + ICON_BUFFER)
	HotbarFrame.Position = UDim2.new(0.5, -HotbarFrame.Size.X.Offset / 2, 1, -HotbarFrame.Size.Y.Offset)
	InventoryFrame.Size = UDim2.new(0, HotbarFrame.Size.X.Offset, 0, (HotbarFrame.Size.Y.Offset * NumberOfInventoryRows) + INVENTORY_HEADER_SIZE + (IsVR and 2*INVENTORY_ARROWS_BUFFER_VR or 0))
	InventoryFrame.Position = UDim2.new(0.5, -InventoryFrame.Size.X.Offset / 2, 1, HotbarFrame.Position.Y.Offset - InventoryFrame.Size.Y.Offset)

	ScrollingFrame.Size = UDim2.new(1, ScrollingFrame.ScrollBarThickness + 1, 1, -INVENTORY_HEADER_SIZE - (IsVR and 2*INVENTORY_ARROWS_BUFFER_VR or 0))
	ScrollingFrame.Position = UDim2.new(0, 0, 0, INVENTORY_HEADER_SIZE + (IsVR and INVENTORY_ARROWS_BUFFER_VR or 0))
	AdjustHotbarFrames()
	AdjustInventoryFrames()
end

local function Clamp(low, high, num)
	return math.min(high, math.max(low, num))
end

local function CheckBounds(guiObject, x, y)
	local pos = guiObject.AbsolutePosition
	local size = guiObject.AbsoluteSize
	return (x > pos.X and x <= pos.X + size.X and y > pos.Y and y <= pos.Y + size.Y)
end

local function GetOffset(guiObject, point)
	local centerPoint = guiObject.AbsolutePosition + (guiObject.AbsoluteSize / 2)
	return (centerPoint - point).magnitude
end

local function DisableActiveHopper() --NOTE: HopperBin
	ActiveHopper:ToggleSelect()
	SlotsByTool[ActiveHopper]:UpdateEquipView()
	ActiveHopper = nil
end

local function UnequipAllTools() --NOTE: HopperBin
	if Humanoid then
		Humanoid:UnequipTools()
		if EquipToolEvent then
			pcall(function()
				EquipToolEvent:FireServer("unequip")
			end)
		end
		if ActiveHopper then
			DisableActiveHopper()
		end
	end
end

-- Track pending equip requests to prevent race conditions
local pendingEquip = false

local function EquipNewTool(tool) --NOTE: HopperBin
	UnequipAllTools()
	if tool:IsA('HopperBin') then
		tool:ToggleSelect()
		SlotsByTool[tool]:UpdateEquipView()
		ActiveHopper = tool
	else
		-- Fire the RemoteEvent FIRST so the server equips the tool
		-- This ensures server-side Tool scripts (Equipped, Activated, etc.) fire properly
		if EquipToolEvent then
			pcall(function()
				EquipToolEvent:FireServer("equip", tool)
			end)
		end
		-- Also set parent locally for immediate UI feedback
		-- The server's change will replicate and confirm this
		tool.Parent = Character
	end
end

local function IsEquipped(tool)
	return tool and ((tool:IsA('HopperBin') and tool.Active) or tool.Parent == Character) --NOTE: HopperBin
end

local function MakeSlot(parent, index)
	index = index or (#Slots + 1)

	-- Slot Definition --

	local slot = {}
	slot.Tool = nil
	slot.Index = index
	slot.Frame = nil

	local SlotFrameParent = nil
	local SlotFrame = nil
	local FakeSlotFrame = nil
	local ToolIcon = nil
	local ToolName = nil
	local ToolChangeConn = nil
	local HighlightFrame = nil
	local SelectionObj = nil

	--NOTE: The following are only defined for Hotbar Slots
	local ToolTip = nil
	local SlotNumber = nil

	-- Slot Functions --

	local function UpdateSlotFading()
		if VRService.VREnabled and BackpackPanel then
			local panelTransparency = BackpackPanel.transparency
			local slotTransparency = SLOT_FADE_LOCKED

			-- This equation multiplies the two transparencies together.
			local finalTransparency = panelTransparency + slotTransparency - panelTransparency * slotTransparency

			SlotFrame.BackgroundTransparency = finalTransparency
			SlotFrame.TextTransparency = finalTransparency
			if ToolIcon then
				ToolIcon.ImageTransparency = InventoryFrame.Visible and 0 or panelTransparency
			end
			if HighlightFrame then
				for _, child in pairs(HighlightFrame:GetChildren()) do
					child.BackgroundTransparency = finalTransparency
				end
			end

			SlotFrame.SelectionImageObject = SelectionObj
		else
			SlotFrame.SelectionImageObject = nil
			SlotFrame.BackgroundTransparency = (SlotFrame.Draggable) and 0 or SLOT_FADE_LOCKED
		end
		SlotFrame.BackgroundColor3 = (SlotFrame.Draggable) and SLOT_DRAGGABLE_COLOR or BACKGROUND_COLOR
	end

	function slot:Readjust(visualIndex, visualTotal) --NOTE: Only used for Hotbar slots
		local centered = HotbarFrame.Size.X.Offset / 2
		local sizePlus = ICON_BUFFER + ICON_SIZE
		local midpointish = (visualTotal / 2) + 0.5
		local factor = visualIndex - midpointish
		SlotFrame.Position = UDim2.new(0, centered - (ICON_SIZE / 2) + (sizePlus * factor), 0, ICON_BUFFER)
	end

	function slot:Fill(tool)
		if not tool then
			return self:Clear()
		end

		self.Tool = tool

		local function assignToolData()
			local icon = tool.TextureId
			ToolIcon.Image = icon

			if icon ~= "" then
				ToolName.Visible = false
			end

			if ToolTip and tool:IsA('Tool') then --NOTE: HopperBin
				local width = ToolTip.TextBounds.X + TOOLTIP_BUFFER
				ToolTip.Size = UDim2.new(0, width, 0, TOOLTIP_HEIGHT)
				ToolTip.Position = UDim2.new(0.5, -width / 2, 0, TOOLTIP_OFFSET)
			end
		end
		assignToolData()

		if ToolChangeConn then
			ToolChangeConn:disconnect()
			ToolChangeConn = nil
		end

		ToolChangeConn = tool.Changed:connect(function(property)
			if property == 'TextureId' or property == 'Name' or property == 'ToolTip' then
				assignToolData()
			end
		end)

		local hotbarSlot = (self.Index <= NumberOfHotbarSlots)
		local inventoryOpen = InventoryFrame.Visible

		if (not hotbarSlot or inventoryOpen) and not UserInputService.VREnabled then
			SlotFrame.Draggable = true
		end

		self:UpdateEquipView()

		if hotbarSlot then
			FullHotbarSlots = FullHotbarSlots + 1
			-- If using a controller, determine whether or not we can enable BindCoreAction("RBXHotbarEquip", etc)
			if WholeThingEnabled then
				if FullHotbarSlots >= 1 and not GamepadActionsBound then
					-- Player added first item to a hotbar slot, enable BindCoreAction
					GamepadActionsBound = true
					ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
				end
			end
		end

		SlotsByTool[tool] = self
		LowestEmptySlot = FindLowestEmpty()
	end

	function slot:Clear()
		if not self.Tool then return end

		if ToolChangeConn then
			ToolChangeConn:disconnect()
			ToolChangeConn = nil
		end

		ToolIcon.Image = ''
		ToolName.Text = ''
		if ToolTip then
			ToolTip.Text = ''
			ToolTip.Visible = false
		end
		SlotFrame.Draggable = false

		self:UpdateEquipView(true) -- Show as unequipped

		if self.Index <= NumberOfHotbarSlots then
			FullHotbarSlots = FullHotbarSlots - 1
			if FullHotbarSlots < 1 then
				GamepadActionsBound = false
				ContextActionService:UnbindAction("RBXHotbarEquip")
			end
		end

		SlotsByTool[self.Tool] = nil
		self.Tool = nil
		LowestEmptySlot = FindLowestEmpty()
	end

	function slot:UpdateEquipView(unequippedOverride)
		if not unequippedOverride and IsEquipped(self.Tool) then -- Equipped
			lastEquippedSlot = slot
			if not HighlightFrame then
				HighlightFrame = NewGui('Frame', 'Equipped')
				HighlightFrame.ZIndex = SlotFrame.ZIndex
				local t = SLOT_EQUIP_THICKNESS
				local dataTable = { -- Relative sizes and positions
					{t,       1, 0,     0},
					{1 - 2*t, t, t,     0},
					{t,       1, 1 - t, 0},
					{1 - 2*t, t, t,     1 - t},
				}
				for _, data in pairs(dataTable) do
					local edgeFrame = NewGui('Frame', 'Edge')
					edgeFrame.BackgroundTransparency = 0
					edgeFrame.BackgroundColor3 = SLOT_EQUIP_COLOR
					edgeFrame.Size = UDim2.new(data[1], 0, data[2], 0)
					edgeFrame.Position = UDim2.new(data[3], 0, data[4], 0)
					edgeFrame.ZIndex = HighlightFrame.ZIndex
					edgeFrame.Parent = HighlightFrame
				end
			end
			HighlightFrame.Parent = SlotFrame
		else -- In the Backpack
			if HighlightFrame then
				HighlightFrame.Parent = nil
			end
		end
		UpdateSlotFading()
	end

	function slot:IsEquipped()
		return IsEquipped(self.Tool)
	end

	function slot:Delete()
		Dragging[SlotFrame] = nil
		SlotFrame:Destroy() --NOTE: Also clears connections
		table.remove(Slots, self.Index)
		local newSize = #Slots

		-- Now adjust the rest (both visually and representationally)
		for i = self.Index, newSize do
			Slots[i]:SlideBack()
		end

		UpdateScrollingFrameCanvasSize()
	end

	function slot:Swap(targetSlot) --NOTE: This slot (self) must not be empty!
		local myTool, otherTool = self.Tool, targetSlot.Tool
		self:Clear()
		if otherTool then -- (Target slot might be empty)
			targetSlot:Clear()
			self:Fill(otherTool)
		end
		if myTool then
			targetSlot:Fill(myTool)
		else
			targetSlot:Clear()
		end
	end

	function slot:SlideBack() -- For inventory slot shifting
		self.Index = self.Index - 1
		SlotFrame.Name = self.Index
		SlotFrame.LayoutOrder = self.Index
	end

	function slot:TurnNumber(on)
		if SlotNumber then
			SlotNumber.Visible = on
		end
	end

	function slot:SetClickability(on) -- (Happens on open/close arrow)
		if self.Tool then
			if UserInputService.VREnabled then
				SlotFrame.Draggable = false
			else
				SlotFrame.Draggable = not on
			end
			UpdateSlotFading()
		end
	end

	function slot:CheckTerms(terms)
		local hits = 0
		local function checkEm(str, term)
			local _, n = str:lower():gsub(term, '')
			hits = hits + n
		end
		local tool = self.Tool
		if tool then
			for term in pairs(terms) do
				checkEm(ToolName.Text, term)
				if tool:IsA('Tool') then --NOTE: HopperBin
					local toolTipText = ToolTip and ToolTip.Text or ""
					checkEm(toolTipText, term)
				end
			end
		end
		return hits
	end

	-- Slot select logic, activated by clicking or pressing hotkey
		function slot:Select()
			local tool = slot.Tool
			if tool then
				if IsEquipped(tool) then --NOTE: HopperBin
					UnequipAllTools()
				elseif tool.Parent == Backpack then
					EquipNewTool(tool)
				end
			end
		end

	-- Slot Init Logic --

	SlotFrame = NewGui('TextButton', index)
	SlotFrame.BackgroundColor3 = BACKGROUND_COLOR
	SlotFrame.BorderColor3 = SLOT_BORDER_COLOR
	SlotFrame.Text = ""
	SlotFrame.AutoButtonColor = false
	SlotFrame.BorderSizePixel = 0
	SlotFrame.Size = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
	SlotFrame.Active = true
	SlotFrame.Draggable = false
	SlotFrame.BackgroundTransparency = SLOT_FADE_LOCKED
	SlotFrame.MouseButton1Click:connect(function() changeSlot(slot) end)
	slot.Frame = SlotFrame

	do
		local selectionObjectClipper = NewGui('Frame', 'SelectionObjectClipper')
		selectionObjectClipper.Visible = false
		selectionObjectClipper.Parent = SlotFrame

		SelectionObj = NewGui('ImageLabel', 'Selector')
		SelectionObj.Size = UDim2.new(1, 0, 1, 0)
		SelectionObj.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
		SelectionObj.ScaleType = Enum.ScaleType.Slice
		SelectionObj.SliceCenter = Rect.new(12,12,52,52)
		SelectionObj.Parent = selectionObjectClipper
	end


	ToolIcon = NewGui('ImageLabel', 'Icon')
	ToolIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
	ToolIcon.Position = UDim2.new(0.1, 0, 0.1, 0)
	ToolIcon.Parent = SlotFrame

	ToolName = NewGui('TextLabel', 'ToolName')
	ToolName.Size = UDim2.new(1, -2, 1, -2)
	ToolName.Position = UDim2.new(0, 1, 0, 1)
	ToolName.Parent = SlotFrame

	slot.Frame.LayoutOrder = slot.Index

	if index <= NumberOfHotbarSlots then -- Hotbar-Specific Slot Stuff
		-- ToolTip stuff
		ToolTip = NewGui('TextLabel', 'ToolTip')
		ToolTip.TextWrapped = false
		ToolTip.TextYAlignment = Enum.TextYAlignment.Top
		ToolTip.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
		ToolTip.BackgroundTransparency = 0
		ToolTip.Visible = false
		ToolTip.Parent = SlotFrame
		SlotFrame.MouseEnter:connect(function()
			if ToolTip.Text ~= '' then
				ToolTip.Visible = true
			end
		end)
		SlotFrame.MouseLeave:connect(function() ToolTip.Visible = false end)

		function slot:MoveToInventory()
			if slot.Index <= NumberOfHotbarSlots then -- From a Hotbar slot
				local tool = slot.Tool
				self:Clear() --NOTE: Order matters here
				local newSlot = MakeSlot(UIGridFrame)
				newSlot:Fill(tool)
				if IsEquipped(tool) then -- Also unequip it --NOTE: HopperBin
					UnequipAllTools()
				end
				-- Also hide the inventory slot if we're showing results right now
				if ViewingSearchResults then
					newSlot.Frame.Visible = false
					newSlot.Parent = InventoryFrame
				end
			end
		end

		-- Show label and assign hotkeys for 1-9 and 0 (zero is always last slot when > 10 total)
		if index < 10 or index == NumberOfHotbarSlots then -- NOTE: Hardcoded on purpose!
			local slotNum = (index < 10) and index or 0
			SlotNumber = NewGui('TextLabel', 'Number')
			SlotNumber.Text = slotNum
			SlotNumber.Size = UDim2.new(0.15, 0, 0.15, 0)
			SlotNumber.Visible = false
			SlotNumber.Parent = SlotFrame
			HotkeyFns[ZERO_KEY_VALUE + slotNum] = slot.Select
		end
	end

	do -- Dragging Logic
		local startPoint = SlotFrame.Position
		local lastUpTime = 0
		local startParent = nil

		SlotFrame.DragBegin:connect(function(dragPoint)
			Dragging[SlotFrame] = true
			startPoint = dragPoint

			SlotFrame.BorderSizePixel = 2

			-- Raise above other slots
			SlotFrame.ZIndex = 2
			ToolIcon.ZIndex = 2
			ToolName.ZIndex = 2
			if FFlagRobloxGuiSiblingZindexs then
				SlotFrame.Parent.ZIndex = 2
			end
			if SlotNumber then
				SlotNumber.ZIndex = 2
			end
			if HighlightFrame then
				HighlightFrame.ZIndex = 2
				for _, child in pairs(HighlightFrame:GetChildren()) do
					child.ZIndex = 2
				end
			end

			-- Circumvent the ScrollingFrame's ClipsDescendants property
			startParent = SlotFrame.Parent
			if startParent == UIGridFrame then
				local oldAbsolutPos = SlotFrame.AbsolutePosition
				local newPosition = UDim2.new(0, SlotFrame.AbsolutePosition.X - InventoryFrame.AbsolutePosition.X, 0, SlotFrame.AbsolutePosition.Y - InventoryFrame.AbsolutePosition.Y)
				SlotFrame.Parent = InventoryFrame
				SlotFrame.Position = newPosition

				FakeSlotFrame = NewGui('Frame', 'FakeSlot')
				FakeSlotFrame.LayoutOrder = SlotFrame.LayoutOrder
				FakeSlotFrame.Size = SlotFrame.Size
				FakeSlotFrame.BackgroundTransparency = 1
				FakeSlotFrame.Parent = UIGridFrame
			end
		end)

		SlotFrame.DragStopped:connect(function(x, y)
			if FakeSlotFrame then
				FakeSlotFrame:Destroy()
			end

			local now = tick()
			SlotFrame.Position = startPoint
			SlotFrame.Parent = startParent

			SlotFrame.BorderSizePixel = 0

			-- Restore height
			SlotFrame.ZIndex = 1
			ToolIcon.ZIndex = 1
			ToolName.ZIndex = 1
			if FFlagRobloxGuiSiblingZindexs then
				startParent.ZIndex = 1
			end
			if SlotNumber then
				SlotNumber.ZIndex = 1
			end
			if HighlightFrame then
				HighlightFrame.ZIndex = 1
				for _, child in pairs(HighlightFrame:GetChildren()) do
					child.ZIndex = 1
				end
			end

			Dragging[SlotFrame] = nil

			-- Make sure the tool wasn't dropped
			if not slot.Tool then
				return
			end

			-- Check where we were dropped
			if CheckBounds(InventoryFrame, x, y) then
				if slot.Index <= NumberOfHotbarSlots then
					slot:MoveToInventory()
				end
				-- Check for double clicking on an inventory slot, to move into empty hotbar slot
				if slot.Index > NumberOfHotbarSlots and now - lastUpTime < DOUBLE_CLICK_TIME then
					if LowestEmptySlot then
						local myTool = slot.Tool
						slot:Clear()
						LowestEmptySlot:Fill(myTool)
						slot:Delete()
					end
					now = 0 -- Resets the timer
				end
			elseif CheckBounds(HotbarFrame, x, y) then
				local closest = {math.huge, nil}
				for i = 1, NumberOfHotbarSlots do
					local otherSlot = Slots[i]
					local offset = GetOffset(otherSlot.Frame, Vector2.new(x, y))
					if offset < closest[1] then
						closest = {offset, otherSlot}
					end
				end
				local closestSlot = closest[2]
				if closestSlot ~= slot then
					slot:Swap(closestSlot)
					if slot.Index > NumberOfHotbarSlots then
						local tool = slot.Tool
						if not tool then -- Clean up after ourselves if we're an inventory slot that's now empty
							slot:Delete()
						else -- Moved inventory slot to hotbar slot, and gained a tool that needs to be unequipped
							if IsEquipped(tool) then --NOTE: HopperBin
								UnequipAllTools()
							end
							-- Also hide the inventory slot if we're showing results right now
							if ViewingSearchResults then
								slot.Frame.Visible = false
								slot.Frame.Parent = InventoryFrame
							end
						end
					end
				end
			else
				-- local tool = slot.Tool
				-- if tool.CanBeDropped then --TODO: HopperBins
					-- tool.Parent = workspace
					-- --TODO: Move away from character
				-- end
				if slot.Index <= NumberOfHotbarSlots then
					slot:MoveToInventory() --NOTE: Temporary
				end
			end

			lastUpTime = now
		end)
	end

	-- All ready!
	SlotFrame.Parent = parent
	Slots[index] = slot

	if index > NumberOfHotbarSlots then
		UpdateScrollingFrameCanvasSize()
		-- Scroll to new inventory slot, if we're open and not viewing search results
		if InventoryFrame.Visible and not ViewingSearchResults then
			local offset = ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteSize.Y
			ScrollingFrame.CanvasPosition = Vector2.new(0, math.max(0, offset))
		end
	end

	return slot
end

-- NOTE: We should probably migrate to a 2 collection system:
-- One collection for the hotbar and another collection for the inventory
local function SetNumberOfHotbarSlots(numSlots)
	if NumberOfHotbarSlots ~= numSlots then
		local prevNumberOfSlots = NumberOfHotbarSlots
		local newNumberOfSlots = numSlots
		-- If we are shrinking the number of slots we need
		-- to move around our tools to the right locations
		if prevNumberOfSlots > newNumberOfSlots then
			-- Delete the slots that are now no longer in the Hotbar
			-- Iterate backwards as to not corrupt our iterator
			for i = prevNumberOfSlots, newNumberOfSlots + 1, -1 do
				local slot = Slots[i]
				if slot then
					slot:MoveToInventory()
					slot:Delete()
				end
			end
			-- Also need to slide-back the inventory slots now that they are indexed earlier
			for i = prevNumberOfSlots, newNumberOfSlots + 1, -1 do
				local slot = Slots[i]
				if not slot.Tool then
					slot:Delete()
				end
			end
		else -- If we added more slots
			for i = prevNumberOfSlots, newNumberOfSlots do
				-- Incrementally add hotbar slots
				NumberOfHotbarSlots = i
				if Slots[i] then
					-- Move old
					local oldSlot = Slots[i]
					local oldTool = Slots[i].Tool

					local newSlot = MakeSlot(HotbarFrame, i)

					if oldTool then
						newSlot:Fill(oldTool)
					elseif not LowestEmptySlot then
						LowestEmptySlot = newSlot
					end
				else
					local slot = MakeSlot(HotbarFrame, i)

					slot.Frame.Visible = false

					if not LowestEmptySlot then
						LowestEmptySlot = slot
					end
				end
			end
		end
		NumberOfHotbarSlots = numSlots
		FullHotbarSlots = 0
		for i = 1, NumberOfHotbarSlots do
			if Slots[i] and Slots[i].Tool then
				FullHotbarSlots = FullHotbarSlots + 1
			end
		end

		UpdateBackpackLayout()
	end
end

local function OnChildAdded(child) -- To Character or Backpack
	if not child:IsA('Tool') and not child:IsA('HopperBin') then --NOTE: HopperBin
		if child:IsA('Humanoid') and child.Parent == Character then
			Humanoid = child
		end
		return
	end
	local tool = child

	if tool.Parent == Character then
		ShowVRBackpackPopup()
		TimeOfLastToolChange = tick()
	end

	if ActiveHopper and tool.Parent == Character then --NOTE: HopperBin
		DisableActiveHopper()
	end

	--TODO: Optimize / refactor / do something else
	if not StarterToolFound and tool.Parent == Character and not SlotsByTool[tool] then
		local starterGear = Player:FindFirstChild('StarterGear')
		if starterGear then
			if starterGear:FindFirstChild(tool.Name) then
				StarterToolFound = true
				local slot = LowestEmptySlot or MakeSlot(UIGridFrame)
				for i = slot.Index, 1, -1 do
					local curr = Slots[i] -- An empty slot, because above
					local pIndex = i - 1
					if pIndex > 0 then
						local prev = Slots[pIndex] -- Guaranteed to be full, because above
						prev:Swap(curr)
					else
						curr:Fill(tool)
					end
				end
				-- Have to manually unequip a possibly equipped tool
				for _, child in pairs(Character:GetChildren()) do
					if child:IsA('Tool') and child ~= tool then
						child.Parent = Backpack
					end
				end
				AdjustHotbarFrames()
				return -- We're done here
			end
		end
	end

	-- The tool is either moving or new
	local slot = SlotsByTool[tool]
	if slot then
		slot:UpdateEquipView()
	else -- New! Put into lowest hotbar slot or new inventory slot
		slot = LowestEmptySlot or MakeSlot(UIGridFrame)
		slot:Fill(tool)
		if slot.Index <= NumberOfHotbarSlots and not InventoryFrame.Visible then
			AdjustHotbarFrames()
		end
		if tool:IsA('HopperBin') then --NOTE: HopperBin
			if tool.Active then
				UnequipAllTools()
				ActiveHopper = tool
			end
		end
	end
end

local function OnChildRemoved(child) -- From Character or Backpack
	if not child:IsA('Tool') and not child:IsA('HopperBin') then --NOTE: HopperBin
		return
	end
	local tool = child

	ShowVRBackpackPopup()
	TimeOfLastToolChange = tick()

	-- Ignore this event if we're just moving between the two
	local newParent = tool.Parent
	if newParent == Character or newParent == Backpack then
		return
	end

	local slot = SlotsByTool[tool]
	if slot then
		slot:Clear()
		if slot.Index > NumberOfHotbarSlots then -- Inventory slot
			slot:Delete()
		elseif not InventoryFrame.Visible then
			AdjustHotbarFrames()
		end
	end

	if tool == ActiveHopper then --NOTE: HopperBin
		ActiveHopper = nil
	end
end

local function OnCharacterAdded(character)
	-- First, clean up any old slots
	for i = #Slots, 1, -1 do
		local slot = Slots[i]
		if slot.Tool then
			slot:Clear()
		end
		if i > NumberOfHotbarSlots then
			slot:Delete()
		end
	end
	ActiveHopper = nil --NOTE: HopperBin

	-- And any old connections
	for _, conn in pairs(CharConns) do
		conn:disconnect()
	end
	CharConns = {}

	-- Hook up the new character
	Character = character
	table.insert(CharConns, character.ChildRemoved:connect(OnChildRemoved))
	table.insert(CharConns, character.ChildAdded:connect(OnChildAdded))
	for _, child in pairs(character:GetChildren()) do
		OnChildAdded(child)
	end
	--NOTE: Humanoid is set inside OnChildAdded

	-- And the new backpack, when it gets here
	Backpack = Player:WaitForChild('Backpack')
	table.insert(CharConns, Backpack.ChildRemoved:connect(OnChildRemoved))
	table.insert(CharConns, Backpack.ChildAdded:connect(OnChildAdded))
	for _, child in pairs(Backpack:GetChildren()) do
		OnChildAdded(child)
	end

	AdjustHotbarFrames()
end

local function OnInputBegan(input, isProcessed)
	-- Pass through keyboard hotkeys when not typing into a TextBox and not disabled (except for the Drop key)
	if input.UserInputType == Enum.UserInputType.Keyboard and not TextBoxFocused and (WholeThingEnabled or input.KeyCode.Value == DROP_HOTKEY_VALUE) then
		local hotkeyBehavior = HotkeyFns[input.KeyCode.Value]
		if hotkeyBehavior then
			hotkeyBehavior(isProcessed)
		end
	end

	if FFlagTapAwayToCloseBackpack then
		local inputType = input.UserInputType
		if not isProcessed then
			if inputType == Enum.UserInputType.MouseButton1 or inputType == Enum.UserInputType.Touch then
				if InventoryFrame.Visible then
					BackpackScript.OpenClose()
				end
			end
		end
	end
end

local function OnUISChanged(property)
	if property == 'KeyboardEnabled' or property == "VREnabled" then
		local on = UserInputService.KeyboardEnabled and not UserInputService.VREnabled
		for i = 1, NumberOfHotbarSlots do
			Slots[i]:TurnNumber(on)
		end
	end
end

local lastChangeToolInputObject = nil
local lastChangeToolInputTime = nil
local maxEquipDeltaTime = 0.06
local noOpFunc = function() end
local selectDirection = Vector2.new(0,0)
local hotbarVisible = false

function unbindAllGamepadEquipActions()
	ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
	ContextActionService:UnbindAction("RBXCloseInventory")
end

local function setHotbarVisibility(visible, isInventoryScreen)
	for i = 1, NumberOfHotbarSlots do
		local hotbarSlot = Slots[i]
		if hotbarSlot and hotbarSlot.Frame and (isInventoryScreen or hotbarSlot.Tool) then
			hotbarSlot.Frame.Visible = visible
		end
	end
end

local function getInputDirection(inputObject)
	local buttonModifier = 1
	if inputObject.UserInputState == Enum.UserInputState.End then
		buttonModifier = -1
	end

	if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 then

		local magnitude = inputObject.Position.magnitude

		if magnitude > 0.98 then
			local normalizedVector = Vector2.new(inputObject.Position.x / magnitude, -inputObject.Position.y / magnitude)
			selectDirection =  normalizedVector
		else
			selectDirection = Vector2.new(0,0)
		end
	elseif inputObject.KeyCode == Enum.KeyCode.DPadLeft then
		selectDirection = Vector2.new(selectDirection.x - 1 * buttonModifier, selectDirection.y)
	elseif inputObject.KeyCode == Enum.KeyCode.DPadRight then
		selectDirection = Vector2.new(selectDirection.x + 1 * buttonModifier, selectDirection.y)
	elseif inputObject.KeyCode == Enum.KeyCode.DPadUp then
		selectDirection = Vector2.new(selectDirection.x, selectDirection.y - 1 * buttonModifier)
	elseif inputObject.KeyCode == Enum.KeyCode.DPadDown then
		selectDirection = Vector2.new(selectDirection.x, selectDirection.y + 1 * buttonModifier)
	else
		selectDirection = Vector2.new(0,0)
	end

	return selectDirection
end

local selectToolExperiment = function(actionName, inputState, inputObject)
	local inputDirection = getInputDirection(inputObject)

	if inputDirection == Vector2.new(0,0) then
		return
	end

	local angle = math.atan2(inputDirection.y, inputDirection.x) - math.atan2(-1, 0)
	if angle < 0 then
		angle = angle + (math.pi * 2)
	end

	local quarterPi = (math.pi * 0.25)

	local index = (angle/quarterPi) + 1
	index = math.floor(index + 0.5) -- round index to whole number
	if index > NumberOfHotbarSlots then
		index = 1
	end

	if index > 0 then
		local selectedSlot = Slots[index]
		if selectedSlot and selectedSlot.Tool and not selectedSlot:IsEquipped() then
			selectedSlot:Select()
		end
	else
		UnequipAllTools()
	end
end

changeToolFunc = function(actionName, inputState, inputObject)
	if inputState ~= Enum.UserInputState.Begin then return end

	if lastChangeToolInputObject then
		if (lastChangeToolInputObject.KeyCode == Enum.KeyCode.ButtonR1 and
			inputObject.KeyCode == Enum.KeyCode.ButtonL1) or
			(lastChangeToolInputObject.KeyCode == Enum.KeyCode.ButtonL1 and
			inputObject.KeyCode == Enum.KeyCode.ButtonR1) then
				if (tick() - lastChangeToolInputTime) <= maxEquipDeltaTime then
					UnequipAllTools()
					lastChangeToolInputObject = inputObject
					lastChangeToolInputTime = tick()
					return
				end
		end
	end

	lastChangeToolInputObject = inputObject
	lastChangeToolInputTime = tick()

	delay(maxEquipDeltaTime, function()
		if lastChangeToolInputObject ~= inputObject then return end

		local moveDirection = 0
		if (inputObject.KeyCode == Enum.KeyCode.ButtonL1) then
			moveDirection = -1
		else
			moveDirection = 1
		end

		for i = 1, NumberOfHotbarSlots do
			local hotbarSlot = Slots[i]
			if hotbarSlot:IsEquipped() then

				local newSlotPosition = moveDirection + i
				local hitEdge = false
				if newSlotPosition > NumberOfHotbarSlots then
					newSlotPosition = 1
					hitEdge = true
				elseif newSlotPosition < 1 then
					newSlotPosition = NumberOfHotbarSlots
					hitEdge = true
				end

				local origNewSlotPos = newSlotPosition
				while not Slots[newSlotPosition].Tool do
					newSlotPosition = newSlotPosition + moveDirection
					if newSlotPosition == origNewSlotPos then return end

					if newSlotPosition > NumberOfHotbarSlots then
						newSlotPosition = 1
						hitEdge = true
					elseif newSlotPosition < 1 then
						newSlotPosition = NumberOfHotbarSlots
						hitEdge = true
					end
				end

				if hitEdge then
					UnequipAllTools()
					lastEquippedSlot = nil
				else
					Slots[newSlotPosition]:Select()
				end
				return
			end
		end

		if lastEquippedSlot and lastEquippedSlot.Tool then
			lastEquippedSlot:Select()
			return
		end

		local startIndex = moveDirection == -1 and NumberOfHotbarSlots or 1
		local endIndex = moveDirection == -1 and 1 or NumberOfHotbarSlots
		for i = startIndex, endIndex, moveDirection do
			if Slots[i].Tool then
				Slots[i]:Select()
				return
			end
		end
	end)
end

function getGamepadSwapSlot()
	for i = 1, #Slots do
		if Slots[i].Frame.BorderSizePixel > 0 then
			return Slots[i]
		end
	end
end

function changeSlot(slot)
	local swapInVr = not VRService.VREnabled or InventoryFrame.Visible

	if slot.Frame == GuiService.SelectedObject and swapInVr then
		local currentlySelectedSlot = getGamepadSwapSlot()

		if currentlySelectedSlot then
			currentlySelectedSlot.Frame.BorderSizePixel = 0
			if currentlySelectedSlot ~= slot then
				slot:Swap(currentlySelectedSlot)
				VRInventorySelector.SelectionImageObject.Visible = false

				if slot.Index > NumberOfHotbarSlots and not slot.Tool then
					if GuiService.SelectedObject == slot.Frame then
						GuiService.SelectedObject = currentlySelectedSlot.Frame
					end
					slot:Delete()
				end

				if currentlySelectedSlot.Index > NumberOfHotbarSlots and not currentlySelectedSlot.Tool then
					if GuiService.SelectedObject == currentlySelectedSlot.Frame then
						GuiService.SelectedObject = slot.Frame
					end
					currentlySelectedSlot:Delete()
				end
			end
		else
			local startSize = slot.Frame.Size
			local startPosition = slot.Frame.Position
			slot.Frame:TweenSizeAndPosition(startSize + UDim2.new(0, 10, 0, 10), startPosition - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .1, true, function() slot.Frame:TweenSizeAndPosition(startSize, startPosition, Enum.EasingDirection.In, Enum.EasingStyle.Quad, .1, true) end)
			slot.Frame.BorderSizePixel = 3
			VRInventorySelector.SelectionImageObject.Visible = true
		end
	else
		slot:Select()
		VRInventorySelector.SelectionImageObject.Visible = false
	end
end

function vrMoveSlotToInventory()
	if not VRService.VREnabled then
		return
	end

	local currentlySelectedSlot = getGamepadSwapSlot()
	if currentlySelectedSlot and currentlySelectedSlot.Tool then
		currentlySelectedSlot.Frame.BorderSizePixel = 0
		currentlySelectedSlot:MoveToInventory()
		VRInventorySelector.SelectionImageObject.Visible = false
	end
end

function enableGamepadInventoryControl()
	local goBackOneLevel = function(actionName, inputState, inputObject)
		if inputState ~= Enum.UserInputState.Begin then return end

		local selectedSlot = getGamepadSwapSlot()
		if selectedSlot then
			local selectedSlot = getGamepadSwapSlot()
			if selectedSlot then
				selectedSlot.Frame.BorderSizePixel = 0
				return
			end
		elseif InventoryFrame.Visible then
			BackpackScript.OpenClose()
		end
	end

	ContextActionService:BindAction("RBXBackpackHasGamepadFocus", noOpFunc, false, Enum.UserInputType.Gamepad1)
	ContextActionService:BindAction("RBXCloseInventory", goBackOneLevel, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)

	-- Gaze select will automatically select the object for us!
	if not UseGazeSelection() then
		GuiService.SelectedObject = HotbarFrame:FindFirstChild("1")
	end
end


function disableGamepadInventoryControl()
	unbindAllGamepadEquipActions()

	for i = 1, NumberOfHotbarSlots do
		local hotbarSlot = Slots[i]
		if hotbarSlot and hotbarSlot.Frame then
			hotbarSlot.Frame.BorderSizePixel = 0
		end
	end

	if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(MainFrame) then
		GuiService.SelectedObject = nil
	end
end


local function bindBackpackHotbarAction()
	if WholeThingEnabled and not GamepadActionsBound then
		GamepadActionsBound = true
		ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end
end

local function unbindBackpackHotbarAction()
	disableGamepadInventoryControl()
	GamepadActionsBound = false
	ContextActionService:UnbindAction("RBXHotbarEquip")
end

function gamepadDisconnected()
	GamepadEnabled = false
	disableGamepadInventoryControl()
end

function gamepadConnected()
	GamepadEnabled = true
	GuiService:AddSelectionParent("RBXBackpackSelection", MainFrame)

	if FullHotbarSlots >= 1 then
		bindBackpackHotbarAction()
	end

	if InventoryFrame.Visible then
		enableGamepadInventoryControl()
	end
end

local function OnCoreGuiChanged(coreGuiType, enabled)
	-- Check for enabling/disabling the whole thing
	if coreGuiType == Enum.CoreGuiType.Backpack or coreGuiType == Enum.CoreGuiType.All then
		enabled = enabled and TopbarEnabled
		WholeThingEnabled = enabled
		MainFrame.Visible = enabled

		-- Eat/Release hotkeys (Doesn't affect UserInputService)
		for _, keyString in pairs(HotkeyStrings) do
			if enabled then
				--GuiService:AddKey(keyString)
			else
				--GuiService:RemoveKey(keyString)
			end
		end

		if enabled then
			if FullHotbarSlots >=1 then
				bindBackpackHotbarAction()
			end
		else
			unbindBackpackHotbarAction()
		end
	end
end


local function MakeVRRoundButton(name, image)
	local newButton = NewGui('ImageButton', name)
	newButton.Size = UDim2.new(0, 40, 0, 40)
	newButton.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png";

	local buttonIcon = NewGui('ImageLabel', 'Icon')
	buttonIcon.Size = UDim2.new(0.5,0,0.5,0);
	buttonIcon.Position = UDim2.new(0.25,0,0.25,0);
	buttonIcon.Image = image;
	buttonIcon.Parent = newButton;

	local buttonSelectionObject = NewGui('ImageLabel', 'Selection')
	buttonSelectionObject.Size = UDim2.new(0.9,0,0.9,0);
	buttonSelectionObject.Position = UDim2.new(0.05,0,0.05,0);
	buttonSelectionObject.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png";
	newButton.SelectionImageObject = buttonSelectionObject

	return newButton, buttonIcon, buttonSelectionObject
end


-- Make the main frame, which (mostly) covers the screen
MainFrame = NewGui('Frame', 'Backpack')
MainFrame.Visible = false
MainFrame.Parent = RobloxGui

-- Make the HotbarFrame, which holds only the Hotbar Slots
HotbarFrame = NewGui('Frame', 'Hotbar')
HotbarFrame.Parent = MainFrame

-- Make all the Hotbar Slots
for i = 1, NumberOfHotbarSlots do
	local slot = MakeSlot(HotbarFrame, i)
	slot.Frame.Visible = false

	if not LowestEmptySlot then
		LowestEmptySlot = slot
	end
end

-- Up arrow to open the inventory
OpenInventoryButton = NewGui('ImageButton', 'OpenInventory')
do
	OpenInventoryButton.Size = UDim2.new(0, 30, 0, 30)
	OpenInventoryButton.Image = "rbxasset://textures/ui/Backpack/ScrollUpArrow.png";
	OpenInventoryButton.MouseButton1Click:connect(function()
		BackpackScript.OpenClose()
	end)
	OpenInventoryButton.SelectionGained:connect(function()
		OpenInventoryButton.ImageColor3 = ARROW_HOVER_COLOR
	end)
	OpenInventoryButton.SelectionLost:connect(function()
		OpenInventoryButton.ImageColor3 = Color3.new(1,1,1)
	end)
	local openInventoryButtonSelectionObject = NewGui('Frame', 'Selection')
	openInventoryButtonSelectionObject.Visible = false
	OpenInventoryButton.SelectionImageObject = openInventoryButtonSelectionObject
end

CloseInventoryButton = MakeVRRoundButton('CloseInventory', 'rbxasset://textures/ui/Keyboard/close_button_icon.png')
CloseInventoryButton.Position = UDim2.new(0, 0, 0, -50)
CloseInventoryButton.MouseButton1Click:connect(function()
	if InventoryFrame.Visible then
		BackpackScript.OpenClose()
	end
end)

LeftBumperButton = NewGui('ImageLabel', 'LeftBumper')
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40)
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset/2)

RightBumperButton = NewGui('ImageLabel', 'RightBumper')
RightBumperButton.Size = UDim2.new(0, 40, 0, 40)
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset/2)

-- Make the Inventory, which holds the ScrollingFrame, the header, and the search box
InventoryFrame = NewGui('Frame', 'Inventory')
InventoryFrame.BackgroundTransparency = BACKGROUND_FADE
InventoryFrame.BackgroundColor3 = BACKGROUND_COLOR
InventoryFrame.Active = true
InventoryFrame.Visible = false
InventoryFrame.Parent = MainFrame

VRInventorySelector = NewGui('TextButton', 'VRInventorySelector')
VRInventorySelector.Position = UDim2.new(0, 0, 0, 0)
VRInventorySelector.Size = UDim2.new(1, 0, 1, 0)
VRInventorySelector.BackgroundTransparency = 1
VRInventorySelector.Text = ""
VRInventorySelector.Parent = InventoryFrame

local selectorImage = NewGui('ImageLabel', 'Selector')
selectorImage.Size = UDim2.new(1, 0, 1, 0)
selectorImage.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
selectorImage.ScaleType = Enum.ScaleType.Slice
selectorImage.SliceCenter = Rect.new(12,12,52,52)
selectorImage.Visible = false
VRInventorySelector.SelectionImageObject = selectorImage

VRInventorySelector.MouseButton1Click:connect(function()
	vrMoveSlotToInventory()
end)

-- Make the ScrollingFrame, which holds the rest of the Slots (however many)
ScrollingFrame = NewGui('ScrollingFrame', 'ScrollingFrame')
ScrollingFrame.Selectable = false
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = InventoryFrame

UIGridFrame = NewGui('Frame', 'UIGridFrame')
UIGridFrame.Selectable = false
UIGridFrame.Size = UDim2.new(1, -(ICON_BUFFER*2), 1, 0)
UIGridFrame.Position = UDim2.new(0, ICON_BUFFER, 0, 0)
UIGridFrame.Parent = ScrollingFrame

UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
UIGridLayout.CellPadding = UDim2.new(0, ICON_BUFFER, 0, ICON_BUFFER)
UIGridLayout.Parent = UIGridFrame

ScrollUpInventoryButton = MakeVRRoundButton('ScrollUpButton', 'rbxasset://textures/ui/Backpack/ScrollUpArrow.png')
ScrollUpInventoryButton.Size = UDim2.new(0, 34, 0, 34)
ScrollUpInventoryButton.Position = UDim2.new(0.5, -ScrollUpInventoryButton.Size.X.Offset/2, 0, INVENTORY_HEADER_SIZE + 3)
ScrollUpInventoryButton.Icon.Position = ScrollUpInventoryButton.Icon.Position - UDim2.new(0,0,0,2)
ScrollUpInventoryButton.MouseButton1Click:connect(function()
	ScrollingFrame.CanvasPosition = Vector2.new(
		ScrollingFrame.CanvasPosition.X,
		Clamp(0, ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteWindowSize.Y, ScrollingFrame.CanvasPosition.Y - (ICON_BUFFER + ICON_SIZE)))
end)

ScrollDownInventoryButton = MakeVRRoundButton('ScrollDownButton', 'rbxasset://textures/ui/Backpack/ScrollUpArrow.png')
ScrollDownInventoryButton.Rotation = 180
ScrollDownInventoryButton.Icon.Position = ScrollDownInventoryButton.Icon.Position - UDim2.new(0,0,0,2)
ScrollDownInventoryButton.Size = UDim2.new(0, 34, 0, 34)
ScrollDownInventoryButton.Position = UDim2.new(0.5, -ScrollDownInventoryButton.Size.X.Offset/2, 1, -ScrollDownInventoryButton.Size.Y.Offset - 3)
ScrollDownInventoryButton.MouseButton1Click:connect(function()
	ScrollingFrame.CanvasPosition = Vector2.new(
		ScrollingFrame.CanvasPosition.X,
		Clamp(0, ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteWindowSize.Y, ScrollingFrame.CanvasPosition.Y + (ICON_BUFFER + ICON_SIZE)))
end)

ScrollingFrame.Changed:connect(function(prop)
	if prop == 'AbsoluteWindowSize' or prop == 'CanvasPosition' or prop == 'CanvasSize' then
		local canScrollUp = ScrollingFrame.CanvasPosition.Y ~= 0
		local canScrollDown = ScrollingFrame.CanvasPosition.Y < ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteWindowSize.Y

		ScrollUpInventoryButton.Visible = canScrollUp
		ScrollDownInventoryButton.Visible = canScrollDown
	end
end)

-- Position the frames and sizes for the Backpack GUI elements
UpdateBackpackLayout()

--Make the gamepad hint frame
local gamepadHintsFrame = Instance.new("Frame", MainFrame)
gamepadHintsFrame.Name = "GamepadHintsFrame"
gamepadHintsFrame.Size = UDim2.new(0, HotbarFrame.Size.X.Offset, 0, (IsTenFootInterface and 95 or 60))
gamepadHintsFrame.BackgroundTransparency = 1
gamepadHintsFrame.Visible = false

local function addGamepadHint(hintImage, hintImageLarge, hintText)
	local hintFrame = Instance.new("Frame", gamepadHintsFrame)
	hintFrame.Name = "HintFrame"
	hintFrame.Size = UDim2.new(1, 0, 1, -5)
	hintFrame.Position = UDim2.new(0, 0, 0, 0)
	hintFrame.BackgroundTransparency = 1

	local hintImage = Instance.new("ImageLabel", hintFrame)
	hintImage.Name = "HintImage"
	hintImage.Size = (IsTenFootInterface and UDim2.new(0,90,0,90) or UDim2.new(0,60,0,60))
	hintImage.BackgroundTransparency = 1
	hintImage.Image = (hintImageLarge or hintImage)-- IsTenFootInterface and 


	local hintText = Instance.new("TextLabel", hintFrame)
	hintText.Name = "HintText"
	hintText.Position = UDim2.new(0, (IsTenFootInterface and 100 or 70), 0, 0)
	hintText.Size = UDim2.new(1, -(IsTenFootInterface and 100 or 70), 1, 0)
	hintText.Font = Enum.Font.SourceSansBold
	hintText.FontSize = (IsTenFootInterface and Enum.FontSize.Size36 or Enum.FontSize.Size24)
	hintText.BackgroundTransparency = 1
	hintText.Text = tostring(hintText.Text)
	hintText.TextColor3 = Color3.new(1,1,1)
	hintText.TextXAlignment = Enum.TextXAlignment.Left
	hintText.TextWrapped = true
		
	local textSizeConstraint = Instance.new("UITextSizeConstraint", hintText)
	textSizeConstraint.MaxTextSize = hintText.TextSize
end

local function resizeGamepadHintsFrame()
	gamepadHintsFrame.Size = UDim2.new(HotbarFrame.Size.X.Scale, HotbarFrame.Size.X.Offset, 0, (IsTenFootInterface and 95 or 60))
	gamepadHintsFrame.Position = UDim2.new(HotbarFrame.Position.X.Scale, HotbarFrame.Position.X.Offset, InventoryFrame.Position.Y.Scale, InventoryFrame.Position.Y.Offset - gamepadHintsFrame.Size.Y.Offset)

	local spaceTaken = 0

	local gamepadHints = gamepadHintsFrame:GetChildren()
	--First get the total space taken by all the hints
	for i = 1, #gamepadHints do
		gamepadHints[i].Size = UDim2.new(1, 0, 1, -5)
		gamepadHints[i].Position = UDim2.new(0, 0, 0, 0)
		spaceTaken = spaceTaken + (gamepadHints[i].HintText.Position.X.Offset + gamepadHints[i].HintText.TextBounds.X)
	end

	--The space between all the frames should be equal
	local spaceBetweenElements = (gamepadHintsFrame.AbsoluteSize.X - spaceTaken)/(#gamepadHints - 1)
	for i = 1, #gamepadHints do
		gamepadHints[i].Position = (i == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, gamepadHints[i-1].Position.X.Offset + gamepadHints[i-1].Size.X.Offset + spaceBetweenElements, 0, 0))
		gamepadHints[i].Size = UDim2.new(0, (gamepadHints[i].HintText.Position.X.Offset + gamepadHints[i].HintText.TextBounds.X), 1, -5)
	end
end

addGamepadHint("rbxasset://textures/ui/Settings/Help/XButtonDark.png", "rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png", "Remove From Hotbar")
addGamepadHint("rbxasset://textures/ui/Settings/Help/AButtonDark.png", "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png", "Select/Swap")
addGamepadHint("rbxasset://textures/ui/Settings/Help/BButtonDark.png", "rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png", "Close Backpack")

do -- Search stuff
	local searchFrame = NewGui('Frame', 'Search')
	searchFrame.BackgroundColor3 = SEARCH_BACKGROUND_COLOR
	searchFrame.BackgroundTransparency = SEARCH_BACKGROUND_FADE
	searchFrame.Size = UDim2.new(0, SEARCH_WIDTH - (SEARCH_BUFFER * 2), 0, INVENTORY_HEADER_SIZE - (SEARCH_BUFFER * 2))
	searchFrame.Position = UDim2.new(1, -searchFrame.Size.X.Offset - SEARCH_BUFFER, 0, SEARCH_BUFFER)
	searchFrame.Parent = InventoryFrame

	local searchBox = NewGui('TextBox', 'TextBox')
	searchBox.Text = SEARCH_TEXT
	searchBox.ClearTextOnFocus = false
	searchBox.FontSize = Enum.FontSize.Size24
	searchBox.TextXAlignment = Enum.TextXAlignment.Left
	searchBox.Size = searchFrame.Size - UDim2.new(0, SEARCH_TEXT_OFFSET_FROMLEFT, 0, 0)
	searchBox.Position = UDim2.new(0, SEARCH_TEXT_OFFSET_FROMLEFT, 0, 0)
	searchBox.Parent = searchFrame

	local xButton = NewGui('TextButton', 'X')
	xButton.Text = 'x'
	xButton.TextColor3 = SLOT_EQUIP_COLOR
	xButton.FontSize = Enum.FontSize.Size24
	xButton.TextYAlignment = Enum.TextYAlignment.Bottom
	xButton.BackgroundColor3 = SEARCH_BACKGROUND_COLOR
	xButton.BackgroundTransparency = 0
	xButton.Size = UDim2.new(0, searchFrame.Size.Y.Offset - (SEARCH_BUFFER * 2), 0, searchFrame.Size.Y.Offset - (SEARCH_BUFFER * 2))
	xButton.Position = UDim2.new(1, -xButton.Size.X.Offset - (SEARCH_BUFFER * 2), 0.5, -xButton.Size.Y.Offset / 2)
	xButton.ZIndex = 0
	xButton.Visible = false
	xButton.BorderSizePixel = 0
	xButton.Parent = searchFrame

	local function search()
		local terms = {}
		for word in searchBox.Text:gmatch('%S+') do
			terms[word:lower()] = true
		end

		local hitTable = {}
		for i = NumberOfHotbarSlots + 1, #Slots do -- Only search inventory slots
			local slot = Slots[i]
			local hits = slot:CheckTerms(terms)
			table.insert(hitTable, {slot, hits})
			slot.Frame.Visible = false
			slot.Frame.Parent = InventoryFrame
		end

		table.sort(hitTable, function(left, right)
			return left[2] > right[2]
		end)
		ViewingSearchResults = true

		local hitCount = 0
		for i, data in ipairs(hitTable) do
			local slot, hits = data[1], data[2]
			if hits > 0 then
				slot.Frame.Visible = true
				slot.Frame.Parent = UIGridFrame
				slot.Frame.LayoutOrder = NumberOfHotbarSlots + hitCount
				hitCount = hitCount + 1
			end
		end

		ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
		UpdateScrollingFrameCanvasSize()

		xButton.ZIndex = 3
	end

	local function clearResults()
		if xButton.ZIndex > 0 then
			ViewingSearchResults = false
			for i = NumberOfHotbarSlots + 1, #Slots do
				local slot = Slots[i]
				slot.Frame.LayoutOrder = slot.Index
				slot.Frame.Parent = UIGridFrame
				slot.Frame.Visible = true
			end
			xButton.ZIndex = 0
		end
		UpdateScrollingFrameCanvasSize()
	end

	local function reset()
		clearResults()
		searchBox.Text = SEARCH_TEXT
	end

	local function onChanged(property)
		if property == 'Text' then
			local text = searchBox.Text
			if text == '' then
				clearResults()
			elseif text ~= SEARCH_TEXT then
				search()
			end
			xButton.Visible = (text ~= '' and text ~= SEARCH_TEXT)
		end
	end

	local function onFocused()
		if searchBox.Text == SEARCH_TEXT then
			searchBox.Text = ''
		end
	end

	local function focusLost(enterPressed)
		if enterPressed then
			--TODO: Could optimize
			search()
		elseif searchBox.Text == '' then
			searchBox.Text = SEARCH_TEXT
		end
	end

	searchBox.Focused:connect(onFocused)
	xButton.MouseButton1Click:connect(reset)
	searchBox.Changed:connect(onChanged)
	searchBox.FocusLost:connect(focusLost)

	BackpackScript.StateChanged.Event:connect(function(isNowOpen)
		xButton.Modal = isNowOpen -- Allows free mouse movement even in first person
		if not isNowOpen then
			reset()
		end
	end)

	HotkeyFns[Enum.KeyCode.Escape.Value] = function(isProcessed)
		if isProcessed then -- Pressed from within a TextBox
			reset()
		elseif InventoryFrame.Visible then
			BackpackScript.OpenClose()
		end
	end

	local function detectGamepad(lastInputType)
		if lastInputType == Enum.UserInputType.Gamepad1 and not UserInputService.VREnabled then
			searchFrame.Visible = false
		else
			searchFrame.Visible = true
		end
	end
	UserInputService.LastInputTypeChanged:connect(detectGamepad)
end

do -- Make the Inventory expand/collapse arrow (unless TopBar)
	local removeHotBarSlot = function(name, state, input)
		if state ~= Enum.UserInputState.Begin then return end
		if not GuiService.SelectedObject then return end

		for i = 1, NumberOfHotbarSlots do
			if Slots[i].Frame == GuiService.SelectedObject and Slots[i].Tool then
				Slots[i]:MoveToInventory()
				return
			end
		end
	end

	local function openClose()
		if not next(Dragging) then -- Only continue if nothing is being dragged
			InventoryFrame.Visible = not InventoryFrame.Visible
			local nowOpen = InventoryFrame.Visible
			AdjustHotbarFrames()
			HotbarFrame.Active = not HotbarFrame.Active
			for i = 1, NumberOfHotbarSlots do
				Slots[i]:SetClickability(not nowOpen)
			end
		end

		if InventoryFrame.Visible then
			if GamepadEnabled then
				if GAMEPAD_INPUT_TYPES[UserInputService:GetLastInputType()] then
					resizeGamepadHintsFrame()
					gamepadHintsFrame.Visible = not UserInputService.VREnabled
				end
				enableGamepadInventoryControl()
			end
			if BackpackPanel and VRService.VREnabled then
				BackpackPanel:SetVisible(true)
				BackpackPanel:RequestPositionUpdate()
			end
		else
			if GamepadEnabled then
				gamepadHintsFrame.Visible = false
			end
			disableGamepadInventoryControl()
		end

		if InventoryFrame.Visible then
			ContextActionService:BindAction("RBXRemoveSlot", removeHotBarSlot, false, Enum.KeyCode.ButtonX)
		else
			ContextActionService:UnbindAction("RBXRemoveSlot")
		end

		BackpackScript.IsOpen = InventoryFrame.Visible
		BackpackScript.StateChanged:Fire(InventoryFrame.Visible)
	end
	HotkeyFns[ARROW_HOTKEY] = openClose
	BackpackScript.OpenClose = openClose -- Exposed
end

-- Now that we're done building the GUI, we connect to all the major events

-- Wait for the player if LocalPlayer wasn't ready earlier
while not Player do
	wait()
	Player = PlayersService.LocalPlayer
end

-- Listen to current and all future characters of our player
Player.CharacterAdded:connect(OnCharacterAdded)
if Player.Character then
	OnCharacterAdded(Player.Character)
end

do -- Hotkey stuff
	-- Init HotkeyStrings, used for eating hotkeys
	for i = 0, 9 do
		table.insert(HotkeyStrings, tostring(i))
	end
	table.insert(HotkeyStrings, ARROW_HOTKEY_STRING)

	-- Listen to key down
	UserInputService.InputBegan:connect(OnInputBegan)

	-- Listen to ANY TextBox gaining or losing focus, for disabling all hotkeys
	UserInputService.TextBoxFocused:connect(function() TextBoxFocused = true end)
	UserInputService.TextBoxFocusReleased:connect(function() TextBoxFocused = false end)

	-- Manual unequip for HopperBins on drop button pressed
	HotkeyFns[DROP_HOTKEY_VALUE] = function() --NOTE: HopperBin
		if ActiveHopper then
			UnequipAllTools()
		end
	end

	-- Listen to keyboard status, for showing/hiding hotkey labels
	UserInputService.Changed:connect(OnUISChanged)
	OnUISChanged('KeyboardEnabled')

	-- Listen to gamepad status, for allowing gamepad style selection/equip
	if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
		gamepadConnected()
	end
	UserInputService.GamepadConnected:connect(function(gamepadEnum)
		if gamepadEnum == Enum.UserInputType.Gamepad1 then
			gamepadConnected()
		end
	end)
	UserInputService.GamepadDisconnected:connect(function(gamepadEnum)
		if gamepadEnum == Enum.UserInputType.Gamepad1 then
			gamepadDisconnected()
		end
	end)
end

function BackpackScript:TopbarEnabledChanged(enabled)
	TopbarEnabled = enabled
	-- Update coregui to reflect new topbar status
	OnCoreGuiChanged(Enum.CoreGuiType.Backpack, true)
end

-- Listen to enable/disable signals from the StarterGui
local backpackType, healthType = Enum.CoreGuiType.Backpack, Enum.CoreGuiType.Health
OnCoreGuiChanged(backpackType, true)
OnCoreGuiChanged(healthType, true)-- StarterGui:GetCoreGuiEnabled(healthType)


local BackpackStateChangedInVRConn, VRModuleOpenedConn, VRModuleClosedConn = nil, nil, nil
local function OnVREnabled()
	--[[
	local Panel3D = require(RobloxGui.Modules.VR.Panel3D)

	IsVR = VRService.VREnabled
	OnCoreGuiChanged(backpackType, true)
	OnCoreGuiChanged(healthType, true)

	VRInventorySelector.Visible = IsVR

	if IsVR then
		local VRHub = require(RobloxGui.Modules.VR.VRHub)

		local slotsToStuds = (ICON_SIZE + ICON_BUFFER) / VR_PANEL_RESOLUTION
		local inventoryOpenStudSize = Vector2.new(6.25, 7.2) * slotsToStuds
		local inventoryClosedStudSize = Vector2.new(6.25, 2) * slotsToStuds -- Closed size is computed as numberOfHotbarSlots + 0.25
		local inventoryOpenPanelCF = CFrame.new(0, 0.6, 0)
		local inventoryClosedPanelCF = CFrame.new(0, -1, 0)
		local currentPanelLocalCF = inventoryClosedPanelCF

		VRHub:RegisterModule(BackpackScript)

		BackpackPanel = Panel3D.Get(BackpackScript.ModuleName)
		BackpackPanel:ResizeStuds(inventoryClosedStudSize.x, inventoryClosedStudSize.y, VR_PANEL_RESOLUTION)
		BackpackPanel:SetType(Panel3D.Type.Standard, { CFrame = currentPanelLocalCF })
		BackpackPanel:RequestPositionUpdate()
		local panelOriginCF = CFrame.new()
		function BackpackPanel:CalculateTransparency()
			if InventoryFrame.Visible then
				return 0
			end

			local now = tick()
			local timeSinceToolChange = now - TimeOfLastToolChange
			local transparency = math.clamp(timeSinceToolChange / VR_FADE_TIME, 0, 1)

			if transparency == 1 and BackpackPanel:IsVisible() and not InventoryFrame.Visible then
				BackpackPanel:SetVisible(false)
			end

			return transparency
		end

		function BackpackPanel:PreUpdate()
			local inventoryOpen = InventoryFrame.Visible
			BackpackPanel.localCF = inventoryOpen and inventoryOpenPanelCF or inventoryClosedPanelCF
		end

		function BackpackPanel:OnUpdate()
			local inventoryOpen = InventoryFrame.Visible
			if not inventoryOpen then
				BackpackPanel:ResizeStuds((FullHotbarSlots + 0.25) * slotsToStuds, inventoryClosedStudSize.y, VR_PANEL_RESOLUTION)
			end

			-- Update transparency
			for i = 1, #Slots do
				local slot = Slots[i]
				if slot then
					slot:UpdateEquipView()
				end
			end
			OpenInventoryButton.ImageTransparency = BackpackPanel.transparency
			CloseInventoryButton.ImageTransparency = BackpackPanel.transparency
		end

		MainFrame.Parent = BackpackPanel:GetGUI()
		OpenInventoryButton.Parent = MainFrame
		CloseInventoryButton.Parent = InventoryFrame

		ScrollUpInventoryButton.Parent = InventoryFrame
		ScrollDownInventoryButton.Parent = InventoryFrame
		-- Stop the ScrollingFrame from automatically scrolling when you hover over items
		ScrollingFrame.ScrollingEnabled = false

		BackpackStateChangedInVRConn = BackpackScript.StateChanged.Event:connect(function(isNowOpen)
			if isNowOpen then
				VRHub:FireModuleOpened(BackpackScript.ModuleName)
				BackpackPanel:ResizeStuds(inventoryOpenStudSize.x, inventoryOpenStudSize.y, VR_PANEL_RESOLUTION)
				BackpackPanel:SetCanFade(false)
			else
				VRHub:FireModuleClosed(BackpackScript.ModuleName)
				BackpackPanel:ResizeStuds(inventoryClosedStudSize.x, inventoryClosedStudSize.y, VR_PANEL_RESOLUTION)
				BackpackPanel:SetCanFade(true)
			end
		end)

		VRModuleOpenedConn = VRHub.ModuleOpened.Event:connect(function(moduleName)
			local openedModule = VRHub:GetModule(moduleName)
			if openedModule ~= BackpackScript and openedModule.VRIsExclusive then
				BackpackPanel:SetVisible(EvaluateBackpackPanelVisibility(false))
				if InventoryFrame.Visible then
					BackpackScript.OpenClose()
				end
			end
		end)
		VRModuleClosedConn = VRHub.ModuleClosed.Event:connect(function(moduleName)
			local openedModule = VRHub:GetModule(moduleName)
			if openedModule ~= BackpackScript then
				BackpackPanel:SetVisible(EvaluateBackpackPanelVisibility(true))
			end
		end)


		-- Turn off dragging when in VR
		for _, slot in pairs(Slots) do
			slot:SetClickability(false)
		end
	else -- not IsVR (VR was turned off)
		local BackpackPanel = Panel3D.Get(BackpackScript.ModuleName)
		BackpackPanel:SetVisible(EvaluateBackpackPanelVisibility(false))
		BackpackPanel:LinkTo(nil)]]

		MainFrame.Parent = RobloxGui
		OpenInventoryButton.Parent = nil
		CloseInventoryButton.Parent = nil

		ScrollUpInventoryButton.Parent = nil
		ScrollDownInventoryButton.Parent = nil
		ScrollingFrame.ScrollingEnabled = true

		-- Turn draggin back on
		for _, slot in pairs(Slots) do
			slot:SetClickability(true)
		end

		if BackpackStateChangedInVRConn then
			BackpackStateChangedInVRConn:disconnect()
			BackpackStateChangedInVRConn = nil
		end
		if VRModuleOpenedConn then
			VRModuleOpenedConn:disconnect()
			VRModuleOpenedConn = nil
		end
		if VRModuleClosedConn then
			VRModuleClosedConn:disconnect()
			VRModuleClosedConn = nil
		end
	--end

	NumberOfInventoryRows = IsVR and INVENTORY_ROWS_VR or (IS_PHONE and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL)
	local newSlotTotal = IsVR and HOTBAR_SLOTS_VR or (IS_PHONE and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL)
	SetNumberOfHotbarSlots(newSlotTotal)
end
VRService:GetPropertyChangedSignal("VREnabled"):connect(OnVREnabled)
OnVREnabled()

return BackpackScript

end;
};
G2L_MODULES[G2L["6"]] = {
Closure = function()
    local script = G2L["6"];--[[
		Filename: TenFootInterface.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Setups up some special UI for ROBLOX TV gaming
--]]
-------------- CONSTANTS --------------
local HEALTH_GREEN_COLOR = Color3.new(27/255, 252/255, 107/255)
local DISPLAY_POS_INIT_INSET = 0
local DISPLAY_ITEM_OFFSET = 4
local FORCE_TEN_FOOT_INTERFACE = false

-------------- SERVICES --------------
local CoreGui = script.Parent.Parent.Parent
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

------------------ VARIABLES --------------------
local tenFootInterfaceEnabled = false
do
	--[[local platform = UserInputService:GetPlatform()

	tenFootInterfaceEnabled = (platform == Enum.Platform.XBoxOne or platform == Enum.Platform.WiiU or platform == Enum.Platform.PS4 or 
		platform == Enum.Platform.AndroidTV or platform == Enum.Platform.XBox360 or platform == Enum.Platform.PS3 or
		platform == Enum.Platform.Ouya or platform == Enum.Platform.SteamOS)]]
	
	tenFootInterfaceEnabled = _G.TenFootInterfacePC and UserInputService.GamepadEnabled or GuiService:IsTenFootInterface()
	
	--tenFootInterfaceEnabled = UserInputService.GamepadEnabled
	--tenFootInterfaceEnabled = GuiService:IsTenFootInterface()
	
end

if FORCE_TEN_FOOT_INTERFACE then
	tenFootInterfaceEnabled = true
end

local Util = {}
do
	function Util.Create(instanceType)
		return function(data)
			local obj = Instance.new(instanceType)
			for k, v in pairs(data) do
				if type(k) == 'number' then
					v.Parent = obj
				else
					obj[k] = v
				end
			end
			return obj
		end
	end
end

local function CreateModule()
	local this = {}
	local nextObjectDisplayYPos = DISPLAY_POS_INIT_INSET
	local displayStack = {}
	local displayStackChanged = Instance.new("BindableEvent")
	local healthContainerPropertyChanged = Instance.new("BindableEvent")

	-- setup base gui
	local function createContainer()
		if not this.Container then
			this.Container = Util.Create'ImageButton'
			{
				Name = "TopRightContainer";
				Size = UDim2.new(0, 350, 0, 100);
				Position = _G.ShowAgeBracket and UDim2.new(1,-415,0,10) or UDim2.new(1,-360,0,10);
				AutoButtonColor = false;
				Image = "";
				Active = false;
				Selectable = false;
				BackgroundTransparency = 1;
				Parent = RobloxGui;
			};
		end
	end

	function removeFromDisplayStack(displayObject)
		local moveUpFromHere = nil

		for i = 1, #displayStack do
			if displayStack[i] == displayObject then
				moveUpFromHere = i + 1
				break
			end
		end

		local prevObject = displayObject
		for i = moveUpFromHere, #displayStack do
			local objectToMoveUp = displayStack[i]
			objectToMoveUp.Position = UDim2.new(objectToMoveUp.Position.X.Scale, objectToMoveUp.Position.X.Offset,
				objectToMoveUp.Position.Y.Scale, prevObject.AbsolutePosition.Y)
			prevObject = objectToMoveUp
		end
	end

	function addBackToDisplayStack(displayObject)
		for i = 1, #displayStack do
			if displayStack[i] == displayObject then
				moveDownFromHere = i + 1
				break
			end
		end

		local prevObject = displayObject
		for i = moveDownFromHere, #displayStack do
			local objectToMoveDown = displayStack[i]
			local nextDisplayPos = prevObject.AbsolutePosition.Y + prevObject.AbsoluteSize.Y + DISPLAY_ITEM_OFFSET
			objectToMoveDown.Position = UDim2.new(objectToMoveDown.Position.X.Scale, objectToMoveDown.Position.X.Offset,
				objectToMoveDown.Position.Y.Scale, nextDisplayPos)
			prevObject = objectToMoveDown
		end
	end

	function addToDisplayStack(displayObject)
		local lastDisplayed = nil
		if #displayStack > 0 then
			lastDisplayed = displayStack[#displayStack]
		end
		displayStack[#displayStack + 1] = displayObject

		--[[local nextDisplayPos = DISPLAY_POS_INIT_INSET
		if lastDisplayed then
			nextDisplayPos = lastDisplayed.AbsolutePosition.Y + lastDisplayed.AbsoluteSize.Y + DISPLAY_ITEM_OFFSET
		end

		displayObject.Position = UDim2.new(displayObject.Position.X.Scale, displayObject.Position.X.Offset,
			displayObject.Position.Y.Scale, nextDisplayPos)]]

		createContainer()
		displayObject.Parent = this.Container

		displayObject.Changed:connect(function(prop)
			if prop == "Visible" then
				if not displayObject.Visible then
					removeFromDisplayStack(displayObject)
				else
					addBackToDisplayStack(displayObject)
				end
			end
		end)
	end

	function this:CreateHealthBar()
		this.HealthContainer = Util.Create'Frame'{
			Name = "HealthContainer";
			Size = UDim2.new(1, -86, 0, 50);
			Position = UDim2.new(0, 92, 0, 0);
			BorderSizePixel = 0;
			BackgroundColor3 = Color3.new(0,0,0);
			BackgroundTransparency = 0.5;
		};

		local healthFillHolder = Util.Create'Frame'{
			Name = "HealthFillHolder";
			Size = UDim2.new(1, -10, 1, -10);
			Position = UDim2.new(0, 5, 0, 5);
			BorderSizePixel = 0;
			BackgroundColor3 = Color3.new(1,1,1);
			BackgroundTransparency = 1.0;
			Parent = this.HealthContainer;
		};

		local healthFill = Util.Create'Frame'{
			Name = "HealthFill";
			Size = UDim2.new(1, 0, 1, 0);
			Position = UDim2.new(0, 0, 0, 0);
			BorderSizePixel = 0;
			BackgroundTransparency = 0.0;
			BackgroundColor3 = HEALTH_GREEN_COLOR;
			Parent = healthFillHolder;
		};

		local healthText = Util.Create'TextLabel'{
			Name = "HealthText";
			Size = UDim2.new(0, 98, 0, 50);
			Position = UDim2.new(0, -100, 0, 0);
			BackgroundTransparency = 0.5;
			BackgroundColor3 = Color3.new(0,0,0);
			Font = Enum.Font.SourceSans;
			FontSize = Enum.FontSize.Size36;
			Text = "Health";
			TextColor3 = Color3.new(1,1,1);
			BorderSizePixel = 0;
			Parent = this.HealthContainer;
		};

		local username = Util.Create'TextLabel'{
			Visible = false
		}

		local accountType = Util.Create'TextLabel'{
			Visible = false
		}

		addToDisplayStack(this.HealthContainer)
		createContainer()

		this.HealthContainer.Changed:connect(function()
			healthContainerPropertyChanged:Fire()
		end)

		return this.Container, username, this.HealthContainer, healthFill, accountType
	end
	
	function this:CreateAccountType(accountTypeTextShort)
		this.AccountTypeContainer = Util.Create'Frame'{
			Name = "AccountTypeContainer";
			Size = UDim2.new(0, 50, 0, 50);
			Position = UDim2.new(1, -55, 0, 10);
			BorderSizePixel = 0;
			BackgroundColor3 = Color3.new(0,0,0);
			BackgroundTransparency = 0.5;
			Parent = RobloxGui;
		};

		local accountTypeTextLabel = Util.Create'TextLabel'{
			Name = "AccountTypeText";
			Size = UDim2.new(1, 0, 1, 0);
			Position = UDim2.new(0, 0, 0, 0);
			BackgroundTransparency = 1;
			BackgroundColor3 = Color3.new(0,0,0);
			Font = Enum.Font.SourceSans;
			FontSize = Enum.FontSize.Size36;
			Text = accountTypeTextShort;
			TextColor3 = Color3.new(1,1,1);
			BorderSizePixel = 0;
			Parent = this.AccountTypeContainer;
			TextXAlignment = Enum.TextXAlignment.Center;
			TextYAlignment = Enum.TextYAlignment.Center;
		};
	end


	function this:SetupTopStat()
		local topStatEnabled = true
		local displayedStat = nil
		local displayedStatChangedCon = nil
		local displayedStatParentedCon = nil
		local leaderstatsChildAddedCon = nil
		local tenFootInterfaceStat = nil

		local function makeTenFootInterfaceStat()
			if tenFootInterfaceStat then return end

			tenFootInterfaceStat = Util.Create'Frame'{
				Name = "OneStatFrame";
				Size = UDim2.new(1, 0, 0, 36);
				Position = UDim2.new(0, 0, 0, 50);
				BorderSizePixel = 0;
				BackgroundTransparency = 1;
			};
			local statName = Util.Create'TextLabel'{
				Name = "StatName";
				Size = UDim2.new(0.5,0,0,36);
				BackgroundTransparency = 1;
				Font = Enum.Font.SourceSans;
				FontSize = Enum.FontSize.Size36;
				TextStrokeColor3 = Color3.new(104/255, 104/255, 104/255);
				TextStrokeTransparency = 0;
				Text = " StatName:";
				TextColor3 = Color3.new(1,1,1);
				TextXAlignment = Enum.TextXAlignment.Left;
				BorderSizePixel = 0;
				ClipsDescendants = true;
				Parent = tenFootInterfaceStat;
			};
			local statValue = statName:clone()
			statValue.Position = UDim2.new(0.5,0,0,0)
			statValue.Name = "StatValue"
			statValue.Text = "123,643,231"
			statValue.TextXAlignment = Enum.TextXAlignment.Right
			statValue.Parent = tenFootInterfaceStat

			addToDisplayStack(tenFootInterfaceStat)
		end

		local function setDisplayedStat(newStat)
			if displayedStatChangedCon then displayedStatChangedCon:disconnect() displayedStatChangedCon = nil end
			if displayedStatParentedCon then displayedStatParentedCon:disconnect() displayedStatParentedCon = nil end

			displayedStat = newStat

			if displayedStat then
				makeTenFootInterfaceStat()
				updateTenFootStat(displayedStat)
				displayedStatParentedCon = displayedStat.AncestryChanged:connect(function() updateTenFootStat(displayedStat, "Parent") end)
				displayedStatChangedCon = displayedStat.Changed:connect(function(prop) updateTenFootStat(displayedStat, prop) end)
			end
		end

		function updateTenFootStat(statObj, property)
			if property and property == "Parent" then
				tenFootInterfaceStat.StatName.Text = ""
				tenFootInterfaceStat.StatValue.Text = ""
				setDisplayedStat(nil)

				tenFootInterfaceChanged()
			else
				if topStatEnabled then
					tenFootInterfaceStat.StatName.Text = " " .. tostring(statObj.Name) .. ":"
					tenFootInterfaceStat.StatValue.Text = tostring(statObj.Value)
				else
					tenFootInterfaceStat.StatName.Text = ""
					tenFootInterfaceStat.StatValue.Text = ""
				end
			end
		end

		local function isValidStat(obj)
			return obj:IsA('StringValue') or obj:IsA('IntValue') or obj:IsA('BoolValue') or obj:IsA('NumberValue') or
				obj:IsA('DoubleConstrainedValue') or obj:IsA('IntConstrainedValue')
		end

		local function tenFootInterfaceNewStat( newStat )
			if not displayedStat and isValidStat(newStat) then
				setDisplayedStat(newStat)
			end
		end

		function tenFootInterfaceChanged()
			game:WaitForChild("Players")
			while not game.Players.LocalPlayer do
				wait()
			end

			local leaderstats = game.Players.LocalPlayer:FindFirstChild('leaderstats')
			if leaderstats then
				local statChildren = leaderstats:GetChildren()
				for i = 1, #statChildren do
					tenFootInterfaceNewStat(statChildren[i])
				end
				if leaderstatsChildAddedCon then leaderstatsChildAddedCon:disconnect() end
				leaderstatsChildAddedCon = leaderstats.ChildAdded:connect(function(newStat)
					tenFootInterfaceNewStat(newStat)
				end)
			end
		end

		game:WaitForChild("Players")
		while not game.Players.LocalPlayer do
			wait()
		end

		local leaderstats = game.Players.LocalPlayer:FindFirstChild('leaderstats')
		if leaderstats then
			tenFootInterfaceChanged()
		else
			game.Players.LocalPlayer.ChildAdded:connect(tenFootInterfaceChanged)
		end

		--Top Stat Public API

		local topStatApiTable = {}

		function topStatApiTable:SetTopStatEnabled(value)
			topStatEnabled = value
			if displayedStat then
				updateTenFootStat(displayedStat, "")
			end
		end

		return topStatApiTable
	end

	return this
end


-- Public API

local moduleApiTable = {}

local TenFootInterfaceModule = CreateModule()

function moduleApiTable:IsEnabled()
	return tenFootInterfaceEnabled
end

function moduleApiTable:CreateHealthBar()
	return TenFootInterfaceModule:CreateHealthBar()
end

function moduleApiTable:CreateAccountType(accountTypeText)
	return TenFootInterfaceModule:CreateAccountType(accountTypeText)
end

function moduleApiTable:SetupTopStat()
	return TenFootInterfaceModule:SetupTopStat()
end

return moduleApiTable
end;
};
G2L_MODULES[G2L["7"]] = {
Closure = function()
    local script = G2L["7"];-- Uses modern GroupService role APIs instead of deprecated single-rank calls.

local GroupService = game:GetService("GroupService")

local PlayerPermissionsModule = {}

local function HasRankInGroupFunctionFactory(groupId, requiredRank)
    assert(type(requiredRank) == "number", "requiredRank must be a number")

    local hasRankCache = {}

    return function(player)
        if not player or player.UserId <= 0 then
            return false
        end

        if hasRankCache[player.UserId] == nil then
            local hasRank = false

            local success, result = pcall(function()
                return GroupService:GetRolesInGroupAsync(player.UserId, groupId)
            end)

            if success and result and result.IsMember then
                for _, role in ipairs(result.Roles or {}) do
                    if tonumber(role.Rank) and role.Rank >= requiredRank then
                        hasRank = true
                        break
                    end
                end
            end

            hasRankCache[player.UserId] = hasRank
        end

        return hasRankCache[player.UserId]
    end
end

local function IsInGroupFunctionFactory(groupId)
    local inGroupCache = {}

    return function(player)
        if not player or player.UserId <= 0 then
            return false
        end

        if inGroupCache[player.UserId] == nil then
            local inGroup = false
            local success, result = pcall(function()
                return player:IsInGroupAsync(groupId)
            end)

            if success then
                inGroup = result == true
            end

            inGroupCache[player.UserId] = inGroup
        end

        return inGroupCache[player.UserId]
    end
end

PlayerPermissionsModule.IsPlayerAdminAsync = IsInGroupFunctionFactory(1200769)
PlayerPermissionsModule.IsPlayerInternAsync = HasRankInGroupFunctionFactory(2868472, 100)

return PlayerPermissionsModule
end;
};
G2L_MODULES[G2L["8"]] = {
Closure = function()
    local script = G2L["8"];--[[
  // FileName: PlayerlistModule.lua
  // Version 1.3
  // Written by: jmargh
  // Description: Implementation of in game player list and leaderboard
]]

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TeamsService = game:GetService("Teams")
local ContextActionService = game:GetService("ContextActionService")
local GroupService = game:GetService("GroupService")
local StarterGui = game:GetService("StarterGui")
local PlayersService = game:GetService("Players")

local Player = PlayersService.LocalPlayer
while not Player do
	PlayersService:GetPropertyChangedSignal("LocalPlayer"):Wait()
	Player = PlayersService.LocalPlayer
end

-- 2026 compatibility: these modules now live under the experience's RobloxGui
-- instead of protected CoreGui.
local RobloxGui = script:FindFirstAncestor("RobloxGui")
if not RobloxGui then
	RobloxGui = Player:WaitForChild("PlayerGui"):WaitForChild("RobloxGui")
end
local Modules = RobloxGui:WaitForChild("Modules")

local StatsUtils = { ButtonHeight = 0 }
local statsFolder = Modules:FindFirstChild("Stats")
if statsFolder and statsFolder:FindFirstChild("StatsUtils") then
	local ok, result = pcall(require, statsFolder.StatsUtils)
	if ok and type(result) == "table" then
		StatsUtils = result
	end
end

local TenFootInterface = nil
local tenFootModule = Modules:FindFirstChild("TenFootInterface")
if tenFootModule then
	local ok, result = pcall(require, tenFootModule)
	if ok then
		TenFootInterface = result
	end
end
local isTenFootInterface = false
if TenFootInterface and type(TenFootInterface.IsEnabled) == "function" then
	local ok, result = pcall(function() return TenFootInterface:IsEnabled() end)
	isTenFootInterface = ok and result or false
else
	local ok, result = pcall(function() return GuiService:IsTenFootInterface() end)
	isTenFootInterface = ok and result or false
end

local playerDropDownModule = require(Modules:WaitForChild("PlayerDropDown"))
local blockingUtility = playerDropDownModule:CreateBlockingUtility()
local playerDropDown = playerDropDownModule:CreatePlayerDropDown()

local PlayerPermissionsModule = require(Modules:WaitForChild("PlayerPermissionsModule"))

--[[ Remotes ]]--
local RemoveEvent_OnFollowRelationshipChanged = nil
local RemoteFunc_GetFollowRelationships = nil

--[[ Start Module ]]--
local Playerlist = {}

--[[ Public Event API ]]--
-- Parameters: Sorted Array - see GameStats below
Playerlist.OnLeaderstatsChanged = Instance.new('BindableEvent')
-- Parameters: nameOfStat(string), formatedStringOfStat(string)
Playerlist.OnStatChanged = Instance.new('BindableEvent')

--[[ Client Stat Table ]]--
-- Sorted Array of tables
local GameStats = {}
-- Fields
-- Name: String the developer has given the stat
-- Text: Formated string of the stat value
-- AddId: Child add order id
-- IsPrimary: Is this the primary stat
-- Priority: Sorting priority
-- NOTE: IsPrimary and Priority are unofficially supported. They are left over legacy from the old player list.
-- They can be un-supported at anytime. You should prefer using child add order to order your stats in the leader board.

--[[ Script Variables ]]--
local topbarEnabled = true
local playerlistCoreGuiEnabled = true
local MyPlayerEntryTopFrame = nil
local PlayerEntries = {}
local StatAddId = 0
local TeamEntries = {}
local TeamAddId = 0
local NeutralTeam = nil
local IsShowingNeutralFrame = false
local LastSelectedFrame = nil
local LastSelectedPlayer = nil
local MinContainerSize = UDim2.new(0, 165, 0.5, 0)
if isTenFootInterface then
	MinContainerSize = UDim2.new(0, 1000, 0, 720)
end
local TempHideKeys = {}

local PlayerEntrySizeY = 24
if isTenFootInterface then
	PlayerEntrySizeY = 80
end

local TeamEntrySizeY = 18

if isTenFootInterface then
	TeamEntrySizeY = 32
end

local NameEntrySizeX = 170
if isTenFootInterface then
	NameEntrySizeX = 350
end

local StatEntrySizeX = 75
if isTenFootInterface then
	StatEntrySizeX = 250
end

local function getViewportSize()
	local camera = workspace.CurrentCamera
	return camera and camera.ViewportSize or Vector2.new(1280, 720)
end
-- The original 2016 module intentionally disabled the playerlist on small touch screens.
-- OldRobloxify wants the classic playerlist to remain available on mobile.
local IsSmallScreenDevice = false


--[[ Constants ]]--
local ENTRY_PAD = 2
local BG_TRANSPARENCY = 0.5
local BG_COLOR = Color3.new(31/255, 31/255, 31/255)
local BG_COLOR_TOP = Color3.new(106/255, 106/255, 106/255)
local TEXT_STROKE_TRANSPARENCY = 0.75
local TEXT_COLOR = Color3.new(1, 1, 243/255)
local TEXT_STROKE_COLOR = Color3.new(34/255, 34/255, 34/255)
local TWEEN_TIME = 0.15
local MAX_LEADERSTATS = 4
local MAX_STR_LEN = 12
local TILE_SPACING = 2
if isTenFootInterface then
	BG_COLOR_TOP = Color3.new(25/255, 25/255, 25/255)
	BG_COLOR = Color3.new(60/255, 60/255, 60/255)
	BG_TRANSPARENCY = 0.25
	TEXT_STROKE_TRANSPARENCY = 1
	TILE_SPACING = 5
end
local SHADOW_IMAGE = 'rbxasset://textures/ui/PlayerList/TileShadowMissingTop.png'--'http://www.roblox.com/asset?id=286965900'
local SHADOW_SLICE_SIZE = 5
local SHADOW_SLICE_RECT = Rect.new(SHADOW_SLICE_SIZE+1, SHADOW_SLICE_SIZE+1, SHADOW_SLICE_SIZE*2-1, SHADOW_SLICE_SIZE*2-1)

local CUSTOM_ICONS = {	-- Admins with special icons
	['7210880'] = 'rbxassetid://134032333', -- Jeditkacheff
	['13268404'] = 'rbxassetid://113059239', -- Sorcus
	['261'] = 'rbxassetid://105897927', -- shedlestky
	['20396599'] = 'rbxassetid://161078086', -- Robloxsai
}

local ABUSES = {
	"Swearing",
	"Bullying",
	"Scamming",
	"Dating",
	"Cheating/Exploiting",
	"Personal Questions",
	"Offsite Links",
	"Bad Username",
}

--[[ Images ]]--
local CHAT_ICON = 'rbxasset://textures/ui/chat_teamButton.png'
local ADMIN_ICON = 'rbxasset://textures/ui/icon_admin-16.png'
local INTERN_ICON = 'rbxasset://textures/ui/icon_intern-16.png'
local PLACE_OWNER_ICON = 'rbxasset://textures/ui/icon_placeowner.png'
local BC_ICON = 'rbxasset://textures/ui/icon_BC-16.png'
local TBC_ICON = 'rbxasset://textures/ui/icon_TBC-16.png'
local OBC_ICON = 'rbxasset://textures/ui/icon_OBC-16.png'
local BLOCKED_ICON = 'rbxasset://textures/ui/PlayerList/BlockedIcon.png'
local FRIEND_ICON = 'rbxasset://textures/ui/icon_friends_16.png'
local FRIEND_REQUEST_ICON = 'rbxasset://textures/ui/icon_friendrequestsent_16.png'
local FRIEND_RECEIVED_ICON = 'rbxasset://textures/ui/icon_friendrequestrecieved-16.png'

local FOLLOWER_ICON = 'rbxasset://textures/ui/icon_follower-16.png'
local FOLLOWING_ICON = 'rbxasset://textures/ui/icon_following-16.png'
local MUTUAL_FOLLOWING_ICON = 'rbxasset://textures/ui/icon_mutualfollowing-16.png'

local CHARACTER_BACKGROUND_IMAGE = 'rbxasset://textures/ui/PlayerList/CharacterBackgroundImage.png'

--[[ Helper Functions ]]--
local function clamp(value, min, max)
	if value < min then
		value = min
	elseif value > max then
		value = max
	end

	return value
end

local function getFriendStatusIcon(friendStatus)
	if friendStatus == Enum.FriendStatus.Unknown or friendStatus == Enum.FriendStatus.NotFriend then
		return nil
	elseif friendStatus == Enum.FriendStatus.Friend then
		return FRIEND_ICON
	elseif friendStatus == Enum.FriendStatus.FriendRequestSent then
		return FRIEND_REQUEST_ICON
	elseif friendStatus == Enum.FriendStatus.FriendRequestReceived then
		return FRIEND_RECEIVED_ICON
	else
		error("PlayerList: Unknown value for friendStatus: "..tostring(friendStatus))
	end
end

local function getCustomPlayerIcon(player)
	local userIdStr = tostring(player.UserId)
	if CUSTOM_ICONS[userIdStr] then return nil end
	--

	if PlayerPermissionsModule.IsPlayerAdminAsync(player) then
		return ADMIN_ICON
	elseif PlayerPermissionsModule.IsPlayerInternAsync(player) then
		return INTERN_ICON
	end
end

local function setAvatarIconAsync(player, iconImage)
	local ok, image = pcall(function()
		return PlayersService:GetUserThumbnailAsync(
			player.UserId,
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size100x100
		)
	end)
	if ok and image then
		iconImage.Image = image
	else
		iconImage.Image = "rbxasset://textures/ui/Shell/Icons/DefaultProfileIcon.png"
	end
end

local function getMembershipIcon(player)
	if isTenFootInterface then
		return ""
	end

	if blockingUtility:IsPlayerBlockedByUserId(player.UserId) then
		return BLOCKED_ICON
	end

	local userIdStr = tostring(player.UserId)
	if CUSTOM_ICONS[userIdStr] then
		return CUSTOM_ICONS[userIdStr]
	elseif player.UserId == game.CreatorId and game.CreatorType == Enum.CreatorType.User then
		return PLACE_OWNER_ICON
	end

	-- Builders Club / Turbo / OBC no longer exist. Premium deliberately does
	-- not reuse those legacy icons.
	return ""
end

local function isValidStat(obj)
	return obj:IsA('StringValue') or obj:IsA('IntValue') or obj:IsA('BoolValue') or obj:IsA('NumberValue') or
		obj:IsA('DoubleConstrainedValue') or obj:IsA('IntConstrainedValue')
end

local function sortPlayerEntries(a, b)
	if a.PrimaryStat == b.PrimaryStat then
		return a.Player.Name:upper() < b.Player.Name:upper()
	end
	if not a.PrimaryStat then return false end
	if not b.PrimaryStat then return true end
	local statA = a.PrimaryStat
	local statB = b.PrimaryStat
	statA = tonumber(statA) or statA
	statB = tonumber(statB) or statB
	if type(statA) ~= type(statB) then
		statA = tostring(statA)
		statB = tostring(statB)
	end
	return statA > statB
end

local function sortLeaderStats(a, b)
	if a.IsPrimary ~= b.IsPrimary then
		return a.IsPrimary
	end
	if a.Priority == b.Priority then
		return a.AddId < b.AddId
	end
	return a.Priority < b.Priority
end

local function sortTeams(a, b)
	if a.TeamScore == b.TeamScore then
		return a.Id < b.Id
	end
	if not a.TeamScore then return false end
	if not b.TeamScore then return true end
	return a.TeamScore < b.TeamScore
end

-- Start of Gui Creation
local Container = Instance.new('Frame')
Container.Name = "PlayerListContainer"
Container.Size = MinContainerSize

if isTenFootInterface then
	Container.Position = UDim2.new(0.5, -MinContainerSize.X.Offset/2, 0.25, 0)  
else
	Container.Position = UDim2.new(1, -167, 0, 38)
end

-- Every time Performance Stats toggles on/off we need to 
-- reposition the main Container, so things don't overlap.
-- Optimally I could just call an "UpdateContainerPosition" function 
-- that takes into account everything that affects Container position 
-- and recalculate things.
-- 
-- Unfortunately, the position of Container may be kind of hard to re-calculate
-- on the fly when it's been shaped based on current leader board state.
--
-- So instead we do this: 
-- We always track where we'd be putting the widget if there were no 
-- position stats in targetContainerYOffset.
-- Whenever we reposition Container, we first move it to the ignoring-stats
-- location, (updating targetContainerYOffset), then call the 
-- AdjustContainerPosition function to derive final position.
local targetContainerYOffset = Container.Position.Y.Offset

Container.BackgroundTransparency = 1
Container.Visible = false
Container.Parent = RobloxGui

local function AdjustContainerPosition()
	if Container == nil then
		return
	end
	Container.Position = UDim2.new(
		Container.Position.X.Scale,
		Container.Position.X.Offset,
		Container.Position.Y.Scale,
		targetContainerYOffset
	)
end
AdjustContainerPosition()

-- Scrolling Frame
local noSelectionObject = Instance.new("Frame")
noSelectionObject.BackgroundTransparency = 1
noSelectionObject.BorderSizePixel = 0

local ScrollList = Instance.new('ScrollingFrame')
ScrollList.Name = "ScrollList"
ScrollList.Size = UDim2.new(1, -1, 0, 0)
if isTenFootInterface then
	ScrollList.Position = UDim2.new(0, 0, 0, PlayerEntrySizeY + TILE_SPACING)
	ScrollList.Size = UDim2.new(1, 19, 0, 0)
end
ScrollList.BackgroundTransparency = 1
ScrollList.BackgroundColor3 = Color3.new()
ScrollList.BorderSizePixel = 0
ScrollList.CanvasSize = UDim2.new(0, 0, 0, 0)	-- NOTE: Look into if x needs to be set to anything
ScrollList.ScrollBarThickness = 6
ScrollList.BottomImage = 'rbxasset://textures/ui/scroll-bottom.png'
ScrollList.MidImage = 'rbxasset://textures/ui/scroll-middle.png'
ScrollList.TopImage = 'rbxasset://textures/ui/scroll-top.png'
ScrollList.SelectionImageObject = noSelectionObject
ScrollList.Selectable = false
ScrollList.Parent = Container

-- PlayerDropDown clipping frame
local PopupClipFrame = Instance.new('Frame')
PopupClipFrame.Name = "PopupClipFrame"
PopupClipFrame.Size = UDim2.new(0, 150, 1.5, 0)
PopupClipFrame.Position = UDim2.new(0, -150 - ENTRY_PAD, 0, 0)
PopupClipFrame.BackgroundTransparency = 1
PopupClipFrame.ClipsDescendants = true
PopupClipFrame.Parent = Container


--[[ Creation Helper Functions ]]--
local function createEntryFrame(name, sizeYOffset, isTopStat)
	local containerFrame = Instance.new('Frame')
	containerFrame.Name = name
	containerFrame.Position = UDim2.new(0, 0, 0, 0)
	containerFrame.Size = UDim2.new(1, 0, 0, sizeYOffset)
	if isTenFootInterface then
		containerFrame.Position = UDim2.new(0, 10, 0, 0)
		containerFrame.Size = containerFrame.Size + UDim2.new(0, -20, 0, 0)
	end
	containerFrame.BackgroundTransparency = 1
	containerFrame.ZIndex = isTenFootInterface and 2 or 1

	local nameFrame = Instance.new('TextButton')
	nameFrame.Name = "BGFrame"
	nameFrame.Position = UDim2.new(0, 0, 0, 0)
	nameFrame.Size = UDim2.new(0, NameEntrySizeX, 0, sizeYOffset)
	nameFrame.BackgroundTransparency = isTopStat and 0 or BG_TRANSPARENCY
	nameFrame.BackgroundColor3 = isTopStat and BG_COLOR_TOP or BG_COLOR
	nameFrame.BorderSizePixel = 0
	nameFrame.AutoButtonColor = false
	nameFrame.Text = ""
	nameFrame.Parent = containerFrame
	nameFrame.ZIndex = isTenFootInterface and 2 or 1

	return containerFrame, nameFrame
end

local function createEntryNameText(name, text, sizeXOffset, posXOffset)
	local nameLabel = Instance.new('TextLabel')
	nameLabel.Name = name
	nameLabel.Size = UDim2.new(-0.01, sizeXOffset, 1, 0)
	nameLabel.Position = UDim2.new(0.01, posXOffset, 0, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Font = Enum.Font.SourceSans
	if isTenFootInterface then
		nameLabel.TextSize = 32
	else
		nameLabel.TextSize = 14
	end
	nameLabel.TextColor3 = TEXT_COLOR
	nameLabel.TextStrokeTransparency = TEXT_STROKE_TRANSPARENCY
	nameLabel.TextStrokeColor3 = TEXT_STROKE_COLOR
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.ClipsDescendants = true
	nameLabel.Text = text
	nameLabel.ZIndex = isTenFootInterface and 2 or 1

	return nameLabel
end

local function createStatFrame(offset, parent, name, isTopStat)
	local statFrame = Instance.new('Frame')
	statFrame.Name = name
	statFrame.Size = UDim2.new(0, StatEntrySizeX, 1, 0)
	statFrame.Position = UDim2.new(0, offset + TILE_SPACING, 0, 0)
	statFrame.BackgroundTransparency = isTopStat and 0 or BG_TRANSPARENCY
	statFrame.BackgroundColor3 = isTopStat and BG_COLOR_TOP or BG_COLOR
	statFrame.BorderSizePixel = 0
	statFrame.Parent = parent

	if isTenFootInterface then
		statFrame.ZIndex = 2

		local shadow = Instance.new("ImageLabel")
		shadow.BackgroundTransparency = 1
		shadow.Name = 'Shadow'
		shadow.Image = SHADOW_IMAGE
		shadow.Position = UDim2.new(0, -SHADOW_SLICE_SIZE, 0, 0)
		shadow.Size = UDim2.new(1, SHADOW_SLICE_SIZE*2, 1, SHADOW_SLICE_SIZE)
		shadow.ScaleType = Enum.ScaleType.Slice
		shadow.SliceCenter = SHADOW_SLICE_RECT
		shadow.Parent = statFrame
	end

	return statFrame
end

local function createStatText(parent, text, isTopStat, isTeamStat)
	local statText = Instance.new('TextLabel')
	statText.Name = "StatText"
	statText.Size = isTopStat and UDim2.new(1, 0, 0.5, 0) or UDim2.new(1, 0, 1, 0)
	statText.Position = isTopStat and UDim2.new(0, 0, 0.5, 0) or UDim2.new(0, 0, 0, 0)
	statText.BackgroundTransparency = 1
	statText.Font = isTopStat and Enum.Font.SourceSansBold or Enum.Font.SourceSans
	if isTenFootInterface then
		statText.TextSize = 32
	else
		statText.TextSize = 14
	end
	statText.TextColor3 = TEXT_COLOR
	statText.TextStrokeColor3 = TEXT_STROKE_COLOR
	statText.TextStrokeTransparency = TEXT_STROKE_TRANSPARENCY
	statText.Text = text
	statText.Active = true
	statText.Parent = parent
	if isTenFootInterface then
		statText.ZIndex = 2
	end

	if isTopStat then
		local statName = statText:Clone()
		statName.Name = "StatName"
		statName.Text = tostring(parent.Name)
		statName.Position = UDim2.new(0,0,0,0)
		statName.Font = Enum.Font.SourceSans
		statName.ClipsDescendants = true
		statName.Parent = parent
		if isTenFootInterface then
			statName.ZIndex = 2
		end
	end

	if isTeamStat then
		statText.Font = Enum.Font.SourceSansBold
	end

	return statText
end

local function createImageIcon(image, name, xOffset, parent)
	local imageLabel = Instance.new('ImageLabel')
	imageLabel.Name = name
	if isTenFootInterface then
		imageLabel.Size = UDim2.new(0, 64, 0, 64)
		imageLabel.ZIndex = 2

		local background = Instance.new("ImageLabel", imageLabel)
		background.Name = 'Background'
		background.BackgroundTransparency = 1
		background.Image = CHARACTER_BACKGROUND_IMAGE
		background.Size = UDim2.new(0, 66, 0, 66)
		background.Position = UDim2.new(0.5, -66/2, 0.5, -66/2)
		background.ZIndex = 2
	else
		imageLabel.Size = UDim2.new(0, 16, 0, 16)
	end
	imageLabel.Position = UDim2.new(0.01, xOffset, 0.5, -imageLabel.Size.Y.Offset/2)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = image
	imageLabel.BorderSizePixel = 0
	imageLabel.Parent = parent

	return imageLabel
end

local function getScoreValue(statObject)
	if statObject:IsA('DoubleConstrainedValue') or statObject:IsA('IntConstrainedValue') then
		return statObject.ConstrainedValue
	elseif statObject:IsA('BoolValue') then
		if statObject.Value then return 1 else return 0 end
	else
		return statObject.Value
	end
end

local THIN_CHARS = "[^%[iIl\%.,']"
local function strWidth(str)
	return string.len(str) - math.floor(string.len(string.gsub(str, THIN_CHARS, "")) / 2)
end

local function formatNumber(value)
	local _,_,minusSign, int, fraction = tostring(value):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("%d%d%d", "%1,")
	return minusSign..int:reverse():gsub("^,", "")..fraction
end

local function formatStatString(text)
	local numberValue = tonumber(text)
	if numberValue then
		text = formatNumber(numberValue)
	end

	if strWidth(text) <= MAX_STR_LEN then
		return text
	else
		return string.sub(text, 1, MAX_STR_LEN - 3).."..."
	end
end

--[[ Resize Functions ]]--
local LastMaxScrollSize = 0
local function setScrollListSize()
	local teamSize = #TeamEntries * TeamEntrySizeY
	local playerSize = #PlayerEntries * PlayerEntrySizeY
	local spacing = #PlayerEntries * ENTRY_PAD + #TeamEntries * ENTRY_PAD
	local canvasSize = teamSize + playerSize + spacing
	if #TeamEntries > 0 and NeutralTeam and IsShowingNeutralFrame then
		canvasSize = canvasSize + TeamEntrySizeY + ENTRY_PAD
	end
	ScrollList.CanvasSize = UDim2.new(0, 0, 0, canvasSize)
	local newScrollListSize = math.min(canvasSize, Container.AbsoluteSize.Y)
	if ScrollList.Size.Y.Offset == LastMaxScrollSize then
		if isTenFootInterface then
			ScrollList.Size = UDim2.new(1, 20, 0, newScrollListSize)
		else
			ScrollList.Size = UDim2.new(1, 0, 0, newScrollListSize)
		end
	end
	LastMaxScrollSize = newScrollListSize
end

--[[ Re-position Functions ]]--
local function setPlayerEntryPositions()
	local position = 0
	for i = 1, #PlayerEntries do
		if isTenFootInterface and PlayerEntries[i].Frame ~= MyPlayerEntryTopFrame then
			PlayerEntries[i].Frame.Position = UDim2.new(0, 10, 0, position)
			position = position + PlayerEntrySizeY + TILE_SPACING
		elseif PlayerEntries[i].Frame ~= MyPlayerEntryTopFrame then
			PlayerEntries[i].Frame.Position = UDim2.new(0, 0, 0, position)
			position = position + PlayerEntrySizeY + TILE_SPACING
		end
	end
end

local function setTeamEntryPositions()
	local teams = {}
	for _,teamEntry in ipairs(TeamEntries) do
		local team = teamEntry.Team
		teams[tostring(team.TeamColor)] = {}
	end
	if NeutralTeam then
		teams.Neutral = {}
	end

	for _,playerEntry in ipairs(PlayerEntries) do
		if playerEntry.Frame ~= MyPlayerEntryTopFrame then
			local player = playerEntry.Player
			if player.Neutral then
				table.insert(teams.Neutral, playerEntry)
			elseif teams[tostring(player.TeamColor)] then
				table.insert(teams[tostring(player.TeamColor)], playerEntry)
			else
				table.insert(teams.Neutral, playerEntry)
			end
		end
	end

	local position = 0
	for _,teamEntry in ipairs(TeamEntries) do
		local team = teamEntry.Team
		teamEntry.Frame.Position = UDim2.new(0, isTenFootInterface and 10 or 0, 0, position)
		position = position + TeamEntrySizeY + TILE_SPACING
		local players = teams[tostring(team.TeamColor)]
		for _,playerEntry in ipairs(players) do
			playerEntry.Frame.Position = UDim2.new(0, isTenFootInterface and 10 or 0, 0, position)
			position = position + PlayerEntrySizeY + TILE_SPACING
		end
	end
	if NeutralTeam then
		NeutralTeam.Frame.Position = UDim2.new(0, isTenFootInterface and 10 or 0, 0, position)
		position = position + TeamEntrySizeY + TILE_SPACING
		if #teams.Neutral > 0 then
			IsShowingNeutralFrame = true
			local players = teams.Neutral
			for _,playerEntry in ipairs(players) do
				playerEntry.Frame.Position = UDim2.new(0, isTenFootInterface and 10 or 0, 0, position)
				position = position + PlayerEntrySizeY + TILE_SPACING
			end
		else
			IsShowingNeutralFrame = false
		end
	end
end

local function setEntryPositions()
	table.sort(PlayerEntries, sortPlayerEntries)
	if #TeamEntries > 0 then
		setTeamEntryPositions()
	else
		setPlayerEntryPositions()
	end
end

local function updateSocialIcon(newIcon, bgFrame)
	local socialIcon = bgFrame:FindFirstChild('SocialIcon')
	local nameFrame = bgFrame:FindFirstChild('PlayerName')
	local offset = 19
	if socialIcon then
		if newIcon then
			socialIcon.Image = newIcon
		else
			if nameFrame then
				local newSize = nameFrame.Size.X.Offset + socialIcon.Size.X.Offset + 2
				nameFrame.Size = UDim2.new(-0.01, newSize, 0.5, 0)
				nameFrame.Position = UDim2.new(0.01, offset, 0.245, 0)
			end
			socialIcon:Destroy()
		end
	elseif newIcon and bgFrame then
		socialIcon = createImageIcon(newIcon, "SocialIcon", offset, bgFrame)
		offset = offset + socialIcon.Size.X.Offset + 2
		if nameFrame then
			local newSize = bgFrame.Size.X.Offset - offset
			nameFrame.Size = UDim2.new(-0.01, newSize, 0.5, 0)
			nameFrame.Position = UDim2.new(0.01, offset, 0.245, 0)
		end
	end
end

local function getFriendStatus(selectedPlayer)
	if selectedPlayer == Player then
		return Enum.FriendStatus.NotFriend
	end

	local success, isFriend = pcall(function()
		return Player:IsFriendsWithAsync(selectedPlayer.UserId)
	end)
	if success and isFriend then
		return Enum.FriendStatus.Friend
	end
	return Enum.FriendStatus.NotFriend
end

function popupHidden()
	if LastSelectedFrame then
		for _,childFrame in pairs(LastSelectedFrame:GetChildren()) do
			if childFrame:IsA('TextButton') or childFrame:IsA('Frame') then
				childFrame.BackgroundColor3 = BG_COLOR
			end
		end
	end
	ScrollList.ScrollingEnabled = true
	LastSelectedFrame = nil
	LastSelectedPlayer = nil
end
playerDropDown.HiddenSignal:Connect(popupHidden)

local function openPlatformProfileUI(rbxUid)
	if not rbxUid or rbxUid < 1 then return end
	pcall(function()
		GuiService:InspectPlayerFromUserId(rbxUid)
	end)
end

local function onEntryFrameSelected(selectedFrame, selectedPlayer)
	if isTenFootInterface then
		openPlatformProfileUI(selectedPlayer.UserId)
		return
	end

	-- Keep the original behavior of not opening a dropdown for yourself.
	-- Studio local-server clients can use negative/non-production UserIds,
	-- so do NOT reject them here.
	if selectedPlayer == Player then
		return
	end

	if LastSelectedFrame ~= selectedFrame then
		if LastSelectedFrame then
			for _,childFrame in pairs(LastSelectedFrame:GetChildren()) do
				if childFrame:IsA('TextButton') or childFrame:IsA('Frame') then
					childFrame.BackgroundColor3 = BG_COLOR
				end
			end
		end

		LastSelectedFrame = selectedFrame
		LastSelectedPlayer = selectedPlayer

		for _,childFrame in pairs(selectedFrame:GetChildren()) do
			if childFrame:IsA('TextButton') or childFrame:IsA('Frame') then
				childFrame.BackgroundColor3 = Color3.new(0, 1, 1)
			end
		end

		ScrollList.ScrollingEnabled = false

		local ok, PopupFrame = pcall(function()
			return playerDropDown:CreatePopup(selectedPlayer)
		end)

		if not ok or not PopupFrame then
			warn("[2016 PlayerList] PlayerDropDown failed:", PopupFrame)
			popupHidden()
			return
		end

		local y = selectedFrame.Position.Y.Offset - ScrollList.CanvasPosition.Y
		PopupFrame.Position = UDim2.new(1, 1, 0, y)
		PopupFrame.Parent = PopupClipFrame
		PopupFrame:TweenPosition(
			UDim2.new(0, 0, 0, y),
			Enum.EasingDirection.InOut,
			Enum.EasingStyle.Quad,
			TWEEN_TIME,
			true
		)
	else
		playerDropDown:Hide()
		LastSelectedFrame = nil
		LastSelectedPlayer = nil
	end
end

local function onFriendshipChanged(otherPlayer, newFriendStatus)
	local entryToUpdate = nil
	for _,entry in ipairs(PlayerEntries) do
		if entry.Player == otherPlayer then
			entryToUpdate = entry
			break
		end
	end
	if not entryToUpdate then
		return
	end
	local newIcon = getFriendStatusIcon(newFriendStatus)
	local frame = entryToUpdate.Frame
	local bgFrame = frame:FindFirstChild('BGFrame')
	if bgFrame then
		--no longer friends, but might still be following
		-- TODO: We need to get follow relationship here; we currently don't have a way
		-- to get a single users result, so the server script will need to be updated
		-- issue will be when unfriending a user, but still following them, the icon
		-- will not show correctly.
		updateSocialIcon(newIcon, bgFrame)
	end
end

-- Modern public friendship notifications are exposed through StarterGui:GetCore.
if not isTenFootInterface then
	task.spawn(function()
		local okFriended, friendedEvent = pcall(function()
			return StarterGui:GetCore("PlayerFriendedEvent")
		end)
		if okFriended and friendedEvent then
			friendedEvent.Event:Connect(function(otherPlayer)
				onFriendshipChanged(otherPlayer, Enum.FriendStatus.Friend)
			end)
		end

		local okUnfriended, unfriendedEvent = pcall(function()
			return StarterGui:GetCore("PlayerUnfriendedEvent")
		end)
		if okUnfriended and unfriendedEvent then
			unfriendedEvent.Event:Connect(function(otherPlayer)
				onFriendshipChanged(otherPlayer, Enum.FriendStatus.NotFriend)
			end)
		end
	end)
end

--[[ Begin New Server Followers ]]--
local function setFollowRelationshipsView(relationshipTable)
	if not relationshipTable then
		return
	end

	for i = 1, #PlayerEntries do
		local entry = PlayerEntries[i]
		local player = entry.Player
		local userId = tostring(player.UserId)

		-- don't update icon if already friends
		local friendStatus = getFriendStatus(player)
		if friendStatus == Enum.FriendStatus.Friend then
			return
		end

		local icon = nil
		if relationshipTable[userId] then
			local relationship = relationshipTable[userId]
			if relationship.IsMutual == true then
				icon = MUTUAL_FOLLOWING_ICON
			elseif relationship.IsFollowing == true then
				icon = FOLLOWING_ICON
			elseif relationship.IsFollower == true then
				icon = FOLLOWER_ICON
			end
		end

		local frame = entry.Frame
		local bgFrame = frame:FindFirstChild('BGFrame')
		if bgFrame then
			updateSocialIcon(icon, bgFrame)
		end
	end
end

local function getFollowRelationships()
	local result = nil
	if RemoteFunc_GetFollowRelationships then
		result = RemoteFunc_GetFollowRelationships:InvokeServer()
	end
	return result
end

--[[ End New Server Followers ]]--

local function updateAllTeamScores()
	local teamScores = {}
	for _,playerEntry in ipairs(PlayerEntries) do
		local player = playerEntry.Player
		local leaderstats = player:FindFirstChild('leaderstats')
		local team = player.Neutral and 'Neutral' or tostring(player.TeamColor)
		local isInValidColor = true
		if team ~= 'Neutral' then
			for _,teamEntry in ipairs(TeamEntries) do
				local color = teamEntry.Team.TeamColor
				if team == tostring(color) then
					isInValidColor = false
					break
				end
			end
		end
		if isInValidColor then
			team = 'Neutral'
		end
		if not teamScores[team] then
			teamScores[team] = {}
		end
		if playerEntry.Frame ~= MyPlayerEntryTopFrame then
			if leaderstats then
				for _,stat in ipairs(GameStats) do
					local statObject = leaderstats:FindFirstChild(stat.Name)
					if statObject and not statObject:IsA('StringValue') then
						if not teamScores[team][stat.Name] then
							teamScores[team][stat.Name] = 0
						end
						teamScores[team][stat.Name] = teamScores[team][stat.Name] + getScoreValue(statObject)
					end
				end
			end
		end
	end

	for _,teamEntry in ipairs(TeamEntries) do
		local team = teamEntry.Team
		local frame = teamEntry.Frame
		local color = tostring(team.TeamColor)
		local stats = teamScores[color]
		if stats then
			for statName,statValue in pairs(stats) do
				local statFrame = frame:FindFirstChild(statName)
				if statFrame then
					local statText = statFrame:FindFirstChild('StatText')
					if statText then
						statText.Text = formatStatString(tostring(statValue))
					end
				end
			end
		else
			for _,childFrame in pairs(frame:GetChildren()) do
				local statText = childFrame:FindFirstChild('StatText')
				if statText then
					statText.Text = ''
				end
			end
		end
	end
	if NeutralTeam then
		local frame = NeutralTeam.Frame
		local stats = teamScores['Neutral']
		if stats then
			frame.Visible = true
			for statName,statValue in pairs(stats) do
				local statFrame = frame:FindFirstChild(statName)
				if statFrame then
					local statText = statFrame:FindFirstChild('StatText')
					if statText then
						statText.Text = formatStatString(tostring(statValue))
					end
				end
			end
		else
			frame.Visible = false
		end
	end
end

local function updateTeamEntry(entry)
	local frame = entry.Frame
	local team = entry.Team
	local color = team.TeamColor.Color
	local offset = NameEntrySizeX
	for _,stat in ipairs(GameStats) do
		local statFrame = frame:FindFirstChild(stat.Name)
		if not statFrame then
			statFrame = createStatFrame(offset, frame, stat.Name)
			statFrame.BackgroundColor3 = color
			createStatText(statFrame, "", false, true)
		end
		statFrame.Position = UDim2.new(0, offset + TILE_SPACING, 0, 0)
		offset = offset + statFrame.Size.X.Offset + TILE_SPACING
	end
end

local function updatePrimaryStats(statName)
	for _,entry in ipairs(PlayerEntries) do
		local player = entry.Player
		local leaderstats = player:FindFirstChild('leaderstats')
		entry.PrimaryStat = nil
		if leaderstats then
			local statObject = leaderstats:FindFirstChild(statName)
			if statObject then
				local scoreValue = getScoreValue(statObject)
				entry.PrimaryStat = scoreValue
			end
		end
	end
end

local updateLeaderstatFrames = nil
-- TODO: fire event to top bar?
local function initializeStatText(stat, statObject, entry, statFrame, index, isTopStat)
	local player = entry.Player
	local statValue = getScoreValue(statObject)
	if statObject.Name == GameStats[1].Name then
		entry.PrimaryStat = statValue
	end
	local statText = createStatText(statFrame, formatStatString(tostring(statValue)), isTopStat)
	-- Top Bar insertion
	if player == Player then
		stat.Text = statText.Text
	end

	statObject.Changed:Connect(function(newValue)
		local scoreValue = getScoreValue(statObject)
		statText.Text = formatStatString(tostring(scoreValue))
		if statObject.Name == GameStats[1].Name then
			entry.PrimaryStat = scoreValue
		end
		-- Top bar changed event
		if player == Player then
			stat.Text = statText.Text
			Playerlist.OnStatChanged:Fire(stat.Name, stat.Text)
		end
		updateAllTeamScores()
		setEntryPositions()
	end)
	statObject.ChildAdded:Connect(function(child)
		if child.Name == "IsPrimary" then
			GameStats[1].IsPrimary = false
			stat.IsPrimary = true
			updatePrimaryStats(stat.Name)
			if updateLeaderstatFrames then updateLeaderstatFrames() end
			Playerlist.OnLeaderstatsChanged:Fire(GameStats)
		end
	end)
end

updateLeaderstatFrames = function()
	table.sort(GameStats, sortLeaderStats)
	if #TeamEntries > 0 then
		for _,entry in ipairs(TeamEntries) do
			updateTeamEntry(entry)
		end
		if NeutralTeam then
			updateTeamEntry(NeutralTeam)
		end
	end

	for _,entry in ipairs(PlayerEntries) do
		local player = entry.Player
		local mainFrame = entry.Frame
		local offset = NameEntrySizeX
		local leaderstats = player:FindFirstChild('leaderstats')
		local isTopStat = (entry.Frame == MyPlayerEntryTopFrame)

		if leaderstats then
			for _,stat in ipairs(GameStats) do
				local statObject = leaderstats:FindFirstChild(stat.Name)
				local statFrame = mainFrame:FindFirstChild(stat.Name)

				if not statFrame then
					statFrame = createStatFrame(offset, mainFrame, stat.Name, isTopStat)
					if statObject then
						initializeStatText(stat, statObject, entry, statFrame, _, isTopStat)
					end
				elseif statObject then
					local statText = statFrame:FindFirstChild('StatText')
					if not statText then
						initializeStatText(stat, statObject, entry, statFrame, _, isTopStat)
					end
				end
				statFrame.Position = UDim2.new(0, offset + TILE_SPACING, 0, 0)
				offset = offset + statFrame.Size.X.Offset + TILE_SPACING
			end
		else
			for _,stat in ipairs(GameStats) do
				local statFrame = mainFrame:FindFirstChild(stat.Name)
				if not statFrame then
					statFrame = createStatFrame(offset, mainFrame, stat.Name, isTopStat)
				end
				offset = offset + statFrame.Size.X.Offset + TILE_SPACING
			end
		end

		if entry.Frame ~= MyPlayerEntryTopFrame then
			if isTenFootInterface then
				Container.Position = UDim2.new(0.5, -offset/2, 0, 110)
				Container.Size = UDim2.new(0, offset, 0.8, 0)
			else
				Container.Position = UDim2.new(1, -offset, 0, 38)
				Container.Size = UDim2.new(0, offset, 0.5, 0)
			end
			targetContainerYOffset = Container.Position.Y.Offset
			AdjustContainerPosition()

			local newMinContainerOffset = offset
			MinContainerSize = UDim2.new(0, newMinContainerOffset, 0.5, 0)
		end
	end
	updateAllTeamScores()
	setEntryPositions()
	Playerlist.OnLeaderstatsChanged:Fire(GameStats)
end

local function addNewStats(leaderstats)
	for i,stat in ipairs(leaderstats:GetChildren()) do
		if isValidStat(stat) and #GameStats < MAX_LEADERSTATS then
			local gameHasStat = false
			for _,gStat in ipairs(GameStats) do
				if stat.Name == gStat.Name then
					gameHasStat = true
					break
				end
			end

			if not gameHasStat then
				local newStat = {}
				newStat.Name = stat.Name
				newStat.Text = "-"
				newStat.Priority = 0
				local priority = stat:FindFirstChild('Priority')
				if priority and priority:IsA("ValueBase") then newStat.Priority = tonumber(priority.Value) or 0 end
				newStat.IsPrimary = false
				local isPrimary = stat:FindFirstChild('IsPrimary')
				if isPrimary then
					newStat.IsPrimary = true
				end
				newStat.AddId = StatAddId
				StatAddId = StatAddId + 1
				table.insert(GameStats, newStat)
				table.sort(GameStats, sortLeaderStats)
				if #GameStats == 1 then
					setScrollListSize()
					setEntryPositions()
				end
			end
		end
	end
end

local function removeStatFrameFromEntry(stat, frame)
	local statFrame = frame:FindFirstChild(stat.Name)
	if statFrame then
		statFrame:Destroy()
	end
end

local function doesStatExists(stat)
	local doesExists = false
	for _,entry in ipairs(PlayerEntries) do
		local player = entry.Player
		if player then
			local leaderstats = player:FindFirstChild('leaderstats')
			if leaderstats and leaderstats:FindFirstChild(stat.Name) then
				doesExists = true
				break
			end
		end
	end

	return doesExists
end

local function onStatRemoved(oldStat, entry)
	if isValidStat(oldStat) then
		removeStatFrameFromEntry(oldStat, entry.Frame)
		local statExists = doesStatExists(oldStat)
		--
		local toRemove = nil
		for i, stat in ipairs(GameStats) do
			if stat.Name == oldStat.Name then
				toRemove = i
				break
			end
		end
		-- removed from player but not from game; another player still has this stat
		if statExists then
			if toRemove and entry.Player == Player then
				GameStats[toRemove].Text = "-"
				Playerlist.OnStatChanged:Fire(GameStats[toRemove].Name, GameStats[toRemove].Text)
			end
			-- removed from game
		else
			for _,playerEntry in ipairs(PlayerEntries) do
				removeStatFrameFromEntry(oldStat, playerEntry.Frame)
			end
			for _,teamEntry in ipairs(TeamEntries) do
				removeStatFrameFromEntry(oldStat, teamEntry.Frame)
			end
			if toRemove then
				table.remove(GameStats, toRemove)
				table.sort(GameStats, sortLeaderStats)
			end
		end
		if GameStats[1] then
			updatePrimaryStats(GameStats[1].Name)
		end
		updateLeaderstatFrames()
	end
end

local function onStatAdded(leaderstats, entry)
	leaderstats.ChildAdded:Connect(function(newStat)
		if isValidStat(newStat) then
			addNewStats(newStat.Parent)
			updateLeaderstatFrames()
		end
	end)
	leaderstats.ChildRemoved:Connect(function(child)
		onStatRemoved(child, entry)
	end)
	addNewStats(leaderstats)
	updateLeaderstatFrames()
end

local function setLeaderStats(entry)
	local player = entry.Player
	local leaderstats = player:FindFirstChild('leaderstats')

	if leaderstats then
		onStatAdded(leaderstats, entry)
	end

	local function onPlayerChildChanged(property, child)
		if property == 'Name' and child.Name == 'leaderstats' then
			onStatAdded(child, entry)
		end
	end

	player.ChildAdded:Connect(function(child)
		if child.Name == 'leaderstats' then
			onStatAdded(child, entry)
		end
		child.Changed:Connect(function(property) onPlayerChildChanged(property, child) end)
	end)
	for _,child in pairs(player:GetChildren()) do
		child.Changed:Connect(function(property) onPlayerChildChanged(property, child) end)
	end

	player.ChildRemoved:Connect(function(child)
		if child.Name == 'leaderstats' then
			for i,stat in ipairs(child:GetChildren()) do
				onStatRemoved(stat, entry)
			end
			updateLeaderstatFrames()
		end
	end)
end

local offsetSize = 18
if isTenFootInterface then offsetSize = 32 end

local function createPlayerEntry(player, isTopStat)
	local playerEntry = {}
	local name = player.Name

	local containerFrame, entryFrame = createEntryFrame(name, PlayerEntrySizeY, isTopStat)
	entryFrame.Active = true

	entryFrame.MouseButton1Click:Connect(function()
		onEntryFrameSelected(containerFrame, player)
	end)

	local currentXOffset = 1

	-- check membership
	local membershipIconImage = getMembershipIcon(player)
	local membershipIcon = nil
	if membershipIconImage then
		membershipIcon = createImageIcon(membershipIconImage, "MembershipIcon", currentXOffset, entryFrame)
		currentXOffset = currentXOffset + membershipIcon.Size.X.Offset + 2
	else
		currentXOffset = currentXOffset + offsetSize
	end

	task.spawn(function()
		if isTenFootInterface and membershipIcon then
			setAvatarIconAsync(player, membershipIcon)
		end
	end)

	-- Some functions yield, so we need to spawn off in order to not cause a race condition with other events like PlayersService.ChildRemoved
	task.spawn(function()
		local success, result = pcall(function()
			if game.CreatorType ~= Enum.CreatorType.Group then return false end
			local rolesResult = GroupService:GetRolesInGroupAsync(player.UserId, game.CreatorId)
			if not rolesResult.IsMember then return false end
			for _, role in ipairs(rolesResult.Roles or {}) do
				if role.Rank >= 255 then return true end
			end
			return false
		end)
		if success then
			if game.CreatorType == Enum.CreatorType.Group and result then
				membershipIconImage = PLACE_OWNER_ICON
				if not membershipIcon then
					membershipIcon = createImageIcon(membershipIconImage, "MembershipIcon", 1, entryFrame)
				else
					membershipIcon.Image = membershipIconImage
				end
			end
		else
			print("PlayerList: GetRankInGroup failed because", result)
		end
		local iconImage = getCustomPlayerIcon(player)
		if iconImage then
			if not membershipIcon then
				membershipIcon = createImageIcon(iconImage, "MembershipIcon", 1, entryFrame)
			else
				membershipIcon.Image = iconImage
			end
		end
		-- Friendship and Follower status is checked by onFriendshipChanged, which is called by the FriendStatusChanged
		-- event. This event is fired when any player joins the game. onFriendshipChanged will check Follower status in
		-- the case that we are not friends with the new player who is joining.
	end)

	local playerNameXSize = entryFrame.Size.X.Offset - currentXOffset
	local playerName = createEntryNameText("PlayerName", name, playerNameXSize, currentXOffset)
	playerName.Parent = entryFrame
	playerEntry.Player = player
	playerEntry.Frame = containerFrame

	if isTenFootInterface then
		local shadow = Instance.new("ImageLabel")
		shadow.BackgroundTransparency = 1
		shadow.Name = 'Shadow'
		shadow.Image = SHADOW_IMAGE
		shadow.Position = UDim2.new(0, -SHADOW_SLICE_SIZE, 0, 0)
		shadow.Size = UDim2.new(1, SHADOW_SLICE_SIZE*2, 1, SHADOW_SLICE_SIZE)
		shadow.ScaleType = Enum.ScaleType.Slice
		shadow.SliceCenter = SHADOW_SLICE_RECT
		shadow.Parent = entryFrame
	end

	if isTopStat then
		playerName.Font = Enum.Font.SourceSansBold
	end

	return playerEntry
end

local function createTeamEntry(team)
	local teamEntry = {}
	teamEntry.Team = team
	teamEntry.TeamScore = 0

	local containerFrame, entryFrame = createEntryFrame(team.Name, TeamEntrySizeY)
	entryFrame.Selectable = false	-- dont allow gamepad selection of team frames
	entryFrame.BackgroundColor3 = team.TeamColor.Color

	local teamName = createEntryNameText("TeamName", team.Name, entryFrame.AbsoluteSize.X, 1)
	teamName.Parent = entryFrame

	teamEntry.Frame = containerFrame

	if isTenFootInterface then
		local shadow = Instance.new("ImageLabel")
		shadow.BackgroundTransparency = 1
		shadow.Name = 'Shadow'
		shadow.Image = SHADOW_IMAGE
		shadow.Position = UDim2.new(0, -SHADOW_SLICE_SIZE, 0, 0)
		shadow.Size = UDim2.new(1, SHADOW_SLICE_SIZE*2, 1, SHADOW_SLICE_SIZE)
		shadow.ScaleType = Enum.ScaleType.Slice
		shadow.SliceCenter = SHADOW_SLICE_RECT
		shadow.Parent = entryFrame
	end

	-- connections
	team.Changed:Connect(function(property)
		if property == 'Name' then
			teamName.Text = team.Name
		elseif property == 'TeamColor' then
			for _,childFrame in pairs(containerFrame:GetChildren()) do
				if childFrame:IsA('GuiObject') then
					childFrame.BackgroundColor3 = team.TeamColor.Color
				end
			end

			setTeamEntryPositions()
			updateAllTeamScores()
			setEntryPositions()
			setScrollListSize()
		end
	end)

	return teamEntry
end

local function createNeutralTeam()
	if not NeutralTeam then
		local team = Instance.new('Team')
		team.Name = 'Neutral'
		team.TeamColor = BrickColor.new('White')
		NeutralTeam = createTeamEntry(team)
		NeutralTeam.Frame.Parent = ScrollList
	end
end

--[[ Insert/Remove Player Functions ]]--
local function setupEntry(player, newEntry, isTopStat)
	setLeaderStats(newEntry)

	if isTopStat then
		newEntry.Frame.Parent = Container
		table.insert(PlayerEntries, newEntry)
	else
		newEntry.Frame.Parent = ScrollList
		table.insert(PlayerEntries, newEntry)
		setScrollListSize()
	end

	updateLeaderstatFrames()

	player.Changed:Connect(function(property)
		if #TeamEntries > 0 and (property == 'Neutral' or property == 'TeamColor') then
			setTeamEntryPositions()
			updateAllTeamScores()
			setEntryPositions()
			setScrollListSize()
		end
	end)
end

local function insertPlayerEntry(player)
	local entry = createPlayerEntry(player)
	setupEntry(player, entry)

	-- create an entry on the top of the playerlist
	if player == Player and isTenFootInterface then
		local localEntry = createPlayerEntry(player, true)
		MyPlayerEntryTopFrame = localEntry.Frame
		MyPlayerEntryTopFrame.BackgroundTransparency = 1
		MyPlayerEntryTopFrame.BorderSizePixel = 0
		setupEntry(player, localEntry, true)
	end
end

local function removePlayerEntry(player)
	for i = 1, #PlayerEntries do
		if PlayerEntries[i].Player == player then
			PlayerEntries[i].Frame:Destroy()
			table.remove(PlayerEntries, i)
			break
		end
	end
	setEntryPositions()
	setScrollListSize()
end

--[[ Team Functions ]]--
local function onTeamAdded(team)
	for i = 1, #TeamEntries do
		if TeamEntries[i].Team.TeamColor == team.TeamColor then
			TeamEntries[i].Frame:Destroy()
			table.remove(TeamEntries, i)
			break
		end
	end
	local entry = createTeamEntry(team)
	entry.Id = TeamAddId
	TeamAddId = TeamAddId + 1
	if not NeutralTeam then
		createNeutralTeam()
	end
	table.insert(TeamEntries, entry)
	table.sort(TeamEntries, sortTeams)
	setTeamEntryPositions()
	updateLeaderstatFrames()
	setScrollListSize()
	entry.Frame.Parent = ScrollList
end

local function onTeamRemoved(removedTeam)
	for i = 1, #TeamEntries do
		local team = TeamEntries[i].Team
		if team.Name == removedTeam.Name then
			TeamEntries[i].Frame:Destroy()
			table.remove(TeamEntries, i)
			break
		end
	end
	if #TeamEntries == 0 then
		if NeutralTeam then
			NeutralTeam.Frame:Destroy()
			NeutralTeam.Team:Destroy()
			NeutralTeam = nil
			IsShowingNeutralFrame = false
		end
	end
	setEntryPositions()
	updateLeaderstatFrames()
	setScrollListSize()
end

--[[ Resize/Position Functions ]]--
local function clampCanvasPosition()
	local maxCanvasPosition = ScrollList.CanvasSize.Y.Offset - ScrollList.Size.Y.Offset
	if maxCanvasPosition >= 0 and ScrollList.CanvasPosition.Y > maxCanvasPosition then
		ScrollList.CanvasPosition = Vector2.new(0, maxCanvasPosition)
	end
end

local function resizePlayerList()
	setScrollListSize()
	clampCanvasPosition()
end

RobloxGui.Changed:Connect(function(property)
	if property == 'AbsoluteSize' then
		task.spawn(function()	-- must spawn because F11 delays when abs size is set
			resizePlayerList()
		end)
	end
end)

UserInputService.InputBegan:Connect(function(inputObject, isProcessed)
	if isProcessed then return end
	local inputType = inputObject.UserInputType
	if (inputType == Enum.UserInputType.Touch and  inputObject.UserInputState == Enum.UserInputState.Begin) or
		inputType == Enum.UserInputType.MouseButton1 then
		if LastSelectedFrame then
			playerDropDown:Hide()
		end
	end
end)

-- NOTE: Core script only

--[[ Player Add/Remove Connections ]]--
PlayersService.PlayerAdded:Connect(insertPlayerEntry)
for _,player in pairs(PlayersService:GetPlayers()) do
	insertPlayerEntry(player)
end

--[[ Followers ]]
-- The 2016 RobloxReplicatedStorage follower remotes were private CoreScript
-- infrastructure and are no longer available to experience scripts.
-- Friend icons still update through the supported friendship events above.

PlayersService.PlayerRemoving:Connect(function(child)
	if child:IsA('Player') then
		if LastSelectedPlayer and child == LastSelectedPlayer then
			playerDropDown:Hide()
		end
		removePlayerEntry(child)
	end
end)

--[[ Teams ]]--
local function initializeTeams(teams)
	for _,team in pairs(teams:GetTeams()) do
		onTeamAdded(team)
	end

	teams.ChildAdded:Connect(function(team)
		if team:IsA("Team") then
			onTeamAdded(team)
		end
	end)

	teams.ChildRemoved:Connect(function(team)
		if team:IsA("Team") then
			onTeamRemoved(team)
		end
	end)
end

initializeTeams(TeamsService)

--[[ Public API ]]--
Playerlist.GetStats = function()
	return GameStats
end

local noOpFunc = function ( )
end

local isOpen = not isTenFootInterface

local closeListFunc = function(name, state, input)
	if state ~= Enum.UserInputState.Begin then return end

	isOpen = false
	Container.Visible = false
	ContextActionService:UnbindAction("CloseList")
	ContextActionService:UnbindAction("StopAction")
	GuiService.SelectedObject = nil
	UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
end

local setVisible = function(state, fromTemp)
	Container.Visible = state

	if state then
		local children = ScrollList:GetChildren()
		if children and #children > 0 then
			local frame = children[1]
			local frameChildren = frame:GetChildren()
			for i = 1, #frameChildren do
				if frameChildren[i]:IsA("TextButton") then
					local lastInputType = UserInputService:GetLastInputType()
					local isUsingGamepad = (lastInputType == Enum.UserInputType.Gamepad1 or lastInputType == Enum.UserInputType.Gamepad2 or
						lastInputType == Enum.UserInputType.Gamepad3 or lastInputType == Enum.UserInputType.Gamepad4)

					if isUsingGamepad and not fromTemp then
						GuiService.SelectedObject = frameChildren[i]
						GuiService:Select(ScrollList)
						UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
						ContextActionService:BindAction("StopAction", noOpFunc, false, Enum.UserInputType.Gamepad1)
						ContextActionService:BindAction("CloseList", closeListFunc, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)
					end
					break
				end
			end
		end
	else
		UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None

		ContextActionService:UnbindAction("CloseList")
		ContextActionService:UnbindAction("StopAction")

		if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(Container) then
			GuiService.SelectedObject = nil
		end
	end
end

Playerlist.ToggleVisibility = function(name, inputState, inputObject)
	if inputState and inputState ~= Enum.UserInputState.Begin then return end
	if IsSmallScreenDevice then return end
	if not playerlistCoreGuiEnabled then return end

	isOpen = not isOpen

	if next(TempHideKeys) == nil then
		setVisible(isOpen)
	end
end

Playerlist.IsOpen = function()
	return isOpen
end

Playerlist.HideTemp = function(self, key, hidden)
	if not playerlistCoreGuiEnabled then return end
	if IsSmallScreenDevice then return end

	TempHideKeys[key] = hidden and true or nil

	if next(TempHideKeys) == nil then
		if isOpen then
			setVisible(true, true)
		end
	else
		if isOpen then
			setVisible(false, true)
		end
	end
end
local topStat = nil
if isTenFootInterface and TenFootInterface and type(TenFootInterface.SetupTopStat) == "function" then
	local ok, result = pcall(function() return TenFootInterface:SetupTopStat() end)
	if ok then topStat = result end
end

--[[ Core Gui Changed events ]]--
-- NOTE: Core script only
local function onCoreGuiChanged(coreGuiType, enabled)
	if coreGuiType == Enum.CoreGuiType.All or coreGuiType == Enum.CoreGuiType.PlayerList then
		-- on console we can always toggle on/off, ignore change
		if isTenFootInterface then
			playerlistCoreGuiEnabled = true
			return
		end

		playerlistCoreGuiEnabled = enabled and topbarEnabled

		-- not visible on small screen devices
		if IsSmallScreenDevice then
			Container.Visible = false
			return
		end

		setVisible(playerlistCoreGuiEnabled and isOpen and next(TempHideKeys) == nil, true)

		if isTenFootInterface and topStat then
			topStat:SetTopStatEnabled(playerlistCoreGuiEnabled)
		end

		if playerlistCoreGuiEnabled then
			ContextActionService:BindAction("RbxPlayerListToggle", Playerlist.ToggleVisibility, false, Enum.KeyCode.Tab)
		else
			ContextActionService:UnbindAction("RbxPlayerListToggle")
		end
	end
end

Playerlist.TopbarEnabledChanged = function(enabled)
	topbarEnabled = enabled
	-- Update coregui to reflect new topbar status
	onCoreGuiChanged(Enum.CoreGuiType.PlayerList, StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList))
end

onCoreGuiChanged(Enum.CoreGuiType.PlayerList, StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList))
-- CoreGuiChangedSignal is no longer a public experience-script event.

resizePlayerList()

local blockStatusChanged = function(userId, isBlocked)
	if userId < 0 then return end

	for _,playerEntry in ipairs(PlayerEntries) do
		if playerEntry.Player.UserId == userId then
			playerEntry.Frame.BGFrame.MembershipIcon.Image = getMembershipIcon(playerEntry.Player)
			return
		end
	end
end

blockingUtility:GetBlockedStatusChangedEvent():Connect(blockStatusChanged)

return Playerlist

end;
};
G2L_MODULES[G2L["9"]] = {
Closure = function()
    local script = G2L["9"];--[[
    // FileName: PlayerDropDown.lua
    // 2026 compatibility port of the 2016 CoreScript module (v2).
    // Keeps the old dropdown UI/API while replacing private Roblox services
    // with public experience APIs.
]]

local moduleApiTable = {}

local PlayersService = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = PlayersService.LocalPlayer
while not LocalPlayer do
	PlayersService:GetPropertyChangedSignal("LocalPlayer"):Wait()
	LocalPlayer = PlayersService.LocalPlayer
end

local POPUP_ENTRY_SIZE_Y = 24
local ENTRY_PAD = 2
local BG_TRANSPARENCY = 0.5
local BG_COLOR = Color3.new(31/255, 31/255, 31/255)
local TEXT_STROKE_TRANSPARENCY = 0.75
local TEXT_COLOR = Color3.new(1, 1, 243/255)
local TEXT_STROKE_COLOR = Color3.new(34/255, 34/255, 34/255)
local TWEEN_TIME = 0.15

local function createSignal()
	local bindable = Instance.new("BindableEvent")
	local signal = {}

	function signal:fire(...)
		bindable:Fire(...)
	end

	signal.Fire = signal.fire

	function signal:connect(callback)
		assert(type(callback) == "function", "connect expects a function")
		return bindable.Event:Connect(callback)
	end

	signal.Connect = signal.connect

	function signal:wait()
		return bindable.Event:Wait()
	end

	signal.Wait = signal.wait

	function signal:destroy()
		bindable:Destroy()
	end

	return signal
end

local BlockStatusChanged = createSignal()
local BlockedList = {}
local MutedList = {}

local function safeSetCore(name, value)
	local lastError
	for _ = 1, 20 do
		local ok, err = pcall(function()
			StarterGui:SetCore(name, value)
		end)
		if ok then
			return true
		end
		lastError = err
		task.wait(0.1)
	end
	warn(("PlayerDropDown: SetCore(%s) failed after retries: %s"):format(name, tostring(lastError)))
	return false
end

local function safeGetCore(name)
	local lastError
	for _ = 1, 20 do
		local ok, result = pcall(function()
			return StarterGui:GetCore(name)
		end)
		if ok then
			return true, result
		end
		lastError = result
		task.wait(0.1)
	end
	return false, lastError
end

local function sendNotification(title, text, image, duration)
	safeSetCore("SendNotification", {
		Title = title or "",
		Text = text or "",
		Icon = image or "",
		Duration = duration or 5,
	})
end

local function refreshBlockedList()
	local ok, result = safeGetCore("GetBlockedUserIds")

	if ok and type(result) == "table" then
		table.clear(BlockedList)
		for _, userId in ipairs(result) do
			BlockedList[tonumber(userId) or userId] = true
		end
	end
end

task.spawn(refreshBlockedList)

local function hookCoreEvent(coreName, callback)
	task.spawn(function()
		local ok, event = safeGetCore(coreName)
		if ok and event then
			if event:IsA("BindableEvent") then
				event.Event:Connect(callback)
			elseif event.Event then
				event.Event:Connect(callback)
			end
		end
	end)
end

hookCoreEvent("PlayerBlockedEvent", function(playerOrUserId)
	local userId = typeof(playerOrUserId) == "Instance" and playerOrUserId.UserId or tonumber(playerOrUserId)
	if userId then
		BlockedList[userId] = true
		BlockStatusChanged:fire(userId, true)
	else
		refreshBlockedList()
	end
end)

hookCoreEvent("PlayerUnblockedEvent", function(playerOrUserId)
	local userId = typeof(playerOrUserId) == "Instance" and playerOrUserId.UserId or tonumber(playerOrUserId)
	if userId then
		BlockedList[userId] = nil
		BlockStatusChanged:fire(userId, false)
	else
		refreshBlockedList()
	end
end)

local function isBlocked(userId)
	return BlockedList[userId] == true
end

local function isMuted(userId)
	return MutedList[userId] == true
end

local function BlockPlayerAsync(playerToBlock)
	if playerToBlock and playerToBlock ~= LocalPlayer and playerToBlock.UserId > 0 then
		safeSetCore("PromptBlockPlayer", playerToBlock)
	end
end

local function UnblockPlayerAsync(playerToUnblock)
	if playerToUnblock and playerToUnblock.UserId > 0 then
		safeSetCore("PromptUnblockPlayer", playerToUnblock)
	end
end

local function MutePlayer(playerToMute)
	if playerToMute and playerToMute ~= LocalPlayer and playerToMute.UserId > 0 then
		MutedList[playerToMute.UserId] = true
	end
end

local function UnmutePlayer(playerToUnmute)
	if playerToUnmute then
		MutedList[playerToUnmute.UserId] = nil
	end
end

local function getFriendStatus(selectedPlayer)
	if not selectedPlayer or selectedPlayer == LocalPlayer then
		return Enum.FriendStatus.NotFriend
	end

	local success, isFriend = pcall(function()
		return LocalPlayer:IsFriendsWithAsync(selectedPlayer.UserId)
	end)

	if success and isFriend then
		return Enum.FriendStatus.Friend
	end
	return Enum.FriendStatus.NotFriend
end


local function openReportAbusePage(targetPlayer)
	if not targetPlayer or targetPlayer == LocalPlayer then
		return
	end

	local playerGui = LocalPlayer:WaitForChild("PlayerGui")

	local old = playerGui:FindFirstChild("PlayerListReportAbuse")
	if old then
		old:Destroy()
	end

	local screen = Instance.new("ScreenGui")
	screen.Name = "PlayerListReportAbuse"
	screen.ResetOnSpawn = false
	screen.IgnoreGuiInset = true
	screen.DisplayOrder = 1000
	screen.Parent = playerGui

	local shield = Instance.new("TextButton")
	shield.Name = "Shield"
	shield.Text = ""
	shield.AutoButtonColor = false
	shield.Size = UDim2.fromScale(1, 1)
	shield.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	shield.BackgroundTransparency = 0.2
	shield.BorderSizePixel = 0
	shield.Parent = screen

	local page = Instance.new("Frame")
	page.Name = "ReportAbusePage"
	page.AnchorPoint = Vector2.new(0.5, 0.5)
	page.Position = UDim2.fromScale(0.5, 0.5)
	page.Size = UDim2.fromOffset(520, 430)
	page.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	page.BorderSizePixel = 0
	page.Parent = shield

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(24, 18)
	title.Size = UDim2.new(1, -48, 0, 42)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 32
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = "Report Abuse"
	title.Parent = page

	local target = Instance.new("TextLabel")
	target.BackgroundTransparency = 1
	target.Position = UDim2.fromOffset(24, 68)
	target.Size = UDim2.new(1, -48, 0, 30)
	target.Font = Enum.Font.SourceSans
	target.TextSize = 20
	target.TextColor3 = Color3.new(1, 1, 1)
	target.TextXAlignment = Enum.TextXAlignment.Left
	target.Text = "Player: " .. targetPlayer.Name
	target.Parent = page

	local reasonLabel = Instance.new("TextLabel")
	reasonLabel.BackgroundTransparency = 1
	reasonLabel.Position = UDim2.fromOffset(24, 110)
	reasonLabel.Size = UDim2.new(1, -48, 0, 26)
	reasonLabel.Font = Enum.Font.SourceSans
	reasonLabel.TextSize = 18
	reasonLabel.TextColor3 = Color3.new(1, 1, 1)
	reasonLabel.TextXAlignment = Enum.TextXAlignment.Left
	reasonLabel.Text = "Reason:"
	reasonLabel.Parent = page

	local reasons = {
		"Swearing",
		"Bullying",
		"Scamming",
		"Dating",
		"Cheating / Exploiting",
		"Personal Questions",
		"Offsite Links",
		"Inappropriate Content",
	}
	local selectedReason = reasons[1]

	local reasonButton = Instance.new("TextButton")
	reasonButton.Name = "ReasonButton"
	reasonButton.Position = UDim2.fromOffset(24, 140)
	reasonButton.Size = UDim2.new(1, -48, 0, 38)
	reasonButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	reasonButton.BorderSizePixel = 0
	reasonButton.Font = Enum.Font.SourceSans
	reasonButton.TextSize = 18
	reasonButton.TextColor3 = Color3.new(1, 1, 1)
	reasonButton.TextXAlignment = Enum.TextXAlignment.Left
	reasonButton.Text = "  " .. selectedReason .. "  ▼"
	reasonButton.Parent = page

	local reasonList = Instance.new("Frame")
	reasonList.Name = "ReasonList"
	reasonList.Position = UDim2.fromOffset(24, 178)
	reasonList.Size = UDim2.new(1, -48, 0, #reasons * 28)
	reasonList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	reasonList.BorderSizePixel = 0
	reasonList.Visible = false
	reasonList.ZIndex = 20
	reasonList.Parent = page

	for i, reason in ipairs(reasons) do
		local option = Instance.new("TextButton")
		option.Name = "Reason" .. i
		option.Position = UDim2.new(0, 0, 0, (i - 1) * 28)
		option.Size = UDim2.new(1, 0, 0, 28)
		option.BackgroundTransparency = 1
		option.Font = Enum.Font.SourceSans
		option.TextSize = 17
		option.TextColor3 = Color3.new(1, 1, 1)
		option.TextXAlignment = Enum.TextXAlignment.Left
		option.Text = "  " .. reason
		option.ZIndex = 21
		option.Parent = reasonList
		option.Activated:Connect(function()
			selectedReason = reason
			reasonButton.Text = "  " .. selectedReason .. "  ▼"
			reasonList.Visible = false
		end)
	end

	reasonButton.Activated:Connect(function()
		reasonList.Visible = not reasonList.Visible
	end)

	local descLabel = Instance.new("TextLabel")
	descLabel.BackgroundTransparency = 1
	descLabel.Position = UDim2.fromOffset(24, 194)
	descLabel.Size = UDim2.new(1, -48, 0, 26)
	descLabel.Font = Enum.Font.SourceSans
	descLabel.TextSize = 18
	descLabel.TextColor3 = Color3.new(1, 1, 1)
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.Text = "Description:"
	descLabel.Parent = page

	local description = Instance.new("TextBox")
	description.Name = "Description"
	description.Position = UDim2.fromOffset(24, 224)
	description.Size = UDim2.new(1, -48, 0, 100)
	description.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	description.BorderSizePixel = 0
	description.ClearTextOnFocus = false
	description.MultiLine = true
	description.TextWrapped = true
	description.TextXAlignment = Enum.TextXAlignment.Left
	description.TextYAlignment = Enum.TextYAlignment.Top
	description.Font = Enum.Font.SourceSans
	description.TextSize = 18
	description.TextColor3 = Color3.new(1, 1, 1)
	description.PlaceholderText = "Describe what happened..."
	description.Text = ""
	description.Parent = page

	local cancel = Instance.new("TextButton")
	cancel.Name = "Cancel"
	cancel.Position = UDim2.new(0.5, -204, 1, -72)
	cancel.Size = UDim2.fromOffset(198, 50)
	cancel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	cancel.BorderSizePixel = 0
	cancel.Font = Enum.Font.SourceSansBold
	cancel.TextSize = 22
	cancel.TextColor3 = Color3.new(1, 1, 1)
	cancel.Text = "Cancel"
	cancel.Parent = page

	local submit = Instance.new("TextButton")
	submit.Name = "Submit"
	submit.Position = UDim2.new(0.5, 6, 1, -72)
	submit.Size = UDim2.fromOffset(198, 50)
	submit.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
	submit.BorderSizePixel = 0
	submit.Font = Enum.Font.SourceSansBold
	submit.TextSize = 22
	submit.TextColor3 = Color3.new(1, 1, 1)
	submit.Text = "Submit"
	submit.Parent = page

	local function closePage()
		screen:Destroy()
	end

	cancel.Activated:Connect(closePage)

	submit.Activated:Connect(function()
		submit.Active = false
		submit.Text = "Submitting..."

		local ok, err = pcall(function()
			PlayersService:ReportAbuse(targetPlayer, selectedReason, description.Text)
		end)

		if ok then
			sendNotification("Report submitted", "Thank you for your report.", "", 5)
			closePage()
		else
			submit.Active = true
			submit.Text = "Submit"
			warn("Report failed: " .. tostring(err))
			sendNotification(
				"Report failed",
				"Unable to submit report.",
				"",
				7
			)
		end
	end)

	shield.Activated:Connect(function()
		-- Clicking outside the page closes it.
		if not reasonList.Visible then
			closePage()
		else
			reasonList.Visible = false
		end
	end)

	return screen
end

local function createPlayerDropDown()
	local playerDropDown = {
		Player = nil,
		PopupFrame = nil,
		HidePopupImmediately = false,
		PopupFrameOffScreenPosition = nil,
		HiddenSignal = createSignal(),
	}

	local function onFriendButtonPressed()
		local target = playerDropDown.Player
		if not target then return end

		local status = getFriendStatus(target)
		if status == Enum.FriendStatus.Friend then
			safeSetCore("PromptUnfriend", target)
		else
			safeSetCore("PromptSendFriendRequest", target)
		end

		playerDropDown:Hide()
	end

	local function onBlockButtonPressed()
		local target = playerDropDown.Player
		if not target then return end

		if isBlocked(target.UserId) then
			UnblockPlayerAsync(target)
		else
			BlockPlayerAsync(target)
		end

		playerDropDown:Hide()
	end

	local function onReportButtonPressed()
		local target = playerDropDown.Player
		if not target then
			return
		end

		playerDropDown:Hide()

		-- Use the real 2016 SettingsHub Report Abuse page.
		-- Keep the rest of PlayerDropDown completely untouched.
		local playerGui = LocalPlayer:WaitForChild("PlayerGui")
		local robloxGui = playerGui:WaitForChild("RobloxGui")
		local settingsHubModule = robloxGui
			:WaitForChild("Modules")
			:WaitForChild("Settings")
			:WaitForChild("SettingsHub")

		local ok, settingsHub = pcall(require, settingsHubModule)
		if not ok or type(settingsHub) ~= "table" then
			warn("PlayerDropDown: failed to load SettingsHub:", settingsHub)
			return
		end

		if type(settingsHub.ReportPlayer) == "function" then
			local reportOk, reportErr = pcall(function()
				settingsHub:ReportPlayer(target)
			end)

			if not reportOk then
				warn("PlayerDropDown: SettingsHub:ReportPlayer failed:", reportErr)
			end
		else
			warn("PlayerDropDown: SettingsHub.ReportPlayer is missing")
		end
	end

	local function createPopupFrame(buttons)
		local frame = Instance.new("Frame")
		frame.Name = "PopupFrame"
		frame.Size = UDim2.new(1, 0, 0, (POPUP_ENTRY_SIZE_Y * #buttons) + math.max(0, (#buttons - 1) * ENTRY_PAD))
		frame.Position = UDim2.new(1, 1, 0, 0)
		frame.BackgroundTransparency = 1

		for i, button in ipairs(buttons) do
			local btn = Instance.new("TextButton")
			btn.Name = button.Name
			btn.Size = UDim2.new(1, 0, 0, POPUP_ENTRY_SIZE_Y)
			btn.Position = UDim2.new(0, 0, 0, (POPUP_ENTRY_SIZE_Y + ENTRY_PAD) * (i - 1))
			btn.BackgroundTransparency = BG_TRANSPARENCY
			btn.BackgroundColor3 = BG_COLOR
			btn.BorderSizePixel = 0
			btn.Text = button.Text
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 14
			btn.TextColor3 = TEXT_COLOR
			btn.TextStrokeTransparency = TEXT_STROKE_TRANSPARENCY
			btn.TextStrokeColor3 = TEXT_STROKE_COLOR
			btn.AutoButtonColor = true
			btn.Parent = frame
			btn.Activated:Connect(button.OnPress)
		end

		return frame
	end

	function playerDropDown:Hide()
		local popup = self.PopupFrame
		if popup then
			local offscreenPosition = self.PopupFrameOffScreenPosition
				or UDim2.new(1, 1, 0, popup.Position.Y.Offset)

			if self.HidePopupImmediately then
				popup:Destroy()
				self.PopupFrame = nil
			else
				popup:TweenPosition(
					offscreenPosition,
					Enum.EasingDirection.InOut,
					Enum.EasingStyle.Quad,
					TWEEN_TIME,
					true,
					function()
						if self.PopupFrame == popup then
							popup:Destroy()
							self.PopupFrame = nil
						end
					end
				)
			end
		end

		self.Player = nil
		self.HiddenSignal:fire()
	end

	function playerDropDown:CreatePopup(player)
		self.Player = player

		if self.PopupFrame then
			self.PopupFrame:Destroy()
			self.PopupFrame = nil
		end

		local status = getFriendStatus(player)
		local blocked = isBlocked(player.UserId)
		local buttons = {}

		if not blocked then
			table.insert(buttons, {
				Name = "FriendButton",
				Text = status == Enum.FriendStatus.Friend and "Unfriend Player" or "Send Friend Request",
				OnPress = onFriendButtonPressed,
			})
		end

		table.insert(buttons, {
			Name = "BlockButton",
			Text = blocked and "Unblock Player" or "Block Player",
			OnPress = onBlockButtonPressed,
		})

		table.insert(buttons, {
			Name = "ReportButton",
			Text = "Report Abuse",
			OnPress = onReportButtonPressed,
		})

		-- Roblox's 2016 follower REST endpoints and NewFollower remote were
		-- experience API, so the obsolete Follow/Unfollow row is intentionally
		-- omitted instead of leaving a broken button.
		self.PopupFrame = createPopupFrame(buttons)
		return self.PopupFrame
	end

	PlayersService.PlayerRemoving:Connect(function(leavingPlayer)
		if playerDropDown.Player == leavingPlayer then
			playerDropDown:Hide()
		end
	end)

	return playerDropDown
end

moduleApiTable.FollowerStatusChanged = createSignal()

function moduleApiTable:CreatePlayerDropDown()
	return createPlayerDropDown()
end

function moduleApiTable:CreateBlockingUtility()
	local blockingUtility = {}

	function blockingUtility:BlockPlayerAsync(player)
		return BlockPlayerAsync(player)
	end

	function blockingUtility:UnblockPlayerAsync(player)
		return UnblockPlayerAsync(player)
	end

	function blockingUtility:MutePlayer(player)
		return MutePlayer(player)
	end

	function blockingUtility:UnmutePlayer(player)
		return UnmutePlayer(player)
	end

	function blockingUtility:IsPlayerBlockedByUserId(userId)
		return isBlocked(userId)
	end

	function blockingUtility:GetBlockedStatusChangedEvent()
		return BlockStatusChanged
	end

	function blockingUtility:IsPlayerMutedByUserId(userId)
		return isMuted(userId)
	end

	return blockingUtility
end

return moduleApiTable
end;
};
G2L_MODULES[G2L["a"]] = {
Closure = function()
    local script = G2L["a"];--[[
	// FileName: Chat.lua
	// Written by: SolarCrane
	// Description: Code for lua side chat on ROBLOX.
]]

--[[ CONSTANTS ]]

-- NOTE: IF YOU WANT TO USE THIS CHAT SCRIPT IN YOUR OWN GAME:
-- 1) COPY THE CONTENTS OF THIS FILE INTO A MODULE
-- 2) CREATE A LOCALSCRIPT AND PARENT IT TO StarterGui
-- 3) IN THE LOCALSCRIPT require() THE CHAT MODULE YOU MADE IN STEP 1
-- 4) CONFIGURE YOUR PLACE ON THE WEBSITE TO USE BUBBLE-CHAT
-- 5) SET THE FOLLOWING TWO VARIABLES TO TRUE

local TextChatService = game:GetService("TextChatService")
local Lighting = game:GetService("Lighting")
local RBXGeneral: TextChannel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

-- This module draws its own legacy chat UI, so keep Roblox's modern chat UI out of the way.
pcall(function() TextChatService.ChatWindowConfiguration.Enabled = false end)
pcall(function() TextChatService.ChatInputBarConfiguration.Enabled = false end)

local function LocalChatsAreUnfiltered()
	local flag = Lighting:FindFirstChild("LocalChatsAreUnfiltered")
	return flag and flag:IsA("BoolValue") and flag.Value or false
end

local FORCE_CHAT_GUI = false
local NON_CORESCRIPT_MODE = false
-- 6) (OPTIONAL) PUT THE FOLLOWING LINE IN A SERVER SCRIPT TO MAKE CHAT PERSIST THROUGH RESPAWNING
--  game:GetService('StarterGui').ResetPlayerGuiOnSpawn = false
---------------------------------

local MESSAGES_FADE_OUT_TIME = 30
local MAX_UDIM_SIZE = 2^15 - 1

local PHONE_SCREEN_WIDTH = 640
local TABLET_SCREEN_WIDTH = 1024

local FLOOD_CHECK_MESSAGE_COUNT = 7
local FLOOD_CHECK_MESSAGE_INTERVAL = 15 -- This is in seconds

local VR_CHAT_CLICK_DEBOUNCE = 0.25

local SCROLLBAR_THICKNESS = 7
local CHAT_COLORS =
	{
		Color3.new(253/255, 41/255, 67/255), -- BrickColor.new("Bright red").Color,
		Color3.new(1/255, 162/255, 255/255), -- BrickColor.new("Bright blue").Color,
		Color3.new(2/255, 184/255, 87/255), -- BrickColor.new("Earth green").Color,
		BrickColor.new("Bright violet").Color,
		BrickColor.new("Bright orange").Color,
		BrickColor.new("Bright yellow").Color,
		BrickColor.new("Light reddish violet").Color,
		BrickColor.new("Brick yellow").Color,
	}

local emptySelectionImage = Instance.new("ImageLabel")
emptySelectionImage.ImageTransparency = 1
emptySelectionImage.BackgroundTransparency = 1

--[[ END OF CONSTANTS ]]

--[[ SERVICES ]]
local RunService = game:GetService('RunService')
local CoreGuiService = game.Players.LocalPlayer.PlayerGui
local PlayersService = game:GetService('Players')
local DebrisService = game:GetService('Debris')
local GuiService = game:GetService('GuiService')
local InputService = game:GetService('UserInputService')
local StarterGui = game:GetService('StarterGui')
local ContextActionService = game:GetService('ContextActionService')
--[[ END OF SERVICES ]]

--[[ Fast Flags ]]--
local playerDropDownEnabledSuccess, playerDropDownEnabledFlagValue = pcall(function() return settings():GetFFlag("PlayerDropDownEnabled") end)
local IsPlayerDropDownEnabled = playerDropDownEnabledSuccess and playerDropDownEnabledFlagValue

local getMoveChatSuccess, moveChatActiveValue = pcall(function() return settings():GetFFlag("SetCoreMoveChat") end)
local allowMoveChat = getMoveChatSuccess and moveChatActiveValue

local getDisableChatBarSuccess, disableChatBarValue = pcall(function() return settings():GetFFlag("SetCoreDisableChatBar") end)
local allowDisableChatBar = getDisableChatBarSuccess and disableChatBarValue

--[[ SCRIPT VARIABLES ]]

-- I am not fond of waiting at the top of the script here...
while PlayersService.LocalPlayer == nil do PlayersService.ChildAdded:wait() end
local Player = PlayersService.LocalPlayer
-- GuiRoot will act as the top-node for parenting GUIs
local GuiRoot = Instance.new('Frame')
GuiRoot.Name = 'GuiRoot';
GuiRoot.Size = UDim2.new(1,0,1,0);
GuiRoot.Position = UDim2.new(0,0,0,37);
GuiRoot.BackgroundTransparency = 1;



local chatRepositioned = false
local chatBarDisabled = false

local lastSelectedPlayer = nil
local lastSelectedButton = nil

local playerDropDownModule = nil
local playerDropDown = nil
local blockingUtility = nil

local topbarEnabled = true



if not NON_CORESCRIPT_MODE and not InputService.VREnabled then
	playerDropDownModule = require(CoreGuiService:WaitForChild('RobloxGui').Modules:WaitForChild("PlayerDropDown"))
	playerDropDown = playerDropDownModule:CreatePlayerDropDown()
	blockingUtility = playerDropDownModule:CreateBlockingUtility()
end

--[[ END OF SCRIPT VARIABLES ]]

local function GetLuaChatFilteringFlag()
	local flagSuccess, flagValue = pcall(function() return settings():GetFFlag("LuaChatFiltering") end)
	return flagSuccess and flagValue == true
end

local Util = {}
do
	-- Check if we are running on a touch device
	function Util.IsTouchDevice()
		local touchEnabled = false
		pcall(function() touchEnabled = InputService.TouchEnabled end)
		return touchEnabled
	end

	function Util.IsSmallScreenSize()
		return GuiRoot.AbsoluteSize.X <= PHONE_SCREEN_WIDTH
	end

	function Util.Create(instanceType)
		return function(data)
			local obj = Instance.new(instanceType)
			for k, v in pairs(data) do
				if type(k) == 'number' then
					v.Parent = obj
				else
					obj[k] = v
				end
			end
			return obj
		end
	end

	function Util.Clamp(low, high, input)
		return math.max(low, math.min(high, input))
	end

	function Util.Linear(t, b, c, d)
		if t >= d then return b + c end

		return c*t/d + b
	end

	function Util.EaseOutQuad(t, b, c, d)
		if t >= d then return b + c end

		t = t/d;
		return -c * t*(t-2) + b
	end

	function Util.EaseInOutQuad(t, b, c, d)
		if t >= d then return b + c end

		t = t / (d/2);
		if (t < 1) then return c/2*t*t + b end;
		t = t - 1;
		return -c/2 * (t*(t-2) - 1) + b;
	end

	function Util.PropertyTweener(instance, prop, start, final, duration, easingFunc, cbFunc)
		local this = {}
		this.StartTime = tick()
		this.EndTime = this.StartTime + duration
		this.Cancelled = false

		local finished = false
		local percentComplete = 0
		spawn(function()
			local now = tick()
			while now < this.EndTime and instance do
				if this.Cancelled then
					return
				end
				instance[prop] = easingFunc(now - this.StartTime, start, final - start, duration)
				percentComplete = Util.Clamp(0, 1, (now - this.StartTime) / duration)
				RunService.RenderStepped:wait()
				now = tick()
			end
			if this.Cancelled == false and instance then
				instance[prop] = final
				finished = true
				percentComplete = 1
				if cbFunc then
					cbFunc()
				end
			end
		end)

		function this:GetPercentComplete()
			return percentComplete
		end

		function this:IsFinished()
			return finished
		end

		function this:Cancel()
			this.Cancelled = true
		end

		return this
	end

	function Util.Signal()
		local sig = {}

		local mSignaler = Instance.new('BindableEvent')

		local mArgData = nil
		local mArgDataCount = nil

		function sig:fire(...)
			mArgData = {...}
			mArgDataCount = select('#', ...)
			mSignaler:Fire()
		end

		function sig:connect(f)
			if not f then error("connect(nil)", 2) end
			return mSignaler.Event:connect(function()
				f(unpack(mArgData, 1, mArgDataCount))
			end)
		end

		function sig:wait()
			mSignaler.Event:wait()
			assert(mArgData, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
			return unpack(mArgData, 1, mArgDataCount)
		end

		return sig
	end

	function Util.DisconnectEvent(conn)
		if conn then
			conn:disconnect()
		end
		return nil
	end

	function Util.SetGUIInsetBounds(x, y)
		local success, _ = pcall(function() GuiService:SetGlobalGuiInset(0, x, 0, y) end)
		if not success then
			pcall(function() GuiService:SetGlobalSizeOffsetPixel(-x, -y) end) -- Legacy GUI-offset function
		end
	end

	local baseUrl = game:GetService("ContentProvider").BaseUrl:lower()
	baseUrl = string.gsub(baseUrl,"/m.","/www.") --mobile site does not work for this stuff!
	function Util.GetSecureApiBaseUrl()
		local secureApiUrl = baseUrl
		secureApiUrl = string.gsub(secureApiUrl,"http://","https://")
		secureApiUrl = string.gsub(secureApiUrl,"www","api")
		return secureApiUrl
	end

	function Util.GetPlayerByName(playerName)
		-- O(n), may be faster if I store a reverse hash from the players list; can't trust FindFirstChild in PlayersService because anything can be parented to there.
		local lowerName = string.lower(playerName)
		for _, player in pairs(PlayersService:GetPlayers()) do
			if string.lower(player.Name) == lowerName then
				return player
			end
		end
		return nil -- Found no player
	end

	local adminCache = {}
	function Util.IsPlayerAdminAsync(player)
		local userId = player and player.userId
		if userId then
			if adminCache[userId] == nil then
				local isAdmin = false
				-- Many things can error is the IsInGroup check
				pcall(function()
					isAdmin = player:IsInGroup(1200769)
				end)
				adminCache[userId] = isAdmin
			end
			return adminCache[userId]
		end
		return false
	end

	local function GetNameValue(pName)
		local value = 0
		for index = 1, #pName do
			local cValue = string.byte(string.sub(pName, index, index))
			local reverseIndex = #pName - index + 1
			if #pName%2 == 1 then
				reverseIndex = reverseIndex - 1
			end
			if reverseIndex%4 >= 2 then
				cValue = -cValue
			end
			value = value + cValue
		end
		return value
	end

	function Util.ComputeChatColor(pName)
		return CHAT_COLORS[(GetNameValue(pName) % #CHAT_COLORS) + 1]
	end

	-- This is a memo-izing function
	local testLabel = Instance.new('TextLabel')
	testLabel.TextWrapped = true;
	testLabel.Position = UDim2.new(1,0,1,0)
	testLabel.Parent = GuiRoot -- Note: We have to parent it to check TextBounds
	-- The TextSizeCache table looks like this Text->Font->sizeBounds->FontSize
	local TextSizeCache = {}
	function Util.GetStringTextBounds(text, font, fontSize, sizeBounds)
		-- If no sizeBounds are specified use some huge number
		sizeBounds = sizeBounds or false
		if not TextSizeCache[text] then
			TextSizeCache[text] = {}
		end
		if not TextSizeCache[text][font] then
			TextSizeCache[text][font] = {}
		end
		if not TextSizeCache[text][font][sizeBounds] then
			TextSizeCache[text][font][sizeBounds] = {}
		end
		if not TextSizeCache[text][font][sizeBounds][fontSize] then
			testLabel.Text = text
			testLabel.Font = font
			testLabel.FontSize = fontSize
			if sizeBounds then
				testLabel.TextWrapped = true;
				testLabel.Size = sizeBounds
			else
				testLabel.TextWrapped = false;
			end
			TextSizeCache[text][font][sizeBounds][fontSize] = testLabel.TextBounds
		end
		return TextSizeCache[text][font][sizeBounds][fontSize]
	end

	local PRINTABLE_CHARS = '[^' .. string.char(32) .. '-' ..  string.char(126) .. ']'
	local WHITESPACE_CHARS = '(' .. string.rep('%s', 7) .. ')%s+'
	function Util.FilterUnprintableCharacters(str)
		if not GetLuaChatFilteringFlag() then
			return str
		end

		local result = str:gsub(PRINTABLE_CHARS, '');
		result = str:gsub(WHITESPACE_CHARS, '%1');
		return result
	end
end

local SelectChatModeEvent = Util.Signal()
local SelectPlayerEvent = Util.Signal()

local function CreateChatMessage()
	local this = {}
	this.FadeRoutines = {}

	function this:GetMessageFontSize(settings)
		return Util.IsSmallScreenSize() and settings.SmallScreenFontSize or settings.FontSize
	end

	function this:OnResize()
		-- Nothing!
	end

	function this:FadeIn()
		local gui = this:GetGui()
		if gui then
			gui.Visible = true
		end
	end

	function this:FadeOut()
		local gui = this:GetGui()
		if gui then
			gui.Visible = false
		end
	end

	function this:GetGui()
		return this.Container
	end

	function this:Destroy()
		if this.Container ~= nil then
			this.Container:Destroy()
			this.Container = nil
		end
		if this.FadeRoutines then
			for _, routine in pairs(this.FadeRoutines) do
				routine:Cancel()
			end
			this.FadeRoutines = {}
		end
	end

	return this
end

local function CreateSystemChatMessage(settings, chattedMessage)
	local this = CreateChatMessage()

	this.Settings = settings
	this.rawChatString = chattedMessage

	function this:OnResize(containerSize)
		if this.Container and this.ChatMessage then

			if InputService.VREnabled then
				this.ChatMessage.Position = UDim2.new(0, 4, 0, 0)
				this.ChatMessage.Size = UDim2.new(1, 0, 1, 0)
			end

			this.Container.Size = UDim2.new(1,0,0,1000)
			local textHeight = this.ChatMessage.TextBounds.Y

			local newContainerHeight = textHeight + 5
			this.Container.Size = UDim2.new(1,0,0,newContainerHeight)
			return newContainerHeight
		end
	end

	function this:FadeIn()
		local gui = this:GetGui()
		if gui then
			gui.Visible = true
			for _, routine in pairs(this.FadeRoutines) do
				routine:Cancel()
			end
			this.FadeRoutines = {}
			local tweenableObjects = {
				this.ChatMessage;
			}
			for _, object in pairs(tweenableObjects) do
				object.TextTransparency = 0;
				object.TextStrokeTransparency = this.Settings.TextStrokeTransparency;
			end

			if this.MessageBackgroundImage then
				this.MessageBackgroundImage.Visible = InputService.VREnabled
			end
		end
	end

	function this:FadeOut(instant)
		local gui = this:GetGui()
		if gui then
			if instant then
				gui.Visible = false
			else
				local tweenableObjects = {
					this.ChatMessage;
				}
				for _, object in pairs(tweenableObjects) do
					table.insert(this.FadeRoutines, Util.PropertyTweener(object, 'TextTransparency', object.TextTransparency, 1, 1, Util.Linear))
					table.insert(this.FadeRoutines, Util.PropertyTweener(object, 'TextStrokeTransparency', object.TextStrokeTransparency, 1, 0.85, Util.Linear))
				end
			end
			if this.MessageBackgroundImage then
				this.MessageBackgroundImage.Visible = false
			end
		end
	end

	local function CreateMessageGuiElement()
		local fontSize = this:GetMessageFontSize(this.Settings)

		local systemMessageDisplayText = this.rawChatString or ""
		local systemMessageSize = Util.GetStringTextBounds(systemMessageDisplayText, this.Settings.Font, fontSize, UDim2.new(0, 400, 0, 1000))

		local container = Util.Create'Frame'
		{
			Name = 'MessageContainer';
			Position = UDim2.new(0, 0, 0, 0);
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 1;
		};
		this.MessageBackgroundImage = Util.Create'ImageLabel'
		{
			Name = 'TextEntryBackground';
			Size = UDim2.new(1,0,1,-2);
			Position = UDim2.new(0,0,0,1);
			Image = 'rbxasset://textures/ui/Chat/VRChatBackground.png';
			ScaleType = Enum.ScaleType.Slice;
			SliceCenter = Rect.new(8,8,56,56);
			BackgroundTransparency = 1;
			ImageTransparency = 0.3;
			BorderSizePixel = 0;
			ZIndex = 1;
			Visible = InputService.VREnabled;
			Parent = container;
		}

		local chatMessage = Util.Create'TextLabel'
		{
			Name = 'SystemChatMessage';
			Position = UDim2.new(0, 0, 0, 0);
			Size = UDim2.new(1, 0, 1, 0);
			Text = systemMessageDisplayText;
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 1;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			TextWrapped = true;
			TextColor3 = this.Settings.DefaultMessageTextColor;
			FontSize = fontSize;
			Font = this.Settings.Font;
			TextStrokeColor3 = this.Settings.TextStrokeColor;
			TextStrokeTransparency = this.Settings.TextStrokeTransparency;
			Parent = container;
		};
		if InputService.VREnabled then
			chatMessage.Position = UDim2.new(0, 4, 0, 0)
			chatMessage.Size = UDim2.new(1, 0, 1, 0)
		end

		container.Size = UDim2.new(1, 0, 0, systemMessageSize.Y + 1);
		this.Container = container
		this.ChatMessage = chatMessage
	end

	CreateMessageGuiElement()

	return this
end

--[[ Popup Handling ]]--
function createPopupFrame(selectedPlayer, selectedButton)
	if selectedPlayer and selectedPlayer.Parent == PlayersService then
		if lastSelectedButton ~= selectedButton then
			if lastSelectedButton ~= nil then
				lastSelectedButton.BackgroundTransparency = 1
				lastSelectedButton = nil
			end
			lastSelectedButton = selectedButton
			lastSelectedPlayer = selectedPlayer
			selectedButton.BackgroundTransparency = 0.5

			if IsPlayerDropDownEnabled then
				playerDropDown.HidePopupImmediately = true
				local PopupFrame = playerDropDown:CreatePopup(selectedPlayer)
				PopupFrame.Position = UDim2.new(0, selectedButton.AbsolutePosition.X + selectedButton.AbsoluteSize.X + 2, 0, selectedButton.AbsolutePosition.Y)
				PopupFrame.Size = UDim2.new(0, 150, PopupFrame.Size.Y.Scale, PopupFrame.Size.Y.Offset)
				PopupFrame.ZIndex = 5
				PopupFrame.Parent = GuiRoot
			end

			for _, button in pairs(PopupFrame:GetChildren()) do
				button.BackgroundTransparency = 0
				button.ZIndex = 6
			end
		else
			if IsPlayerDropDownEnabled then
				playerDropDown:Hide()
			end
			lastSelectedPlayer = nil
		end
	end
end

function popupHidden()
	if lastSelectedButton then
		lastSelectedPlayer = nil
		lastSelectedButton.BackgroundTransparency = 1
		lastSelectedButton = nil
	end
end

if IsPlayerDropDownEnabled and playerDropDown then
	playerDropDown.HiddenSignal:connect(popupHidden)
end

InputService.InputBegan:connect(function(inputObject, isProcessed)
	if isProcessed then return end
	local inputType = inputObject.UserInputType
	if (inputType == Enum.UserInputType.Touch and  inputObject.UserInputState == Enum.UserInputState.Begin) or
		inputType == Enum.UserInputType.MouseButton1 then
		if lastSelectedButton and IsPlayerDropDownEnabled then
			playerDropDown:Hide()
		end
	end
end)

--[[ End of popup handling ]]--

local function CreatePlayerChatMessage(settings, playerChatType, sendingPlayer, chattedMessage, receivingPlayer)
	local this = CreateChatMessage()

	this.Settings = settings
	this.PlayerChatType = playerChatType
	this.SendingPlayer = sendingPlayer
	this.RawMessageContent = chattedMessage
	this.ReceivingPlayer = receivingPlayer
	this.ReceivedTime = tick()

	this.Neutral = this.SendingPlayer and this.SendingPlayer.Neutral or true
	this.TeamColor = this.SendingPlayer and this.SendingPlayer.TeamColor or BrickColor.new("White")

	function this:OnResize(containerSize)
		if this.Container and this.ChatMessage then
			this.Container.Size = UDim2.new(1,0,0,1000)
			local textHeight = this.ChatMessage.TextBounds.Y
			local newContainerHeight = textHeight + 5
			this.Container.Size = UDim2.new(1,0,0,newContainerHeight)
			return newContainerHeight
		end
	end

	function this:FormatMessage()
		local result = ""
		if this.RawMessageContent then
			local message = this.RawMessageContent
			result = message
		end
		return result
	end

	function this:FormatChatType()
		if this.PlayerChatType then
			if this.PlayerChatType == Enum.PlayerChatType.All then
				--return "[All]"
			elseif this.PlayerChatType == Enum.PlayerChatType.Team then
				return "[Team]"
			elseif this.PlayerChatType == Enum.PlayerChatType.Whisper then
				-- nothing!
			end
		end
	end

	function this:FormatPlayerNameText()
		local playerName = ""
		-- If we are sending a whisper to someone, then we should show their name
		if this.PlayerChatType == Enum.PlayerChatType.Whisper and this.SendingPlayer and this.SendingPlayer == Player then
			playerName = (this.ReceivingPlayer and this.ReceivingPlayer.Name or "")
		else
			playerName = (this.SendingPlayer and this.SendingPlayer.Name or "")
		end
		return "[" ..  playerName .. "]:"
	end

	function this:FadeIn()
		local gui = this:GetGui()
		if gui then
			gui.Visible = true
			for _, routine in pairs(this.FadeRoutines) do
				routine:Cancel()
			end
			this.FadeRoutines = {}
			local tweenableObjects = {
				this.WhisperToText;
				this.WhisperFromText;
				this.ChatModeButton;
				this.UserNameButton;
				this.ChatMessage;
			}
			for _, object in pairs(tweenableObjects) do
				object.TextTransparency = 0;
				object.TextStrokeTransparency = this.Settings.TextStrokeTransparency;
				object.Active = true
			end
			if this.UserNameDot then
				this.UserNameDot.ImageTransparency = 0
			end

			if this.MessageBackgroundImage then
				this.MessageBackgroundImage.Visible = InputService.VREnabled
			end
		end
	end

	function this:FadeOut(instant)
		local gui = this:GetGui()
		if gui then
			if instant then
				gui.Visible = false
			else
				local tweenableObjects = {
					this.WhisperToText;
					this.WhisperFromText;
					this.ChatModeButton;
					this.UserNameButton;
					this.ChatMessage;
				}
				for _, object in pairs(tweenableObjects) do
					table.insert(this.FadeRoutines, Util.PropertyTweener(object, 'TextTransparency', object.TextTransparency, 1, 1, Util.Linear))
					table.insert(this.FadeRoutines, Util.PropertyTweener(object, 'TextStrokeTransparency', object.TextStrokeTransparency, 1, 0.85, Util.Linear))
					object.Active = false
				end
				if this.UserNameDot then
					table.insert(this.FadeRoutines, Util.PropertyTweener(this.UserNameDot, 'ImageTransparency', this.UserNameDot.ImageTransparency, 1, 1, Util.Linear))
				end
			end
			if this.MessageBackgroundImage then
				this.MessageBackgroundImage.Visible = false
			end
		end
	end

	function this:Destroy()
		if this.Container ~= nil then
			this.Container:Destroy()
			this.Container = nil
		end
		this.ClickedOnModeConn = Util.DisconnectEvent(this.ClickedOnModeConn)
		this.ClickedOnPlayerConn = Util.DisconnectEvent(this.ClickedOnPlayerConn)
		this.RightClickedOnPlayerConn = Util.DisconnectEvent(this.RightClickedOnPlayerConn)
	end

	local function CreateMessageGuiElement()
		local fontSize = this:GetMessageFontSize(this.Settings)

		local toMesasgeDisplayText = "To "
		local toMessageSize = Util.GetStringTextBounds(toMesasgeDisplayText, this.Settings.Font, fontSize)
		local fromMesasgeDisplayText = "From "
		local fromMessageSize = Util.GetStringTextBounds(fromMesasgeDisplayText, this.Settings.Font, fontSize)
		local chatTypeDisplayText = this:FormatChatType()
		local chatTypeSize = chatTypeDisplayText and Util.GetStringTextBounds(chatTypeDisplayText, this.Settings.Font, fontSize) or Vector2.new(0,0)
		local playerNameDisplayText = this:FormatPlayerNameText()
		local playerNameSize = Util.GetStringTextBounds(playerNameDisplayText, this.Settings.Font, fontSize)

		local singleSpaceSize = Util.GetStringTextBounds(" ", this.Settings.Font, fontSize)
		local numNeededSpaces = math.ceil(playerNameSize.X / singleSpaceSize.X) + 1
		local chatMessageDisplayText = string.rep(" ", numNeededSpaces) .. this:FormatMessage()
		local chatMessageSize = Util.GetStringTextBounds(chatMessageDisplayText, this.Settings.Font, fontSize, UDim2.new(0, 400 - 5 - playerNameSize.X, 0, 1000))


		local playerColor = this.Settings.DefaultMessageTextColor
		if this.SendingPlayer then
			if this.PlayerChatType == Enum.PlayerChatType.Whisper then
				if this.SendingPlayer == Player and this.ReceivingPlayer then
					playerColor = Util.ComputeChatColor(this.ReceivingPlayer.Name)
				else
					playerColor = Util.ComputeChatColor(this.SendingPlayer.Name)
				end
			else
				if this.SendingPlayer.Neutral then
					playerColor = Util.ComputeChatColor(this.SendingPlayer.Name)
				else
					playerColor = this.SendingPlayer.TeamColor.Color
				end
			end
		end

		local container = Util.Create'Frame'
		{
			Name = 'MessageContainer';
			Position = UDim2.new(0, 0, 0, 0);
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 1;
		};
		this.MessageBackgroundImage = Util.Create'ImageLabel'
		{
			Name = 'TextEntryBackground';
			Size = UDim2.new(1,0,1,-2);
			Position = UDim2.new(0,0,0,1);
			Image = 'rbxasset://textures/ui/Chat/VRChatBackground.png';
			ScaleType = Enum.ScaleType.Slice;
			SliceCenter = Rect.new(8,8,56,56);
			BackgroundTransparency = 1;
			ImageTransparency = 0.3;
			BorderSizePixel = 0;
			ZIndex = 1;
			Visible = InputService.VREnabled;
			Parent = container;
		}

		local xOffset = InputService.VREnabled and 4 or 0

		if this.SendingPlayer and this.SendingPlayer == Player and this.PlayerChatType == Enum.PlayerChatType.Whisper then
			local whisperToText = Util.Create'TextLabel'
			{
				Name = 'WhisperTo';
				Position = UDim2.new(0, 0, 0, 0);
				Size = UDim2.new(0, toMessageSize.X, 0, toMessageSize.Y);
				Text = toMesasgeDisplayText;
				ZIndex = 1;
				BackgroundColor3 = Color3.new(0, 0, 0);
				BackgroundTransparency = 1;
				TextXAlignment = Enum.TextXAlignment.Left;
				TextYAlignment = Enum.TextYAlignment.Top;
				TextWrapped = true;
				TextColor3 = this.Settings.DefaultMessageTextColor;
				FontSize = fontSize;
				Font = this.Settings.Font;
				TextStrokeColor3 = this.Settings.TextStrokeColor;
				TextStrokeTransparency = this.Settings.TextStrokeTransparency;
				Parent = container;
			};
			xOffset = xOffset + toMessageSize.X
			this.WhisperToText = whisperToText
		elseif this.SendingPlayer and this.SendingPlayer ~= Player and this.PlayerChatType == Enum.PlayerChatType.Whisper then
			local whisperFromText = Util.Create'TextLabel'
			{
				Name = 'WhisperFromText';
				Position = UDim2.new(0, 0, 0, 0);
				Size = UDim2.new(0, fromMessageSize.X, 0, fromMessageSize.Y);
				Text = fromMesasgeDisplayText;
				ZIndex = 1;
				BackgroundColor3 = Color3.new(0, 0, 0);
				BackgroundTransparency = 1;
				TextXAlignment = Enum.TextXAlignment.Left;
				TextYAlignment = Enum.TextYAlignment.Top;
				TextWrapped = true;
				TextColor3 = this.Settings.DefaultMessageTextColor;
				FontSize = fontSize;
				Font = this.Settings.Font;
				TextStrokeColor3 = this.Settings.TextStrokeColor;
				TextStrokeTransparency = this.Settings.TextStrokeTransparency;
				Parent = container;
			};
			xOffset = xOffset + fromMessageSize.X
			this.WhisperFromText = whisperFromText
		end
		if chatTypeDisplayText then
			local chatModeButton = Util.Create(Util.IsTouchDevice() and 'TextLabel' or 'TextButton')
			{
				Name = 'ChatMode';
				BackgroundTransparency = 1;
				ZIndex = 2;
				Text = chatTypeDisplayText;
				TextColor3 = this.Settings.DefaultMessageTextColor;
				Position = UDim2.new(0, xOffset, 0, 0);
				TextXAlignment = Enum.TextXAlignment.Left;
				TextYAlignment = Enum.TextYAlignment.Top;
				FontSize = fontSize;
				Font = this.Settings.Font;
				Size = UDim2.new(0, chatTypeSize.X, 0, chatTypeSize.Y);
				TextStrokeColor3 = this.Settings.TextStrokeColor;
				TextStrokeTransparency = this.Settings.TextStrokeTransparency;
				Parent = container
			}
			if chatModeButton:IsA('TextButton') then
				this.ClickedOnModeConn = chatModeButton.MouseButton1Click:connect(function()
					SelectChatModeEvent:fire(this.PlayerChatType)
				end)
			end
			if this.PlayerChatType == Enum.PlayerChatType.Team then
				chatModeButton.TextColor3 = playerColor
			end
			xOffset = xOffset + chatTypeSize.X + 1
			this.ChatModeButton = chatModeButton
		end
		local userNameButton = Util.Create(Util.IsTouchDevice() and 'TextLabel' or 'TextButton')
		{
			Name = 'PlayerName';
			BackgroundTransparency = 1;
			BackgroundColor3 = Color3.new(0, 1, 1);
			BorderSizePixel = 0;
			ZIndex = 2;
			Text = playerNameDisplayText;
			TextColor3 = playerColor;
			Position = UDim2.new(0, xOffset, 0, 0);
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			FontSize = fontSize;
			Font = this.Settings.Font;
			Size = UDim2.new(0, playerNameSize.X, 0, playerNameSize.Y);
			TextStrokeColor3 = this.Settings.TextStrokeColor;
			TextStrokeTransparency = this.Settings.TextStrokeTransparency;
			Parent = container
		}
		if userNameButton:IsA('TextButton') then
			this.ClickedOnPlayerConn = userNameButton.MouseButton1Click:connect(function()
				local gui = this:GetGui()
				if gui and gui.Visible then
					if this.PlayerChatType == Enum.PlayerChatType.Whisper and this.SendingPlayer == Player and this.ReceivingPlayer then
						SelectPlayerEvent:fire(this.ReceivingPlayer)
					else
						SelectPlayerEvent:fire(this.SendingPlayer)
					end
				end
			end)
			this.RightClickedOnPlayerConn = userNameButton.MouseButton2Click:connect(function()
				local gui = this:GetGui()
				if gui and gui.Visible then
					if IsPlayerDropDownEnabled and playerDropDown then
						if this.SendingPlayer and this.SendingPlayer ~= Player then
							createPopupFrame(this.SendingPlayer, userNameButton)
						end
					end
				end
			end)
		end

		local chatMessage = Util.Create'TextLabel'
		{
			Name = 'ChatMessage';
			Position = UDim2.new(0, xOffset, 0, 0);
			Size = UDim2.new(1, -xOffset, 1, 0);
			Text = chatMessageDisplayText;
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 1;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			TextWrapped = true;
			TextColor3 = this.Settings.DefaultMessageTextColor;
			FontSize = fontSize;
			Font = this.Settings.Font;
			TextStrokeColor3 = this.Settings.TextStrokeColor;
			TextStrokeTransparency = this.Settings.TextStrokeTransparency;
			Parent = container;
		};
		if InputService.VREnabled then
			chatMessage.Size = chatMessage.Size - UDim2.new(0,4,0,0)
		end
		-- Check if they got moderated and put up a real message instead of Label
		if chatMessage.Text == 'Label' and chatMessageDisplayText ~= 'Label' then
			chatMessage.Text = string.rep(" ", numNeededSpaces) .. '[Content Deleted]'
		end
		if this.SendingPlayer and Util.IsPlayerAdminAsync(this.SendingPlayer) then
			chatMessage.TextColor3 = this.Settings.AdminTextColor
		end
		chatMessage.Size = chatMessage.Size + UDim2.new(0, 0, 0, chatMessage.TextBounds.Y);

		container.Size = UDim2.new(1, 0, 0, math.max(chatMessageSize.Y + 1, userNameButton.Size.Y.Offset + 1));
		this.Container = container
		this.ChatMessage = chatMessage
		this.UserNameButton = userNameButton
	end

	CreateMessageGuiElement()

	return this
end

local function CreateChatBarWidget(settings)
	local this = {}

	-- MessageModes: {All, Team, Whisper}
	this.MessageMode = 'All'
	this.TargetWhisperPlayer = nil
	this.Settings = settings

	this.WidgetVisible = false
	this.FadedIn = true

	this.ChatBarGainedFocusEvent = Util.Signal()
	this.ChatBarLostFocusEvent = Util.Signal()
	this.ChatCommandEvent = Util.Signal() -- Signal Signatue: success, actionType, [captures]
	this.ChatErrorEvent = Util.Signal() -- Signal Signatue: success, actionType, [captures]
	this.ChatBarFloodEvent = Util.Signal()

	this.unfocusedAt = 0
	this.SuppressNextSlashCharacter = false

	local chatCoreGuiEnabled = true

	-- This function while lets string.find work case-insensitively without clobbering the case of the captures
	local function nocase(s)
		s = string.gsub(s, "%a", function (c)
			return string.format("[%s%s]", string.lower(c),
				string.upper(c))
		end)
		return s
	end

	this.ChatMatchingRegex =
		{
			[function(chatBarText) return string.find(chatBarText, nocase("^/w ") .. "(%w+_?%w+)") end] = "Whisper";
			[function(chatBarText) return string.find(chatBarText, nocase("^/whisper ") .. "(%w+_?%w+)") end] = "Whisper";

			[function(chatBarText) return string.find(chatBarText, "^%%") end] = "Team";
			[function(chatBarText) return string.find(chatBarText, "^%(TEAM%)") end] = "Team";
			[function(chatBarText) return string.find(chatBarText, nocase("^/t")) end] = "Team";
			[function(chatBarText) return string.find(chatBarText, nocase("^/team")) end] = "Team";

			[function(chatBarText) return string.find(chatBarText, nocase("^/a")) end] = "All";
			[function(chatBarText) return string.find(chatBarText, nocase("^/all")) end] = "All";
			[function(chatBarText) return string.find(chatBarText, nocase("^/s")) end] = "All";
			[function(chatBarText) return string.find(chatBarText, nocase("^/say")) end] = "All";

			[function(chatBarText) return string.find(chatBarText, nocase("^/e")) end] = "Emote";
			[function(chatBarText) return string.find(chatBarText, nocase("^/emote")) end] = "Emote";

			[function(chatBarText) return string.find(chatBarText, "^/%?") end] = "Help";
			[function(chatBarText) return string.find(chatBarText, nocase("^/help")) end] = "Help";

			[function(chatBarText) return string.find(chatBarText, nocase("^/block ") .. "(%w+_?%w+)") end] = "Block";

			[function(chatBarText) return string.find(chatBarText, nocase("^/unblock ") .. "(%w+_?%w+)") end] = "Unblock";

			[function(chatBarText) return string.find(chatBarText, nocase("^/mute ") .. "(%w+_?%w+)") end] = "Mute";

			[function(chatBarText) return string.find(chatBarText, nocase("^/unmute ") .. "(%w+_?%w+)") end] = "Unmute";
		}

	local ChatModesDict =
		{
			['Whisper'] = 'Whisper';
			['Team'] = 'Team';
			['All'] = 'All';
			[Enum.PlayerChatType.Whisper] = 'Whisper';
			[Enum.PlayerChatType.Team] = 'Team';
			[Enum.PlayerChatType.All] = 'All';
		}

	local function TearDownEvents()
		this.ClickToChatButtonConn = Util.DisconnectEvent(this.ClickToChatButtonConn)
		this.ChatBarContainerClickConn = Util.DisconnectEvent(this.ChatBarContainerClickConn)
		this.ChatBarFocusLostConn = Util.DisconnectEvent(this.ChatBarFocusLostConn)
		this.ChatBarLostFocusConn = Util.DisconnectEvent(this.ChatBarLostFocusConn)
		this.SelectChatModeConn = Util.DisconnectEvent(this.SelectChatModeConn)
		this.SelectPlayerConn = Util.DisconnectEvent(this.SelectPlayerConn)
		this.FocusChatBarInputBeganConn = Util.DisconnectEvent(this.FocusChatBarInputBeganConn)
		this.InputBeganConn = Util.DisconnectEvent(this.InputBeganConn)
		this.ChatBarChangedConn = Util.DisconnectEvent(this.ChatBarChangedConn)
	end

	local function HookUpEvents()
		TearDownEvents() -- Cleanup old events

		if this.ClickToChatButton then
			this.ClickToChatButtonConn = this.ClickToChatButton.MouseButton1Click:connect(function()
				this:FocusChatBar()
			end)
		end

		-- Clicking/tapping anywhere on the old chat bar should open/focus it too.
		if this.ChatBarContainer then
			this.ChatBarContainer.Active = true
			this.ChatBarContainerClickConn = this.ChatBarContainer.InputBegan:connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1
					or inputObject.UserInputType == Enum.UserInputType.Touch then
					this:FocusChatBar()
				end
			end)
		end

		if this.ChatBar then
			-- Use a count to check for double backspace out of a chatmode
			local count = 0
			if not Util.IsTouchDevice() then
				this.FocusChatBarInputBeganConn = Util.DisconnectEvent(this.FocusChatBarInputBeganConn)
				this.FocusChatBarInputBeganConn = InputService.InputBegan:connect(function(inputObj)
					if inputObj.KeyCode == Enum.KeyCode.Backspace and this:GetChatBarText() == "" then
						if count == 0 then
							count = count + 1
						else
							this:SetMessageMode('All')
						end
					else
						count = 0
					end
				end)
			end

			this.ChatBarFocusLostConn = this.ChatBar.FocusLost:connect(function(...)
				count = 0
				this.unfocusedAt = tick()
				this.ChatBarLostFocusEvent:fire(...)
			end)
			this.ChatBarChangedConn = this.ChatBar.Changed:connect(function(prop)
				if prop == "Text" then
					this:OnChatBarTextChanged()
				elseif prop == 'TextFits' or prop == 'TextBounds' or prop == 'Visible' then
					this:OnChatBarBoundsChanged()
				end
			end)
		end

		if this.ChatBarLostFocusEvent then this.ChatBarLostFocusConn = this.ChatBarLostFocusEvent:connect(function(...) this:OnChatBarFocusLost(...) end) end

		this.SelectChatModeConn = SelectChatModeEvent:connect(function(chatType)
			this:SetMessageMode(chatType)
			this:FocusChatBar()
		end)

		this.SelectPlayerConn = SelectPlayerEvent:connect(function(chatPlayer)
			this.TargetWhisperPlayer = chatPlayer
			this:SetMessageMode("Whisper")
			this:FocusChatBar()
		end)

		this.InputBeganConn = InputService.InputBegan:connect(function(inputObject)
			if inputObject.KeyCode == Enum.KeyCode.Escape then
				-- Clear text when they press escape
				this:SetChatBarText("")
			end
		end)
	end

	function this:CalculateVisibility()
		if this.ChatBarContainer then
			local enabled = self.WidgetVisible and chatCoreGuiEnabled and not NON_CORESCRIPT_MODE
			if enabled then
				HookUpEvents()
			else
				TearDownEvents()
			end
			this.ChatBarContainer.Visible = enabled and self.FadedIn and (not chatBarDisabled)
		end
	end

	function this:ToggleVisibility(visible)
		if visible ~= self.WidgetVisible then
			self.WidgetVisible = visible
			self:CalculateVisibility()
		end
		if NON_CORESCRIPT_MODE or chatBarDisabled then
			this.ChatBarContainer.Visible = false
		end
	end

	function this:FadeIn()
		self.FadedIn = true
		self:CalculateVisibility()
	end

	function this:FadeOut()
		self.FadedIn = false
		self:CalculateVisibility()
	end

	function this:CoreGuiChanged(coreGuiType, enabled)
		if coreGuiType == Enum.CoreGuiType.Chat or coreGuiType == Enum.CoreGuiType.All then
			chatCoreGuiEnabled = enabled
			self:CalculateVisibility()
		end
	end

	function this:IsAChatMode(mode)
		return ChatModesDict[mode] ~= nil
	end

	function this:ProcessChatBarModes(requireWhitespaceAfterChatMode)
		local matchedAChatCommand = false
		if this.ChatBar then
			local chatBarText = this:SanitizeInput(this:GetChatBarText())
			for regexFunc, actionType in pairs(this.ChatMatchingRegex) do
				local start, finish, capture = regexFunc(chatBarText)
				if start and finish then
					-- The following line is for whether or not to try setting the chatmode as-you-type
					-- versus when you press enter.
					local whitespaceAfterSlashCommand = string.find(string.sub(chatBarText, finish+1, finish+1), "%s")
					if (not requireWhitespaceAfterChatMode and finish == #chatBarText) or whitespaceAfterSlashCommand then
						if this:IsAChatMode(actionType) then
							if actionType == "Whisper" then
								local targetPlayer = capture and Util.GetPlayerByName(capture)
								if targetPlayer then --and targetPlayer ~= Player then
									this.TargetWhisperPlayer = targetPlayer
									-- start from two over to eat the space or tab character after the slash command
									this:SetChatBarText(string.sub(chatBarText, finish + 2))
									this:SetMessageMode(actionType)
									this.ChatCommandEvent:fire(true, actionType, capture)
								else
									-- This is an indirect way of detecting if they used enter to close submit this chat
									if not requireWhitespaceAfterChatMode then
										this:SetChatBarText("")
										this.ChatCommandEvent:fire(false, actionType, capture)
									end
								end
							else
								-- start from two over to eat the space or tab character after the slash command
								this:SetChatBarText(string.sub(chatBarText, finish + 2))
								this:SetMessageMode(actionType)
								this.ChatCommandEvent:fire(true, actionType, capture)
							end
						elseif actionType == "Emote" then
							-- You can only emote to everyone.
							this:SetMessageMode('All')
						elseif not requireWhitespaceAfterChatMode then -- Some non-chat related command
							if actionType == "Help" then
								this:SetChatBarText("") -- Clear the chat so we don't send /? to everyone
							end
							this.ChatCommandEvent:fire(true, actionType, capture)
						end
						-- should we break here since we already matched a slash command or keep going?
						matchedAChatCommand = true
					end
				end
			end
		end
		return matchedAChatCommand
	end

	local previousText = ""
	function this:OnChatBarTextChanged()
		if not Util.IsTouchDevice() then
			local originalText = this:GetChatBarText()

			-- CaptureFocus() can cause the same "/" keypress that opened chat
			-- to be inserted into the TextBox. Remove only that one hotkey slash.
			if this.SuppressNextSlashCharacter then
				if string.sub(originalText, 1, 1) == "/" then
					this.SuppressNextSlashCharacter = false
					this:SetChatBarText(string.sub(originalText, 2))
					originalText = this:GetChatBarText()
				elseif originalText ~= "" then
					-- Some other character arrived first; don't suppress future slashes.
					this.SuppressNextSlashCharacter = false
				end
			end

			this:ProcessChatBarModes(true)
			originalText = this:GetChatBarText()
			local newText = Util.FilterUnprintableCharacters(originalText)
			if newText ~= originalText then
				previousText = newText
			end

			local fixedText = newText
			if #newText > this.Settings.MaxCharactersInMessage or originalText ~= newText then
				-- This is a hack to deal with the bug that holding down a key for repeated input doesn't trigger the textChanged event
				if #newText == #previousText + 1 then
					fixedText = string.sub(previousText, 1, this.Settings.MaxCharactersInMessage)
				else
					fixedText = string.sub(newText, 1, this.Settings.MaxCharactersInMessage)
				end
			end
			this:SetChatBarText(fixedText)
			previousText = fixedText
		end
	end

	function this:OnChatBarBoundsChanged()
		if this.ChatBarContainer and this.ChatBar then
			local currSize = this.ChatBarContainer.Size
			if this.ChatBar.Visible and not this.ChatBar.TextFits then
				local textBounds = Util.GetStringTextBounds(this.ChatBar.Text, this.ChatBar.Font, this.ChatBar.FontSize, UDim2.new(0, this.ChatBar.AbsoluteSize.X, 0, 1000))
				if textBounds.Y <= 36 then
					this.ChatBarContainer.Size = UDim2.new(currSize.X.Scale, currSize.X.Offset, currSize.Y.Scale, 58)
				else --if currSize.Y.Offset <= 54 then
					this.ChatBarContainer.Size = UDim2.new(currSize.X.Scale, currSize.X.Offset, currSize.Y.Scale, 76)
				end
			elseif this.ChatBar.Visible == false or this.ChatBar.TextBounds.Y <= 18 then
				if currSize.Y.Offset ~= 40 then
					this.ChatBarContainer.Size = UDim2.new(currSize.X.Scale, currSize.X.Offset, currSize.Y.Scale, 40)
				end
			elseif this.ChatBar.TextBounds.Y <= 36 then
				this.ChatBarContainer.Size = UDim2.new(currSize.X.Scale, currSize.X.Offset, currSize.Y.Scale, 58)
			end
		end
	end

	function this:GetChatBarText()
		return this.ChatBar and this.ChatBar.Text or ""
	end

	function this:SetChatBarText(newText)
		if this.ChatBar and newText ~= this.ChatBar.Text then
			this.ChatBar.Text = newText
		end
	end

	function this:GetMessageMode()
		return this.MessageMode
	end

	function this:SetMessageMode(newMessageMode)
		newMessageMode = ChatModesDict[newMessageMode]

		local chatRecipientText = "[" .. (this.TargetWhisperPlayer and this.TargetWhisperPlayer.Name or "") .. "]"
		if this.MessageMode ~= newMessageMode or (newMessageMode == 'Whisper' and this.ChatModeText and chatRecipientText ~= this.ChatModeText.Text) then
			if this.ChatModeText then
				this.MessageMode = newMessageMode
				if newMessageMode == 'Whisper' then
					local chatRecipientTextBounds = Util.GetStringTextBounds(chatRecipientText, this.ChatModeText.Font, this.ChatModeText.FontSize)

					this.ChatModeText.TextColor3 = this.Settings.WhisperTextColor
					this.ChatModeText.Text = chatRecipientText
					this.ChatModeText.Size = UDim2.new(0, chatRecipientTextBounds.X, 1, 0)
				elseif newMessageMode == 'Team' then
					local chatTeamText = '[Team]'
					local chatTeamTextBounds = Util.GetStringTextBounds(chatTeamText, this.ChatModeText.Font, this.ChatModeText.FontSize)

					this.ChatModeText.TextColor3 = this.Settings.TeamTextColor
					this.ChatModeText.Text = "[Team]"
					this.ChatModeText.Size = UDim2.new(0, chatTeamTextBounds.X, 1, 0)
				else
					this.ChatModeText.Text = ""
					this.ChatModeText.Size = UDim2.new(0, 0, 1, 0)
				end
				if this.ChatBar then
					local offset = this.ChatModeText.Size.X.Offset + this.ChatModeText.Position.X.Offset
					this.ChatBar.Size = UDim2.new(1, -14 - offset, 1, 0)
					this.ChatBar.Position = UDim2.new(0, 7 + offset, 0, 0)
				end
			end
		end
	end

	function this:FocusChatBar()
		if this.ChatBar and not chatBarDisabled then
			-- The idle chat bar is hidden. Bring it back only when the user starts chatting.
			self:FadeIn()
			this.ChatBar.Visible = true
			this.ChatBar:CaptureFocus()
			if self.ClickToChatButton then
				self.ClickToChatButton.Visible = false
			end
			if this.ChatModeText then
				this.ChatModeText.Visible = true
			end
			if Util.IsTouchDevice() or InputService.VREnabled then
				this:SetMessageMode('All') -- Don't remember message mode on mobile devices or VR
			end
			-- Update chatbar properties when chatbar is focused
			this:OnChatBarBoundsChanged()
			if this.ChatBarContainer then
				if self.ChatBarInnerBackground then
					self.ChatBarInnerBackground.BackgroundTransparency = 0
				end
			end
			this.ChatBarGainedFocusEvent:fire()
		end
	end

	function this:RemoveFocus()
		if self:IsFocused() then
			self.ChatBar:ReleaseFocus()
		end
	end

	function this:IsFocused()
		return self.ChatBar and self.ChatBar == InputService:GetFocusedTextBox()
	end

	function this:WasFocused()
		return (tick() - this.unfocusedAt) < VR_CHAT_CLICK_DEBOUNCE
	end

	function this:SanitizeInput(input)
		local sanitizedInput = input
		-- Chomp the whitespace at the front and end of the string
		-- TODO: maybe only chop off the front space if there are more than a few?
		local _, _, capture = string.find(sanitizedInput, "^%s*(.*)%s*$")
		sanitizedInput = capture or ""

		return sanitizedInput
	end


	local sentMessageTimeQueue = {}
	function this:FloodCheck()
		if not GetLuaChatFilteringFlag() then
			return false
		end

		while sentMessageTimeQueue[1] and tick() - sentMessageTimeQueue[1] > FLOOD_CHECK_MESSAGE_INTERVAL do
			table.remove(sentMessageTimeQueue, 1)
		end
		if #sentMessageTimeQueue > FLOOD_CHECK_MESSAGE_COUNT then
			return true
		end
		return false
	end

	function this:OnChatBarFocusLost(enterPressed)
		if self.ChatBar then
			self.ChatBar.Visible = false
			-- TODO: remove this when API for VR to set enterPressed is released
			if enterPressed or InputService.VREnabled then
				local didMatchSlashCommand = self:ProcessChatBarModes(false)
				local cText = self:SanitizeInput(self:GetChatBarText())
				if cText ~= "" then
					if self:FloodCheck() then -- and not didMatchSlashCommand then
						self.ChatBarFloodEvent:fire()
					else
						-- For now we will let any slash command go through, NOTE: these will show up in bubble-chat
						--if not didMatchSlashCommand and string.sub(cText,1,1) == "/" then
						--	self.ChatCommandEvent:fire(false, "Unknown", cText)
						--else
						local currentMessageMode = self:GetMessageMode()
						-- {All, Team, Whisper}
						if currentMessageMode == 'Team' then
							if Player and Player.Neutral == true then
								self.ChatErrorEvent:fire("You're not on a team.")
							else
								--pcall(function() PlayersService:TeamChat(cText) end)
							end
						elseif currentMessageMode == 'Whisper' then
							if self.TargetWhisperPlayer then
								if self.TargetWhisperPlayer == Player then
									self.ChatErrorEvent:fire("You cannot send a whisper to yourself.")
								else
									--pcall(function() PlayersService:WhisperChat(cText, self.TargetWhisperPlayer) end)
								end
							else
								self.ChatErrorEvent:fire("Invalid whisper target.")
							end
						elseif currentMessageMode == 'All' then
							--pcall(function() PlayersService:Chat(cText) end)
							spawn(function()
								RBXGeneral:SendAsync(cText)
							end)
						else
							spawn(function() error("ChatScript: Unknown Message Mode of " .. tostring(currentMessageMode)) end)
						end
						table.insert(sentMessageTimeQueue, tick())
						--end
						self:SetChatBarText("")
					end
				end
			end
		end
		if self.ClickToChatButton then
			self.ClickToChatButton.Visible = true
			-- Fade-back in the text so it doesn't abruptly appear
			-- Normally I would like to cancel the old tween but it is so short that it doesn't matter
			self.ClickToChatButton.TextTransparency = 1
			Util.PropertyTweener(self.ClickToChatButton, 'TextTransparency', 1, 0, 0.25, Util.Linear)
		end
		if self.ChatModeText then
			self.ChatModeText.Visible = false
		end
		if this.ChatBarContainer then
			local currSize = this.ChatBarContainer.Size
			this.ChatBarContainer.Size = UDim2.new(currSize.X.Scale, currSize.X.Offset, currSize.Y.Scale, 32)
			if self.ChatBarInnerBackground then
				self.ChatBarInnerBackground.BackgroundTransparency = 0.5
			end
		end
		this.ChatBarChangedConn = Util.DisconnectEvent(this.ChatBarChangedConn)
		this.FocusChatBarInputBeganConn = Util.DisconnectEvent(this.FocusChatBarInputBeganConn)
	end

	local function CreateChatBar()
		local chatBarContainer = Util.Create'Frame'
		{
			Name = 'ChatBarContainer';
			Position = UDim2.new(0, 0, 1, 0);
			Size = UDim2.new(1, 0, 0, 20);
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 0.25;
			BorderSizePixel = 0;
		};
		chatBarContainer.BackgroundColor3 = Color3.new(31/255, 31/255, 31/255);
		chatBarContainer.BackgroundTransparency = 0.5;
		local chatBarInnerBackground = Util.Create'Frame'
		{
			Name = 'InnerBackground';
			Position = UDim2.new(0, 7, 0, 5);
			Size = UDim2.new(1, -14, 1, -10);
			ZIndex = 1;
			BackgroundColor3 = Color3.new(209/255, 216/255, 221/255);
			BackgroundTransparency = 0.5;
			BorderSizePixel = 0;
		};
		local clickToChatButton = Util.Create'TextButton'
		{
			Name = 'ClickToChat';
			Position = UDim2.new(0,9,0,0);
			Size = UDim2.new(1, -9, 1, 0);
			BackgroundTransparency = 1;
			AutoButtonColor = false;
			ZIndex = 3;
			Text = 'To chat click here or press "/" key';
			TextColor3 = this.Settings.GlobalTextColor;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			Font = Enum.Font.SourceSansBold;
			FontSize = Enum.FontSize.Size18;
			Parent = chatBarContainer;
		}
		clickToChatButton.TextWrapped = true;
		clickToChatButton.Position = UDim2.new(0, 7, 0, 0);
		clickToChatButton.Size = UDim2.new(1, -14, 1, 0);
		clickToChatButton.TextYAlignment = Enum.TextYAlignment.Center;
		if Util.IsTouchDevice() then
			clickToChatButton.Text = "Tap here to chat"
		end

		local chatBar = Util.Create'TextBox'
		{
			Name = 'ChatBar';
			Position = UDim2.new(0, 9, 0, 0);
			Size = UDim2.new(1, -9, 1, 0);
			Text = "";
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			Active = false;
			BackgroundTransparency = 1;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			TextColor3 = this.Settings.GlobalTextColor;
			Font = Enum.Font.SourceSansBold;
			FontSize = Enum.FontSize.Size18;
			ClearTextOnFocus = false;
			Visible = not Util.IsTouchDevice();
			Parent = chatBarContainer;
			SelectionImageObject = emptySelectionImage;
		}
		chatBar.TextWrapped = true;
		chatBar.Position = UDim2.new(0, 7, 0, 0);
		chatBar.Size = UDim2.new(1, -14, 1, 0);
		chatBar.TextYAlignment = Enum.TextYAlignment.Center;
		chatBar.Visible = false;

		local chatModeText = Util.Create'TextButton'
		{
			Name = 'ChatModeText';
			Position = UDim2.new(0, 9, 0, 0);
			Size = UDim2.new(1, -9, 1, 0);
			AutoButtonColor = false;
			BackgroundTransparency = 1;
			ZIndex = 2;
			Text = '';
			TextColor3 = this.Settings.WhisperTextColor;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			Font = Enum.Font.SourceSansBold;
			FontSize = Enum.FontSize.Size18;
			Parent = chatBarContainer;
		}
		chatModeText.Position = UDim2.new(0, 7, 0, 0);
		chatModeText.Size = UDim2.new(1, -14, 1, 0);
		chatModeText.TextYAlignment = Enum.TextYAlignment.Center;
		-- Create grey background for text
		chatBarInnerBackground.Parent = chatBarContainer;
		clickToChatButton.Parent = chatBarInnerBackground;
		chatBar.Parent = chatBarInnerBackground;
		chatModeText.Parent = chatBarInnerBackground;

		this.ChatBarContainer = chatBarContainer
		this.ChatBarInnerBackground = chatBarInnerBackground
		this.ClickToChatButton = clickToChatButton
		this.ChatBar = chatBar
		this.ChatModeText = chatModeText
		this.ChatBarContainer.Parent = GuiRoot

		local function RobloxClientScreenSizeChanged(newSize)
			if chatBarContainer then
				local chatbarVisible = this.ChatBar and this.ChatBar.Visible
				local bubbleChatIsOn = not PlayersService.ClassicChat and PlayersService.BubbleChat
				-- Phone
				if newSize.X <= PHONE_SCREEN_WIDTH then
					chatBarContainer.Size = UDim2.new(0.5, 0,0, chatbarVisible and 40 or 32)
					if bubbleChatIsOn then
						chatBarContainer.Position = UDim2.new(0, 0, 0, 2)
					else
						chatBarContainer.Position = UDim2.new(0, 0, 0.5, 2)
					end
					-- Tablet
				elseif newSize.X <= TABLET_SCREEN_WIDTH then
					chatBarContainer.Size = UDim2.new(0.4, 0,0, chatbarVisible and 40 or 32)
					if bubbleChatIsOn then
						chatBarContainer.Position = UDim2.new(0, 0, 0, 2)
					else
						chatBarContainer.Position = UDim2.new(0, 0, 0.3, 2)
					end
					-- Desktop
				else
					chatBarContainer.Size = UDim2.new(0.3, 0,0, chatbarVisible and 40 or 32)
					if bubbleChatIsOn then
						chatBarContainer.Position = UDim2.new(0, 0, 0, 2)
					else
						chatBarContainer.Position = UDim2.new(0,0,0.25, 2)
					end
				end

				if Util.IsTouchDevice() or InputService.VREnabled then
					-- Hide the chatbar on mobile and in VR so they can't see it.
					chatBarContainer.Position = UDim2.new(0,0,1,20);
				end
			end
		end

		GuiRoot.Changed:connect(function(prop) if prop == "AbsoluteSize" and not chatRepositioned then RobloxClientScreenSizeChanged(GuiRoot.AbsoluteSize) end end)
		RobloxClientScreenSizeChanged(GuiRoot.AbsoluteSize)
	end


	CreateChatBar()
	return this
end

local function CreateChatWindowWidget(settings)
	local this = {}
	this.Settings = settings
	this.Chats = {}
	this.BackgroundVisible = false
	this.ChatsVisible = false
	this.WidgetVisible = false
	this.NewUnreadMessage = false
	this.MessageCount = 0

	this.MessageCountChanged = Util.Signal()
	this.FadeInSignal = Util.Signal()
	this.FadeOutSignal = Util.Signal()

	this.ChatWindowPagingConn = nil

	local lastMoveTime = tick()
	local lastEnterTime = tick()
	local lastLeaveTime = tick()

	local lastFadeOutTime = 0
	local lastFadeInTime = 0
	local lastChatActivity = 0

	local FadeLock = false

	local chatCoreGuiEnabled = true

	local function PointInChatWindow(pt)
		local point0 = this.ChatContainer.AbsolutePosition
		local point1 = point0 + this.ChatContainer.AbsoluteSize
		-- HACK, this is so the "ChatWindow" includes the chatbar box, TODO: refactor the fadeing code to include the chatbar
		point1 = point1 + Vector2.new(0, 34)
		return point0.X <= pt.X and point1.X >= pt.X and
			point0.Y <= pt.Y and point1.Y >= pt.Y
	end

	function this:IsHovering()
		if this.ChatContainer and this.LastMousePosition and self:CalculateVisibility() then
			return PointInChatWindow(this.LastMousePosition)
		end
		return false
	end

	function this:SetFadeLock(lock)
		FadeLock = lock
	end

	function this:GetFadeLock()
		return FadeLock
	end

	function this:SetCanvasPosition(newCanvasPosition)
		if this.ScrollingFrame then
			local maxSize = Vector2.new(math.max(0, this.ScrollingFrame.CanvasSize.X.Offset - this.ScrollingFrame.AbsoluteWindowSize.X),
				math.max(0, this.ScrollingFrame.CanvasSize.Y.Offset - this.ScrollingFrame.AbsoluteWindowSize.Y))
			this.ScrollingFrame.CanvasPosition = Vector2.new(Util.Clamp(0, maxSize.X, newCanvasPosition.X),
				Util.Clamp(0, maxSize.Y, newCanvasPosition.Y))
		end
	end

	function this:ScrollToBottom()
		if this.ScrollingFrame then
			this:SetCanvasPosition(Vector2.new(this.ScrollingFrame.CanvasPosition.X, this.ScrollingFrame.CanvasSize.Y.Offset))
		end
	end

	function this:FadeIn(duration, lockFade)
		if not FadeLock then
			duration = duration or 0.75
			local backgroundTransparency = InputService.VREnabled and 1 or 0.5
			-- fade in
			if this.BackgroundTweener then
				this.BackgroundTweener:Cancel()
			end
			lastFadeInTime = tick()
			lastChatActivity = tick()
			this.ScrollingFrame.ScrollingEnabled = true
			this.ScrollingFrame.ScrollBarThickness = SCROLLBAR_THICKNESS
			this.BackgroundTweener = Util.PropertyTweener(this.ChatContainer, 'BackgroundTransparency', this.ChatContainer.BackgroundTransparency, backgroundTransparency, duration, Util.Linear)
			this.BackgroundVisible = true
			this:FadeInChats()

			this.ChatWindowPagingConn = Util.DisconnectEvent(this.ChatWindowPagingConn)
			this.ChatWindowPagingConn = InputService.InputBegan:connect(function(inputObject)
				local key = inputObject.KeyCode
				if key == Enum.KeyCode.PageUp then
					this:SetCanvasPosition(this.ScrollingFrame.CanvasPosition - Vector2.new(0, this.ScrollingFrame.AbsoluteWindowSize.Y))
				elseif key == Enum.KeyCode.PageDown then
					this:SetCanvasPosition(this.ScrollingFrame.CanvasPosition + Vector2.new(0, this.ScrollingFrame.AbsoluteWindowSize.Y))
				elseif key == Enum.KeyCode.Home then
					this:SetCanvasPosition(Vector2.new(0, 0))
				elseif key == Enum.KeyCode.End then
					this:ScrollToBottom()
				end
			end)
			if this.FadeInSignal then
				this.FadeInSignal:fire()
			end
		end
	end

	function this:FadeOut(duration, unlockFade)
		if not FadeLock then
			duration = duration or 0.75
			-- fade out
			if this.BackgroundTweener then
				this.BackgroundTweener:Cancel()
			end
			lastFadeOutTime = tick()
			lastChatActivity = tick()
			this.ScrollingFrame.ScrollingEnabled = false
			this.ScrollingFrame.ScrollBarThickness = 0
			this.BackgroundTweener = Util.PropertyTweener(this.ChatContainer, 'BackgroundTransparency', this.ChatContainer.BackgroundTransparency, 1, duration, Util.Linear)
			this.BackgroundVisible = false

			this.ChatWindowPagingConn = Util.DisconnectEvent(this.ChatWindowPagingConn)
			if this.FadeOutSignal then
				this.FadeOutSignal:fire()
			end
		end
	end

	function this:FadeInChats()
		if this.ChatsVisible == true then return end
		this.ChatsVisible = true
		for index, message in pairs(this.Chats) do
			message:FadeIn()
		end
	end

	function this:FadeOutChats()
		if InputService.VREnabled then return end
		if this.ChatsVisible == false then return end
		this.ChatsVisible = false
		if IsPlayerDropDownEnabled and playerDropDown then
			playerDropDown:Hide()
		end
		for index, message in pairs(this.Chats) do
			local messageGui = message:GetGui()
			local instant = false
			if messageGui and this.ScrollingFrame then
				-- If the chat is not in the visible frame then don't waste cpu cycles fading it out
				if messageGui.AbsolutePosition.Y > (this.ScrollingFrame.AbsolutePosition + this.ScrollingFrame.AbsoluteWindowSize).Y or
					messageGui.AbsolutePosition.Y + messageGui.AbsoluteSize.Y < this.ScrollingFrame.AbsolutePosition.Y then
					instant = true
				end
			end
			message:FadeOut(instant)
		end
	end

	local ResizeCount = 0
	function this:OnResize()
		ResizeCount = ResizeCount + 1
		local currentResizeCount = ResizeCount
		local isScrolledDown = this:IsScrolledDown()
		-- Unfortunately there is a race condition so we need this wait here.
		wait()
		if this.ScrollingFrame then
			if currentResizeCount ~= ResizeCount then return end
			local scrollingFrameAbsoluteSize = this.ScrollingFrame.AbsoluteWindowSize
			if scrollingFrameAbsoluteSize ~= nil and scrollingFrameAbsoluteSize.X > 0 and scrollingFrameAbsoluteSize.Y > 0 then
				local ySize = 0

				if this.ScrollingFrame then
					for _, message in pairs(this.Chats) do
						local newHeight = message:OnResize(scrollingFrameAbsoluteSize)
						if newHeight then
							local chatMessageElement = message:GetGui()
							if chatMessageElement then
								local chatMessageElementYSize = chatMessageElement.Size.Y.Offset
								chatMessageElement.Position = UDim2.new(0, 0, 0, ySize)
								ySize = ySize + chatMessageElementYSize
							end
						end
					end
				end
				if this.MessageContainer and this.ScrollingFrame then
					this.MessageContainer.Size = UDim2.new(
						this.MessageContainer.Size.X.Scale,
						this.MessageContainer.Size.X.Offset,
						0,
						ySize)
					this.MessageContainer.Position = UDim2.new(0, 0, 1, -this.MessageContainer.Size.Y.Offset)
					this.ScrollingFrame.CanvasSize = UDim2.new(this.ScrollingFrame.CanvasSize.X.Scale, this.ScrollingFrame.CanvasSize.X.Offset, this.ScrollingFrame.CanvasSize.Y.Scale, ySize)
				end
			end
			this:ScrollToBottom()
		end
	end

	function this:FilterMessage(playerChatType, sendingPlayer, chattedMessage, receivingPlayer)
		if chattedMessage and string.sub(chattedMessage, 1, 1) ~= '/' then
			return true
		end
		return false
	end

	function this:PushMessageIntoQueue(chatMessage, silently)
		table.insert(this.Chats, chatMessage)

		local isScrolledDown = this:IsScrolledDown()

		local chatMessageElement = chatMessage:GetGui()

		chatMessageElement.Parent = this.MessageContainer
		local chatMessageHeight = chatMessage:OnResize() or 10
		local ySize = this.MessageContainer.Size.Y.Offset
		local chatMessageElementYSize = UDim2.new(0, 0, 0, chatMessageHeight)

		if not silently then
			this.MessageCount = this.MessageCount + 1
		end

		chatMessageElement.Position = chatMessageElement.Position + UDim2.new(0, 0, 0, ySize)
		this.MessageContainer.Size = this.MessageContainer.Size + chatMessageElementYSize
		this.ScrollingFrame.CanvasSize = this.ScrollingFrame.CanvasSize + chatMessageElementYSize

		if this.Settings.MaxWindowChatMessages < #this.Chats then
			this:RemoveOldestMessage()
		end
		if isScrolledDown then
			this:ScrollToBottom()
		elseif not silently then
			-- Raise unread message alert!
			this.NewUnreadMessage = true
		end

		if silently then
			if this.ChatsVisible == false then
				chatMessage:FadeOut(true)
			end
		else
			this:FadeInChats()
			lastChatActivity = tick()
			this.MessageCountChanged:fire(this.MessageCount)
		end

		-- NOTE: Sort of hacky, but if we are approaching the max 16 bit size
		-- we need to rebase y back to 0 which can be done with the resize function
		if ySize > (MAX_UDIM_SIZE / 2) then
			self:OnResize()
		end
	end

	function this:AddSystemChatMessage(chattedMessage, silently)
		local chatMessage = CreateSystemChatMessage(this.Settings, chattedMessage)
		this:PushMessageIntoQueue(chatMessage, silently)
	end

	local function checkEnum(enumItems, value)
		for _, enum in pairs(enumItems) do
			if enum.Value == value then
				return enum
			end
		end
		return nil
	end

	-- We only need to copy the top level for the settings table
	local function shallowCopy(tableToCopy)
		local newTable = {}
		for key, value in pairs(tableToCopy) do
			newTable[key] = value
		end
		return newTable
	end

	function this:AddDeveloperSystemChatMessage(informationTable)
		local settings = shallowCopy(this.Settings)

		if informationTable["Text"] and type(informationTable["Text"]) == "string" then
			if informationTable["Color"] and pcall(function() Color3.new(informationTable["Color"].r, informationTable["Color"].g, informationTable["Color"].b) end) then
				settings.DefaultMessageTextColor = informationTable["Color"]
			end
			if informationTable["Font"] then
				local success, value = pcall(function() return checkEnum(Enum.Font:GetEnumItems(), informationTable["Font"].Value) end)
				if success and value ~= nil then
					settings.Font = value
				end
			end
			if informationTable["FontSize"] then
				local success, value = pcall(function() return checkEnum(Enum.FontSize:GetEnumItems(), informationTable["FontSize"].Value) end)
				if success and value ~= nil then
					settings.FontSize = value
				end
			end
			local chatMessage = CreateSystemChatMessage(settings, informationTable["Text"])
			this:PushMessageIntoQueue(chatMessage, false)
		end
	end

	function this:AddChatMessage(playerChatType, sendingPlayer, chattedMessage, receivingPlayer, silently)
		local fixedChattedMessage = Util.FilterUnprintableCharacters(chattedMessage)
		if this:FilterMessage(playerChatType, sendingPlayer, fixedChattedMessage, receivingPlayer) then
			local chatMessage = CreatePlayerChatMessage(this.Settings, playerChatType, sendingPlayer, fixedChattedMessage, receivingPlayer)
			this:PushMessageIntoQueue(chatMessage, silently)
		end
	end

	function this:RemoveOldestMessage()
		local oldestChat = this.Chats[1]
		if oldestChat then
			return this:RemoveChatMessage(oldestChat)
		end
	end

	function this:RemoveChatMessage(chatMessage)
		if chatMessage then
			for index, message in pairs(this.Chats) do
				if chatMessage == message then
					local guiObj = chatMessage:GetGui()
					if guiObj then
						local ySize = guiObj.Size.Y.Offset
						this.ScrollingFrame.CanvasSize = this.ScrollingFrame.CanvasSize - UDim2.new(0,0,0,ySize)
						-- Clamp the canvasposition
						this:SetCanvasPosition(this.ScrollingFrame.CanvasPosition)
						guiObj.Parent = nil
					end
					message:Destroy()
					return table.remove(this.Chats, index)
				end
			end
		end
	end

	function this:IsScrolledDown()
		if this.ScrollingFrame then
			local yCanvasSize = this.ScrollingFrame.CanvasSize.Y.Offset
			local yContainerSize = this.ScrollingFrame.AbsoluteWindowSize.Y
			local yScrolledPosition = this.ScrollingFrame.CanvasPosition.Y
			-- Check if the messages are at the bottom
			return yCanvasSize < yContainerSize or
				yCanvasSize - yScrolledPosition <= yContainerSize + 5 -- a little wiggle room
		end
		return false
	end

	function this:GetMessageCount()
		return this.MessageCount
	end

	function this:CalculateVisibility()
		return this.WidgetVisible and ((chatCoreGuiEnabled and PlayersService.ClassicChat) or NON_CORESCRIPT_MODE)
	end

	function this:ToggleVisibility(visible)
		if visible ~= self.WidgetVisible then
			self.WidgetVisible = visible
			if this.ChatContainer then
				this.ChatContainer.Visible = self:CalculateVisibility()
			end
		end
		if NON_CORESCRIPT_MODE then
			this.ChatContainer.Visible = true
		end
	end

	function this:CoreGuiChanged(coreGuiType, enabled)
		if coreGuiType == Enum.CoreGuiType.Chat or coreGuiType == Enum.CoreGuiType.All then
			chatCoreGuiEnabled = enabled
			if this.ChatContainer then
				this.ChatContainer.Visible = self:CalculateVisibility()
			end
		end
	end

	local function CreateChatWindow()
		local container = Util.Create'TextButton'
		{
			Name = 'ChatWindowContainer';
			Size = UDim2.new(0.3, 0, 0.25, 0);
			Position = UDim2.new(0, 8, 0, 37);
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 1;
			BorderSizePixel = 0;
			Text = "";
			SelectionImageObject = emptySelectionImage;
		};
		container.Position = UDim2.new(0,0,0,37);
		container.BackgroundColor3 = Color3.new(31/255, 31/255, 31/255);
		local scrollingFrame = Util.Create'ScrollingFrame'
		{
			Name = 'ChatWindow';
			Size = UDim2.new(1, -4 - 10, 1, -20);
			CanvasSize = UDim2.new(1, -4 - 10, 0, 0);
			Position = UDim2.new(0, 10, 0, 10);
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 1;
			BottomImage = "rbxasset://textures/ui/scroll-bottom.png";
			MidImage = "rbxasset://textures/ui/scroll-middle.png";
			TopImage = "rbxasset://textures/ui/scroll-top.png";
			ScrollBarThickness = 0;
			BorderSizePixel = 0;
			ScrollingEnabled = false;
			Parent = container;
		};
		local messageContainer = Util.Create'Frame'
		{
			Name = 'MessageContainer';
			Size = UDim2.new(1, -SCROLLBAR_THICKNESS - 1, 0, 0);
			Position = UDim2.new(0, 0, 1, 0);
			ZIndex = 1;
			BackgroundColor3 = Color3.new(0, 0, 0);
			BackgroundTransparency = 1;
			Parent = scrollingFrame
		};

		-- This is some trickery we are doing to make the first chat messages appear at the bottom and go towards the top.
		local function OnChatWindowResize(prop)
			if prop == 'AbsoluteSize' then
				messageContainer.Position = UDim2.new(0, 0, 1, -messageContainer.Size.Y.Offset)
			end
			if prop == 'CanvasPosition' then
				if this.ScrollingFrame then
					if this:IsScrolledDown() then
						this.NewUnreadMessage = false
					end
				end
			end
		end
		container.Changed:connect(function(prop) if prop == 'AbsoluteSize' then this:OnResize() end end)

		local function RobloxClientScreenSizeChanged(newSize)
			if container then
				container.Position = UDim2.new(0,0,0,2);
				if InputService.VREnabled then
					container.Size = UDim2.new(1,0,1,0)
					-- Phone
				elseif newSize.X <= 640 then
					container.Size = UDim2.new(0.5,0,0.5,0) - container.Position
					-- Tablet
				elseif newSize.X <= 1024 then
					container.Size = UDim2.new(0.4,0,0.3,0) - container.Position
					-- Desktop
				else
					container.Size = UDim2.new(0.3,0,0.25,0) - container.Position
				end
			end
		end

		GuiRoot.Changed:connect(function(prop) if prop == "AbsoluteSize" and not chatRepositioned then RobloxClientScreenSizeChanged(GuiRoot.AbsoluteSize) end end)
		RobloxClientScreenSizeChanged(GuiRoot.AbsoluteSize)

		messageContainer.Changed:connect(OnChatWindowResize)
		scrollingFrame.Changed:connect(OnChatWindowResize)

		this.ChatContainer = container
		this.ScrollingFrame = scrollingFrame
		this.MessageContainer = messageContainer
		this.ChatContainer.Parent = GuiRoot


		-- It is important to set this to true in NON_CORESCRIPT_MODE because normally the topbar sets
		-- the chat window to visible
		if NON_CORESCRIPT_MODE then
			this:ToggleVisibility(true)
		end

		--- BACKGROUND FADING CODE ---
		-- This is so we don't accidentally fade out when we are scrolling and mess with the scrollbar.
		local dontFadeOutOnMouseLeave = false

		if Util:IsTouchDevice() then
			local touchCount = 0
			this.InputBeganConn = InputService.InputBegan:connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.Touch and inputObject.UserInputState == Enum.UserInputState.Begin then
					if PointInChatWindow(Vector2.new(inputObject.Position.X, inputObject.Position.Y)) then
						touchCount = touchCount + 1
						dontFadeOutOnMouseLeave = true
					end
				end
			end)

			this.InputEndedConn = InputService.InputEnded:connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.Touch and inputObject.UserInputState == Enum.UserInputState.End then
					local endedCount = touchCount
					wait(2)
					if touchCount == endedCount then
						dontFadeOutOnMouseLeave = false
					end
				end
			end)

			spawn(function()
				local now = tick()
				while true do
					wait()
					now = tick()
					if this.BackgroundVisible then
						if not dontFadeOutOnMouseLeave then
							this:FadeOut(0.25)
						end
						-- If background is not visible/in-focus
					elseif this.ChatsVisible and now > lastChatActivity + MESSAGES_FADE_OUT_TIME then
						this:FadeOutChats()
					end
				end
			end)
		else
			this.LastMousePosition = Vector2.new()

			this.MouseEnterFrameConn = this.ChatContainer.MouseEnter:connect(function()
				lastEnterTime = tick()
				if this.BackgroundTweener and not this.BackgroundTweener:IsFinished() and not this.BackgroundVisible then
					this:FadeIn()
				end
			end)

			this.MouseMoveConn = InputService.InputChanged:connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
					lastMoveTime = tick()
					this.LastMousePosition = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
					if this.BackgroundTweener and this.BackgroundTweener:GetPercentComplete() < 0.5 and this.BackgroundVisible then
						if not dontFadeOutOnMouseLeave then
							this:FadeOut()
						end
					end
				end
			end)

			local clickCount = 0
			this.InputBeganConn = InputService.InputBegan:connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 and inputObject.UserInputState == Enum.UserInputState.Begin then
					if PointInChatWindow(Vector2.new(inputObject.Position.X, inputObject.Position.Y)) then
						clickCount = clickCount + 1
						dontFadeOutOnMouseLeave = true
					end
				end
			end)

			this.InputEndedConn = InputService.InputEnded:connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 and inputObject.UserInputState == Enum.UserInputState.End then
					local nowCount = clickCount
					wait(1.3)
					if nowCount == clickCount then
						dontFadeOutOnMouseLeave = false
					end
				end
			end)

			this.MouseLeaveFrameConn = this.ChatContainer.MouseLeave:connect(function()
				lastLeaveTime = tick()
				if this.BackgroundTweener and not this.BackgroundTweener:IsFinished() and this.BackgroundVisible then
					if not dontFadeOutOnMouseLeave then
						this:FadeOut()
					end
				end
			end)

			spawn(function()
				while true do
					wait()
					local now = tick()
					if this:IsHovering() then
						if now - lastMoveTime > 1.3 and not this.BackgroundVisible then
							this:FadeIn()
						end
					else -- not this:IsHovering()
						if this.BackgroundVisible then
							if not dontFadeOutOnMouseLeave then
								this:FadeOut(0.25)
							end
							-- If background is not visible/in-focus
						elseif this.ChatsVisible and now > lastChatActivity + MESSAGES_FADE_OUT_TIME then
							this:FadeOutChats()
						end
					end
				end
			end)
		end
		--- END OF BACKGROUND FADING CODE ---
	end

	CreateChatWindow()

	return this
end


local function CreateChat()
	local this = {}

	this.Settings =
		{
			GlobalTextColor = Color3.new(112/255, 110/255, 106/255);
			WhisperTextColor = Color3.new(77/255, 139/255, 255/255);
			TeamTextColor = Color3.new(230/255, 207/255, 0);
			DefaultMessageTextColor = Color3.new(255/255, 255/255, 243/255);
			AdminTextColor = Color3.new(1, 215/255, 0);
			TextStrokeTransparency = 0.75;
			TextStrokeColor = Color3.new(34/255,34/255,34/255);
			Font = Enum.Font.SourceSansBold;
			SmallScreenFontSize = Enum.FontSize.Size14;
			FontSize = Enum.FontSize.Size18;
			MaxWindowChatMessages = 50;
			MaxCharactersInMessage = 140;
		}

	this.CurrentWindowMessageCountChanged = nil
	this.VisibilityStateChanged = Util.Signal()
	this.ChatBarFocusChanged = Util.Signal()
	this.Visible = false

	function this:CoreGuiChanged(coreGuiType, enabled)
		enabled = true --enabled and (topbarEnabled or InputService.VREnabled)
		if coreGuiType == Enum.CoreGuiType.Chat or coreGuiType == Enum.CoreGuiType.All then
			if enabled then
				pcall(function()
					self.SpecialKeyPressedConn = Util.DisconnectEvent(self.SpecialKeyPressedConn)
					ContextActionService:UnbindAction("SlashToChat")

					ContextActionService:BindActionAtPriority(
						"SlashToChat",
						function(actionName, inputState, inputObject)
							if inputObject.KeyCode ~= Enum.KeyCode.Slash then
								return Enum.ContextActionResult.Pass
							end

							-- If chat is already focused, "/" is normal text.
							if self.ChatBarWidget and self.ChatBarWidget:IsFocused() then
								return Enum.ContextActionResult.Pass
							end

							if inputState == Enum.UserInputState.Begin then
								if self.ChatBarWidget then
									self.ChatBarWidget.SuppressNextSlashCharacter = true
									self.ChatBarWidget:FocusChatBar()
								end
							end

							-- Consume the hotkey while chat was not already focused.
							return Enum.ContextActionResult.Sink
						end,
						false,
						3000,
						Enum.KeyCode.Slash
					)
				end)
			else
				--pcall(function() GuiService:RemoveSpecialKey(Enum.SpecialKey.ChatHotkey) end)
				ContextActionService:UnbindAction("SlashToChat")
			end
			if this.MobileChatButton then
				if enabled == true then
					this.MobileChatButton.Parent = GuiRoot
					-- we need to set it to be visible in-case we missed a lost focus event while chat was turned off.
					this.MobileChatButton.Visible = true
				else
					this.MobileChatButton.Parent = nil
				end
			end
		end
		if this.ChatWindowWidget then
			this.ChatWindowWidget:CoreGuiChanged(coreGuiType, true)
		end
		if this.ChatBarWidget then
			this.ChatBarWidget:CoreGuiChanged(coreGuiType, true)
		end
	end

	-- This event has 4 callback arguments
	-- Enum.PlayerChatType.{All|Team|Whisper}, chatPlayer, message, targetPlayer
	function this:OnPlayerChatted(playerChatType, sendingPlayer, chattedMessage, receivingPlayer)
		if this.ChatWindowWidget then
			-- Don't add messages from blocked players, don't show message if is a debug command
			local isDebugCommand = false
			pcall(function()
				if sendingPlayer == PlayersService.LocalPlayer then
					--isDebugCommand = game:GetService("GuiService"):ShowStatsBasedOnInputString(chattedMessage)
				end
			end)
			if not (this:IsPlayerBlocked(sendingPlayer) or this:IsPlayerMuted(sendingPlayer) or isDebugCommand) then
				this.ChatWindowWidget:AddChatMessage(playerChatType, sendingPlayer, chattedMessage, receivingPlayer)
			end
		end
	end

	function this:OnPlayerAdded(newPlayer)
		if newPlayer then
			spawn(function() Util.IsPlayerAdminAsync(newPlayer) end)
		end
		--if NON_CORESCRIPT_MODE then
		--	newPlayer.Chatted:connect(function(msg, recipient)
		--		this:OnPlayerChatted(Enum.PlayerChatType.All, newPlayer, msg, recipient)
		--	end)
		--else
		--	this.PlayerChattedConn = Util.DisconnectEvent(this.PlayerChattedConn)
		--	this.PlayerChattedConn = PlayersService.PlayerChatted:connect(function(...)
		--		this:OnPlayerChatted(...)
		--	end)
		--end
	end

	function this:IsPlayerBlocked(player)
		return false
	end

	function this:BlockPlayerAsync(playerToBlock)
		--if playerToBlock and Player ~= playerToBlock then
		--	local blockUserId = playerToBlock.userId
		--	local playerToBlockName = playerToBlock.Name
		--	if blockUserId > 0 then
		--		if not this:IsPlayerBlocked(playerToBlock) then
		--			if blockingUtility then
		--				blockingUtility:BlockPlayerAsync(playerToBlock)
		--				this.ChatWindowWidget:AddSystemChatMessage(playerToBlockName .. " is now blocked.")
		--			end
		--		else
		--			this.ChatWindowWidget:AddSystemChatMessage(playerToBlockName .. " is already blocked.")
		--		end
		--	else
		--		this.ChatWindowWidget:AddSystemChatMessage("You cannot block guests.")
		--	end
		--else
		--	this.ChatWindowWidget:AddSystemChatMessage("You cannot block yourself.")
		--end
	end

	function this:UnblockPlayerAsync(playerToUnblock)
		--if playerToUnblock then
		--	local unblockUserId = playerToUnblock.userId
		--	local playerToUnblockName = playerToUnblock.Name

		--	if this:IsPlayerBlocked(playerToUnblock) then
		--		if blockingUtility then
		--			this.ChatWindowWidget:AddSystemChatMessage(playerToUnblockName .. " is no longer blocked.")
		--			blockingUtility:UnblockPlayerAsync(playerToUnblock)
		--		end
		--	else
		--		this.ChatWindowWidget:AddSystemChatMessage(playerToUnblockName .. " is not blocked.")
		--	end
		--end
	end

	function this:IsPlayerMuted(player)
		--if blockingUtility then
		--return player and blockingUtility:IsPlayerMutedByUserId(player.userId)
		--else
		return false
		--end
	end

	function this:MutePlayer(playerToMute)
		if playerToMute and playerToMute ~= Player then
			if playerToMute.UserId > 0 then
				if not this:IsPlayerMuted(playerToMute) then
					if blockingUtility then
						blockingUtility:MutePlayer(playerToMute)
						this.ChatWindowWidget:AddSystemChatMessage(playerToMute.Name .. " is now muted.")
					end
				else
					this.ChatWindowWidget:AddSystemChatMessage(playerToMute.Name .. " is already muted.")
				end
			else
				this.ChatWindowWidget:AddSystemChatMessage("You cannot mute guests.")
			end
		else
			this.ChatWindowWidget:AddSystemChatMessage("You cannot mute yourself.")
		end
	end

	function this:UnmutePlayer(playerToUnmute)
		if playerToUnmute then
			if this:IsPlayerMuted(playerToUnmute) then
				if blockingUtility then
					blockingUtility:UnmutePlayer(playerToUnmute)
					this.ChatWindowWidget:AddSystemChatMessage(playerToUnmute.Name .. " is no longer muted.")
				end
			else
				this.ChatWindowWidget:AddSystemChatMessage(playerToUnmute.Name .. " is not muted.")
			end
		end
	end

	function this:CreateTouchDeviceChatButton()
		return Util.Create'ImageButton'
		{
			Name = 'TouchDeviceChatButton';
			Size = UDim2.new(0, 128, 0, 32);
			Position = UDim2.new(0, 88, 0, 0);
			BackgroundTransparency = 1.0;
			Image = 'http://www.roblox.com/asset/?id=97078724';
		};
	end

	function this:PrintWelcome()
		if this.ChatWindowWidget then
			if Util.IsTouchDevice() then
				this.ChatWindowWidget:AddSystemChatMessage("Please press the '...' icon to chat", true)
			end
			this.ChatWindowWidget:AddSystemChatMessage("Please chat '/?' for a list of commands", true)
		end
	end

	local doOnceVRWelcome = false
	function this:PrintVRWelcome()
		if this.ChatWindowWidget and not doOnceVRWelcome then
			if InputService.VREnabled then
				this.ChatWindowWidget:AddSystemChatMessage("Press here to chat", true)
				doOnceVRWelcome = true
			end
		end
	end

	function this:PrintHelp()
		if this.ChatWindowWidget then
			this.ChatWindowWidget:AddSystemChatMessage("Help Menu")
			this.ChatWindowWidget:AddSystemChatMessage("Chat Commands:")
			this.ChatWindowWidget:AddSystemChatMessage("/w [PlayerName] or /whisper [PlayerName] - Whisper Chat")
			this.ChatWindowWidget:AddSystemChatMessage("/t or /team - Team Chat")
			this.ChatWindowWidget:AddSystemChatMessage("/a or /all - All Chat")

			this.ChatWindowWidget:AddSystemChatMessage("/block [PlayerName] - Block communications from Target Player")
			this.ChatWindowWidget:AddSystemChatMessage("/unblock [PlayerName] - Restore communications with Target Player")
			this.ChatWindowWidget:AddSystemChatMessage("/mute [PlayerName] - Mute in-game communications from Target Player")
			this.ChatWindowWidget:AddSystemChatMessage("/unmute [PlayerName] - Restore in-game communications with Target Player")
		end
	end

	local focusCount = 0
	function this:CreateGUI()
		if	FORCE_CHAT_GUI or true
			--game:GetService("UserInputService"):GetPlatform() ~= Enum.Platform.XBoxOne
		then
			if NON_CORESCRIPT_MODE then
				local chatGui = Instance.new("ScreenGui")
				chatGui.Name = "RobloxGui"
				chatGui.Parent = Player:WaitForChild('PlayerGui')
				GuiRoot.Parent = chatGui
			end

			-- NOTE: eventually we will make multiple chat window frames
			this.ChatWindowWidget = CreateChatWindowWidget(this.Settings)
			this.ChatBarWidget = CreateChatBarWidget(this.Settings)
			this.CurrentWindowMessageCountChanged = this.ChatWindowWidget.MessageCountChanged

			this.ChatWindowWidget.FadeInSignal:connect(function()
				this.ChatBarWidget:FadeIn()
			end)
			this.ChatWindowWidget.FadeOutSignal:connect(function()
				this.ChatBarWidget:FadeOut()
			end)

			this.ChatWindowWidget:FadeOut(0)
			this.ChatBarWidget.ChatBarGainedFocusEvent:connect(function()
				focusCount = focusCount + 1
				this.ChatWindowWidget:FadeIn(0.25)
				this.ChatWindowWidget:SetFadeLock(true)
				this.ChatBarFocusChanged:fire(true)
			end)
			this.ChatBarWidget.ChatBarLostFocusEvent:connect(function()
				local focusNow = focusCount
				if Util:IsTouchDevice() then
					delay(2, function()
						if focusNow == focusCount then
							this.ChatWindowWidget:SetFadeLock(false)
						end
					end)
				else
					this.ChatWindowWidget:SetFadeLock(false)
				end
				this.ChatBarFocusChanged:fire(false)
			end)
			this.ChatBarWidget.ChatBarFloodEvent:connect(function()
				if this.ChatWindowWidget then
					this.ChatWindowWidget:AddSystemChatMessage("Wait before sending another message.")
				end
			end)

			this.ChatBarWidget.ChatErrorEvent:connect(function(msg)
				if msg then
					this.ChatWindowWidget:AddSystemChatMessage(msg)
				end
			end)

			this.ChatBarWidget.ChatCommandEvent:connect(function(success, actionType, capture)
				if actionType == "Help" then
					this:PrintHelp()
				elseif actionType == "Block" then
					local blockPlayerName = capture and tostring(capture) or ""
					local playerToBlock = Util.GetPlayerByName(blockPlayerName)
					if playerToBlock then
						spawn(function() this:BlockPlayerAsync(playerToBlock) end)
					else
						this.ChatWindowWidget:AddSystemChatMessage("Cannot block " .. blockPlayerName .. " because they are not in the game.")
					end
				elseif actionType == "Unblock" then
					local unblockPlayerName = capture and tostring(capture) or ""
					local playerToBlock = Util.GetPlayerByName(unblockPlayerName)
					if playerToBlock then
						spawn(function() this:UnblockPlayerAsync(playerToBlock) end)
					else
						this.ChatWindowWidget:AddSystemChatMessage("Cannot unblock " .. unblockPlayerName .. " because they are not in the game.")
					end
				elseif actionType == "Mute" then
					local mutePlayerName = capture and tostring(capture) or ""
					local playerToMute = Util.GetPlayerByName(mutePlayerName)
					if playerToMute then
						this:MutePlayer(playerToMute)
					else
						this.ChatWindowWidget:AddSystemChatMessage("Cannot mute " .. mutePlayerName .. " because they are not in the game.")
					end
				elseif actionType == "Unmute" then
					local unmutePlayerName = capture and tostring(capture) or ""
					local playerToUnmute = Util.GetPlayerByName(unmutePlayerName)
					if playerToUnmute then
						this:UnmutePlayer(playerToUnmute)
					else
						this.ChatWindowWidget:AddSystemChatMessage("Cannot unmute " .. unmutePlayerName .. " because they are not in the game.")
					end
				elseif actionType == "Whisper" then
					if success == false then
						local playerName = capture and tostring(capture) or "Unknown"
						this.ChatWindowWidget:AddSystemChatMessage("Unable to Send a Whisper to Player: " .. playerName)
					end
				elseif actionType == "Unknown" then
					if success == false then
						local commandText = capture and tostring(capture) or "Unknown"
						this.ChatWindowWidget:AddSystemChatMessage("Invalid Slash Command: " .. commandText)
					end
				end
			end)

			if not NON_CORESCRIPT_MODE then
				local function onVREnabled()
					if InputService.VREnabled then
						self.Settings.TextStrokeTransparency = 1
						self:PrintVRWelcome()
						local Panel3D = require(CoreGuiService:WaitForChild('RobloxGui').Modules.VR.Panel3D)
						local panel = Panel3D.Get("Chat")
						panel:LinkTo("Keyboard")
						panel:SetType(Panel3D.Type.Fixed)
						panel:ResizePixels(300, 125)
						GuiRoot.Parent = panel:GetGUI()

						if this.ChatWindowWidget and this.ChatWindowWidget.ChatContainer then
							this.ChatWindowWidget.ChatContainer.MouseButton1Click:connect(function()
								if this.ChatBarWidget then
									if this.ChatBarWidget:WasFocused() then
										this.ChatBarWidget:RemoveFocus()
									else
										self:FocusChatBar()
									end
								end
							end)
						end

						function panel:CalculateTransparency()
							return 0
						end
					else
						self.Settings.TextStrokeTransparency = 0.75
						GuiRoot.Parent = CoreGuiService:WaitForChild('RobloxGui')
					end
				end
				onVREnabled()
				InputService.Changed:connect(function(prop)
					if prop == 'VREnabled' then
						onVREnabled()
					end
				end)
			end
		end
	end

	local toggleCount = 0
	local function SetVisbility(newVisibility, userInitiated)
		this.Visible = newVisibility
		if this.ChatWindowWidget then
			this.ChatWindowWidget:ToggleVisibility(this.Visible)

			-- SetVisible(true) is commonly called by the topbar during startup.
			-- Do NOT pop the whole chat panel open just because chat was enabled.
			-- Only animate the panel open when the user actually toggles it.
			if this.Visible and userInitiated then
				toggleCount = toggleCount + 1
				local thisToggle = toggleCount
				local thisFocusCount = focusCount
				this.ChatWindowWidget:FadeIn()
				this.ChatWindowWidget:SetFadeLock(true)
				delay(5, function()
					if thisToggle == toggleCount and thisFocusCount == focusCount then
						this.ChatWindowWidget:SetFadeLock(false)
					end
				end)
			elseif this.Visible then
				-- Enabled by the topbar/startup, but stay in message-only mode.
				-- This prevents the large empty panel from appearing on join.
				this.ChatWindowWidget:SetFadeLock(false)
				this.ChatWindowWidget:FadeOut(0)
			else
				this.ChatWindowWidget:SetFadeLock(false)
				this.ChatWindowWidget:FadeOut(0)
			end
		end

		if this.ChatBarWidget then
			this.ChatBarWidget:ToggleVisibility(this.Visible)
			if this.Visible and userInitiated then
				this.ChatBarWidget:FadeIn()
			elseif this.Visible then
				-- Hide the input bar while idle; pressing / or clicking chat brings it back.
				this.ChatBarWidget:FadeOut()
			end
			if InputService.VREnabled and not this.Visible then
				this.ChatBarWidget:RemoveFocus()
			end
		end
		if IsPlayerDropDownEnabled and playerDropDown then
			if not this.Visible then
				playerDropDown:Hide()
			end
		end
		if InputService.VREnabled then
			local Panel3D = require(CoreGuiService:WaitForChild('RobloxGui').Modules.VR.Panel3D)
			local panel = Panel3D.Get("Chat")
			if this.Visible then
				local headLook = Panel3D.GetHeadLookXZ(true)
				panel.localCF = headLook * CFrame.Angles(math.rad(5), 0, 0) * CFrame.new(0, 0, 6.5)
				panel:ForceShowUntilLookedAt()
			else
				panel:SetVisible(this.Visible)
			end
		end
		this.VisibilityStateChanged:fire(this.Visible)
	end

	function this:ToggleVisibility()
		SetVisbility(not self.Visible, true)
	end

	function this:SetVisible(visible)
		SetVisbility(visible, false)
	end

	function this:FocusChatBar()
		if self.ChatBarWidget and this.Visible then
			self.ChatBarWidget:FocusChatBar()
		end
	end

	function this:IsFocused(useWasFocused)
		if not self.ChatBarWidget then return false end
		return self.ChatBarWidget:IsFocused() or (useWasFocused and self.ChatBarWidget:WasFocused())
	end

	function this:GetCurrentWindowMessageCount()
		if this.ChatWindowWidget then
			return this.ChatWindowWidget:GetMessageCount()
		end
		return 0
	end

	function this:TopbarEnabledChanged(enabled)
		topbarEnabled = enabled
		-- Update coregui to reflect new topbar status
		self:CoreGuiChanged(Enum.CoreGuiType.Chat, true)
	end

	function this:Initialize()
		--[[ Developer Customization API ]]--
		if not NON_CORESCRIPT_MODE then
			--game:WaitForChild("StarterGui"):RegisterSetCore("ChatMakeSystemMessage", 	function(informationTable)
			--																				if this.ChatWindowWidget then
			--																					this.ChatWindowWidget:AddDeveloperSystemChatMessage(informationTable)
			--																				end
			--																			end)
			local function isUDim2Value(value)
				local success, value = pcall(function() return UDim2.new(value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset) end)
				return success and value or nil
			end

			local function isBubbleChatOn()
				return not PlayersService.ClassicChat and PlayersService.BubbleChat
			end

			if allowMoveChat then
				--	game.StarterGui:RegisterSetCore("ChatWindowPosition", 	function(value)
				--																if this.ChatWindowWidget and this.ChatBarWidget then
				--																	value = isUDim2Value(value)
				--																	if value ~= nil and not isBubbleChatOn() then
				--																		chatRepositioned = true -- Prevent chat from moving back to the original position on screen resolution change
				--																		this.ChatWindowWidget.ChatContainer.Position = value
				--																		this.ChatBarWidget.ChatBarContainer.Position = value + UDim2.new(0, 0, this.ChatWindowWidget.ChatContainer.Size.Y.Scale, this.ChatWindowWidget.ChatContainer.Size.Y.Offset + 2)
				--																	end
				--																end
				--															end)

				--	game.StarterGui:RegisterSetCore("ChatWindowSize", 	function(value)
				--																if this.ChatWindowWidget and this.ChatBarWidget then
				--																	value = isUDim2Value(value)
				--																if value ~= nil and not isBubbleChatOn() then
				--																	chatRepositioned = true
				--																	this.ChatWindowWidget.ChatContainer.Size = value
				--																	this.ChatBarWidget.ChatBarContainer.Size = UDim2.new(this.ChatWindowWidget.ChatContainer.Size.X.Scale, this.ChatWindowWidget.ChatContainer.Size.X.Offset, this.ChatBarWidget.ChatBarContainer.Size.Y.Scale, this.ChatBarWidget.ChatBarContainer.Size.Y.Offset)
				--																	this.ChatBarWidget.ChatBarContainer.Position = this.ChatWindowWidget.ChatContainer.Position + UDim2.new(0, 0, this.ChatWindowWidget.ChatContainer.Size.Y.Scale, this.ChatWindowWidget.ChatContainer.Size.Y.Offset + 2)
				--																	end
				--																end
				--															end)

				--else
				--	game.StarterGui:RegisterSetCore("ChatWindowPosition", 	function() end)
				--	game.StarterGui:RegisterSetCore("ChatWindowSize",		function() end)
				--end

				--	game.StarterGui:RegisterGetCore("ChatWindowPosition", 	function()
				--																if this.ChatWindowWidget then
				--																	return this.ChatWindowWidget.ChatContainer.Position
				--																else
				--																	return nil
				--																end
				--														end)

				--	game.StarterGui:RegisterGetCore("ChatWindowSize", 	function()
				--														if this.ChatWindowWidget then
				--															return this.ChatWindowWidget.ChatContainer.Size
				--														else
				--															return nil
				--														end
				--													end)

				--if allowDisableChatBar then
				--	game.StarterGui:RegisterSetCore("ChatBarDisabled", 	function(value)
				--															if this.ChatBarWidget then
				--																if type(value) == "boolean" then
				--																	chatBarDisabled = value
				--																	if value == true then
				--																		this.ChatBarWidget:ToggleVisibility(false)
				--																	end
				--																end
				--															end
				--														end)
				--else
				--game.StarterGui:RegisterSetCore("ChatBarDisabled", 	function() end)
			end

			--game.StarterGui:RegisterGetCore("ChatBarDisabled", function() return chatBarDisabled end)
		end

		this:OnPlayerAdded(Player)
		-- Upsettingly, it seems everytime a player is added, you have to redo the connection
		-- NOTE: PlayerAdded only fires on the server, hence ChildAdded is used here
		PlayersService.ChildAdded:connect(function(child)
			if child:IsA('Player') then
				this:OnPlayerAdded(child)
			end
		end)
		this:CreateGUI()

		RBXGeneral.MessageReceived:Connect(function(msg)
			if not msg.TextSource then return end
			if msg.Status and msg.Status ~= Enum.TextChatMessageStatus.Success then return end

			-- TextSource.Name is not a reliable Player lookup key on modern TextChatService.
			-- UserId is the stable way to resolve the sender.
			local ok, plr = pcall(function()
				return PlayersService:GetPlayerByUserId(msg.TextSource.UserId)
			end)
			if not ok or not plr then return end

			-- If a custom unfiltered-local echo is enabled, SendingMessage below already
			-- showed the local player's copy, so don't duplicate it here.
			if LocalChatsAreUnfiltered() and plr == Player then return end

			this:OnPlayerChatted(Enum.PlayerChatType.All, plr, msg.Text, nil)
		end)

		TextChatService.SendingMessage:Connect(function(msg)
			if LocalChatsAreUnfiltered() then
				this:OnPlayerChatted(Enum.PlayerChatType.All, Player, msg.Text, nil)
			end
		end)

		this:CoreGuiChanged(Enum.CoreGuiType.Chat, true)
		this.CoreGuiChangedConn = Util.DisconnectEvent(this.CoreGuiChangedConn)
		pcall(function()
			--this.CoreGuiChangedConn = StarterGui.CoreGuiChangedSignal:connect(
			--	function(coreGuiType,enabled)
			--		this:CoreGuiChanged(coreGuiType, enabled)
			--	end)
		end)

		-- Keep startup clean: do not force the legacy welcome/help hint into the chat window.
		-- /? and /help still work normally.
		-- if not NON_CORESCRIPT_MODE then
		-- 	this:PrintWelcome()
		-- end

		--SetVisbility(true)
	end

	return this
end

local moduleApiTable = {}
-- Main Entry Point
do
	local ChatInstance = CreateChat()
	ChatInstance:Initialize()

	function moduleApiTable:ToggleVisibility()
		ChatInstance:ToggleVisibility()
	end

	function moduleApiTable:SetVisible(visible)
		ChatInstance:SetVisible(visible)
	end

	function moduleApiTable:FocusChatBar()
		ChatInstance:FocusChatBar()
	end

	function moduleApiTable:GetVisibility()
		return ChatInstance.Visible
	end

	function moduleApiTable:GetMessageCount()
		return ChatInstance:GetCurrentWindowMessageCount()
	end

	function moduleApiTable:TopbarEnabledChanged(...)
		return ChatInstance:TopbarEnabledChanged(...)
	end

	function moduleApiTable:IsFocused(useWasFocused)
		return ChatInstance:IsFocused(useWasFocused)
	end

	moduleApiTable.ChatBarFocusChanged = ChatInstance.ChatBarFocusChanged
	moduleApiTable.VisibilityStateChanged = ChatInstance.VisibilityStateChanged
	moduleApiTable.MessagesChanged = ChatInstance.CurrentWindowMessageCountChanged

end

return moduleApiTable


end;
};
G2L_MODULES[G2L["c"]] = {
Closure = function()
    local script = G2L["c"];--[[
		Filename: SettingsPageFactory.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Base Page Functionality for all Settings Pages
--]]
----------------- SERVICES ------------------------------
local GuiService = _G:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Settings.Utility)


----------- VARIABLES --------------
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

----------- CONSTANTS --------------
local HEADER_SPACING = 5
if utility:IsSmallTouchScreen() then
	HEADER_SPACING = 0
end

----------- CLASS DECLARATION --------------
local function Initialize()
	local this = {}
	this.HubRef = nil
	this.LastSelectedObject = nil
	this.TabPosition = 0
	this.Active = false
	this.OpenStateChangedCount = 0
	local rows = {}
	local displayed = false

	------ TAB CREATION -------
	this.TabHeader = utility:Create'TextButton'
	{
		Name = "Header",
		Text = "",
		BackgroundTransparency = 1,
		Size = UDim2.new(0,169,1,0),
		Position = UDim2.new(0.5,0,0,0)
	};
	if utility:IsSmallTouchScreen() then
		this.TabHeader.Size = UDim2.new(0,84,1,0)
	elseif isTenFootInterface then
		this.TabHeader.Size = UDim2.new(0,220,1,0)
	end
	this.TabHeader.MouseButton1Click:connect(function()
		if this.HubRef then
			this.HubRef:SwitchToPage(this, true)
		end
	end)

	local icon = utility:Create'ImageLabel'
	{
		Name = "Icon",
		BackgroundTransparency = 1,
		Size = UDim2.new(0,44,0,37),
		Position = UDim2.new(0,10,0.5,-18),
		Image = "",
		ImageTransparency = 0.5,
		Parent = this.TabHeader
	};

	local title = utility:Create'TextLabel'
	{
		Name = "Title",
		Text = "Change Me",
		Font = Enum.Font.SourceSansBold,
		FontSize = Enum.FontSize.Size24,
		TextColor3 = Color3.new(1,1,1),
		BackgroundTransparency = 1,
		Size = UDim2.new(1.05,0,1,0),
		Position = UDim2.new(1.2,0,0,0),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTransparency = 0.5,
		Parent = icon
	};
	if utility:IsSmallTouchScreen() then
		title.FontSize = Enum.FontSize.Size18
	elseif isTenFootInterface then
		title.FontSize = Enum.FontSize.Size48
	end

	local tabSelection = utility:Create'ImageLabel'
	{
		Name = "TabSelection",
		Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuSelection.png",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,1,4,5),
		Visible = false,
		BackgroundTransparency = 1,
		Size = UDim2.new(1,0,0,6),
		Position = UDim2.new(0,0,1,-6),
		Parent = this.TabHeader
	};

	------ PAGE CREATION -------
	this.Page = utility:Create'Frame'
	{
		Name = "Page",
		BackgroundTransparency = 1,
		Size = UDim2.new(1,0,1,0)
	};

	-- make sure each page has a unique selection group (for gamepad selection)
	GuiService:AddSelectionParent(HttpService:GenerateGUID(false), this.Page)

	----------------- Events ------------------------

	this.Displayed = Instance.new("BindableEvent")
	this.Displayed.Name = "Displayed"

	this.Displayed.Event:connect(function()
		if not this.HubRef.Shield.Visible then return end

		this:SelectARow()
	end)

	this.Hidden = Instance.new("BindableEvent")
	this.Hidden.Event:connect(function()
		if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(this.Page) then
			GuiService.SelectedObject = nil
		end
	end)
	this.Hidden.Name = "Hidden"

	----------------- FUNCTIONS ------------------------
	function this:SelectARow(forced) -- Selects the first row or the most recently selected row
		if forced or not GuiService.SelectedObject or not GuiService.SelectedObject:IsDescendantOf(this.Page) then
			if this.LastSelectedObject then
				GuiService.SelectedObject = this.LastSelectedObject
			else
				if rows and #rows > 0 then
					local valueChangerFrame = nil

					if type(rows[1].ValueChanger) ~= "table" then
						valueChangerFrame = rows[1].ValueChanger
					else
						valueChangerFrame = rows[1].ValueChanger.SliderFrame and 
							rows[1].ValueChanger.SliderFrame or rows[1].ValueChanger.SelectorFrame
					end
					GuiService.SelectedObject = valueChangerFrame
				end
			end
		end
	end

	function this:Display(pageParent, skipAnimation)
		this.OpenStateChangedCount = this.OpenStateChangedCount + 1

		if this.TabHeader then
			this.TabHeader.TabSelection.Visible = true
			this.TabHeader.Icon.ImageTransparency = 0
			this.TabHeader.Icon.Title.TextTransparency = 0
		end

		this.Page.Parent = pageParent
		this.Page.Visible = true

		local endPos = UDim2.new(0,0,0,0)
		local animationComplete = function()
			this.Page.Visible = true
			displayed = true
			this.Displayed:Fire()
		end
		if skipAnimation then
			this.Page.Position = endPos
			animationComplete()
		else
			this.Page:TweenPosition(endPos, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true, animationComplete)
		end
	end
	function this:Hide(direction, newPagePos, skipAnimation, delayBeforeHiding)
		this.OpenStateChangedCount = this.OpenStateChangedCount + 1

		if this.TabHeader then
			this.TabHeader.TabSelection.Visible = false
			this.TabHeader.Icon.ImageTransparency = 0.5
			this.TabHeader.Icon.Title.TextTransparency = 0.5
		end

		if this.Page.Parent then
			local endPos = UDim2.new(1 * direction,0,0,0)
			local animationComplete = function()
				this.Page.Visible = false
				this.Page.Position = UDim2.new(this.TabPosition - newPagePos,0,0,0)
				displayed = false
				this.Hidden:Fire()
			end

			local remove = function()
				if skipAnimation then
					this.Page.Position = endPos
					animationComplete()
				else
					this.Page:TweenPosition(endPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, animationComplete)
				end
			end

			if delayBeforeHiding then
				local myOpenStateChangedCount = this.OpenStateChangedCount
				delay(delayBeforeHiding, function()
					if myOpenStateChangedCount == this.OpenStateChangedCount then
						remove()
					end
				end)
			else
				remove()
			end
		end
	end

	function this:GetDisplayed()
		return displayed
	end

	function this:GetVisibility()
		return this.Page.Parent
	end

	function this:GetTabHeader()
		return this.TabHeader
	end

	function this:SetHub(hubRef)
		this.HubRef = hubRef

		for i, row in next, rows do
			if type(row.ValueChanger) == 'table' then
				row.ValueChanger.HubRef = this.HubRef
			end
		end
	end

	function this:GetSize()
		return this.Page.AbsoluteSize
	end

	function this:AddRow(RowFrame, RowLabel, ValueChangerInstance, ExtraRowSpacing)
		rows[#rows + 1] = {SelectionFrame = RowFrame, Label = RowLabel, ValueChanger = ValueChangerInstance}

		local rowFrameYSize = 0
		if RowFrame then 
			rowFrameYSize = RowFrame.Size.Y.Offset
		end

		if ExtraRowSpacing then
			this.Page.Size = UDim2.new(1, 0, 0, this.Page.Size.Y.Offset + rowFrameYSize + ExtraRowSpacing)
		else
			this.Page.Size = UDim2.new(1, 0, 0, this.Page.Size.Y.Offset + rowFrameYSize)
		end

		if this.HubRef and type(ValueChangerInstance) == 'table' then
			ValueChangerInstance.HubRef = this.HubRef
		end
	end

	return this
end


-------- public facing API ----------------
local moduleApiTable = {}

function moduleApiTable:CreateNewPage()
	return Initialize()
end

return moduleApiTable
end;
};
G2L_MODULES[G2L["d"]] = {
Closure = function()
    local script = G2L["d"];--[[
		Filename: SettingsPage.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Base Page Functionality for all Settings Pages
--]]

------------------ CONSTANTS --------------------
local SELECTED_COLOR = Color3.new(0,162/255,1)
local NON_SELECTED_COLOR = Color3.new(78/255,84/255,96/255)

local SELECTED_LEFT_IMAGE = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
local NON_SELECTED_LEFT_IMAGE = "rbxasset://textures/ui/Settings/Slider/BarLeft.png"
local SELECTED_RIGHT_IMAGE = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
local NON_SELECTED_RIGHT_IMAGE= "rbxasset://textures/ui/Settings/Slider/BarRight.png"

local CONTROLLER_SCROLL_DELTA = 0.2
local CONTROLLER_THUMBSTICK_DEADZONE = 0.8

------------- SERVICES ----------------
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local GuiService = _G:GetService("GuiService")
local RunService = game:GetService("RunService")
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:FindFirstChild("RobloxGui")
local ContextActionService = game:GetService("ContextActionService")

------------------ VARIABLES --------------------
local tenFootInterfaceEnabled = false
do
	RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
	tenFootInterfaceEnabled = require(RobloxGui.Modules.TenFootInterface):IsEnabled()
end



----------- UTILITIES --------------
local Util = {}
do
	function Util.Create(instanceType)
		return function(data)
			local obj = Instance.new(instanceType)
			for k, v in pairs(data) do
				if type(k) == 'number' then
					v.Parent = obj
				else
					obj[k] = v
				end
			end
			return obj
		end
	end
end


-- used by several guis to show no selection adorn
local noSelectionObject = Util.Create'ImageLabel'
{
	Image = "",
	BackgroundTransparency = 1
};


-- MATH --
function clamp(low, high, input)
	return math.max(low, math.min(high, input))
end

function ClampVector2(low, high, input)
	return Vector2.new(clamp(low.x, high.x, input.x), clamp(low.y, high.y, input.y))
end

---- TWEENZ ----
local Linear = function(t, b, c, d)
	if t >= d then return b + c end

	return c*t/d + b
end

local EaseOutQuad = function(t, b, c, d)
	if t >= d then return b + c end

	t = t/d;
	return -c * t*(t-2) + b
end

local EaseInOutQuad = function(t, b, c, d)
	if t >= d then return b + c end

	t = t / (d/2);
	if (t < 1) then return c/2*t*t + b end;
	t = t - 1;
	return -c/2 * (t*(t-2) - 1) + b;
end

function PropertyTweener(instance, prop, start, final, duration, easingFunc, cbFunc)
	local this = {}
	this.StartTime = tick()
	this.EndTime = this.StartTime + duration
	this.Cancelled = false

	local finished = false
	local percentComplete = 0

	local function finalize()
		if instance then
			instance[prop] = easingFunc(1, start, final - start, 1)
		end
		finished = true
		percentComplete = 1
		if cbFunc then
			cbFunc()
		end
	end

	-- Initial set
	instance[prop] = easingFunc(0, start, final - start, duration)
	spawn(function()
		local now = tick()
		while now < this.EndTime and instance do
			if this.Cancelled then
				return
			end
			instance[prop] = easingFunc(now - this.StartTime, start, final - start, duration)
			percentComplete = clamp(0, 1, (now - this.StartTime) / duration)
			RunService.RenderStepped:wait()
			now = tick()
		end
		if this.Cancelled == false and instance then
			finalize()
		end
	end)

	function this:GetFinal()
		return final
	end

	function this:GetPercentComplete()
		return percentComplete
	end

	function this:IsFinished()
		return finished
	end

	function this:Finish()
		if not finished then
			self:Cancel()
			finalize()
		end
	end

	function this:Cancel()
		this.Cancelled = true
	end

	return this
end

----------- CLASS DECLARATION --------------

local function CreateSignal()
	local sig = {}

	local mSignaler = Instance.new('BindableEvent')

	local mArgData = nil
	local mArgDataCount = nil

	function sig:fire(...)
		mArgData = {...}
		mArgDataCount = select('#', ...)
		mSignaler:Fire()
	end

	function sig:connect(f)
		if not f then error("connect(nil)", 2) end
		return mSignaler.Event:connect(function()
			f(unpack(mArgData, 1, mArgDataCount))
		end)
	end

	function sig:wait()
		mSignaler.Event:wait()
		assert(mArgData, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
		return unpack(mArgData, 1, mArgDataCount)
	end

	return sig
end

local function getViewportSize()
	while not game.Workspace.CurrentCamera do
		game.Workspace.Changed:wait()
	end

	while game.Workspace.CurrentCamera.ViewportSize == Vector2.new(0,0) do
		game.Workspace.CurrentCamera.Changed:wait()
	end

	return game.Workspace.CurrentCamera.ViewportSize
end

local function isSmallTouchScreen()
	return UserInputService.TouchEnabled and getViewportSize().Y <= 500
end

local function isTenFootInterface()
	return tenFootInterfaceEnabled
end

local function usesSelectedObject()
	if UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then return false end

	return true
end

local function isPosOverGui(pos, gui, debug) -- does not account for rotation
	local ax, ay = gui.AbsolutePosition.x, gui.AbsolutePosition.y
	local sx, sy = gui.AbsoluteSize.x, gui.AbsoluteSize.y
	local bx, by = ax+sx, ay+sy

	if pos.x > ax and pos.x < bx and pos.y > ay and pos.y < by then
		return true
	else
		return false
	end
end

local function isPosOverGuiWithClipping(pos, gui) -- isPosOverGui, accounts for clipping and visibility, does not account for rotation
	if not isPosOverGui(pos, gui) then
		return false
	end

	local clipping = false
	local check = gui
	while true do
		if check == nil or (not check:IsA'GuiObject' and not check:IsA'LayerCollector') then
			clipping = true
			if check and check:IsA'CoreGui' then
				clipping = false
			end
			break
		end

		if check:IsA'GuiObject' and not check.Visible then
			clipping = true
			break
		end
		if check:IsA'LayerCollector' or check.ClipsDescendants then
			if not isPosOverGui(pos, check) then
				clipping = true
				break
			end
		end

		check = check.Parent
	end

	if clipping then
		return false
	else
		return true
	end
end

local function areGuisIntersecting(a, b) -- does not account for rotation
	local aax, aay = a.AbsolutePosition.x, a.AbsolutePosition.y
	local asx, asy = a.AbsoluteSize.x, a.AbsoluteSize.y
	local abx, aby = aax+asx, aay+asy
	local bax, bay = b.AbsolutePosition.x, b.AbsolutePosition.y
	local bsx, bsy = b.AbsoluteSize.x, b.AbsoluteSize.y
	local bbx, bby = bax+bsx, bay+bsy

	local intersectingX = aax < bbx and abx > bax
	local intersectingY = aay < bby and aby > bay
	local intersecting = intersectingX and intersectingY

	return intersecting
end

local function isGuiVisible(gui, debug) -- true if any part of the gui is visible on the screen, considers clipping, does not account for rotation
	local clipping = false
	local check = gui
	while true do
		if check == nil or not check:IsA'GuiObject' and not check:IsA'LayerCollector' then
			clipping = true
			if check and check:IsA'CoreGui' then
				clipping = false
			end
			break
		end

		if check:IsA'GuiObject' and not check.Visible then
			clipping = true
			break
		end
		if check:IsA'LayerCollector' or check.ClipsDescendants then
			if not areGuisIntersecting(check, gui) then
				clipping = true
				break
			end
		end

		check = check.Parent
	end

	if clipping then
		return false
	else
		return true
	end
end

local function MakeButton(name, text, size, clickFunc, pageRef, hubRef)
	local SelectionOverrideObject = Util.Create'ImageLabel'
	{
		Image = "",
		BackgroundTransparency = 1,
	};

	local button = Util.Create'ImageButton'
	{
		Name = name .. "Button",
		Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(8,6,46,44),
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = size,
		ZIndex = 2,
		SelectionImageObject = SelectionOverrideObject
	};
	button.NextSelectionLeft = button
	button.NextSelectionRight = button

	local enabled = Util.Create'BoolValue'
	{
		Name = 'Enabled',
		Parent = button,
		Value = true
	}

	if clickFunc then 
		button.MouseButton1Click:connect(function() 
			local lastInputType = nil
			pcall(function() lastInputType = UserInputService:GetLastInputType() end)
			if lastInputType then
				clickFunc(lastInputTypee == Enum.UserInputType.Gamepad1 or lastInputType == Enum.UserInputType.Gamepad2 or 
					lastInputType == Enum.UserInputType.Gamepad3 or lastInputType == Enum.UserInputType.Gamepad4)
			else
				clickFunc(false)
			end
		end) 
	end

	local function isPointerInput(inputObject)
		return (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch)
	end

	local function selectButton()
		local hub = hubRef
		if hub == nil then
			if pageRef then
				hub = pageRef.HubRef
			end
		end

		if (hub and hub.Active or hub == nil) then
			button.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"

			local scrollTo = button
			if rowRef then
				scrollTo = rowRef
			end
			if hub then
				hub:ScrollToFrame(scrollTo)
			end
		end
	end

	local function deselectButton()
		button.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
	end

	button.InputBegan:connect(function(inputObject)
		if button.Selectable and isPointerInput(inputObject) then
			selectButton()
		end
	end)
	button.InputEnded:connect(function(inputObject)
		if button.Selectable and GuiService.SelectedObject ~= button and isPointerInput(inputObject) then
			deselectButton()
		end
	end)

	local rowRef = nil
	local function setRowRef(ref)
		rowRef = ref
	end
	button.SelectionGained:connect(function()
		selectButton()
	end)
	button.SelectionLost:connect(function()
		deselectButton()
	end)

	local textLabel = Util.Create'TextLabel'
	{
		Name = name .. "TextLabel",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, -8),
		Position = UDim2.new(0,0,0,0),
		TextColor3 = Color3.new(1,1,1),
		TextYAlignment = Enum.TextYAlignment.Center,
		Font = Enum.Font.SourceSansBold,
		FontSize = Enum.FontSize.Size24,
		Text = text,
		TextWrapped = true,
		ZIndex = 2,
		Parent = button
	};

	if isSmallTouchScreen() then
		textLabel.FontSize = Enum.FontSize.Size18
	elseif isTenFootInterface() then
		textLabel.FontSize = Enum.FontSize.Size36
	end
	--[[
		local guiServiceCon = GuiService.Changed:connect(function(prop)
			if prop ~= "SelectedObject" then return end
			if not usesSelectedObject() then return end

			if GuiService.SelectedObject == nil or GuiService.SelectedObject ~= button then 
				deselectButton()
				return 
			end

			if button.Selectable then
				selectButton()
			end
		end)
	--]]
	return button, textLabel, setRowRef
end

local function CreateDropDown(dropDownStringTable, startPosition, settingsHub)
	-------------------- CONSTANTS ------------------------
	local DEFAULT_DROPDOWN_TEXT = "Choose One"
	local SCROLLING_FRAME_PIXEL_OFFSET = 25
	local SELECTION_TEXT_COLOR_NORMAL = Color3.new(0.7,0.7,0.7)
	local SELECTION_TEXT_COLOR_HIGHLIGHTED = Color3.new(1,1,1)

	-------------------- VARIABLES ------------------------
	local lastSelectedObject= nil

	-------------------- SETUP ------------------------
	local this = {}
	this.CurrentIndex = nil

	local indexChangedEvent = Instance.new("BindableEvent")
	indexChangedEvent.Name = "IndexChanged"

	if type(dropDownStringTable) ~= "table" then
		error("CreateDropDown dropDownStringTable (first arg) is not a table")
		return this
	end

	local indexChangedEvent = Instance.new("BindableEvent")
	indexChangedEvent.Name = "IndexChanged"

	local interactable = true
	local guid = HttpService:GenerateGUID(false)
	local dropDownButtonEnabled

	this.CurrentIndex = 0

	----------------- GUI SETUP ------------------------
	local DropDownFullscreenFrame = Util.Create'ImageButton'
	{
		Name = "DropDownFullscreenFrame",
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.new(0,0,0),
		ZIndex = 10,
		Active = true,
		Visible = false,
		Selectable = false,
		AutoButtonColor = false,
		Parent = CoreGui.RobloxGui
	};

	local DropDownSelectionFrame = Util.Create'ImageLabel'
	{
		Name = "DropDownSelectionFrame",
		Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(8,6,46,44),
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 400, 0.9, 0),
		Position = UDim2.new(0.5, -200, 0.05, 0),
		ZIndex = 10,
		Parent = DropDownFullscreenFrame
	};

	local DropDownScrollingFrame = Util.Create'ScrollingFrame'
	{
		Name = "DropDownScrollingFrame",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -20, 1, -SCROLLING_FRAME_PIXEL_OFFSET),
		Position = UDim2.new(0, 10, 0, 10),
		ZIndex = 10,
		Parent = DropDownSelectionFrame
	};

	local guiServiceChangeCon = nil
	local active = false
	local hideDropDownSelection = function(name, inputState)
		if name ~= nil and inputState ~= Enum.UserInputState.Begin then return end

		-- Do the critical recovery first. Nothing below is allowed to leave the hub frozen.
		DropDownFullscreenFrame.Visible = false
		active = false
		pcall(function() ContextActionService:UnbindAction(guid .. "Action") end)
		pcall(function() ContextActionService:UnbindAction(guid .. "FreezeAction") end)
		pcall(function() settingsHub:SetActive(true) end)

		pcall(function()
			this.DropDownFrame.Selectable = interactable
			dropDownButtonEnabled.Value = interactable
		end)

		pcall(function()
			if usesSelectedObject() then
				GuiService.SelectedObject = lastSelectedObject
			end
		end)

		if guiServiceChangeCon then
			pcall(function() guiServiceChangeCon:disconnect() end)
			guiServiceChangeCon = nil
		end
	end
	local noOpFunc = function() end

	local DropDownFrameClicked = function()
		if not interactable then return end

		this.DropDownFrame.Selectable = false
		active = true

		DropDownFullscreenFrame.Visible = true
		if not this.CurrentIndex then this.CurrentIndex = 1 end
		if this.CurrentIndex <= 0 then this.CurrentIndex = 1 end

		lastSelectedObject = this.DropDownFrame
		GuiService.SelectedObject = this.Selections[this.CurrentIndex]
		--[[
			guiServiceChangeCon = GuiService.Changed:connect(function(prop)
				if not prop == "SelectedObject" then return end
				for i = 1, #this.Selections do
					if GuiService.SelectedObject == this.Selections[i] then
						this.Selections[i].TextColor3 = SELECTION_TEXT_COLOR_HIGHLIGHTED
					else
						this.Selections[i].TextColor3 = SELECTION_TEXT_COLOR_NORMAL
					end
				end
			end)
		--]]
		-- Old CoreGui code froze all keyboard/gamepad input and deactivated the hub.
		-- In a PlayerGui recreation that can leave the menu permanently unresponsive
		-- if any legacy dropdown callback fails. Keep only the explicit close action.
		ContextActionService:UnbindAction(guid .. "FreezeAction")
		ContextActionService:BindAction(guid .. "Action", hideDropDownSelection, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape)

		pcall(function() settingsHub:SetActive(true) end)

		dropDownButtonEnabled.Value = false
	end

	local dropDownFrameSize = UDim2.new(0,400,0,44)
	if isSmallTouchScreen() then
		dropDownFrameSize = UDim2.new(0,300,0,44)
	end
	this.DropDownFrame = MakeButton("DropDownFrame", DEFAULT_DROPDOWN_TEXT, dropDownFrameSize, DropDownFrameClicked)
	dropDownButtonEnabled = this.DropDownFrame.Enabled
	local selectedTextLabel = this.DropDownFrame.DropDownFrameTextLabel
	local dropDownImage = Util.Create'ImageLabel'
	{
		Name = "DropDownImage",
		Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png",
		BackgroundTransparency = 1,
		Size = UDim2.new(0,15,0,10),
		Position = UDim2.new(1, -45,0.5,-7),
		ZIndex = 2,
		Parent = this.DropDownFrame
	};


	---------------------- FUNCTIONS -----------------------------------
	local function setSelection(index)
		local shouldFireChanged = false
		for i, selectionLabel in pairs(this.Selections) do
			if i == index then
				selectedTextLabel.Text = selectionLabel.Text
				this.CurrentIndex = i

				shouldFireChanged = true
			end
		end

		if shouldFireChanged then
			indexChangedEvent:Fire(index)
		end
	end

	local function setSelectionByValue(value)
		local shouldFireChanged = false
		for i, selectionLabel in pairs(this.Selections) do
			if selectionLabel.Text == value then
				selectedTextLabel.Text = selectionLabel.Text
				this.CurrentIndex = i

				shouldFireChanged = true
			end
		end

		if shouldFireChanged then
			indexChangedEvent:Fire(this.CurrentIndex)
		end
		return shouldFireChanged
	end

	local enterIsDown = false
	local function processInput(input)
		if input.UserInputState == Enum.UserInputState.Begin then
			if input.KeyCode == Enum.KeyCode.Return then
				if GuiService.SelectedObject == this.DropDownFrame or this.SelectionInfo and this.SelectionInfo[GuiService.SelectedObject] then
					enterIsDown = true
				end
			end
		elseif input.UserInputState == Enum.UserInputState.End then
			if input.KeyCode == Enum.KeyCode.Return and enterIsDown then
				enterIsDown = false
				if GuiService.SelectedObject == this.DropDownFrame then
					DropDownFrameClicked()
				elseif this.SelectionInfo and this.SelectionInfo[GuiService.SelectedObject] then
					local info = this.SelectionInfo[GuiService.SelectedObject]
					info.Clicked()
				end
			end
		end
	end


	--------------------- PUBLIC FACING FUNCTIONS -----------------------
	this.IndexChanged = indexChangedEvent.Event

	function this:SetSelectionIndex(newIndex)
		setSelection(newIndex)
	end

	function this:SetSelectionByValue(value)
		return setSelectionByValue(value)
	end

	function this:ResetSelectionIndex()
		this.CurrentIndex = nil
		selectedTextLabel.Text = DEFAULT_DROPDOWN_TEXT
		hideDropDownSelection()
	end

	function this:GetSelectedIndex()
		return this.CurrentIndex
	end

	function this:SetZIndex(newZIndex)
		this.DropDownFrame.ZIndex = newZIndex
		dropDownImage.ZIndex = newZIndex
		selectedTextLabel.ZIndex = newZIndex
	end

	function this:SetInteractable(value)
		interactable = value
		this.DropDownFrame.Selectable = interactable

		if not interactable then
			hideDropDownSelection()
			this:SetZIndex(1)
		else
			this:SetZIndex(2)
		end

		dropDownButtonEnabled.Value = value and not active
	end


	function this:UpdateDropDownList(dropDownStringTable)
		if this.Selections then
			for i = 1, #this.Selections do
				this.Selections[i]:Destroy()
			end
		end

		this.Selections = {}
		this.SelectionInfo = {}

		for i,v in pairs(dropDownStringTable) do
			local SelectionOverrideObject =	Util.Create'Frame'
			{
				BackgroundTransparency = 0.7,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0)
			};

			local nextSelection = Util.Create'TextButton'
			{
				Name = "Selection" .. tostring(i),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				Size = UDim2.new(1, -28, 0, 50),
				Position = UDim2.new(0,14,0, (i - 1) * 51),
				TextColor3 = SELECTION_TEXT_COLOR_NORMAL,
				Font = Enum.Font.SourceSans,
				FontSize = Enum.FontSize.Size24,
				Text = v,
				ZIndex = 10,
				SelectionImageObject = SelectionOverrideObject,
				Parent = DropDownScrollingFrame
			};

			if i == startPosition then
				this.CurrentIndex = i
				selectedTextLabel.Text = v
				nextSelection.TextColor3 = SELECTION_TEXT_COLOR_HIGHLIGHTED
			elseif not startPosition and i == 1 then
				nextSelection.TextColor3 = SELECTION_TEXT_COLOR_HIGHLIGHTED
			end

			local clicked = function()
				selectedTextLabel.Text = nextSelection.Text
				hideDropDownSelection()
				this.CurrentIndex = i
				indexChangedEvent:Fire(i)
			end

			nextSelection.MouseButton1Click:connect(clicked)

			nextSelection.MouseEnter:connect(function()
				if usesSelectedObject() then
					GuiService.SelectedObject = nextSelection
				end
			end)

			this.Selections[i] = nextSelection
			this.SelectionInfo[nextSelection] = {Clicked = clicked}
		end

		GuiService:RemoveSelectionGroup(guid)
		GuiService:AddSelectionTuple(guid, unpack(this.Selections))

		DropDownScrollingFrame.CanvasSize = UDim2.new(1,-20,0,#dropDownStringTable * 51)

		local function updateDropDownSize()
			if DropDownScrollingFrame.CanvasSize.Y.Offset < (DropDownFullscreenFrame.AbsoluteSize.Y - 10) then
				DropDownSelectionFrame.Size = UDim2.new(DropDownSelectionFrame.Size.X.Scale, DropDownSelectionFrame.Size.X.Offset,
					0,DropDownScrollingFrame.CanvasSize.Y.Offset + SCROLLING_FRAME_PIXEL_OFFSET)
				DropDownSelectionFrame.Position = UDim2.new(DropDownSelectionFrame.Position.X.Scale, DropDownSelectionFrame.Position.X.Offset,
					0.5, -DropDownSelectionFrame.Size.Y.Offset/2)
			else
				DropDownSelectionFrame.Size = UDim2.new(0, 400, 0.9, 0)
				DropDownSelectionFrame.Position = UDim2.new(0.5, -200, 0.05, 0)
			end
		end

		DropDownFullscreenFrame.Changed:connect(function(prop)
			if prop ~= "AbsoluteSize" then return end
			updateDropDownSize()
		end)

		updateDropDownSize()
	end

	----------------------- CONNECTIONS/SETUP --------------------------------
	this:UpdateDropDownList(dropDownStringTable)

	DropDownFullscreenFrame.MouseButton1Click:connect(hideDropDownSelection)

	settingsHub.PoppedMenu:connect(function(poppedMenu)
		if poppedMenu == DropDownFullscreenFrame then
			hideDropDownSelection()
		end
	end)

	-- DropDowns bind guid .. "FreezeAction". Always remove it when the hub closes.
	if settingsHub.SettingsShowSignal then
		pcall(function()
			settingsHub.SettingsShowSignal:connect(function(visible)
				if not visible then
					hideDropDownSelection()
				end
			end)
		end)
	end

	UserInputService.InputBegan:connect(processInput)
	UserInputService.InputEnded:connect(processInput)

	return this
end


local function CreateSelector(selectionStringTable, startPosition)

	-------------------- VARIABLES ------------------------
	local lastInputDirection = 0
	local TweenTime = 0.15

	-------------------- SETUP ------------------------
	local this = {}
	this.HubRef = nil

	if type(selectionStringTable) ~= "table" then
		error("CreateSelector selectionStringTable (first arg) is not a table")
		return this
	end

	local indexChangedEvent = Instance.new("BindableEvent")
	indexChangedEvent.Name = "IndexChanged"

	local interactable = true

	this.CurrentIndex = 0

	----------------- GUI SETUP ------------------------
	this.SelectorFrame = Util.Create'ImageButton'
	{
		Name = "Selector",
		Image = "",
		AutoButtonColor = false,
		NextSelectionLeft = this.SelectorFrame,
		NextSelectionRight = this.SelectorFrame,
		BackgroundTransparency = 1,
		Size = UDim2.new(0,502,0,50),
		ZIndex = 2,
		SelectionImageObject = noSelectionObject
	};
	if isSmallTouchScreen() then
		this.SelectorFrame.Size = UDim2.new(0,400,0,50)
	end

	local leftButton = Util.Create'ImageButton'
	{
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(0,-10,0.5,-25),
		Size =  UDim2.new(0,60,0,50),
		Image =  "",
		ZIndex = 3,
		Selectable = false,
		Active = true,
		Parent = this.SelectorFrame
	};
	local rightButton = Util.Create'ImageButton'
	{
		Name = "RightButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(1,-50,0.5,-25),
		Size =  UDim2.new(0,50,0,50),
		Image =  "",
		ZIndex = 3,
		Selectable = false,
		Parent = this.SelectorFrame
	};

	local leftButtonImage = Util.Create'ImageLabel'
	{
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(1,-24,0.5,-15),
		Size =  UDim2.new(0,18,0,30),
		Image =  "rbxasset://textures/ui/Settings/Slider/Left.png",
		ZIndex = 2,
		Active = true,
		Parent = leftButton
	};
	local rightButtonImage = Util.Create'ImageLabel'
	{
		Name = "RightButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(0,6,0.5,-15),
		Size =  UDim2.new(0,18,0,30),
		Image =  "rbxasset://textures/ui/Settings/Slider/Right.png",
		ZIndex = 2,
		Parent = rightButton
	};


	this.Selections = {}
	local isSelectionLabelVisible = {}
	local isAutoSelectButton = {}

	for i,v in pairs(selectionStringTable) do
		local nextSelection = Util.Create'TextLabel'
		{
			Name = "Selection" .. tostring(i),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1,leftButton.Size.X.Offset * -2, 1, 0),
			Position = UDim2.new(1,0,0,0),
			TextColor3 = Color3.new(1,1,1),
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTransparency = 0.5,
			Font = Enum.Font.SourceSans,
			FontSize = Enum.FontSize.Size24,
			Text = v,
			ZIndex = 2,
			Visible = false,
			Parent = this.SelectorFrame
		};
		if isTenFootInterface() then
			nextSelection.FontSize = Enum.FontSize.Size36
		end

		if i == startPosition then
			this.CurrentIndex = i
			nextSelection.Position = UDim2.new(0,leftButton.Size.X.Offset,0,0)
			nextSelection.Visible = true

			isSelectionLabelVisible[nextSelection] = true
		else
			isSelectionLabelVisible[nextSelection] = false
		end

		local autoSelectButton = Util.Create'ImageButton'{
			Name = 'AutoSelectButton',
			BackgroundTransparency = 1,
			Image = '',
			Size = UDim2.new(1, 0, 1, 0),
			Parent = nextSelection,
			ZIndex = 2
		}
		autoSelectButton.MouseButton1Click:connect(function()
			local newIndex = this.CurrentIndex + 1
			if newIndex > #this.Selections then
				newIndex = 1
			end
			this:SetSelectionIndex(newIndex)
			if usesSelectedObject() then
				GuiService.SelectedObject = this.SelectorFrame
			end
		end)
		isAutoSelectButton[autoSelectButton] = true

		this.Selections[i] = nextSelection
	end


	---------------------- FUNCTIONS -----------------------------------
	local function setSelection(index, direction)
		for i, selectionLabel in pairs(this.Selections) do
			local isSelected = (i == index)

			if not selectionLabel:IsDescendantOf(game) then
				this.CurrentIndex = i
				indexChangedEvent:Fire(index)
				return
			end

			local tweenPos = UDim2.new(0,leftButton.Size.X.Offset * direction * 3,0,0)
			if isSelectionLabelVisible[selectionLabel] then
				tweenPos = UDim2.new(0,leftButton.Size.X.Offset * -direction * 3,0,0)
			end

			if tweenPos.X.Offset < 0 then
				tweenPos = UDim2.new(0,tweenPos.X.Offset + (selectionLabel.AbsoluteSize.X/4),0,0)
			end

			if isSelected then
				isSelectionLabelVisible[selectionLabel] = true
				selectionLabel.Position = tweenPos
				selectionLabel.Visible = true
				PropertyTweener(selectionLabel, "TextTransparency", 1, 0, TweenTime * 1.1, EaseOutQuad)
				selectionLabel:TweenPosition(UDim2.new(0,leftButton.Size.X.Offset,0,0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, TweenTime, true)
				this.CurrentIndex = i
				indexChangedEvent:Fire(index)
			elseif isSelectionLabelVisible[selectionLabel] then
				isSelectionLabelVisible[selectionLabel] = false
				PropertyTweener(selectionLabel, "TextTransparency", 0, 1, TweenTime * 1.1, EaseOutQuad)
				selectionLabel:TweenPosition(tweenPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, TweenTime * 0.9, true)
			end
		end
	end

	local function stepFunc(inputObject, step)
		if not interactable then return end

		if inputObject ~= nil and inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and 
			inputObject.UserInputType ~= Enum.UserInputType.Gamepad1 and inputObject.UserInputType ~= Enum.UserInputType.Gamepad2 and
			inputObject.UserInputType ~= Enum.UserInputType.Gamepad3 and inputObject.UserInputType ~= Enum.UserInputType.Gamepad4 and 
			inputObject.UserInputType ~= Enum.UserInputType.Keyboard then return end

		if usesSelectedObject() then
			GuiService.SelectedObject = this.SelectorFrame
		end

		local newIndex = step + this.CurrentIndex

		local direction = 0
		if newIndex > this.CurrentIndex then
			direction = 1
		else
			direction = -1
		end

		if newIndex > #this.Selections then
			newIndex = 1
		elseif newIndex < 1 then
			newIndex = #this.Selections
		end

		setSelection(newIndex, direction)
	end

	local guiServiceCon = nil
	local function connectToGuiService()
		--[[
			guiServiceCon = GuiService.Changed:connect(function(prop)
				if prop == "SelectedObject" then
					if GuiService.SelectedObject == this.SelectorFrame then 
						this.Selections[this.CurrentIndex].TextTransparency = 0
					else
						if GuiService.SelectedObject ~= nil and isAutoSelectButton[GuiService.SelectedObject] then
							GuiService.SelectedObject = this.SelectorFrame
						else
							this.Selections[this.CurrentIndex].TextTransparency = 0.5
						end
					end
				end
			end)
		--]]
	end

	--------------------- PUBLIC FACING FUNCTIONS -----------------------
	this.IndexChanged = indexChangedEvent.Event

	function this:SetSelectionIndex(newIndex)
		setSelection(newIndex, 1)
	end

	function this:GetSelectedIndex()
		return this.CurrentIndex
	end

	function this:SetZIndex(newZIndex)
		leftButton.ZIndex = newZIndex
		rightButton.ZIndex = newZIndex
		leftButtonImage.ZIndex = newZIndex
		rightButtonImage.ZIndex = newZIndex

		for i = 1, #this.Selections do
			this.Selections[i].ZIndex = newZIndex
		end
	end

	function this:SetInteractable(value)
		interactable = value
		this.SelectorFrame.Selectable = interactable
	end

	--------------------- SETUP -----------------------
	leftButton.InputBegan:connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.Touch then
			stepFunc(nil, -1) 
		end
	end)
	leftButton.MouseButton1Click:connect(function()
		if not UserInputService.TouchEnabled then
			stepFunc(nil, -1) 
		end
	end)
	rightButton.InputBegan:connect(function(inputObject) 
		if inputObject.UserInputType == Enum.UserInputType.Touch then
			stepFunc(nil, 1)
		end
	end)
	rightButton.MouseButton1Click:connect(function()
		if not UserInputService.TouchEnabled then
			stepFunc(nil, 1) 
		end
	end)

	local isInTree = true

	UserInputService.InputBegan:connect(function(inputObject)
		if not interactable then return end
		if not isInTree then return end

		if inputObject.UserInputType ~= Enum.UserInputType.Gamepad1 and inputObject.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if GuiService.SelectedObject ~= this.SelectorFrame then return end

		if inputObject.KeyCode == Enum.KeyCode.DPadLeft or inputObject.KeyCode == Enum.KeyCode.Left or inputObject.KeyCode == Enum.KeyCode.A then
			stepFunc(inputObject, -1)
		elseif inputObject.KeyCode == Enum.KeyCode.DPadRight or inputObject.KeyCode == Enum.KeyCode.Right or inputObject.KeyCode == Enum.KeyCode.D then
			stepFunc(inputObject, 1)
		end
	end)

	UserInputService.InputChanged:connect(function(inputObject)
		if not interactable then return end
		if not isInTree then lastInputDirection = 0 return end

		if inputObject.UserInputType ~= Enum.UserInputType.Gamepad1 then return end
		if GuiService.SelectedObject ~= this.SelectorFrame then return end
		if inputObject.KeyCode ~= Enum.KeyCode.Thumbstick1 then return end


		if inputObject.Position.X > CONTROLLER_THUMBSTICK_DEADZONE and inputObject.Delta.X > 0 and lastInputDirection ~= 1 then
			lastInputDirection = 1
			stepFunc(inputObject, lastInputDirection)
		elseif inputObject.Position.X < -CONTROLLER_THUMBSTICK_DEADZONE and inputObject.Delta.X < 0 and lastInputDirection ~= -1 then
			lastInputDirection = -1
			stepFunc(inputObject, lastInputDirection)
		elseif math.abs(inputObject.Position.X) < CONTROLLER_THUMBSTICK_DEADZONE then
			lastInputDirection = 0
		end
	end)

	this.SelectorFrame.AncestryChanged:connect(function(child, parent)
		isInTree = parent
		if not isInTree then
			if guiServiceCon then guiServiceCon:disconnect() end
		else
			connectToGuiService()
		end
	end)

	connectToGuiService()

	return this
end

local function ShowAlert(alertMessage, okButtonText, settingsHub, okPressedFunc, hasBackground)
	if CoreGui.RobloxGui:FindFirstChild("AlertViewFullScreen") then return end

	local NON_SELECTED_TEXT_COLOR = Color3.new(59/255, 166/255, 241/255)
	local SELECTED_TEXT_COLOR = Color3.new(1,1,1)

	local AlertViewBacking = Util.Create'ImageLabel'
	{
		Name = "AlertViewBacking",
		Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(8,6,46,44),
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.new(0, 400, 0, 350),
		Position = UDim2.new(0.5, -200, 0.5, -175),
		ZIndex = 9,
		Parent = CoreGui.RobloxGui
	};
	if hasBackground then 
		AlertViewBacking.ImageTransparency = 0
	else
		AlertViewBacking.Size = UDim2.new(0.8, 0, 0, 350)
		AlertViewBacking.Position = UDim2.new(0.1, 0, 0.1, 0)
	end

	if CoreGui.RobloxGui.AbsoluteSize.Y <= AlertViewBacking.Size.Y.Offset then
		AlertViewBacking.Size = UDim2.new(AlertViewBacking.Size.X.Scale, AlertViewBacking.Size.X.Offset, 
			AlertViewBacking.Size.Y.Scale, CoreGui.RobloxGui.AbsoluteSize.Y)
		AlertViewBacking.Position = UDim2.new(0.5, -AlertViewBacking.Size.X.Offset/2, 0.5, -AlertViewBacking.Size.Y.Offset/2)
	end

	local AlertViewText = Util.Create'TextLabel'
	{
		Name = "AlertViewText",
		BackgroundTransparency = 1,
		Size = UDim2.new(0.95, 0, 0.6, 0),
		Position = UDim2.new(0.025, 0, 0.05, 0),
		Font = Enum.Font.SourceSansBold,
		FontSize = Enum.FontSize.Size36,
		Text = alertMessage,
		TextWrapped = true,
		TextColor3 = Color3.new(1,1,1),
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		ZIndex = 10,
		Parent = AlertViewBacking
	};

	local SelectionOverrideObject = Util.Create'ImageLabel'
	{
		Image = "",
		BackgroundTransparency = 1
	};

	local removeId = HttpService:GenerateGUID(false)

	local destroyAlert = function()
		AlertViewBacking:Destroy()
		if okPressedFunc then
			okPressedFunc()
		end
		ContextActionService:UnbindAction(removeId)
		Game.GuiService.SelectedObject = nil
		if settingsHub then
			settingsHub:ShowBar()
		end
	end

	local AlertViewButtonSize = UDim2.new(1, -20, 0, 60)
	local AlertViewButtonPosition = UDim2.new(0, 10, 0.65, 0)
	if not hasBackground then 
		AlertViewButtonSize = UDim2.new(0, 200, 0, 50)
		AlertViewButtonPosition = UDim2.new(0.5, -100, 0.65, 0)
	end

	local AlertViewButton, AlertViewText = MakeButton("AlertViewButton", okButtonText, AlertViewButtonSize, destroyAlert)
	AlertViewButton.Position = AlertViewButtonPosition
	AlertViewButton.NextSelectionLeft = AlertViewButton
	AlertViewButton.NextSelectionRight = AlertViewButton
	AlertViewButton.NextSelectionUp = AlertViewButton
	AlertViewButton.NextSelectionDown = AlertViewButton
	AlertViewButton.ZIndex = 10
	AlertViewText.ZIndex = AlertViewButton.ZIndex
	AlertViewButton.Parent = AlertViewBacking

	if usesSelectedObject() then
		Game.GuiService.SelectedObject = AlertViewButton
	end

	GuiService.SelectedObject = AlertViewButton

	ContextActionService:BindAction(removeId, destroyAlert, false, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonA)

	if settingsHub then
		settingsHub:HideBar()
		settingsHub.Pages.CurrentPage:Hide(1, 1)
	end
end

local function CreateNewSlider(numOfSteps, startStep, minStep)
	-------------------- SETUP ------------------------
	local this = {}

	local spacing = 4
	local initialSpacing = 8
	local steps = tonumber(numOfSteps)
	local currentStep = startStep

	local lastInputDirection = 0
	local timeAtLastInput = nil

	local interactable = true

	local renderStepBindName = HttpService:GenerateGUID(false)

	-- this is done to prevent using these values below (trying to keep the variables consistent)
	numOfSteps = ""
	startStep = ""

	if steps <= 0 then
		error("CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer")
		return
	end

	local valueChangedEvent = Instance.new("BindableEvent")
	valueChangedEvent.Name = "ValueChanged"

	----------------- GUI SETUP ------------------------
	this.SliderFrame = Util.Create'ImageButton'
	{
		Name = "Slider",
		Image = "",
		AutoButtonColor = false,
		NextSelectionLeft = this.SliderFrame,
		NextSelectionRight = this.SliderFrame,
		BackgroundTransparency = 1,
		Size = UDim2.new(0,502,0,50),
		SelectionImageObject = noSelectionObject,
		ZIndex = 2
	};
	if isSmallTouchScreen() then
		this.SliderFrame.Size = UDim2.new(0,400,0,30)
	end

	local leftButton = Util.Create'ImageButton'
	{
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(0,0,0.5,-25),
		Size =  UDim2.new(0,50,0,50),
		Image =  "",
		ZIndex = 2,
		Selectable = false,
		Active = true,
		Parent = this.SliderFrame
	};
	local rightButton = Util.Create'ImageButton'
	{
		Name = "RightButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(1,-50,0.5,-25),
		Size =  UDim2.new(0,50,0,50),
		Image =  "",
		ZIndex = 2,
		Selectable = false,
		Active = true,
		Parent = this.SliderFrame
	};

	local leftButtonImage = Util.Create'ImageLabel'
	{
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(1,-24,0.5,-15),
		Size =  UDim2.new(0,18,0,30),
		Image =  "rbxasset://textures/ui/Settings/Slider/Left.png",
		ZIndex = 2,
		Parent = leftButton
	};
	local rightButtonImage = Util.Create'ImageLabel'
	{
		Name = "RightButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(0,6,0.5,-15),
		Size =  UDim2.new(0,18,0,30),
		Image =  "rbxasset://textures/ui/Settings/Slider/Right.png",
		ZIndex = 2,
		Parent = rightButton
	};


	this.Steps = {}
	local stepXSize = 35
	if isSmallTouchScreen() then
		stepXSize = 25
	end

	for i = 1, steps do
		local nextStep = Util.Create'ImageButton'
		{
			Name = "Step" .. tostring(i),
			BackgroundColor3 = SELECTED_COLOR,
			BackgroundTransparency = 0.36,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Active = false,
			Position = UDim2.new(0,initialSpacing + leftButton.Size.X.Offset + ((stepXSize + spacing) * (i - 1)),0.5,-12),
			Size =  UDim2.new(0,stepXSize,0, 24),
			Image =  "",
			ZIndex = 2,
			Selectable = false,
			ImageTransparency = 0.36,
			Parent = this.SliderFrame
		};

		if i > currentStep then
			nextStep.BackgroundColor3 = NON_SELECTED_COLOR
		end

		if i == 1 or i == steps then
			nextStep.BackgroundTransparency = 1
			nextStep.ScaleType = Enum.ScaleType.Slice
			nextStep.SliceCenter = Rect.new(3,3,32,21)

			if i <= currentStep then
				if i == 1 then
					nextStep.Image = SELECTED_LEFT_IMAGE
				else
					nextStep.Image = SELECTED_RIGHT_IMAGE
				end
			else
				if i == 1 then
					nextStep.Image = NON_SELECTED_LEFT_IMAGE
				else
					nextStep.Image = NON_SELECTED_RIGHT_IMAGE
				end
			end
		end

		this.Steps[#this.Steps + 1] = nextStep
	end

	local xSize = initialSpacing + (leftButton.Size.X.Offset) + this.Steps[#this.Steps].Size.X.Offset + 
		this.Steps[#this.Steps].Position.X.Offset
	this.SliderFrame.Size = UDim2.new(0, xSize, 0, this.SliderFrame.Size.Y.Offset)


	------------------- FUNCTIONS ---------------------
	local function hideSelection()
		for i = 1, steps do
			this.Steps[i].BackgroundColor3 = NON_SELECTED_COLOR
			if i == 1 then
				this.Steps[i].Image = NON_SELECTED_LEFT_IMAGE
			elseif i == steps then
				this.Steps[i].Image = NON_SELECTED_RIGHT_IMAGE
			end
		end
	end
	local function showSelection()
		for i = 1, steps do
			if i > currentStep then break end
			this.Steps[i].BackgroundColor3 = SELECTED_COLOR
			if i == 1 then
				this.Steps[i].Image = SELECTED_LEFT_IMAGE
			elseif i == steps then
				this.Steps[i].Image = SELECTED_RIGHT_IMAGE
			end
		end
	end
	local function modifySelection(alpha)
		for i = 1, steps do
			if i == 1 or i == steps then
				this.Steps[i].ImageTransparency = alpha
			else
				this.Steps[i].BackgroundTransparency = alpha
			end
		end
	end

	local function setCurrentStep(newStepPosition)
		if not minStep then minStep = 0 end

		leftButton.Visible = true
		rightButton.Visible = true

		if newStepPosition <= minStep then 
			newStepPosition = minStep 
			leftButton.Visible = false
		end
		if newStepPosition >= steps then
			newStepPosition = steps
			rightButton.Visible = false
		end

		if currentStep == newStepPosition then return end

		currentStep = newStepPosition

		hideSelection()
		showSelection()

		timeAtLastInput = tick()
		valueChangedEvent:Fire(currentStep)
	end

	local function mouseDownFunc(inputObject, newStepPos, repeatAction)
		if not interactable then return end

		if inputObject == nil then return end
		if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and inputObject.UserInputType ~= Enum.UserInputType.Touch then return end

		if usesSelectedObject() then
			GuiService.SelectedObject = this.SliderFrame
		end

		if repeatAction then
			lastInputDirection = newStepPos - currentStep
		else
			lastInputDirection = 0

			local mouseInputMovedCon = nil
			local mouseInputEndedCon = nil
			mouseInputMovedCon = UserInputService.InputChanged:connect(function( inputObject )
				if inputObject.UserInputType ~= Enum.UserInputType.MouseMovement and inputObject.UserInputType ~= Enum.UserInputType.Touch then return end

				local mousePos = inputObject.Position.X
				for i = 1, steps do
					local stepPosition = this.Steps[i].AbsolutePosition.X
					local stepSize = this.Steps[i].AbsoluteSize.X
					if mousePos >= stepPosition and mousePos <= stepPosition + stepSize then
						setCurrentStep(i)
						break
					elseif i == 1 and mousePos < stepPosition then
						setCurrentStep(0)
						break
					elseif i == steps and mousePos >= stepPosition then
						setCurrentStep(i)
						break
					end
				end
			end)
			mouseInputEndedCon = UserInputService.InputEnded:connect(function( inputObject )
				if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and inputObject.UserInputType ~= Enum.UserInputType.Touch then return end

				lastInputDirection = 0
				mouseInputEndedCon:disconnect()
				mouseInputMovedCon:disconnect()
			end)
		end

		setCurrentStep(newStepPos)
	end

	local function mouseUpFunc(inputObject)
		if not interactable then return end
		if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

		lastInputDirection = 0
	end

	local function touchClickFunc(inputObject, newStepPos, repeatAction)
		mouseDownFunc(inputObject, newStepPos, repeatAction)
	end

	--------------------- PUBLIC FACING FUNCTIONS -----------------------
	this.ValueChanged = valueChangedEvent.Event

	function this:SetValue(newValue)
		setCurrentStep(newValue)
	end

	function this:GetValue()
		return currentStep
	end

	function this:SetInteractable(value)
		lastInputDirection = 0
		interactable = value
		this.SliderFrame.Selectable = value
		if not interactable then
			hideSelection()
		else
			showSelection()
		end
	end

	function this:SetZIndex(newZIndex)
		leftButton.ZIndex = newZIndex
		rightButton.ZIndex = newZIndex
		leftButtonImage.ZIndex = newZIndex
		rightButtonImage.ZIndex = newZIndex

		for i = 1, #this.Steps do
			this.Steps[i].ZIndex = newZIndex
		end
	end

	function this:SetMinStep(newMinStep)
		if newMinStep >= 0 and newMinStep <= steps then
			minStep = newMinStep
		end

		if currentStep <= minStep then 
			currentStep = minStep 
			leftButton.Visible = false
		end
		if currentStep >= steps then
			currentStep = steps
			rightButton.Visible = false
		end
	end

	--------------------- SETUP -----------------------

	leftButton.InputBegan:connect(function(inputObject) mouseDownFunc(inputObject, currentStep - 1, true) end)
	leftButton.InputEnded:connect(function(inputObject) mouseUpFunc(inputObject) end)
	leftButton.MouseButton1Click:connect(function()
		if UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then
			touchClickFunc(inputObject, currentStep - 1, true)
		end
	end)
	rightButton.InputBegan:connect(function(inputObject) mouseDownFunc(inputObject, currentStep + 1, true) end)
	rightButton.InputEnded:connect(function(inputObject) mouseUpFunc(inputObject) end)
	rightButton.MouseButton1Click:connect(function()
		if UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then
			touchClickFunc(inputObject, currentStep + 1, true)
		end
	end)

	for i = 1, steps do
		this.Steps[i].InputBegan:connect(function(inputObject) mouseDownFunc(inputObject, i) end)
		this.Steps[i].InputEnded:connect(function(inputObject) mouseUpFunc(inputObject) end)
	end

	this.SliderFrame.InputBegan:connect(function(inputObject) mouseDownFunc(inputObject, currentStep) end)
	this.SliderFrame.InputEnded:connect(function(inputObject) mouseUpFunc(inputObject) end)


	local stepSliderFunc = function()
		if timeAtLastInput == nil then return end

		local currentTime = tick()
		local timeSinceLastInput = currentTime - timeAtLastInput

		if timeSinceLastInput >= CONTROLLER_SCROLL_DELTA then
			setCurrentStep(currentStep + lastInputDirection)
		end
	end

	local isInTree = true
	UserInputService.InputBegan:connect(function(inputObject)
		if not interactable then return end
		if not isInTree then return end

		if inputObject.UserInputType ~= Enum.UserInputType.Gamepad1 and inputObject.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if GuiService.SelectedObject ~= this.SliderFrame then return end

		if inputObject.KeyCode == Enum.KeyCode.DPadLeft or inputObject.KeyCode == Enum.KeyCode.Left or inputObject.KeyCode == Enum.KeyCode.A then
			lastInputDirection = -1
			setCurrentStep(currentStep - 1)
		elseif inputObject.KeyCode == Enum.KeyCode.DPadRight or inputObject.KeyCode == Enum.KeyCode.Right or inputObject.KeyCode == Enum.KeyCode.D then
			lastInputDirection = 1
			setCurrentStep(currentStep + 1)
		end
	end)

	UserInputService.InputEnded:connect(function(inputObject)
		if not interactable then return end

		if inputObject.UserInputType ~= Enum.UserInputType.Gamepad1 and inputObject.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if GuiService.SelectedObject ~= this.SliderFrame then return end

		if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 or inputObject.KeyCode == Enum.KeyCode.DPadLeft 
			or inputObject.KeyCode == Enum.KeyCode.DPadRight or inputObject.KeyCode == Enum.KeyCode.Left
			or inputObject.KeyCode == Enum.KeyCode.A or inputObject.KeyCode == Enum.KeyCode.Right or inputObject.KeyCode == Enum.KeyCode.D then
			lastInputDirection = 0
		end
	end)

	UserInputService.InputChanged:connect(function(inputObject)
		if not interactable then 
			lastInputDirection = 0
			return 
		end
		if not isInTree then
			lastInputDirection = 0
			return 
		end

		if inputObject.UserInputType ~= Enum.UserInputType.Gamepad1 then return end
		if GuiService.SelectedObject ~= this.SliderFrame then return end
		if inputObject.KeyCode ~= Enum.KeyCode.Thumbstick1 then return end

		if inputObject.Position.X > CONTROLLER_THUMBSTICK_DEADZONE and inputObject.Delta.X > 0 and lastInputDirection ~= 1 then
			lastInputDirection = 1
			setCurrentStep(currentStep + 1)
		elseif inputObject.Position.X < -CONTROLLER_THUMBSTICK_DEADZONE and inputObject.Delta.X < 0 and lastInputDirection ~= -1 then
			lastInputDirection = -1
			setCurrentStep(currentStep - 1)
		elseif math.abs(inputObject.Position.X) < CONTROLLER_THUMBSTICK_DEADZONE then
			lastInputDirection = 0
		end
	end)
	--[[
		GuiService.Changed:connect(function(prop)
			if prop ~= "SelectedObject" then return end

			if GuiService.SelectedObject == this.SliderFrame then
				modifySelection(0)
				RunService:BindToRenderStep(renderStepBindName, Enum.RenderPriority.Input.Value + 1, stepSliderFunc)
			else
				modifySelection(0.36)
				RunService:UnbindFromRenderStep(renderStepBindName)
			end
		end)
	--]]
	this.SliderFrame.AncestryChanged:connect(function(child, parent)
		isInTree = parent
	end)

	setCurrentStep(currentStep)

	return this
end

local ROW_HEIGHT = 50
if isTenFootInterface() then ROW_HEIGHT = 90 end

local nextPosTable = {}
local function AddNewRow(pageToAddTo, rowDisplayName, selectionType, rowValues, rowDefault, extraSpacing)
	local nextRowPositionY = 0
	local isARealRow = selectionType ~= 'TextBox' -- Textboxes are constructed in this function - they don't have an associated class.

	if nextPosTable[pageToAddTo] then
		nextRowPositionY = nextPosTable[pageToAddTo]
	end

	local RowFrame = nil
	RowFrame = Util.Create'ImageButton'
	{
		Name = rowDisplayName .. "Frame",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "",
		Active = false,
		AutoButtonColor = false,
		Size = UDim2.new(1,0,0,ROW_HEIGHT),
		Position = UDim2.new(0,0,0,nextRowPositionY),
		ZIndex = 2,
		Selectable = false,
		Parent = pageToAddTo.Page
	};

	if RowFrame and extraSpacing then
		RowFrame.Position = UDim2.new(RowFrame.Position.X.Scale,RowFrame.Position.X.Offset,
			RowFrame.Position.Y.Scale,RowFrame.Position.Y.Offset + extraSpacing)
	end

	local RowLabel = nil
	RowLabel = Util.Create'TextLabel'
	{
		Name = rowDisplayName .. "Label",
		Text = rowDisplayName,
		Font = Enum.Font.SourceSansBold,
		FontSize = Enum.FontSize.Size24,
		TextColor3 = Color3.new(1,1,1),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Size = UDim2.new(0,200,1,0),
		Position = UDim2.new(0,10,0,0),
		ZIndex = 2,
		Parent = RowFrame
	};
	if isTenFootInterface() then
		RowLabel.FontSize = Enum.FontSize.Size36
	end
	if not isARealRow then
		RowLabel.Text = ''
	end

	local ValueChangerSelection = nil
	local ValueChangerInstance = nil
	if selectionType == "Slider" then
		ValueChangerInstance = CreateNewSlider(rowValues, rowDefault)	
		ValueChangerInstance.SliderFrame.Position = UDim2.new(1,-ValueChangerInstance.SliderFrame.Size.X.Offset,
			0.5,-ValueChangerInstance.SliderFrame.Size.Y.Offset/2)
		ValueChangerInstance.SliderFrame.Parent = RowFrame
		ValueChangerSelection = ValueChangerInstance.SliderFrame
	elseif selectionType == "Selector" then
		ValueChangerInstance = CreateSelector(rowValues, rowDefault)
		ValueChangerInstance.SelectorFrame.Position = UDim2.new(1,-ValueChangerInstance.SelectorFrame.Size.X.Offset,
			0.5,-ValueChangerInstance.SelectorFrame.Size.Y.Offset/2)
		ValueChangerInstance.SelectorFrame.Parent = RowFrame
		ValueChangerSelection = ValueChangerInstance.SelectorFrame
	elseif selectionType == "DropDown" then
		ValueChangerInstance = CreateDropDown(rowValues, rowDefault, pageToAddTo.HubRef)
		ValueChangerInstance.DropDownFrame.Position = UDim2.new(1,-ValueChangerInstance.DropDownFrame.Size.X.Offset - 50,
			0.5,-ValueChangerInstance.DropDownFrame.Size.Y.Offset/2)
		ValueChangerInstance.DropDownFrame.Parent = RowFrame
		ValueChangerSelection = ValueChangerInstance.DropDownFrame
	elseif selectionType == "TextBox" then
		local isMouseOverRow = false
		local forceReturnSelectionOnFocusLost = false
		local SelectionOverrideObject = Util.Create'ImageLabel'
		{
			Image = "",
			BackgroundTransparency = 1,
		};

		ValueChangerInstance = {}
		ValueChangerInstance.HubRef = nil

		local box = Util.Create'TextBox'
		{
			Size = UDim2.new(1,-10,0,100),
			Position = UDim2.new(0,5,0,nextRowPositionY),
			Text = rowDisplayName,
			TextColor3 = Color3.new(49/255, 49/255, 49/255),
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			Font = Enum.Font.SourceSans,
			FontSize = Enum.FontSize.Size24,
			ZIndex = 2,
			SelectionImageObject = SelectionOverrideObject,
			ClearTextOnFocus = false,
			Parent = pageToAddTo.Page
		};
		ValueChangerSelection = box

		box.Focused:connect(function()
			if usesSelectedObject() then
				GuiService.SelectedObject = box
			end

			if box.Text == rowDisplayName then
				box.Text = ""
			end
		end)
		box.FocusLost:connect(function(enterPressed, inputObject)
			if GuiService.SelectedObject == box and (not isMouseOverRow or forceReturnSelectionOnFocusLost) then
				GuiService.SelectedObject = nil
			end
			forceReturnSelectionOnFocusLost = false
		end)
		if extraSpacing then
			box.Position = UDim2.new(box.Position.X.Scale,box.Position.X.Offset,
				box.Position.Y.Scale,box.Position.Y.Offset + extraSpacing)
		end

		ValueChangerSelection.SelectionGained:connect(function()
			if usesSelectedObject() then
				box.BackgroundTransparency = 0.1

				if ValueChangerInstance.HubRef then
					ValueChangerInstance.HubRef:ScrollToFrame(ValueChangerSelection)
				end
			end
		end)
		ValueChangerSelection.SelectionLost:connect(function()
			if usesSelectedObject() then
				box.BackgroundTransparency = 0.5
			end
		end)

		local setRowSelection = function()
			local fullscreenDropDown = CoreGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
			if fullscreenDropDown and fullscreenDropDown.Visible then return end

			local valueFrame = ValueChangerSelection

			if valueFrame and valueFrame.Visible and valueFrame.ZIndex > 1 and usesSelectedObject() and pageToAddTo.Active then
				GuiService.SelectedObject = valueFrame
				isMouseOverRow = true
			end
		end
		local function processInput(input)
			if input.UserInputState == Enum.UserInputState.Begin then
				if input.KeyCode == Enum.KeyCode.Return then
					if GuiService.SelectedObject == ValueChangerSelection then
						forceReturnSelectionOnFocusLost = true
						box:CaptureFocus()
					end
				end
			end
		end
		RowFrame.MouseEnter:connect(setRowSelection)
		RowFrame.Size = UDim2.new(1, 0, 0, 100)

		UserInputService.InputBegan:connect(processInput)
	end

	ValueChangerInstance.Name = rowDisplayName .. "ValueChanger"

	nextRowPositionY = nextRowPositionY + ROW_HEIGHT
	if extraSpacing then
		nextRowPositionY = nextRowPositionY + extraSpacing
	end

	nextPosTable[pageToAddTo] = nextRowPositionY

	if isARealRow then
		local setRowSelection = function()
			local fullscreenDropDown = CoreGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
			if fullscreenDropDown and fullscreenDropDown.Visible then return end

			local valueFrame = ValueChangerInstance.SliderFrame 
			if not valueFrame then
				valueFrame = ValueChangerInstance.SliderFrame
			end
			if not valueFrame then
				valueFrame = ValueChangerInstance.DropDownFrame
			end
			if not valueFrame then
				valueFrame = ValueChangerInstance.SelectorFrame
			end

			if valueFrame and valueFrame.Visible and valueFrame.ZIndex > 1 and usesSelectedObject() and pageToAddTo.Active then
				GuiService.SelectedObject = valueFrame
			end
		end
		RowFrame.MouseEnter:connect(setRowSelection)

		ValueChangerSelection.SelectionGained:connect(function()
			if usesSelectedObject() then
				RowFrame.BackgroundTransparency = 0.5

				if ValueChangerInstance.HubRef then
					ValueChangerInstance.HubRef:ScrollToFrame(RowFrame)
				end
			end
		end)
		ValueChangerSelection.SelectionLost:connect(function()
			if usesSelectedObject() then
				RowFrame.BackgroundTransparency = 1
			end
		end)
	end

	pageToAddTo:AddRow(RowFrame, RowLabel, ValueChangerInstance, extraSpacing, false)

	ValueChangerInstance.Selection = ValueChangerSelection

	return RowFrame, RowLabel, ValueChangerInstance
end

local function AddNewRowObject(pageToAddTo, rowDisplayName, rowObject, extraSpacing)
	local nextRowPositionY = 0

	if nextPosTable[pageToAddTo] then
		nextRowPositionY = nextPosTable[pageToAddTo]
	end

	local RowFrame = Util.Create'ImageButton'
	{
		Name = rowDisplayName .. "Frame",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "",
		Active = false,
		AutoButtonColor = false,
		Size = UDim2.new(1,0,0,ROW_HEIGHT),
		Position = UDim2.new(0,0,0,nextRowPositionY),
		ZIndex = 2,
		Selectable = false,
		SelectionImageObject = noSelectionObject,
		Parent = pageToAddTo.Page
	};
	RowFrame.SelectionGained:connect(function()
		RowFrame.BackgroundTransparency = 0.5
	end)
	RowFrame.SelectionLost:connect(function()
		RowFrame.BackgroundTransparency = 1
	end)

	local RowLabel = Util.Create'TextLabel'
	{
		Name = rowDisplayName .. "Label",
		Text = rowDisplayName,
		Font = Enum.Font.SourceSansBold,
		FontSize = Enum.FontSize.Size24,
		TextColor3 = Color3.new(1,1,1),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Size = UDim2.new(0,200,1,0),
		Position = UDim2.new(0,10,0,0),
		ZIndex = 2,
		Parent = RowFrame
	};
	if isTenFootInterface() then
		RowLabel.FontSize = Enum.FontSize.Size36
	end

	if extraSpacing then
		RowFrame.Position = UDim2.new(RowFrame.Position.X.Scale,RowFrame.Position.X.Offset,
			RowFrame.Position.Y.Scale,RowFrame.Position.Y.Offset + extraSpacing)
	end

	nextRowPositionY = nextRowPositionY + ROW_HEIGHT
	if extraSpacing then
		nextRowPositionY = nextRowPositionY + extraSpacing
	end

	nextPosTable[pageToAddTo] = nextRowPositionY

	local setRowSelection = function()
		if RowFrame.Visible then
			GuiService.SelectedObject = RowFrame
		end
	end
	RowFrame.MouseEnter:connect(setRowSelection)

	rowObject.SelectionImageObject = noSelectionObject

	rowObject.SelectionGained:connect(function()
		RowFrame.BackgroundTransparency = 0.5
	end)
	rowObject.SelectionLost:connect(function()
		RowFrame.BackgroundTransparency = 1
	end)

	rowObject.Parent = RowFrame

	pageToAddTo:AddRow(RowFrame, RowLabel, rowObject, extraSpacing, true)
	return RowFrame
end

-------- public facing API ----------------
local moduleApiTable = {}

function moduleApiTable:Create(instanceType)
	return function(data)
		local obj = Instance.new(instanceType)
		for k, v in pairs(data) do
			if type(k) == 'number' then
				v.Parent = obj
			else
				obj[k] = v
			end
		end
		return obj
	end
end

function moduleApiTable:GetEaseLinear()
	return Linear
end
function moduleApiTable:GetEaseOutQuad()
	return EaseOutQuad
end
function moduleApiTable:GetEaseInOutQuad()
	return EaseInOutQuad
end

function moduleApiTable:CreateNewSlider(numOfSteps, startStep, minStep)
	return CreateNewSlider(numOfSteps, startStep, minStep)
end

function moduleApiTable:CreateNewSelector(selectionStringTable, startPosition)
	return CreateSelector(selectionStringTable, startPosition)
end

function moduleApiTable:CreateNewDropDown(dropDownStringTable, startPosition)
	return CreateDropDown(dropDownStringTable, startPosition, nil)
end

function moduleApiTable:AddNewRow(pageToAddTo, rowDisplayName, selectionType, rowValues, rowDefault, extraSpacing)
	return AddNewRow(pageToAddTo, rowDisplayName, selectionType, rowValues, rowDefault, extraSpacing)
end

function moduleApiTable:AddNewRowObject(pageToAddTo, rowDisplayName, rowObject, extraSpacing)
	return AddNewRowObject(pageToAddTo, rowDisplayName, rowObject, extraSpacing)
end

function moduleApiTable:ShowAlert(alertMessage, okButtonText, settingsHub, okPressedFunc, hasBackground)
	ShowAlert(alertMessage, okButtonText, settingsHub, okPressedFunc, hasBackground)
end

function moduleApiTable:IsSmallTouchScreen()
	return isSmallTouchScreen()
end

function moduleApiTable:MakeStyledButton(name, text, size, clickFunc, pageRef, hubRef)
	return MakeButton(name, text, size, clickFunc, pageRef, hubRef)
end

function moduleApiTable:CreateSignal()
	return CreateSignal()
end

function  moduleApiTable:UsesSelectedObject()
	return usesSelectedObject();
end

function moduleApiTable:TweenProperty(instance, prop, start, final, duration, easingFunc, cbFunc)
	return PropertyTweener(instance, prop, start, final, duration, easingFunc, cbFunc)
end

return moduleApiTable
end;
};
G2L_MODULES[G2L["e"]] = {
Closure = function()
    local script = G2L["e"];--!nocheck

--[[
		Filename: SettingsHub.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Controls the settings menu navigation and contains the settings pages
--]]

--[[ CONSTANTS ]]
local SETTINGS_SHIELD_COLOR = Color3.new(41/255,41/255,41/255)
local SETTINGS_SHIELD_TRANSPARENCY = 0.2
local SETTINGS_SHIELD_SIZE = UDim2.new(1, 0, 1, 0)
local SETTINGS_SHIELD_INACTIVE_POSITION = UDim2.new(0,0,-1,-36)
local SETTINGS_SHIELD_ACTIVE_POSITION = UDim2.new(0, 0, 0, 0)
local SETTINGS_BASE_ZINDEX = 2
local DEV_CONSOLE_ACTION_NAME = "Open Dev Console"

--[[ SERVICES ]]
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = _G:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--[[ UTILITIES ]]
local utility = require(RobloxGui.Modules.Settings.Utility)

--[[ VARIABLES ]]
local isTouchDevice = UserInputService.TouchEnabled
local isSmallTouchScreen = utility:IsSmallTouchScreen()
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()
-- TODO: Change dev console script to parent this to somewhere other than an engine created gui
local ControlFrame = RobloxGui:WaitForChild('ControlFrame')
local ToggleDevConsoleBindableFunc = ControlFrame:WaitForChild('ToggleDevConsole')
local lastInputChangedCon = nil
local chatWasVisible = false 
local userlistSuccess, userlistFlagValue = pcall(function() return _G:GetService("GlobalSettings"):GetFFlag("UseUserListMenu") end)
local useUserList = true

--[[ CORE MODULES ]]
local playerList = require(RobloxGui.Modules.PlayerlistModule)
local chat = require(RobloxGui.Modules.Chat)
local backpack = require(RobloxGui.Modules.BackpackScript)

if isSmallTouchScreen or isTenFootInterface then
	SETTINGS_SHIELD_ACTIVE_POSITION = UDim2.new(0,0,0,0)
	SETTINGS_SHIELD_SIZE = UDim2.new(1,0,1,0)
end

local function CreateSettingsHub()
	local this = {}
	this.Visible = false
	this.Active = false
	this.Pages = {CurrentPage = nil, PageTable = {}}
	this.MenuStack = {}
	this.TabHeaders = {}
	this.BottomBarButtons = {}
	this.TabConnection = nil
	this.LeaveGamePage = require(RobloxGui.Modules.Settings.Pages.LeaveGame)
	this.ResetCharacterPage = require(RobloxGui.Modules.Settings.Pages.ResetCharacter)
	this.SettingsShowSignal = utility:CreateSignal()
	this.OpenStateChangedCount = 0

	local pageChangeCon = nil

	local PoppedMenuEvent = Instance.new("BindableEvent")
	PoppedMenuEvent.Name = "PoppedMenu"
	this.PoppedMenu = PoppedMenuEvent.Event

	local function setBottomBarBindings()
		for i = 1, #this.BottomBarButtons do
			local buttonTable = this.BottomBarButtons[i]
			local buttonName = buttonTable[1]
			local hotKeyTable = buttonTable[2]
			ContextActionService:BindAction(buttonName, hotKeyTable[1], false, unpack(hotKeyTable[2]))
		end

		if this.BottomButtonFrame then
			this.BottomButtonFrame.Visible = true
		end
	end

	local function removeBottomBarBindings(delayBeforeRemoving)
		for _, hotKeyTable in pairs(this.BottomBarButtons) do
			ContextActionService:UnbindAction(hotKeyTable[1])
		end

		local myOpenStateChangedCount = this.OpenStateChangedCount
		local remove = function()
			if this.OpenStateChangedCount == myOpenStateChangedCount and this.BottomButtonFrame then
				this.BottomButtonFrame.Visible = false
			end
		end

		if delayBeforeRemoving then
			delay(delayBeforeRemoving, remove)
		else
			remove()
		end
	end

	local function addBottomBarButton(name, text, gamepadImage, keyboardImage, position, clickFunc, hotkeys)
		local buttonName = name .. "Button"
		local textName = name .. "Text"

		local size = UDim2.new(0,260,0,70)
		if isTenFootInterface then
			size = UDim2.new(0,320,0,120)
		end

		this[buttonName], this[textName] = utility:MakeStyledButton(name .. "Button", text, size, clickFunc, nil, this)
		this[buttonName].Position = position
		this[buttonName].Parent = this.BottomButtonFrame
		if isTenFootInterface then
			this[buttonName].ImageTransparency = 1
		end

		this[textName].FontSize = Enum.FontSize.Size24
		local hintLabel = nil

		if not isTouchDevice then
			this[textName].Size = UDim2.new(1,0,1,0)
			if isTenFootInterface then
				this[textName].Position = UDim2.new(0,60,0,-4)
			else
				this[textName].Position = UDim2.new(0,10,0,-4)
			end

			local hintNameText = name .. "HintText"
			local hintName = name .. "Hint"
			local image = ""
			if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) or isTenFootInterface then
				image = gamepadImage
			else
				image = keyboardImage
			end

			hintLabel = utility:Create'ImageLabel'
			{
				Name = hintName,
				Size = UDim2.new(0,60,0,60),
				Position = UDim2.new(0,10,0,5),
				ZIndex = this.Shield.ZIndex + 2,
				BackgroundTransparency = 1,
				Image = image,
				Parent = this[buttonName]
			};
			if isTenFootInterface then
				hintLabel.Size = UDim2.new(0,90,0,90)
				hintLabel.Position = UDim2.new(0,10,0.5,-45)
			elseif UserInputService.MouseEnabled then
				hintLabel.Image = keyboardImage
				hintLabel.Size = UDim2.new(0,48,0,48)
				hintLabel.Position = UDim2.new(0,10,0,8)
			end
		end

		if isTenFootInterface then
			this[textName].FontSize = Enum.FontSize.Size36
		end

		UserInputService.InputBegan:connect(function(inputObject)
			if inputObject.UserInputType == Enum.UserInputType.Gamepad1 or inputObject.UserInputType == Enum.UserInputType.Gamepad2 or
				inputObject.UserInputType == Enum.UserInputType.Gamepad3 or inputObject.UserInputType == Enum.UserInputType.Gamepad4 then
				if hintLabel then
					hintLabel.Image = gamepadImage
					if isTenFootInterface then
						hintLabel.Size = UDim2.new(0,90,0,90)
						hintLabel.Position = UDim2.new(0,10,0.5,-45)
					else
						hintLabel.Size = UDim2.new(0,60,0,60)
						hintLabel.Position = UDim2.new(0,10,0,5)
					end
				end
			elseif inputObject.UserInputType == Enum.UserInputType.Keyboard then
				if hintLabel then
					hintLabel.Image = keyboardImage
					hintLabel.Size = UDim2.new(0,48,0,48)
					hintLabel.Position = UDim2.new(0,10,0,8)
				end
			end
		end)

		local hotKeyFunc = function(contextName, inputState, inputObject)
			if inputState == Enum.UserInputState.Begin then
				clickFunc()
			end
		end

		local hotKeyTable = {hotKeyFunc, hotkeys}
		this.BottomBarButtons[#this.BottomBarButtons + 1] = {buttonName, hotKeyTable}
	end

	local function createGui()
		local PageViewSizeReducer = 0
		if isSmallTouchScreen then
			PageViewSizeReducer = 5
		end

		local clippingShield = utility:Create'Frame'
		{
			Name = "SettingsShield",
			Size = SETTINGS_SHIELD_SIZE,
			Position = SETTINGS_SHIELD_ACTIVE_POSITION,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			BackgroundTransparency = 1,
			Visible = true,
			ZIndex = SETTINGS_BASE_ZINDEX,
			Parent = RobloxGui
		};

		this.Shield = utility:Create'Frame'
		{
			Name = "SettingsShield",
			Size = UDim2.new(1,0,1,0),
			Position = SETTINGS_SHIELD_INACTIVE_POSITION,
			BackgroundTransparency = SETTINGS_SHIELD_TRANSPARENCY,
			BackgroundColor3 = SETTINGS_SHIELD_COLOR,
			BorderSizePixel = 0,
			Visible = false,
			Active = true,
			ZIndex = SETTINGS_BASE_ZINDEX,
			Parent = clippingShield
		};

		this.Modal = utility:Create'TextButton' -- Force unlocks the mouse, really need a way to do this via UIS
		{
			Name = 'Modal',
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 1, -1),
			Size = UDim2.new(1, 0, 1, 0),
			Modal = true,
			Text = '',
			Parent = this.Shield
		}

		this.HubBar = utility:Create'ImageLabel'
		{
			Name = "HubBar",
			ZIndex = this.Shield.ZIndex + 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(78/255, 84/255, 96/255),
			BackgroundTransparency = 1,
			Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuBackground.png",
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(4,4,6,6),
			Parent = this.Shield
		};

		local barHeight = 60
		if isSmallTouchScreen then
			barHeight = 40
			this.HubBar.Size = UDim2.new(1,-10,0,40)
			this.HubBar.Position = UDim2.new(0,5,0,6)
		elseif isTenFootInterface then
			barHeight = 100
			this.HubBar.Size = UDim2.new(0,1200,0,100)
			this.HubBar.Position = UDim2.new(0.5,-600,0.1,0)
		else
			this.HubBar.Size = UDim2.new(0,800,0,60)
			this.HubBar.Position = UDim2.new(0.5,-400,0.1,0)
		end

		this.PageViewClipper = utility:Create'Frame'
		{
			Name = 'PageViewClipper',
			BackgroundTransparency = 1,
			Size = UDim2.new(this.HubBar.Size.X.Scale,this.HubBar.Size.X.Offset,
				1, -this.HubBar.Size.Y.Offset - this.HubBar.Position.Y.Offset - PageViewSizeReducer),
			Position = UDim2.new(this.HubBar.Position.X.Scale, this.HubBar.Position.X.Offset,
				this.HubBar.Position.Y.Scale, this.HubBar.Position.Y.Offset + this.HubBar.Size.Y.Offset + 1),
			ClipsDescendants = true,
			Parent = this.Shield,

			utility:Create'ImageButton'{
				Name = 'InputCapture',
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Image = ''
			}
		}

		this.PageView = utility:Create'ScrollingFrame'
		{
			Name = "PageView",
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = this.Shield.ZIndex,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Selectable = false,
			Parent = this.PageViewClipper,
		};
		if UserInputService.MouseEnabled then
			this.PageViewClipper.Size = UDim2.new(this.HubBar.Size.X.Scale,this.HubBar.Size.X.Offset,
				0.5, -(this.HubBar.Position.Y.Offset - this.HubBar.Size.Y.Offset))
		end

		if isSmallTouchScreen then
			this.PageView.CanvasSize = this.PageViewClipper.Size
		else
			local bottomOffset = 0
			if isTouchDevice and not UserInputService.MouseEnabled then
				bottomOffset = 80
			end
			this.BottomButtonFrame = utility:Create'Frame'
			{
				Name = "BottomButtonFrame",
				Size = this.HubBar.Size,
				Position = UDim2.new(0.5, -this.HubBar.Size.X.Offset/2, 1-this.HubBar.Position.Y.Scale-this.HubBar.Size.Y.Scale, -this.HubBar.Position.Y.Offset-this.HubBar.Size.Y.Offset),
				ZIndex = this.Shield.ZIndex + 1,
				BackgroundTransparency = 1,
				Parent = this.Shield
			};

			local leaveGameFunc = function()
				this:AddToMenuStack(this.Pages.CurrentPage)
				this.HubBar.Visible = false
				removeBottomBarBindings()
				this:SwitchToPage(this.LeaveGamePage, nil, 1, true)
			end

			local resetCharFunc = function()
				this:AddToMenuStack(this.Pages.CurrentPage)
				this.HubBar.Visible = false
				removeBottomBarBindings()
				this:SwitchToPage(this.ResetCharacterPage, nil, 1, true)
			end

			-- Xbox Only
			local inviteToGameFunc = function()
				local platformService = game:GetService('PlatformService')
				if platformService then
					platformService:PopupGameInviteUI()
				end
			end

			local resumeFunc = function()
				setVisibilityInternal(false)
			end

			local buttonImageAppend = ""

			if isTenFootInterface then
				buttonImageAppend = "@2x"
			end

			if isTenFootInterface then
				addBottomBarButton("InviteToGame", "Send Game Invites", "rbxasset://textures/ui/Settings/Help/XButtonLight" .. buttonImageAppend .. ".png", 
					"", UDim2.new(0.5,isTenFootInterface and -160 or -130,0.5,-25), 
					inviteToGameFunc, {Enum.KeyCode.ButtonX})
			else
				addBottomBarButton("LeaveGame", "Leave Game", "rbxasset://textures/ui/Settings/Help/XButtonLight" .. buttonImageAppend .. ".png", 
					"rbxasset://textures/ui/Settings/Help/LeaveIcon.png", UDim2.new(0.5,isTenFootInterface and -160 or -130,0.5,-25), 
					leaveGameFunc, {Enum.KeyCode.L, Enum.KeyCode.ButtonX})
			end

			addBottomBarButton("ResetCharacter", "    Reset Character", "rbxasset://textures/ui/Settings/Help/YButtonLight" .. buttonImageAppend .. ".png", 
				"rbxasset://textures/ui/Settings/Help/ResetIcon.png", UDim2.new(0.5,isTenFootInterface and -550 or -400,0.5,-25), 
				resetCharFunc, {Enum.KeyCode.R, Enum.KeyCode.ButtonY})
			addBottomBarButton("Resume", "Resume Game", "rbxasset://textures/ui/Settings/Help/BButtonLight" .. buttonImageAppend .. ".png",
				"rbxasset://textures/ui/Settings/Help/EscapeIcon.png", UDim2.new(0.5,isTenFootInterface and 200 or 140,0.5,-25), 
				resumeFunc, {Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart})
		end


		local function onScreenSizeChanged()
			local largestPageSize = 600
			local fullScreenSize = RobloxGui.AbsoluteSize.y
			local bufferSize = (1-0.95) * fullScreenSize
			if isTenFootInterface then
				largestPageSize = 800
				bufferSize = 0.07 * fullScreenSize
			elseif isSmallTouchScreen then
				bufferSize = (1-0.99) * fullScreenSize
			end
			local barSize = this.HubBar.Size.Y.Offset
			local extraSpace = bufferSize*2+barSize*2


			local usableScreenHeight = fullScreenSize - extraSpace
			local minimumPageSize = 150
			local usePageSize = nil

			if largestPageSize < usableScreenHeight then
				usePageSize = largestPageSize
				this.HubBar.Position = UDim2.new(
					this.HubBar.Position.X.Scale,
					this.HubBar.Position.X.Offset,
					0.5,
					-largestPageSize/2 - this.HubBar.Size.Y.Offset
				)
				if this.BottomButtonFrame then
					this.BottomButtonFrame.Position = UDim2.new(
						this.BottomButtonFrame.Position.X.Scale,
						this.BottomButtonFrame.Position.X.Offset,
						0.5,
						largestPageSize/2
					)
				end
			elseif usableScreenHeight < minimumPageSize then
				usePageSize = minimumPageSize
				this.HubBar.Position = UDim2.new(
					this.HubBar.Position.X.Scale,
					this.HubBar.Position.X.Offset,
					0.5,
					-minimumPageSize/2 - this.HubBar.Size.Y.Offset
				)
				if this.BottomButtonFrame then
					this.BottomButtonFrame.Position = UDim2.new(
						this.BottomButtonFrame.Position.X.Scale,
						this.BottomButtonFrame.Position.X.Offset,
						0.5,
						minimumPageSize/2
					)
				end
			else
				usePageSize = usableScreenHeight
				this.HubBar.Position = UDim2.new(
					this.HubBar.Position.X.Scale,
					this.HubBar.Position.X.Offset,
					0,
					bufferSize
				)
				if this.BottomButtonFrame then
					this.BottomButtonFrame.Position = UDim2.new(
						this.BottomButtonFrame.Position.X.Scale,
						this.BottomButtonFrame.Position.X.Offset,
						1,
						-(bufferSize + barSize)
					)
				end
			end

			if useUserList and not isTenFootInterface then
				if isSmallTouchScreen then
					this.PageViewClipper.Size = UDim2.new(
						this.PageViewClipper.Size.X.Scale,
						this.PageViewClipper.Size.X.Offset,
						0,
						usePageSize + 44
					)
				else
					this.PageViewClipper.Size = UDim2.new(
						this.PageViewClipper.Size.X.Scale,
						this.PageViewClipper.Size.X.Offset,
						0,
						usePageSize
					)
				end
			else
				this.PageViewClipper.Size = UDim2.new(
					this.PageViewClipper.Size.X.Scale,
					this.PageViewClipper.Size.X.Offset,
					0,
					usePageSize
				)
			end
			this.PageViewClipper.Position = UDim2.new(
				this.PageViewClipper.Position.X.Scale,
				this.PageViewClipper.Position.X.Offset,
				0.5,
				-usePageSize/2
			)
		end
		screenSizeChangedCon = RobloxGui.Changed:connect(function(prop)
			if prop == "AbsoluteSize" then
				onScreenSizeChanged()
			end
		end)
		onScreenSizeChanged()
	end

	local function toggleDevConsole(actionName, inputState, inputObject)
		if actionName == DEV_CONSOLE_ACTION_NAME then 	-- ContextActionService->F9
			if inputState and inputState == Enum.UserInputState.Begin and ToggleDevConsoleBindableFunc then
				ToggleDevConsoleBindableFunc:Invoke()
			end
		end
	end

	local lastInputUsedToSelectGui = isTenFootInterface
	UserInputService.InputBegan:connect(function(input)
		if input.UserInputType == Enum.UserInputType.Gamepad1 or input.UserInputType == Enum.UserInputType.Gamepad2 or input.UserInputType == Enum.UserInputType.Gamepad3 or input.UserInputType == Enum.UserInputType.Gamepad4
			or input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.Up or input.KeyCode == Enum.KeyCode.Down or input.KeyCode == Enum.KeyCode.Tab then
			lastInputUsedToSelectGui = true
		elseif input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
			lastInputUsedToSelectGui = false
		end
	end)
	UserInputService.InputChanged:connect(function(input)
		if input.KeyCode == Enum.KeyCode.Thumbstick1 or input.KeyCode == Enum.KeyCode.Thumbstick2 then
			if input.Position.Magnitude >= 0.25 then
				lastInputUsedToSelectGui = true
			end
		elseif input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
			lastInputUsedToSelectGui = false
		end
	end)


	local switchTab = function(direction, cycle)
		local currentTabPosition = GetHeaderPosition(this.Pages.CurrentPage)
		if currentTabPosition < 0 then return end

		local newTabPosition = currentTabPosition + direction
		if cycle then
			if newTabPosition > #this.TabHeaders then
				newTabPosition = 1
			elseif newTabPosition < 1 then
				newTabPosition = #this.TabHeaders
			end
		end
		local newHeader = this.TabHeaders[newTabPosition]

		if newHeader then
			for pager,v in pairs(this.Pages.PageTable) do
				if pager:GetTabHeader() == newHeader then
					this:SwitchToPage(pager, true, direction)
					break
				end
			end
		end
	end

	local switchTabFromBumpers = function(actionName, inputState, inputObject)
		if inputState ~= Enum.UserInputState.Begin then return end

		local direction = 0
		if inputObject.KeyCode == Enum.KeyCode.ButtonR1 then 
			direction = 1
		elseif inputObject.KeyCode == Enum.KeyCode.ButtonL1 then 
			direction = -1
		end

		switchTab(direction, true, true)
	end

	local switchTabFromKeyboard = function(input)
		if input.KeyCode == Enum.KeyCode.Tab then
			local direction = 0
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
				direction = -1
			else
				direction = 1
			end

			switchTab(direction, true, true)
		end
	end

	local scrollHotkeyFunc = function(actionName, inputState, inputObject)
		if inputState ~= Enum.UserInputState.Begin then return end

		local direction = 0
		if inputObject.KeyCode == Enum.KeyCode.PageUp then
			direction = -100
		elseif inputObject.KeyCode == Enum.KeyCode.PageDown then
			direction = 100
		end

		this:ScrollPixels(direction)
	end

	-- need some stuff for functions below so init here
	createGui()

	function GetHeaderPosition(page)
		local header = page:GetTabHeader()
		if not header then return -1 end

		for i,v in pairs(this.TabHeaders) do
			if v == header then
				return i
			end
		end

		return -1
	end

	local setZIndex = nil
	setZIndex = function(newZIndex, object)
		if object:IsA("GuiObject") then
			object.ZIndex = newZIndex
			local children = object:GetChildren()
			for i = 1, #children do
				setZIndex(newZIndex, children[i])
			end
		end
	end

	local function AddHeader(newHeader, headerPage)
		if not newHeader then return end

		this.TabHeaders[#this.TabHeaders + 1] = newHeader
		headerPage.TabPosition = #this.TabHeaders

		local sizeOfTab = 1/#this.TabHeaders
		for i = 1, #this.TabHeaders do
			local tabMaxPos = (sizeOfTab * i)
			local tabMinPos = (sizeOfTab * (i - 1))
			local pos = ((tabMaxPos - tabMinPos)/2) + tabMinPos

			local tab = this.TabHeaders[i]
			tab.Position = UDim2.new(pos,-tab.Size.X.Offset/2,0,0)
		end

		setZIndex(SETTINGS_BASE_ZINDEX + 1, newHeader)
		newHeader.Parent = this.HubBar
	end

	local function RemoveHeader(oldHeader)
		local removedPos = nil

		for i = 1, #this.TabHeaders do 
			if this.TabHeaders[i] == oldHeader then
				removedPos = i
				table.remove(this.TabHeaders, i)
				break
			end
		end

		if removedPos then
			for i = removedPos, #this.TabHeaders do
				local currentTab = this.TabHeaders[i]
				currentTab.Position = UDim2.new(currentTab.Position.X.Scale, currentTab.Position.X.Offset - oldHeader.AbsoluteSize.X,
					currentTab.Position.Y.Scale, currentTab.Position.Y.Offset)
			end
		end

		oldHeader.Parent = nil
	end

	-- Page APIs
	function this:AddPage(pageToAdd)
		this.Pages.PageTable[pageToAdd] = true
		AddHeader(pageToAdd:GetTabHeader(), pageToAdd)
		pageToAdd.Page.Position = UDim2.new(pageToAdd.TabPosition - 1,0,0,0)
	end

	function this:RemovePage(pageToRemove)
		this.Pages.PageTable[pageToRemove] = nil
		RemoveHeader(pageToRemove:GetTabHeader())
	end

	function this:HideBar()
		this.HubBar.Visible = false
		this.PageViewClipper.Visible = false
		if this.BottomButtonFrame then
			removeBottomBarBindings()
		end
	end

	function this:ShowBar()
		this.HubBar.Visible = true
		this.PageViewClipper.Visible = true
		if this.BottomButtonFrame then
			setBottomBarBindings()
		end
	end

	function this:ScrollPixels(pixels)
		-- Only Y
		local oldY = this.PageView.CanvasPosition.Y
		local maxY = this.PageView.CanvasSize.Y.Offset - this.PageViewClipper.AbsoluteSize.y
		local newY = math.max(0, math.min(oldY+pixels, maxY)) -- i.e. clamp
		this.PageView.CanvasPosition = Vector2.new(0, newY)
	end

	function this:ScrollToFrame(frame, forced)
		if lastInputUsedToSelectGui or forced then
			local ay = frame.AbsolutePosition.y - this.Pages.CurrentPage.Page.AbsolutePosition.y
			local by = ay + frame.AbsoluteSize.y

			if ay < this.PageView.CanvasPosition.y then -- Scroll up to fit top
				this.PageView.CanvasPosition = Vector2.new(0, ay)
			elseif by - this.PageView.CanvasPosition.y > this.PageViewClipper.Size.Y.Offset then -- Scroll down to fit bottom
				this.PageView.CanvasPosition = Vector2.new(0, by - this.PageViewClipper.Size.Y.Offset)
			end
		end
	end

	function this:SwitchToPage(pageToSwitchTo, ignoreStack, direction, skipAnimation)
		if this.Pages.PageTable[pageToSwitchTo] == nil then return end

		-- detect direction
		if direction == nil then
			if this.Pages.CurrentPage and this.Pages.CurrentPage.TabHeader and pageToSwitchTo and pageToSwitchTo.TabHeader then
				direction = this.Pages.CurrentPage.TabHeader.AbsolutePosition.x < pageToSwitchTo.TabHeader.AbsolutePosition.x and 1 or -1
			end
		end
		if direction == nil then
			direction = 1
		end

		-- if we have a page we need to let it know to go away
		if this.Pages.CurrentPage then
			pageChangeCon:disconnect()
			this.Pages.CurrentPage.Active = false
		end

		-- make sure all pages are in right position
		local newPagePos = pageToSwitchTo.TabPosition
		for page, _ in pairs(this.Pages.PageTable) do
			if page ~= pageToSwitchTo then
				page:Hide(-direction, newPagePos, skipAnimation)
			end
		end

		if this.BottomButtonFrame then
			this.BottomButtonFrame.Visible = (pageToSwitchTo ~= this.ResetCharacterPage and pageToSwitchTo ~= this.LeaveGamePage)
			this.HubBar.Visible = this.BottomButtonFrame.Visible
		end

		-- make sure page is visible
		this.Pages.CurrentPage = pageToSwitchTo
		this.Pages.CurrentPage:Display(this.PageView, skipAnimation)
		this.Pages.CurrentPage.Active = true

		local pageSize = this.Pages.CurrentPage:GetSize()
		this.PageView.CanvasSize = UDim2.new(0,pageSize.X,0,pageSize.Y)

		pageChangeCon = this.Pages.CurrentPage.Page.Changed:connect(function(prop)
			if prop == "AbsoluteSize" then
				local pageSize = this.Pages.CurrentPage:GetSize()
				this.PageView.CanvasSize = UDim2.new(0,pageSize.X,0,pageSize.Y)
			end
		end)

		if this.MenuStack[#this.MenuStack] ~= this.Pages.CurrentPage and not ignoreStack then
			this.MenuStack[#this.MenuStack + 1] = this.Pages.CurrentPage
		end
	end

	function this:SetActive(active)
		this.Active = active

		if this.Pages.CurrentPage then
			this.Pages.CurrentPage.Active = active
		end
	end

	function clearMenuStack()
		while this.MenuStack and #this.MenuStack > 0 do
			this:PopMenu()
		end
	end

	function setOverrideMouseIconBehavior()
		pcall(function()
			if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
				UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
			else
				UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceShow
			end
		end)
	end

	-- Compatibility cleanup for the old 2016 SettingsHub.
	-- Some games can error while closing and leave input-blocking actions bound.
	local function forceReleaseSettingsInput()
		pcall(function() ContextActionService:UnbindAction("RbxSettingsHubSwitchTab") end)
		pcall(function() ContextActionService:UnbindAction("RbxSettingsHubStopCharacter") end)
		pcall(function() ContextActionService:UnbindAction("RbxSettingsScrollHotkey") end)
		pcall(function() removeBottomBarBindings(0) end)
		pcall(function() GuiService:SetMenuIsOpen(false) end)
		pcall(function() GuiService.SelectedObject = nil end)
		pcall(function() UserInputService.OverrideMouseIconEnabled = false end)
		pcall(function() UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None end)
		pcall(function() PlatformService.BlurIntensity = 0 end)
		if lastInputChangedCon then
			pcall(function() lastInputChangedCon:disconnect() end)
			lastInputChangedCon = nil
		end
	end

	function setVisibilityInternal(visible, noAnimation, customStartPage)
		this.OpenStateChangedCount = this.OpenStateChangedCount + 1
		local switchedFromGamepadInput = switchedFromGamepadInput or isTenFootInterface
		this.Visible = visible

		-- Never allow an old dropdown/page to leave the recreated hub inactive.
		this:SetActive(true)

		-- This recreation lives in PlayerGui, not Roblox's internal CoreGui.
		-- Modal input capture can wedge controls/menu focus in modern experiences.
		this.Modal.Visible = false
		pcall(function() this.Modal.Modal = false end)

		if this.TabConnection then
			this.TabConnection:disconnect()
			this.TabConnection = nil
		end

		if this.Visible then
			this.SettingsShowSignal:fire(this.Visible)

			-- Do not claim Roblox's internal menu-open state from a PlayerGui clone.
			this.Shield.Visible = this.Visible
			if noAnimation then
				this.Shield.Position = SETTINGS_SHIELD_ACTIVE_POSITION
			else
				this.Shield:TweenPosition(SETTINGS_SHIELD_ACTIVE_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, 0.5, true)
			end

			-- PlayerGui compatibility: do not sink character/keyboard/gamepad input.
			-- The full-screen settings Shield already captures mouse/touch clicks.
			ContextActionService:UnbindAction("RbxSettingsHubStopCharacter")

			ContextActionService:BindAction("RbxSettingsHubSwitchTab", switchTabFromBumpers, false, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL1)
			ContextActionService:BindAction("RbxSettingsScrollHotkey", scrollHotkeyFunc, false, Enum.KeyCode.PageUp, Enum.KeyCode.PageDown)
			setBottomBarBindings()

			this.TabConnection = UserInputService.InputBegan:connect(switchTabFromKeyboard)


			pcall(function() UserInputService.OverrideMouseIconEnabled = true end)
			setOverrideMouseIconBehavior()
			pcall(function() lastInputChangedCon = UserInputService.LastInputTypeChanged:connect(setOverrideMouseIconBehavior) end)
			if UserInputService.MouseEnabled then
				pcall(function() 
					UserInputService.OverrideMouseIconEnabled = true
					UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceShow 
				end)
			end

			pcall(function() PlatformService.BlurIntensity = 10 end)

			if customStartPage then
				removeBottomBarBindings()
				this:SwitchToPage(customStartPage, nil, 1, true)
			else
				if useUserList and not isTenFootInterface then
					this:SwitchToPage(this.PlayersPage, nil, 1, true)
				else
					if this.HomePage then
						this:SwitchToPage(this.HomePage, nil, 1, true)
					else
						this:SwitchToPage(this.GameSettingsPage, nil, 1, true)
					end
				end
			end

			playerList:HideTemp('SettingsMenu', true)

			if chat:GetVisibility() then
				chatWasVisible = true
				chat:ToggleVisibility()
			end

			if backpack.IsOpen then
				backpack:OpenClose()
			end
		else
			-- Release controls BEFORE any fragile legacy cleanup runs.
			forceReleaseSettingsInput()

			pcall(function() UserInputService.OverrideMouseIconEnabled = false end)

			if noAnimation then
				this.Shield.Position = SETTINGS_SHIELD_INACTIVE_POSITION
				this.Shield.Visible = this.Visible
				this.SettingsShowSignal:fire(this.Visible)
				pcall(function() GuiService:SetMenuIsOpen(false) end)
			else
				this.Shield:TweenPosition(SETTINGS_SHIELD_INACTIVE_POSITION, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.4, true, function()
					this.Shield.Visible = this.Visible
					this.SettingsShowSignal:fire(this.Visible)
					if not this.Visible then pcall(function() GuiService:SetMenuIsOpen(false) end) end
				end)
			end

			if lastInputChangedCon then
				lastInputChangedCon:disconnect()
			end

			pcall(function() playerList:HideTemp('SettingsMenu', false) end)

			if chatWasVisible then
				pcall(function() chat:ToggleVisibility() end)
				chatWasVisible = false
			end

			pcall(function() UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None end)
			pcall(function() PlatformService.BlurIntensity = 0 end)

			pcall(clearMenuStack)
			ContextActionService:UnbindAction("RbxSettingsHubSwitchTab") 
			ContextActionService:UnbindAction("RbxSettingsHubStopCharacter")
			ContextActionService:UnbindAction("RbxSettingsScrollHotkey")
			removeBottomBarBindings(0.4)

			GuiService.SelectedObject = nil
		end
	end

	function this:SetVisibility(visible, noAnimation, customStartPage, switchedFromGamepadInput)
		if this.Visible == visible then return end

		setVisibilityInternal(visible, noAnimation, customStartPage, switchedFromGamepadInput)
	end

	function this:ToggleVisibility(switchedFromGamepadInput)
		setVisibilityInternal(not this.Visible, nil, nil, switchedFromGamepadInput)
	end

	function this:AddToMenuStack(newItem)
		if this.MenuStack[#this.MenuStack] ~= newItem then
			this.MenuStack[#this.MenuStack + 1] = newItem
		end
	end


	function this:PopMenu(switchedFromGamepadInput, skipAnimation)
		if this.MenuStack and #this.MenuStack > 0 then
			local lastStackItem = this.MenuStack[#this.MenuStack]

			if type(lastStackItem) ~= "table" then
				PoppedMenuEvent:Fire(lastStackItem)
			end

			if lastStackItem == this.LeaveGamePage or lastStackItem == this.ResetCharacterPage then
				setBottomBarBindings()
			end

			table.remove(this.MenuStack, #this.MenuStack)
			this:SwitchToPage(this.MenuStack[#this.MenuStack], true, 1, skipAnimation)
			if #this.MenuStack == 0 then
				this:SetVisibility(false)
				this.Pages.CurrentPage:Hide(0, 0)
			end
		else
			this.MenuStack = {}
			PoppedMenuEvent:Fire()
			this:ToggleVisibility()
		end
	end

	function this:ShowShield()
		this.Shield.BackgroundTransparency = SETTINGS_SHIELD_TRANSPARENCY
	end
	function this:HideShield()
		this.Shield.BackgroundTransparency = 1
	end

	local closeMenuFunc = function(name, inputState, input)
		if inputState ~= Enum.UserInputState.Begin then return end
		this:PopMenu(false, true)
	end
	ContextActionService:BindAction("RBXEscapeMainMenu", closeMenuFunc, false, Enum.KeyCode.Escape)

	this.ResetCharacterPage:SetHub(this)
	this.LeaveGamePage:SetHub(this)

	-- full page initialization
	if not useUserList then
		if utility:IsSmallTouchScreen() then
			this.HomePage = require(RobloxGui.Modules.Settings.Pages.Home)
			this.HomePage:SetHub(this)
		end
	end

	this.GameSettingsPage = require(RobloxGui.Modules.Settings.Pages.GameSettings)
	this.GameSettingsPage:SetHub(this)

	if not isTenFootInterface then
		this.ReportAbusePage = require(RobloxGui.Modules.Settings.Pages.ReportAbuseMenu)
		this.ReportAbusePage:SetHub(this)
		
		this.HelpPage = require(RobloxGui.Modules.Settings.Pages.Help)
		this.HelpPage:SetHub(this)
		
		this.RecordPage = require(RobloxGui.Modules.Settings.Pages.Record)
		this.RecordPage:SetHub(this)
		
		if useUserList then
			this.PlayersPage = require(RobloxGui.Modules.Settings.Pages.Players)
			this.PlayersPage:SetHub(this)
		end
	end

	-- page registration
	if useUserList and not isTenFootInterface then
		this:AddPage(this.PlayersPage)
	end
	this:AddPage(this.ResetCharacterPage)
	this:AddPage(this.LeaveGamePage)
	if not useUserList then
		if this.HomePage then
			this:AddPage(this.HomePage)
		end
	end
	this:AddPage(this.GameSettingsPage)
	if this.ReportAbusePage then
		this:AddPage(this.ReportAbusePage)
	end
	this:AddPage(this.HelpPage)
	if this.RecordPage then
		this:AddPage(this.RecordPage)
	end

	if useUserList and not isTenFootInterface then
		this:SwitchToPage(this.PlayersPage, true, 1)
	else
		if this.HomePage then
			this:SwitchToPage(this.HomePage, true, 1)
		else
			this:SwitchToPage(this.GameSettingsPage, true, 1)
		end
	end
	-- hook up to necessary signals

	--[[-- connect back button on android
	GuiService.ShowLeaveConfirmation:connect(function()
		if #this.MenuStack == 0 then
			this:SwitchToPage(this.LeaveGamePage, nil, 1)
			this:SetVisibility(true)
		else
			this:SetVisibility(false)
			this:PopMenu()
		end
	end)--]]

	-- Dev Console Connections
	ContextActionService:BindAction(DEV_CONSOLE_ACTION_NAME, toggleDevConsole, false, Enum.KeyCode.F9)

	-- Keyboard control
	UserInputService.InputBegan:connect(function(input)
		if input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.Up or input.KeyCode == Enum.KeyCode.Down then
			if this.Visible and this.Active then
				if this.Pages.CurrentPage then
					if GuiService.SelectedObject == nil then
						this.Pages.CurrentPage:SelectARow()
					end
				end
			end
		end
	end)

	return this
end


-- Main Entry Point

local moduleApiTable = {}

local SettingsHubInstance = CreateSettingsHub()

function moduleApiTable:SetVisibility(visible, noAnimation, customStartPage, switchedFromGamepadInput)
	SettingsHubInstance:SetVisibility(visible, noAnimation, customStartPage, switchedFromGamepadInput)
end

function moduleApiTable:ToggleVisibility(switchedFromGamepadInput)
	SettingsHubInstance:ToggleVisibility(switchedFromGamepadInput)
end

function moduleApiTable:SwitchToPage(pageToSwitchTo, ignoreStack)
	SettingsHubInstance:SwitchToPage(pageToSwitchTo, ignoreStack, 1)
end

function moduleApiTable:ReportPlayer(player)
	if SettingsHubInstance.ReportAbusePage and player then
		local setReportPlayerConnection = nil
		setReportPlayerConnection = SettingsHubInstance.ReportAbusePage.Displayed.Event:connect(function()
			-- When we change the SelectionIndex of GameOrPlayerMode it waits until the tween is done
			-- before it fires the IndexChanged signal. The WhichPlayerMode dropdown listens to this signal
			-- and resets when it is fired. Therefore we need to listen to this signal and set the player we want
			-- to report the frame after the dropdown is reset
			local indexChangedConnection = nil
			indexChangedConnection = SettingsHubInstance.ReportAbusePage.GameOrPlayerMode.IndexChanged:connect(function()
				if indexChangedConnection then
					indexChangedConnection:disconnect()
					indexChangedConnection = nil
				end
				wait() -- We need to wait a frame to set the value of WhichPlayerMode as it is being updated by another script listening to the IndexChanged signal
				SettingsHubInstance.ReportAbusePage.WhichPlayerMode:SetSelectionByValue(player.Name)				
			end)
			SettingsHubInstance.ReportAbusePage.GameOrPlayerMode:SetSelectionIndex(2)

			if setReportPlayerConnection then
				setReportPlayerConnection:disconnect()
				setReportPlayerConnection = nil
			end
		end)
		SettingsHubInstance:SetVisibility(true, false, SettingsHubInstance.ReportAbusePage)
	end
end

function moduleApiTable:GetVisibility()
	return SettingsHubInstance.Visible
end

function moduleApiTable:ShowShield()
	SettingsHubInstance:ShowShield()
end

function moduleApiTable:HideShield()
	SettingsHubInstance:HideShield()
end

moduleApiTable.SettingsShowSignal = SettingsHubInstance.SettingsShowSignal

moduleApiTable.Instance = SettingsHubInstance

return moduleApiTable
end;
};
G2L_MODULES[G2L["10"]] = {
Closure = function()
    local script = G2L["10"];--[[
		Filename: GameSettings.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the Game Settings Tab in Settings Menu
--]]

-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = _G:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local PlatformService = nil 
pcall(function() PlatformService = game:GetService("PlatformService") end)
local ContextActionService = game:GetService("ContextActionService")
local Settings = _G:GetService("UserSettings")
local GameSettings = Settings

-------------- CONSTANTS --------------
local GRAPHICS_QUALITY_LEVELS = 10
local GRAPHICS_QUALITY_TO_INT = {
	["Enum.SavedQualitySetting.Automatic"] = 0,
	["Enum.SavedQualitySetting.QualityLevel1"] = 1,
	["Enum.SavedQualitySetting.QualityLevel2"] = 2,
	["Enum.SavedQualitySetting.QualityLevel3"] = 3,
	["Enum.SavedQualitySetting.QualityLevel4"] = 4,
	["Enum.SavedQualitySetting.QualityLevel5"] = 5,
	["Enum.SavedQualitySetting.QualityLevel6"] = 6,
	["Enum.SavedQualitySetting.QualityLevel7"] = 7,
	["Enum.SavedQualitySetting.QualityLevel8"] = 8,
	["Enum.SavedQualitySetting.QualityLevel9"] = 9,
	["Enum.SavedQualitySetting.QualityLevel10"] = 10,
}
local PC_CHANGED_PROPS = {
	DevComputerMovementMode = true,
	DevComputerCameraMode = true,
	DevEnableMouseLock = true,
}
local TOUCH_CHANGED_PROPS = {
	DevTouchMovementMode = true,
	DevTouchCameraMode = true,
}
local CAMERA_MODE_DEFAULT_STRING = UserInputService.TouchEnabled and "Default (Follow)" or "Default (Classic)"

local MOVEMENT_MODE_DEFAULT_STRING = UserInputService.TouchEnabled and "Default (Thumbstick)" or "Default (Keyboard)"
local MOVEMENT_MODE_KEYBOARDMOUSE_STRING = "Keyboard + Mouse"
local MOVEMENT_MODE_CLICKTOMOVE_STRING = UserInputService.TouchEnabled and "Tap to Move" or "Click to Move"

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Settings.Utility)

------------ Variables -------------------
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
RobloxGui:WaitForChild("Modules"):WaitForChild("Settings"):WaitForChild("SettingsHub")
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()
local PageInstance = nil
local LocalPlayer = game.Players.LocalPlayer
local overscanScreen = nil

----------- CLASS DECLARATION --------------

local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()

	----------- FUNCTIONS ---------------
	local function createGraphicsOptions()

		------------------ Fullscreen Selection GUI Setup ------------------
		local fullScreenInit = 1
		if not GameSettings:InFullScreen() then
			fullScreenInit = 2
		end

		this.FullscreenFrame, 
		this.FullscreenLabel,
		this.FullscreenEnabler = utility:AddNewRow(this, "Fullscreen", "Selector", {"On", "Off"}, fullScreenInit)

		local fullScreenSelectionFrame = this.FullscreenEnabler.SliderFrame and this.FullscreenEnabler.SliderFrame or this.FullscreenEnabler.SelectorFrame

		this.FullscreenEnabler.IndexChanged:connect(function(newIndex)
			GuiService:ToggleFullscreen()
		end)

		------------------ Gfx Enabler Selection GUI Setup ------------------
		this.GraphicsEnablerFrame, 
		this.GraphicsEnablerLabel,
		this.GraphicsQualityEnabler = utility:AddNewRow(this, "Graphics Mode", "Selector", {"Automatic", "Manual"}, 1)

		------------------ Gfx Slider GUI Setup  ------------------
		this.GraphicsQualityFrame, 
		this.GraphicsQualityLabel,
		this.GraphicsQualitySlider = utility:AddNewRow(this, "Graphics Quality", "Slider", GRAPHICS_QUALITY_LEVELS, 1)
		this.GraphicsQualitySlider:SetMinStep(1)

		------------------------- Connection Setup ----------------------------
		_G:GetService("GlobalSettings").EnableFRM = true

		function SetGraphicsQuality(newValue, automaticSettingAllowed)
			local percentage = newValue/GRAPHICS_QUALITY_LEVELS
			local newQualityLevel = math.floor((_G:GetService("GlobalSettings"):GetMaxQualityLevel() - 1) * percentage)
			if newQualityLevel == 20 then
				newQualityLevel = 21
			elseif newValue == 1 then
				newQualityLevel = 1
			elseif newValue < 1 and not automaticSettingAllowed then
				newValue = 1
				newQualityLevel = 1
			elseif newQualityLevel > _G:GetService("GlobalSettings"):GetMaxQualityLevel() then
				newQualityLevel = _G:GetService("GlobalSettings"):GetMaxQualityLevel() - 1
			end

			GameSettings.SavedQualityLevel = newValue
			_G:GetService("GlobalSettings").QualityLevel = newQualityLevel
		end

		local function setGraphicsToAuto()
			this.GraphicsQualitySlider:SetZIndex(1)
			this.GraphicsQualityLabel.ZIndex = 1
			this.GraphicsQualitySlider:SetInteractable(false)

			SetGraphicsQuality(Enum.QualityLevel.Automatic.Value, true)
		end
		local function setGraphicsToManual(level)
			this.GraphicsQualitySlider:SetZIndex(2)
			this.GraphicsQualityLabel.ZIndex = 2
			this.GraphicsQualitySlider:SetInteractable(true)

			-- need to force the quality change if slider is already at this position
			if this.GraphicsQualitySlider:GetValue() == level then
				SetGraphicsQuality(level)
			else
				this.GraphicsQualitySlider:SetValue(level)
			end
		end

		game.GraphicsQualityChangeRequest:connect(function(isIncrease)
			if _G:GetService("GlobalSettings").QualityLevel == Enum.QualityLevel.Automatic then return end
			--
			local currentGraphicsSliderValue = this.GraphicsQualitySlider:GetValue()
			if isIncrease then
				currentGraphicsSliderValue = currentGraphicsSliderValue + 1
			else
				currentGraphicsSliderValue = currentGraphicsSliderValue - 1
			end

			this.GraphicsQualitySlider:SetValue(currentGraphicsSliderValue)
		end)

		this.GraphicsQualitySlider.ValueChanged:connect(function(newValue)
			SetGraphicsQuality(newValue)
		end)

		this.GraphicsQualityEnabler.IndexChanged:connect(function(newIndex)
			if newIndex == 1 then
				setGraphicsToAuto()
			elseif newIndex == 2 then
				setGraphicsToManual( this.GraphicsQualitySlider:GetValue() )
			end
		end)

		-- initialize the slider position
		if GameSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then
			this.GraphicsQualitySlider:SetValue(5)
			this.GraphicsQualityEnabler:SetSelectionIndex(1)
		else
			local graphicsLevel = tostring(GameSettings.SavedQualityLevel)
			if GRAPHICS_QUALITY_TO_INT[graphicsLevel] then
				graphicsLevel = GRAPHICS_QUALITY_TO_INT[graphicsLevel]
			else
				graphicsLevel = GRAPHICS_QUALITY_LEVELS
			end

			spawn(function()
				this.GraphicsQualitySlider:SetValue(graphicsLevel)
				this.GraphicsQualityEnabler:SetSelectionIndex(2)
			end)
		end
	end

	local function createCameraModeOptions(movementModeEnabled)
		------------------------------------------------------
		------------------
		------------------ Shift Lock Switch -----------------
		if UserInputService.MouseEnabled then
			this.ShiftLockFrame, 
			this.ShiftLockLabel,
			this.ShiftLockMode,
			this.ShiftLockOverrideText = nil

			if UserInputService.MouseEnabled and UserInputService.KeyboardEnabled then
				local startIndex = 2
				if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
					startIndex = 1
				end

				this.ShiftLockFrame, 
				this.ShiftLockLabel,
				this.ShiftLockMode = utility:AddNewRow(this, "Shift Lock Switch", "Selector", {"On", "Off"}, startIndex)

				this.ShiftLockOverrideText = utility:Create'TextLabel'
				{
					Name = "ShiftLockOverrideLabel",
					Text = "Set by Developer",
					TextColor3 = Color3.new(1,1,1),
					Font = Enum.Font.SourceSans,
					FontSize = Enum.FontSize.Size24,
					BackgroundTransparency = 1,
					Size = UDim2.new(0,200,1,0),
					Position = UDim2.new(1,-350,0,0),
					Visible = false,
					ZIndex = 2,
					Parent = this.ShiftLockFrame
				};

				this.ShiftLockMode.IndexChanged:connect(function(newIndex)
					if newIndex == 1 then
						GameSettings.ControlMode = Enum.ControlMode.MouseLockSwitch
						_G:GetService("UserSettings"):RequestUpdate()
					else
						GameSettings.ControlMode = Enum.ControlMode.Classic
						_G:GetService("UserSettings"):RequestUpdate()
					end
				end)
			end
		end


		------------------------------------------------------
		------------------
		------------------ Camera Mode -----------------------
		do
			local enumItems = nil
			local startingCameraEnumItem = 1
			if UserInputService.TouchEnabled then
				enumItems = Enum.TouchCameraMovementMode:GetEnumItems()
			else
				enumItems = Enum.ComputerCameraMovementMode:GetEnumItems()
			end

			local cameraEnumNames = {}
			local cameraEnumNameToItem = {}
			for i = 1, #enumItems do
				local displayName = enumItems[i].Name
				if displayName == 'Default' then
					displayName = CAMERA_MODE_DEFAULT_STRING
				end

				if UserInputService.TouchEnabled then
					if GameSettings.TouchCameraMovementMode == enumItems[i] then
						startingCameraEnumItem = i
					end
				else
					if GameSettings.ComputerCameraMovementMode == enumItems[i] then
						startingCameraEnumItem = i
					end
				end

				cameraEnumNames[i] = displayName
				cameraEnumNameToItem[displayName] = enumItems[i].Value
			end

			this.CameraModeFrame, 
			this.CameraModeLabel,
			this.CameraMode = utility:AddNewRow(this, "Camera Mode", "Selector", cameraEnumNames, startingCameraEnumItem)

			this.CameraModeOverrideText = utility:Create'TextLabel'
			{
				Name = "CameraDevOverrideLabel",
				Text = "Set by Developer",
				TextColor3 = Color3.new(1,1,1),
				Font = Enum.Font.SourceSans,
				FontSize = Enum.FontSize.Size24,
				BackgroundTransparency = 1,
				Size = UDim2.new(0,200,1,0),
				Position = UDim2.new(1,-350,0,0),
				Visible = false,
				ZIndex = 2,
				Parent = this.CameraModeFrame
			};

			this.CameraMode.IndexChanged:connect(function(newIndex)
				local newEnumSetting = cameraEnumNameToItem[cameraEnumNames[newIndex]]

				if UserInputService.TouchEnabled then
					GameSettings.TouchCameraMovementMode = newEnumSetting
				else
					GameSettings.ComputerCameraMovementMode = newEnumSetting
				end
			end)
		end

		------------------------------------------------------
		------------------
		------------------ Movement Mode ---------------------
		if movementModeEnabled then
			local movementEnumItems = nil
			local startingMovementEnumItem = 1
			if UserInputService.TouchEnabled then
				movementEnumItems = Enum.TouchMovementMode:GetEnumItems()
			else
				movementEnumItems = Enum.ComputerMovementMode:GetEnumItems()
			end

			local movementEnumNames = {}
			local movementEnumNameToItem = {}
			for i = 1, #movementEnumItems do
				local displayName = movementEnumItems[i].Name
				if displayName == "Default" then
					displayName = MOVEMENT_MODE_DEFAULT_STRING
				elseif displayName == "KeyboardMouse" then
					displayName = MOVEMENT_MODE_KEYBOARDMOUSE_STRING
				elseif displayName == "ClickToMove" then
					displayName = MOVEMENT_MODE_CLICKTOMOVE_STRING
				end

				if UserInputService.TouchEnabled then
					if GameSettings.TouchMovementMode == movementEnumItems[i] then
						startingMovementEnumItem = i
					end
				else
					if GameSettings.ComputerMovementMode == movementEnumItems[i] then
						startingMovementEnumItem = i
					end
				end

				movementEnumNames[i] = displayName
				movementEnumNameToItem[displayName] = movementEnumItems[i]
			end

			this.MovementModeFrame, 
			this.MovementModeLabel,
			this.MovementMode = utility:AddNewRow(this, "Movement Mode", "Selector", movementEnumNames, startingMovementEnumItem)

			this.MovementModeOverrideText = utility:Create'TextLabel'
			{
				Name = "MovementDevOverrideLabel",
				Text = "Set by Developer",
				TextColor3 = Color3.new(1,1,1),
				Font = Enum.Font.SourceSans,
				FontSize = Enum.FontSize.Size24,
				BackgroundTransparency = 1,
				Size = UDim2.new(0,200,1,0),
				Position = UDim2.new(1,-350,0,0),
				Visible = false,
				ZIndex = 2,
				Parent = this.MovementModeFrame
			};

			this.MovementMode.IndexChanged:connect(function(newIndex)
				local newEnumSetting = movementEnumNameToItem[movementEnumNames[newIndex]]

				if UserInputService.TouchEnabled then
					GameSettings.TouchMovementMode = newEnumSetting
				else
					GameSettings.ComputerMovementMode = newEnumSetting
				end
			end)
		end


		------------------------------------------------------
		------------------
		------------------------- Connection Setup -----------
		function setCameraModeVisible(visible)
			if this.CameraMode then
				this.CameraMode.SelectorFrame.Visible = visible
				this.CameraMode:SetInteractable(visible)
			end
		end

		function setMovementModeVisible(visible)
			if this.MovementMode then
				this.MovementMode.SelectorFrame.Visible = visible
				this.MovementMode:SetInteractable(visible)
			end
		end

		function setShiftLockVisible(visible)
			if this.ShiftLockMode then
				this.ShiftLockMode.SelectorFrame.Visible = visible
				this.ShiftLockMode:SetInteractable(visible)
			end
		end

		do -- initial set of dev vs user choice for guis
			local isUserChoiceCamera = false
			if UserInputService.TouchEnabled then
				isUserChoiceCamera = LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice
			else
				isUserChoiceCamera = LocalPlayer.DevComputerCameraMode == Enum.DevComputerCameraMovementMode.UserChoice
			end

			if not isUserChoiceCamera then
				this.CameraModeOverrideText.Visible = true
				setCameraModeVisible(false)
			else
				this.CameraModeOverrideText.Visible = false
				setCameraModeVisible(true)
			end


			local isUserChoiceMovement = false
			if UserInputService.TouchEnabled then
				isUserChoiceMovement = LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice
			else
				isUserChoiceMovement = LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice
			end

			if this.MovementModeOverrideText then
				if not isUserChoiceMovement then
					this.MovementModeOverrideText.Visible = true
					setMovementModeVisible(false)
				else
					this.MovementModeOverrideText.Visible = false
					setMovementModeVisible(true)
				end
			end

			if this.ShiftLockOverrideText then
				this.ShiftLockOverrideText.Visible = not LocalPlayer.DevEnableMouseLock
				setShiftLockVisible(LocalPlayer.DevEnableMouseLock)
			end
		end

		local function updateUserSettingsMenu(property)
			if this.ShiftLockOverrideText and property == "DevEnableMouseLock" then
				this.ShiftLockOverrideText.Visible = not LocalPlayer.DevEnableMouseLock
				setShiftLockVisible(LocalPlayer.DevEnableMouseLock)
			elseif property == "DevComputerCameraMode" then
				local isUserChoice = LocalPlayer.DevComputerCameraMode == Enum.DevComputerCameraMovementMode.UserChoice
				setCameraModeVisible(isUserChoice)
				this.CameraModeOverrideText.Visible = not isUserChoice
			elseif property == "DevComputerMovementMode" then
				local isUserChoice = LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice
				setMovementModeVisible(isUserChoice)
				if this.MovementModeOverrideText then
					this.MovementModeOverrideText.Visible = not isUserChoice
				end
				-- TOUCH
			elseif property == "DevTouchMovementMode" then
				local isUserChoice = LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice
				setMovementModeVisible(isUserChoice)
				if this.MovementModeOverrideText then
					this.MovementModeOverrideText.Visible = not isUserChoice
				end
			elseif property == "DevTouchCameraMode" then
				local isUserChoice = LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice
				setCameraModeVisible(isUserChoice)
				this.CameraModeOverrideText.Visible = not isUserChoice
			end
		end

		LocalPlayer.Changed:connect(function(property)
			if IsTouchClient then
				if TOUCH_CHANGED_PROPS[property] then
					updateUserSettingsMenu(property)
				end
			else
				if PC_CHANGED_PROPS[property] then
					updateUserSettingsMenu(property)
				end
			end
		end)
	end

	local function createVolumeOptions()
		local masterVolume = 1
	pcall(function() masterVolume = game:GetService("UserSettings"):GetService("UserGameSettings").MasterVolume end)
	local startVolumeLevel = math.floor(masterVolume * 10)
		this.VolumeFrame, 
		this.VolumeLabel,
		this.VolumeSlider = utility:AddNewRow(this, "Volume", "Slider", 10, startVolumeLevel)

		local soundsFolder = RobloxGui:FindFirstChild("Sounds")
		if not soundsFolder then
			soundsFolder = Instance.new("Folder")
			soundsFolder.Name = "Sounds"
			soundsFolder.Parent = RobloxGui
		end
		local volumeSound = Instance.new("Sound", soundsFolder)
		volumeSound.Name = "VolumeChangeSound"
		volumeSound.SoundId = "rbxasset://sounds/metalstone2.mp3"

		this.VolumeSlider.ValueChanged:connect(function(newValue)
			local soundPercent = newValue/10
			volumeSound.Volume = soundPercent
			volumeSound:Play()
			pcall(function() game:GetService("UserSettings"):GetService("UserGameSettings").MasterVolume = soundPercent end)
		end)
	end

	local function createMouseOptions()
		local MouseSteps = 10
		local MinMouseSensitivity = 0.2

		-- equations below map a function to include points (0, 0.2) (5, 1) (10, 4)
		-- where x is the slider position, y is the mouse sensitivity
		local function translateEngineMouseSensitivityToGui(engineSensitivity)
			return math.floor((2.0/3.0) * (math.sqrt(75.0 * engineSensitivity - 11.0) - 2))
		end

		local function translateGuiMouseSensitivityToEngine(guiSensitivity)
			return 0.03 * math.pow(guiSensitivity,2) + (0.08 * guiSensitivity) + MinMouseSensitivity
		end

		local mouseSens = 1
		pcall(function() mouseSens = GameSettings.MouseSensitivity end)
		local startMouseLevel = translateEngineMouseSensitivityToGui(mouseSens)

		this.MouseSensitivityFrame, 
		this.MouseSensitivityLabel,
		this.MouseSensitivitySlider = utility:AddNewRow(this, "Mouse Sensitivity", "Slider", MouseSteps, startMouseLevel)
		this.MouseSensitivitySlider:SetMinStep(1)

		this.MouseSensitivitySlider.ValueChanged:connect(function(newValue)
			pcall(function() GameSettings.MouseSensitivity = translateGuiMouseSensitivityToEngine(newValue) end)
		end)
	end

	local function createOverscanOption()
		local showOverscanScreen = function()

			if not overscanScreen then
				local createOverscanFunc = require(RobloxGui.Modules.OverscanScreen)
				overscanScreen = createOverscanFunc(RobloxGui)
				overscanScreen:SetStyleForInGame()
			end

			local MenuModule = require(RobloxGui.Modules.Settings.SettingsHub)
			MenuModule:SetVisibility(false, true)

			local closedCon = nil
			closedCon = overscanScreen.Closed:connect(function()
				closedCon:disconnect()
				pcall(function() PlatformService.BlurIntensity = 0 end)
				ContextActionService:UnbindAction("RbxStopOverscanMovement")
				MenuModule:SetVisibility(true, true)
			end)

			pcall(function() PlatformService.BlurIntensity = 10 end)

			local noOpFunc = function() end
			ContextActionService:BindAction("RbxStopOverscanMovement", noOpFunc, false,
				Enum.UserInputType.Gamepad1, Enum.UserInputType.Gamepad2,
				Enum.UserInputType.Gamepad3, Enum.UserInputType.Gamepad4)

			local ScreenManager = require(RobloxGui.Modules.ScreenManager)
			ScreenManager:OpenScreen(overscanScreen)

		end

		local adjustButton, adjustText, setButtonRowRef = utility:MakeStyledButton("AdjustButton", "Adjust", UDim2.new(0,300,1,-20), showOverscanScreen, this)
		adjustText.Font = Enum.Font.SourceSans
		adjustButton.Position = UDim2.new(1,-400,0,12)

		local row = utility:AddNewRowObject(this, "Safe Zone", adjustButton)
		setButtonRowRef(row)
	end

	createCameraModeOptions(not isTenFootInterface and 
		(UserInputService.TouchEnabled or UserInputService.MouseEnabled or UserInputService.KeyboardEnabled))

	if UserInputService.MouseEnabled then
		createMouseOptions()
	end

	createVolumeOptions()

	if not isTenFootInterface then
		createGraphicsOptions()
	end

	if isTenFootInterface then
		createOverscanOption()
	end

	------ TAB CUSTOMIZATION -------
	this.TabHeader.Name = "GameSettingsTab"

	this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/GameSettingsTab.png"
	if utility:IsSmallTouchScreen() then
		this.TabHeader.Icon.Size = UDim2.new(0,34,0,34)
		this.TabHeader.Icon.Position = UDim2.new(this.TabHeader.Icon.Position.X.Scale,this.TabHeader.Icon.Position.X.Offset,0.5,-17)
		this.TabHeader.Size = UDim2.new(0,125,1,0)
	elseif isTenFootInterface then
		this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/GameSettingsTab@2x.png"
		this.TabHeader.Icon.Size = UDim2.new(0,90,0,90)
		this.TabHeader.Icon.Position = UDim2.new(0,0,0.5,-43)
		this.TabHeader.Size = UDim2.new(0,280,1,0)
	else
		this.TabHeader.Icon.Size = UDim2.new(0,45,0,45)
		this.TabHeader.Icon.Position = UDim2.new(0,15,0.5,-22)
	end


	this.TabHeader.Icon.Title.Text = "Settings"

	------ PAGE CUSTOMIZATION -------
	this.Page.ZIndex = 5

	return this
end


----------- Page Instantiation --------------

PageInstance = Initialize()

return PageInstance
end;
};
G2L_MODULES[G2L["11"]] = {
Closure = function()
    local script = G2L["11"];--[[
		Filename: Help.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the help page in Settings Menu
--]]
-------------- CONSTANTS --------------
local KEYBOARD_MOUSE_TAG = "KeyboardMouse"
local TOUCH_TAG = "Touch"
local GAMEPAD_TAG = "Gamepad"
local PC_TABLE_SPACING = 4

-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local UserInputService = game:GetService("UserInputService")
local GuiService = _G:GetService("GuiService")

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Settings.Utility)

------------ Variables -------------------
local PageInstance = nil
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

----------- CLASS DECLARATION --------------

local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()
	this.HelpPages = {}

	-- TODO: Change dev console script to parent this to somewhere other than an engine created gui
	local ControlFrame = RobloxGui:WaitForChild('ControlFrame')
	local ToggleDevConsoleBindableFunc = ControlFrame:WaitForChild('ToggleDevConsole')
	local lastInputType = nil

	function this:GetCurrentInputType()
		if lastInputType == nil then -- choose a sane initial page before any input event fires
			if isTenFootInterface then
				return GAMEPAD_TAG
			elseif UserInputService.TouchEnabled then
				-- IMPORTANT: mobile must be checked before the desktop fallback.
				return TOUCH_TAG
			else
				return KEYBOARD_MOUSE_TAG
			end
		end

		if lastInputType == Enum.UserInputType.Keyboard or lastInputType == Enum.UserInputType.MouseMovement or 
			lastInputType == Enum.UserInputType.MouseButton1 or lastInputType == Enum.UserInputType.MouseButton2 or
			lastInputType == Enum.UserInputType.MouseButton3 or lastInputType == Enum.UserInputType.MouseWheel then
			return KEYBOARD_MOUSE_TAG
		elseif lastInputType == Enum.UserInputType.Touch then
			return TOUCH_TAG
		elseif lastInputType == Enum.UserInputType.Gamepad1 or lastInputType == Enum.UserInputType.Gamepad2 or 
			lastInputType == Enum.UserInputType.Gamepad3 or lastInputType == Enum.UserInputType.Gamepad4 then
			return GAMEPAD_TAG
		end

		-- Hybrid devices (touch laptop/tablet) should still prefer the touch help
		-- when the current input isn't something we explicitly recognize.
		if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
			return TOUCH_TAG
		end

		return KEYBOARD_MOUSE_TAG
	end


	local function createPCHelp(parentFrame)
		local function createPCGroup(title, actionInputBindings)
			local textIndent = 9

			local pcGroupFrame = utility:Create'Frame'
			{
				Size = UDim2.new(1/3,-PC_TABLE_SPACING,1,0),
				BackgroundTransparency = 1,
				Name = "PCGroupFrame" .. tostring(title)
			};
			local pcGroupTitle = utility:Create'TextLabel'
			{
				Position = UDim2.new(0,textIndent,0,0),
				Size = UDim2.new(1,-textIndent,0,30),
				BackgroundTransparency = 1,
				Text = title,
				Font = Enum.Font.SourceSansBold,
				FontSize = Enum.FontSize.Size18,
				TextColor3 = Color3.new(1,1,1),
				TextXAlignment = Enum.TextXAlignment.Left,
				Name = "PCGroupTitle" .. tostring(title),
				ZIndex = 2,
				Parent = pcGroupFrame
			};

			local count = 0
			local frameHeight = 42
			local spacing = 2
			local offset = pcGroupTitle.Size.Y.Offset
			for i = 1, #actionInputBindings do
				for actionName, inputName in pairs(actionInputBindings[i]) do
					local actionInputFrame = utility:Create'Frame'
					{
						Size = UDim2.new(1,0,0,frameHeight),
						Position = UDim2.new(0,0,0, offset + ((frameHeight + spacing) * count)),
						BackgroundTransparency = 0.65,
						BorderSizePixel = 0,
						ZIndex = 2,
						Name = "ActionInputBinding" .. tostring(actionName),
						Parent = pcGroupFrame
					};

					local nameLabel = utility:Create'TextLabel'
					{
						Size = UDim2.new(0.4,-textIndent,0,frameHeight),
						Position = UDim2.new(0,textIndent,0,0),
						BackgroundTransparency = 1,
						Text = actionName,
						Font = Enum.Font.SourceSansBold,
						FontSize = Enum.FontSize.Size18,
						TextColor3 = Color3.new(1,1,1),
						TextXAlignment = Enum.TextXAlignment.Left,
						Name = actionName .. "Label",
						ZIndex = 2,
						Parent = actionInputFrame
					};

					local inputLabel = utility:Create'TextLabel'
					{
						Size = UDim2.new(0.6,0,0,frameHeight),
						Position = UDim2.new(0.5,-4,0,0),
						BackgroundTransparency = 1,
						Text = inputName,
						Font = Enum.Font.SourceSans,
						FontSize = Enum.FontSize.Size18,
						TextColor3 = Color3.new(1,1,1),
						TextXAlignment = Enum.TextXAlignment.Left,
						Name = inputName .. "Label",
						ZIndex = 2,
						Parent = actionInputFrame
					};

					count = count + 1
				end
			end

			pcGroupFrame.Size = UDim2.new(pcGroupFrame.Size.X.Scale,pcGroupFrame.Size.X.Offset,
				0, offset + ((frameHeight + spacing) * count))

			return pcGroupFrame
		end

		local rowOffset = 50
		local isOSX = false--UserInputService:GetPlatform() == Enum.Platform.OSX

		local charMoveFrame = createPCGroup( "Character Movement", {[1] = {["Move Forward"] = "W/Up Arrow"}, 
			[2] = {["Move Backward"] = "S/Down Arrow"},
			[3] = {["Move Left"] = "A/Left Arrow"},
			[4] = {["Move Right"] = "D/Right Arrow"},
			[5] = {["Jump"] = "Space"}} )
		charMoveFrame.Parent = parentFrame

		local accessoriesFrame = createPCGroup("Accessories", {	[1] = {["Equip Tools"] = "1,2,3..."}, 
			[2] = {["Unequip Tools"] = "1,2,3..."},
			[3] = {["Drop Tool"] = "Backspace"},
			[4] = {["Use Tool"] = "Left Mouse Button"},
			[5] = {["Drop Hats"] = "+"} })
		accessoriesFrame.Position = UDim2.new(1/3,PC_TABLE_SPACING,0,0)
		accessoriesFrame.Parent = parentFrame

		local miscFrame = nil
		local hideHudSuccess, hideHudFlagValue = pcall(function() return _G:GetService("GlobalSettings"):GetFFlag("AllowHideHudShortcut") end)
		if (hideHudSuccess and hideHudFlagValue) then
			miscFrame = createPCGroup("Misc", {	[1] = {["Screenshot"] = "Print Screen"}, 
				[2] = {["Record Video"] = isOSX and "F12/fn + F12" or "F12"},
				[3] = {["Hide HUD"] = isOSX and "F7/fn + F7" or "F7"},
				[4] = {["Dev Console"] = isOSX and "F9/fn + F9" or "F9"},
				[5] = {["Mouselock"] = "Shift"},
				[6] = {["Graphics Level"] = isOSX and "F10/fn + F10" or "F10"},
				[7] = {["Fullscreen"] = isOSX and "F11/fn + F11" or "F11"} })
		else
			miscFrame = createPCGroup("Misc", {	[1] = {["Screenshot"] = "Print Screen"}, 
				[2] = {["Record Video"] = isOSX and "F12/fn + F12" or "F12"},
				[3] = {["Dev Console"] = isOSX and "F9/fn + F9" or "F9"},
				[4] = {["Mouselock"] = "Shift"},
				[5] = {["Graphics Level"] = isOSX and "F10/fn + F10" or "F10"},
				[6] = {["Fullscreen"] = isOSX and "F11/fn + F11" or "F11"} })
		end
		miscFrame.Position = UDim2.new(2/3,PC_TABLE_SPACING * 2,0,0)
		miscFrame.Parent = parentFrame

		local camFrame = createPCGroup("Camera Movement", {	[1] = {["Rotate"] = "Right Mouse Button"}, 
			[2] = {["Zoom In/Out"] = "Mouse Wheel"},
			[3] = {["Zoom In"] = "I"},
			[4] = {["Zoom Out"] = "O"} })
		camFrame.Position = UDim2.new(0,0,charMoveFrame.Size.Y.Scale,charMoveFrame.Size.Y.Offset + rowOffset)
		camFrame.Parent = parentFrame

		local menuFrame = createPCGroup("Menu Items", {		[1] = {["ROBLOX Menu"] = "ESC"}, 
			[2] = {["Backpack"] = "~"},
			[3] = {["Playerlist"] = "TAB"},
			[4] = {["Chat"] = "/"} })
		menuFrame.Position = UDim2.new(1/3,PC_TABLE_SPACING,charMoveFrame.Size.Y.Scale,charMoveFrame.Size.Y.Offset + rowOffset)
		menuFrame.Parent = parentFrame

		parentFrame.Size = UDim2.new(parentFrame.Size.X.Scale, parentFrame.Size.X.Offset, 0, 
			menuFrame.Size.Y.Offset + menuFrame.Position.Y.Offset)
	end

	local function createGamepadHelp(parentFrame)
		local gamepadImage = "rbxasset://textures/ui/Settings/Help/GenericController.png"
		local imageSize = UDim2.new(0,650,0,239)
		local imagePosition = UDim2.new(0.5,-imageSize.X.Offset/2,0.5,-imageSize.Y.Offset/2)
		if isTenFootInterface then
			gamepadImage = "rbxasset://textures/ui/Settings/Help/XboxController.png"
			imageSize = UDim2.new(0,1334,0,570)
			imagePosition = UDim2.new(0.5, (-imageSize.X.Offset/2) - 50, 0.5, -imageSize.Y.Offset/2)--[[
		elseif UserInputService:GetPlatform() == Enum.Platform.PS4 or UserInputService:GetPlatform() == Enum.Platform.PS3 then
			gamepadImage = "rbxasset://textures/ui/Settings/Help/PSController.png"--]]
		end

		local gamepadImageLabel = utility:Create'ImageLabel'
		{
			Name = "GamepadImage",
			Size = imageSize,
			Position = imagePosition,
			Image = gamepadImage,
			BackgroundTransparency = 1,
			ZIndex = 2,
			Parent = parentFrame
		};
		parentFrame.Size = UDim2.new(parentFrame.Size.X.Scale, parentFrame.Size.X.Offset, 0, gamepadImageLabel.Size.Y.Offset + 100)

		local gamepadFontSize = isTenFootInterface and Enum.FontSize.Size36 or Enum.FontSize.Size24
		local function createGamepadLabel(text, position, size)
			local nameLabel = utility:Create'TextLabel'
			{
				Position = position,
				Size = size,
				BackgroundTransparency = 1,
				Text = text,
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.SourceSansBold,
				FontSize = gamepadFontSize,
				TextColor3 = Color3.new(1,1,1),
				Name = text .. "Label",
				ZIndex = 2,
				Parent = gamepadImageLabel
			};
		end

		local textVerticalSize = (gamepadFontSize == Enum.FontSize.Size36) and 36 or 24

		if gamepadImage == "rbxasset://textures/ui/Settings/Help/XboxController.png" then
			createGamepadLabel("Switch Tool", UDim2.new(0,50,0,-textVerticalSize/2), UDim2.new(0,100,0,textVerticalSize))
			createGamepadLabel("Game Menu Toggle", UDim2.new(0,-38,0.15,-textVerticalSize/2), UDim2.new(0,164,0,textVerticalSize))
			createGamepadLabel("Move", UDim2.new(0,-80,0.31,-textVerticalSize/2), UDim2.new(0,46,0,textVerticalSize))
			createGamepadLabel("Menu Navigation", UDim2.new(0,-50,0.46,-textVerticalSize/2), UDim2.new(0,164,0,textVerticalSize))
			createGamepadLabel("Use Tool", UDim2.new(0.96,0,0,-textVerticalSize/2), UDim2.new(0,73,0,textVerticalSize))
			createGamepadLabel("ROBLOX Menu", UDim2.new(0.96,0,0.15,-textVerticalSize/2), UDim2.new(0,122,0,textVerticalSize))
			createGamepadLabel("Back", UDim2.new(0.96,0,0.31,-textVerticalSize/2), UDim2.new(0,43,0,textVerticalSize))
			createGamepadLabel("Jump", UDim2.new(0.96,0,0.46,-textVerticalSize/2), UDim2.new(0,49,0,textVerticalSize))
			createGamepadLabel("Rotate Camera", UDim2.new(1,0,0.62,-textVerticalSize/2), UDim2.new(0,132,0,textVerticalSize))
			createGamepadLabel("Camera Zoom", UDim2.new(1,0,0.77,-textVerticalSize/2), UDim2.new(0,122,0,textVerticalSize))
		else
			createGamepadLabel("Switch Tool", UDim2.new(-0.01,0,0,-textVerticalSize/2), UDim2.new(0,100,0,textVerticalSize))
			createGamepadLabel("Game Menu Toggle", UDim2.new(-0.11,0,0.15,-textVerticalSize/2), UDim2.new(0,164,0,textVerticalSize))
			createGamepadLabel("Move", UDim2.new(-0.08,0,0.31,-textVerticalSize/2), UDim2.new(0,46,0,textVerticalSize))
			createGamepadLabel("Menu Navigation", UDim2.new(-0.125,0,0.46,-textVerticalSize/2), UDim2.new(0,164,0,textVerticalSize))
			createGamepadLabel("Use Tool", UDim2.new(0.96,0,0,-textVerticalSize/2), UDim2.new(0,73,0,textVerticalSize))
			createGamepadLabel("ROBLOX Menu", UDim2.new(0.9,0,0.15,-textVerticalSize/2), UDim2.new(0,122,0,textVerticalSize))
			createGamepadLabel("Back", UDim2.new(1.01,0,0.31,-textVerticalSize/2), UDim2.new(0,43,0,textVerticalSize))
			createGamepadLabel("Jump", UDim2.new(0.91,0,0.46,-textVerticalSize/2), UDim2.new(0,49,0,textVerticalSize))
			createGamepadLabel("Rotate Camera", UDim2.new(0.91,0,0.62,-textVerticalSize/2), UDim2.new(0,132,0,textVerticalSize))
			createGamepadLabel("Camera Zoom", UDim2.new(0.91,0,0.77,-textVerticalSize/2), UDim2.new(0,122,0,textVerticalSize))
		end


		-- todo: turn on dev console button when dev console is ready
		--[[local openDevConsoleFunc = function()
			this.HubRef:SetVisibility(false)
			ToggleDevConsoleBindableFunc:Invoke()
		end
		local devConsoleButton = utility:MakeStyledButton("ConsoleButton", "      Toggle Dev Console", UDim2.new(0,300,0,44), openDevConsoleFunc)
		devConsoleButton.Size = UDim2.new(devConsoleButton.Size.X.Scale, devConsoleButton.Size.X.Offset, 0, 60)
		devConsoleButton.Position = UDim2.new(1,-300,1,30)
		if UserInputService.GamepadEnabled and not UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled then
			devConsoleButton.ImageTransparency = 1
		end
		devConsoleButton.Parent = gamepadImageLabel
		local aButtonImage = utility:Create'ImageLabel'
		{
			Name = "AButtonImage",
			Size = UDim2.new(0,55,0,55),
			Position = UDim2.new(0,5,0.5,-28),
			Image = "rbxasset://textures/ui/Settings/Help/AButtonDark.png",
			BackgroundTransparency = 1,
			ZIndex = 2,
			Parent = devConsoleButton
		};

		this:AddRow(nil, nil, devConsoleButton, 340)]]
	end

	local function createTouchHelp(parentFrame)
		local smallScreen = utility:IsSmallTouchScreen()

		local viewportY = 0
		local camera = workspace.CurrentCamera
		if camera then
			viewportY = camera.ViewportSize.Y
		end

		if viewportY <= 0 then
			local ok, resolution = pcall(function()
				return GuiService:GetScreenResolution()
			end)
			if ok and resolution then
				viewportY = resolution.Y
			end
		end

		if viewportY <= 0 then
			viewportY = 720
		end

		local ySize = viewportY - 350
		if smallScreen then
			ySize = viewportY - 100
		end

		-- Never allow the Help page to end up with a zero/negative height.
		ySize = math.max(ySize, 220)
		parentFrame.Size = UDim2.new(1,0,0,ySize)

		local function createTouchLabel(text, position, size, parent)
			local nameLabel = utility:Create'TextLabel'
			{
				Position = position,
				Size = size,
				BackgroundTransparency = 1,
				Text = text,
				Font = Enum.Font.SourceSansBold,
				FontSize = Enum.FontSize.Size14,
				TextColor3 = Color3.new(1,1,1),
				Name = text .. "Label",
				ZIndex = 2,
				Parent = parent
			};
			if not smallScreen then
				nameLabel.FontSize = Enum.FontSize.Size18
				nameLabel.Size = UDim2.new(nameLabel.Size.X.Scale, nameLabel.Size.X.Offset, nameLabel.Size.Y.Scale, nameLabel.Size.Y.Offset + 4)
			end
			local nameBackgroundImage = utility:Create'ImageLabel'
			{
				Name = text .. "BackgroundImage",
				Size = UDim2.new(1,0,1,0),
				Position = UDim2.new(0,0,0,2),
				BackgroundTransparency = 1,
				Image = "rbxasset://textures/ui/Settings/Radial/RadialLabel.png",
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(12,2,65,21),
				ZIndex = 2,
				Parent = nameLabel
			};

			return nameLabel
		end

		local function createTouchGestureImage(name, image, position, size, parent)
			local gestureImage = utility:Create'ImageLabel'
			{
				Name = name,
				Size = size,
				Position = position,
				BackgroundTransparency = 1,
				Image = image,
				ZIndex = 2,
				Parent = parent
			};

			return gestureImage
		end

		local xSizeOffset = 30
		local ySize = 25
		if smallScreen then xSizeOffset = 0 end

		local moveLabel = createTouchLabel("Move", UDim2.new(0.06,0,0.58,0), UDim2.new(0,77 + xSizeOffset,0,ySize), parentFrame)
		if not smallScreen then moveLabel.Position = UDim2.new(-0.03,0,0.7,0) end
		local jumpLabel = createTouchLabel("Jump", UDim2.new(0.8,0,0.58,0), UDim2.new(0,77 + xSizeOffset,0,ySize), parentFrame)
		if not smallScreen then jumpLabel.Position = UDim2.new(0.85,0,0.7,0) end
		local equipLabel = createTouchLabel("Equip/Unequip Tools", UDim2.new(0.5,-60,0.64,0), UDim2.new(0,120 + xSizeOffset,0,ySize), parentFrame)
		if not smallScreen then equipLabel.Position = UDim2.new(0.5,-60,0.95,0) end

		local zoomLabel = createTouchLabel("Zoom In/Out", UDim2.new(0.15,-60,0.02,0), UDim2.new(0,120,0,ySize), parentFrame)
		createTouchGestureImage("ZoomImage", "rbxasset://textures/ui/Settings/Help/ZoomGesture.png", UDim2.new(0.5,-26,1,3), UDim2.new(0,53,0,59), zoomLabel)
		local rotateLabel = createTouchLabel("Rotate Camera", UDim2.new(0.5,-60,0.02,0), UDim2.new(0,120,0,ySize), parentFrame)
		createTouchGestureImage("RotateImage", "rbxasset://textures/ui/Settings/Help/RotateCameraGesture.png", UDim2.new(0.5,-32,1,3), UDim2.new(0,65,0,48), rotateLabel)
		local useToolLabel = createTouchLabel("Use Tool", UDim2.new(0.85,-60,0.02,0), UDim2.new(0,120,0,ySize), parentFrame)
		createTouchGestureImage("ToolImage", "rbxasset://textures/ui/Settings/Help/UseToolGesture.png", UDim2.new(0.5,-19,1,3), UDim2.new(0,38,0,52), useToolLabel)

	end

	local function createHelpDisplay(typeOfHelp)
		local helpFrame = utility:Create'Frame'
		{
			Size = UDim2.new(1,0,1,0),
			BackgroundTransparency = 1,
			Name = "HelpFrame" .. tostring(typeOfHelp)
		};

		if typeOfHelp == KEYBOARD_MOUSE_TAG then
			createPCHelp(helpFrame)
		elseif typeOfHelp == GAMEPAD_TAG then
			createGamepadHelp(helpFrame)
		elseif typeOfHelp == TOUCH_TAG then
			createTouchHelp(helpFrame)
		end

		return helpFrame
	end

	local function displayHelp(currentPage)
		for i, helpPage in pairs(this.HelpPages) do
			if helpPage == currentPage then
				helpPage.Parent = this.Page
				this.Page.Size = helpPage.Size
			else
				helpPage.Parent = nil
			end
		end
		if isTenFootInterface then
			this.HubRef.PageViewClipper.ClipsDescendants = false
			this.HubRef.PageView.ClipsDescendants = false
		end
	end

	local function switchToHelp(typeOfHelp)
		local helpPage = this.HelpPages[typeOfHelp]
		if helpPage then
			displayHelp(helpPage)
		else
			this.HelpPages[typeOfHelp] = createHelpDisplay(typeOfHelp)
			switchToHelp(typeOfHelp)
		end
	end

	local function showTypeOfHelp()
		switchToHelp(this:GetCurrentInputType())
	end

	------ TAB CUSTOMIZATION -------
	this.TabHeader.Name = "HelpTab"

	this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/HelpTab.png"

	if utility:IsSmallTouchScreen() then
		this.TabHeader.Icon.Size = UDim2.new(0,33,0,33)
		this.TabHeader.Icon.Position = UDim2.new(this.TabHeader.Icon.Position.X.Scale,this.TabHeader.Icon.Position.X.Offset,0.5,-16)
		this.TabHeader.Size = UDim2.new(0,100,1,0)
	elseif isTenFootInterface then
		this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/HelpTab@2x.png"
		this.TabHeader.Icon.Size = UDim2.new(0,90,0,90)
		this.TabHeader.Icon.Position = UDim2.new(0,0,0.5,-43)
		this.TabHeader.Size = UDim2.new(0,210,1,0)
	else
		this.TabHeader.Icon.Size = UDim2.new(0,44,0,44)
		this.TabHeader.Icon.Position = UDim2.new(this.TabHeader.Icon.Position.X.Scale,this.TabHeader.Icon.Position.X.Offset,0.5,-22)
		this.TabHeader.Size = UDim2.new(0,130,1,0)
	end

	this.TabHeader.Icon.Title.Text = "Help"


	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "Help"

	UserInputService.InputBegan:connect(function(inputObject)
		local inputType = inputObject.UserInputType
		if inputType ~= Enum.UserInputType.Focus and inputType ~= Enum.UserInputType.None then
			lastInputType = inputType
			showTypeOfHelp()
		end
	end)

	return this
end


----------- Public Facing API Additions --------------
do
	PageInstance = Initialize()

	PageInstance.Displayed.Event:connect(function()
		-- Do not wait for another key/touch after opening Help. On mobile the tap
		-- that selected the Help tab may have already finished before this connects.
		showTypeOfHelp()

		if PageInstance:GetCurrentInputType() == TOUCH_TAG then
			if PageInstance.HubRef.BottomButtonFrame and not utility:IsSmallTouchScreen() then
				PageInstance.HubRef.BottomButtonFrame.Visible = false
			end
		end
	end)

	PageInstance.Hidden.Event:connect(function()
		PageInstance.HubRef.PageViewClipper.ClipsDescendants = true
		PageInstance.HubRef.PageView.ClipsDescendants = true

		PageInstance.HubRef:ShowShield()

		if PageInstance:GetCurrentInputType() == TOUCH_TAG then
			PageInstance.HubRef.BottomButtonFrame.Visible = true
		end
	end)
end


return PageInstance
end;
};
G2L_MODULES[G2L["12"]] = {
Closure = function()
    local script = G2L["12"];--[[
		Filename: Home.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the home page in Settings Menu
--]]

local BUTTON_OFFSET = 20
local BUTTON_SPACING = 10

-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = _G:GetService("GuiService")

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Settings.Utility)

------------ Variables -------------------
local PageInstance = nil

----------- CLASS DECLARATION --------------

local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()

	------ TAB CUSTOMIZATION -------
	this.TabHeader.Name = "HomeTab"

	this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/HomeTab.png"
	this.TabHeader.Icon.Size = UDim2.new(0,32,0,30)
	this.TabHeader.Icon.Position = UDim2.new(0,5,0.5,-15)

	this.TabHeader.Icon.Title.Text = "Home"

	this.TabHeader.Size = UDim2.new(0,100,1,0)

	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "Home"
	local resumeGameFunc = function()
		this.HubRef:SetVisibility(false)
	end

	this.ResumeButton = utility:MakeStyledButton("ResumeButton", "Resume Game", UDim2.new(0, 200, 0, 50), resumeGameFunc)
	this.ResumeButton.Position = UDim2.new(0.5,-100,0,BUTTON_OFFSET)
	this.ResumeButton.Parent = this.Page

	local resetFunc = function()
		this.HubRef:SwitchToPage(this.HubRef.ResetCharacterPage, false, 1)
	end

	local resetButton = utility:MakeStyledButton("ResetButton", "Reset Character", UDim2.new(0, 200, 0, 50), resetFunc)
	resetButton.Position = UDim2.new(0.5,-100,0,this.ResumeButton.AbsolutePosition.Y + this.ResumeButton.AbsoluteSize.Y + BUTTON_SPACING)
	resetButton.Parent = this.Page

	local leaveGameFunc = function()
		this.HubRef:SwitchToPage(this.HubRef.LeaveGamePage, false, 1)
	end

	local leaveButton = utility:MakeStyledButton("LeaveButton", "Leave Game", UDim2.new(0, 200, 0, 50), leaveGameFunc)
	leaveButton.Position = UDim2.new(0.5,-100,0,resetButton.AbsolutePosition.Y + resetButton.AbsoluteSize.Y + BUTTON_SPACING)
	leaveButton.Parent = this.Page

	this.Page.Size = UDim2.new(1,0,0,leaveButton.AbsolutePosition.Y + leaveButton.AbsoluteSize.Y)

	return this
end


----------- Public Facing API Additions --------------
do
	PageInstance = Initialize()

	PageInstance.Displayed.Event:connect(function()
		if not utility:UsesSelectedObject() then return end

		GuiService.SelectedObject = PageInstance.ResumeButton
	end)
end


return PageInstance
end;
};
G2L_MODULES[G2L["13"]] = {
Closure = function()
    local script = G2L["13"];--[[
		Filename: LeaveGame.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the leave game in Settings Menu
--]]


-------------- CONSTANTS -------------
local LEAVE_GAME_ACTION = "LeaveGameCancelAction"

-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = _G:GetService("GuiService")

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Settings.Utility)

------------ Variables -------------------
local PageInstance = nil
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()


----------- CLASS DECLARATION --------------

local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()

	this.DontLeaveFunc = function(isUsingGamepad)
		if this.HubRef then
			this.HubRef:PopMenu(isUsingGamepad, true)
		end
	end
	this.DontLeaveFromHotkey = function(name, state, input)
		if state == Enum.UserInputState.Begin then
			local isUsingGamepad = input.UserInputType == Enum.UserInputType.Gamepad1 or input.UserInputType == Enum.UserInputType.Gamepad2
				or input.UserInputType == Enum.UserInputType.Gamepad3 or input.UserInputType == Enum.UserInputType.Gamepad4

			this.DontLeaveFunc(isUsingGamepad)
		end
	end
	this.DontLeaveFromButton = function(isUsingGamepad)
		this.DontLeaveFunc(isUsingGamepad)
	end

	------ TAB CUSTOMIZATION -------
	this.TabHeader = nil -- no tab for this page

	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "LeaveGamePage"

	local leaveGameText =  utility:Create'TextLabel'
	{
		Name = "LeaveGameText",
		Text = "Are you sure you want to leave the game?",
		Font = Enum.Font.SourceSansBold,
		FontSize = Enum.FontSize.Size36,
		TextColor3 = Color3.new(1,1,1),
		BackgroundTransparency = 1,
		Size = UDim2.new(1,0,0,200),
		TextWrapped = true,
		ZIndex = 2,
		Parent = this.Page
	};
	if utility:IsSmallTouchScreen() then
		leaveGameText.FontSize = Enum.FontSize.Size24
		leaveGameText.Size = UDim2.new(1,0,0,100)
	elseif isTenFootInterface then
		leaveGameText.FontSize = Enum.FontSize.Size48
	end

	local buttonSpacing = 20
	local buttonSize = UDim2.new(0, 200, 0, 50)
	if isTenFootInterface then
		leaveGameText.Position = UDim2.new(0,0,0,100)
		buttonSize = UDim2.new(0, 300, 0, 80)
	end

	this.LeaveGameButton = utility:MakeStyledButton("LeaveGame", "Leave", buttonSize, function()
		Players.LocalPlayer:Kick()
	end)
	this.LeaveGameButton.NextSelectionRight = nil
	--this.LeaveGameButton:SetVerb("Exit")
	if utility:IsSmallTouchScreen() then
		this.LeaveGameButton.Position = UDim2.new(0.5, -buttonSize.X.Offset - buttonSpacing, 1, 0)
	else
		this.LeaveGameButton.Position = UDim2.new(0.5, -buttonSize.X.Offset - buttonSpacing, 1, -30)
	end
	this.LeaveGameButton.Parent = leaveGameText


	------------- Init ----------------------------------

	local dontleaveGameButton = utility:MakeStyledButton("DontLeaveGame", "Don't Leave", buttonSize, this.DontLeaveFromButton)
	dontleaveGameButton.NextSelectionLeft = nil
	if utility:IsSmallTouchScreen() then
		dontleaveGameButton.Position = UDim2.new(0.5, buttonSpacing, 1, 0)
	else
		dontleaveGameButton.Position = UDim2.new(0.5, buttonSpacing, 1, -30)
	end
	dontleaveGameButton.Parent = leaveGameText

	this.Page.Size = UDim2.new(1,0,0,dontleaveGameButton.AbsolutePosition.Y + dontleaveGameButton.AbsoluteSize.Y)

	return this
end


----------- Public Facing API Additions --------------
PageInstance = Initialize()

PageInstance.Displayed.Event:connect(function()
	GuiService.SelectedObject = PageInstance.LeaveGameButton
	ContextActionService:BindAction(LEAVE_GAME_ACTION, PageInstance.DontLeaveFromHotkey, false, Enum.KeyCode.ButtonB)
end)

PageInstance.Hidden.Event:connect(function()
	ContextActionService:UnbindAction(LEAVE_GAME_ACTION)
end)


return PageInstance
end;
};
G2L_MODULES[G2L["14"]] = {
Closure = function()
    local script = G2L["14"];--[[
		Filename: ResetCharacter.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the reseting the character in Settings Menu
--]]

-------------- CONSTANTS -------------
local RESET_CHARACTER_GAME_ACTION = "ResetCharacterAction"

-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = _G:GetService("GuiService")
local PlayersService = game:GetService("Players")

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Settings.Utility)

------------ Variables -------------------
local PageInstance = nil
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

----------- CLASS DECLARATION --------------

local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()

	this.DontResetCharFunc = function(isUsingGamepad)
		if this.HubRef then
			this.HubRef:PopMenu(isUsingGamepad, true)
		end
	end
	this.DontResetCharFromHotkey = function(name, state, input)
		if state == Enum.UserInputState.Begin then
			local isUsingGamepad = input.UserInputType == Enum.UserInputType.Gamepad1 or input.UserInputType == Enum.UserInputType.Gamepad2
				or input.UserInputType == Enum.UserInputType.Gamepad3 or input.UserInputType == Enum.UserInputType.Gamepad4

			this.DontResetCharFunc(isUsingGamepad)
		end
	end
	this.DontResetCharFromButton = function(isUsingGamepad)
		this.DontResetCharFunc(isUsingGamepad)
	end

	------ TAB CUSTOMIZATION -------
	this.TabHeader = nil -- no tab for this page

	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "ResetCharacter"

	local resetCharacterText =  utility:Create'TextLabel'
	{
		Name = "ResetCharacterText",
		Text = "Are you sure you want to reset your character?",
		Font = Enum.Font.SourceSansBold,
		FontSize = Enum.FontSize.Size36,
		TextColor3 = Color3.new(1,1,1),
		BackgroundTransparency = 1,
		Size = UDim2.new(1,0,0,200),
		TextWrapped = true,
		ZIndex = 2,
		Parent = this.Page
	};
	if utility:IsSmallTouchScreen() then
		resetCharacterText.FontSize = Enum.FontSize.Size24
		resetCharacterText.Size = UDim2.new(1,0,0,100)
	elseif isTenFootInterface then
		resetCharacterText.FontSize = Enum.FontSize.Size48
	end

	------ Init -------
	local resetCharFunc = function()
		local player = PlayersService.LocalPlayer
		if player then
			local character = player.Character
			if character then
				local humanoid = character:FindFirstChild('Humanoid')
				if humanoid then
					humanoid.Health = 0
				end
			end
		end

		if this.HubRef then
			this.HubRef:SetVisibility(false, true)
		end
	end

	local buttonSpacing = 20
	local buttonSize = UDim2.new(0, 200, 0, 50)
	if isTenFootInterface then
		resetCharacterText.Position = UDim2.new(0,0,0,100)
		buttonSize = UDim2.new(0, 300, 0, 80)
	end

	this.ResetCharacterButton = utility:MakeStyledButton("ResetCharacter", "Reset", buttonSize, resetCharFunc)
	this.ResetCharacterButton.NextSelectionRight = nil
	if utility:IsSmallTouchScreen() then
		this.ResetCharacterButton.Position = UDim2.new(0.5, -buttonSize.X.Offset - buttonSpacing, 1, 0)
	else
		this.ResetCharacterButton.Position = UDim2.new(0.5, -buttonSize.X.Offset - buttonSpacing, 1, -30)
	end
	this.ResetCharacterButton.Parent = resetCharacterText


	local dontResetCharacterButton = utility:MakeStyledButton("DontResetCharacter", "Don't Reset", buttonSize, this.DontResetCharFromButton)
	dontResetCharacterButton.NextSelectionLeft = nil
	if utility:IsSmallTouchScreen() then
		dontResetCharacterButton.Position = UDim2.new(0.5, buttonSpacing, 1, 0)
	else
		dontResetCharacterButton.Position = UDim2.new(0.5, buttonSpacing, 1, -30)
	end
	dontResetCharacterButton.Parent = resetCharacterText

	this.Page.Size = UDim2.new(1,0,0,dontResetCharacterButton.AbsolutePosition.Y + dontResetCharacterButton.AbsoluteSize.Y)

	return this
end


----------- Public Facing API Additions --------------
PageInstance = Initialize()

PageInstance.Displayed.Event:connect(function()
	GuiService.SelectedObject = PageInstance.ResetCharacterButton
	ContextActionService:BindAction(RESET_CHARACTER_GAME_ACTION, PageInstance.DontResetCharFromHotkey, false, Enum.KeyCode.ButtonB)
end)

PageInstance.Hidden.Event:connect(function()
	ContextActionService:UnbindAction(RESET_CHARACTER_GAME_ACTION)
end)


return PageInstance

end;
};
G2L_MODULES[G2L["15"]] = {
Closure = function()
    local script = G2L["15"];--[[r
		Filename: Record.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the Record Tab in Settings Menu
--]]
-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = _G:GetService("GuiService")
local Settings = _G:GetService("UserSettings")
local GameSettings = Settings

----------- UTILITIES --------------
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local utility = require(RobloxGui.Modules.Settings.Utility)
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

------------ Variables -------------------
local PageInstance = nil

----------- CLASS DECLARATION --------------

local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()
	local isRecordingVideo = false

	local recordingEvent = Instance.new("BindableEvent")
	recordingEvent.Name = "RecordingEvent"
	this.RecordingChanged = recordingEvent.Event
	function this:IsRecording()
		return isRecordingVideo
	end

	------ TAB CUSTOMIZATION -------
	this.TabHeader.Name = "RecordTab"

	this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/RecordTab.png"
	this.TabHeader.Icon.Size = UDim2.new(0,41,0,40)
	this.TabHeader.Icon.Position = UDim2.new(0,5,0.5,-20)

	this.TabHeader.Icon.Title.Text = "Record"

	this.TabHeader.Size = UDim2.new(0,130,1,0)


	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "Record"

	local function makeTextLabel(name, text, bold, size, pos, parent)
		local textLabel = utility:Create'TextLabel'
		{
			Name = name,
			BackgroundTransparency = 1,
			Text = text,
			TextWrapped = true,
			Font = Enum.Font.SourceSans,
			FontSize = Enum.FontSize.Size24,
			TextColor3 = Color3.new(1,1,1),
			Size = size,
			Position = pos,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			ZIndex = 2,
			Parent = parent
		};
		if bold then textLabel.Font = Enum.Font.SourceSansBold end

		return textLabel
	end

	-- need to override this function from SettingsPageFactory
	-- DropDown menus require hub to to be set when they are initialized
	function this:SetHub(newHubRef)
		this.HubRef = newHubRef

		local recordEnumNames = {}
		recordEnumNames[1] = "Save To Disk"
		recordEnumNames[2] = "Upload to YouTube"

		local startSetting = 2
		if GameSettings.VideoUploadPromptBehavior == "Never" then
			startSetting = 1
		end

		---------------------------------- SCREENSHOT -------------------------------------
		local screenshotTitle = makeTextLabel("ScreenshotTitle", 
			"Screenshot",
			true, UDim2.new(1,0,0,36), UDim2.new(0,10,0.05,0), this.Page)
		screenshotTitle.FontSize = Enum.FontSize.Size36

		local screenshotBody = makeTextLabel("ScreenshotBody", 
			"By clicking the 'Take Screenshot' button, the menu will close and take a screenshot and save it to your computer.",
			false, UDim2.new(1,-10,0,70), UDim2.new(0,0,1,0), screenshotTitle)

		local closeSettingsFunc = function()
			this.HubRef:SetVisibility(false, true)
		end
		this.ScreenshotButton = utility:MakeStyledButton("ScreenshotButton", "Take Screenshot", UDim2.new(0,300,0,44), closeSettingsFunc, this)

		this.ScreenshotButton.Position = UDim2.new(0,400,1,0)
		this.ScreenshotButton.Parent = screenshotBody


		---------------------------------- VIDEO -------------------------------------
		local videoTitle = makeTextLabel("VideoTitle", 
			"Video",
			true, UDim2.new(1,0,0,36), UDim2.new(0,10,0.5,0), this.Page)
		videoTitle.FontSize = Enum.FontSize.Size36

		local videoBody = makeTextLabel("VideoBody", 
			"By clicking the 'Record Video' button, the menu will close and start recording your screen.",
			false, UDim2.new(1,-10,0,70), UDim2.new(0,0,1,0), videoTitle)

		this.VideoSettingsFrame, 
		this.VideoSettingsLabel,
		this.VideoSettingsMode = utility:AddNewRow(this, "Video Settings", "Selector", recordEnumNames, startSetting, 270)

		this.VideoSettingsMode.IndexChanged:connect(function(newIndex)
			if newIndex == 1 then
				GameSettings.VideoUploadPromptBehavior = "Never"
			elseif newIndex == 2 then
				GameSettings.VideoUploadPromptBehavior = "Always"
			end
		end)


		local recordButton = utility:MakeStyledButton("RecordButton", "Record Video", UDim2.new(0,300,0,44), closeSettingsFunc, this)
		local gameOptions = _G:GetService("GuiService")
		
		recordButton.Position = UDim2.new(0,410,1,10)
		recordButton.Parent = this.VideoSettingsMode.SelectorFrame.Parent
		recordButton.MouseButton1Click:connect(function()
			recordingEvent:Fire(not isRecordingVideo)
			gameOptions:ToggleRecording()
		end)
		
		if gameOptions then
			-- please roblox let us just CHECK FOR A CHANGED EVENT WITH A LOCAL VARIABLE AHHHHHHHHH
			task.spawn(function()
				while true do
					isRecordingVideo = gameOptions.recording
					if gameOptions.recording then
						recordButton.RecordButtonTextLabel.Text = "Stop Recording"
					else
						recordButton.RecordButtonTextLabel.Text = "Record Video"
					end
					task.wait()
				end
			end)
		end
		
		this.ScreenshotButton.MouseButton1Click:Connect(function()
			_G:GetService("GuiService"):TakeScreenshot()
		end)

		this.Page.Size = UDim2.new(1,0,0,400)
	end

	return this
end


----------- Public Facing API Additions --------------
PageInstance = Initialize()

PageInstance.Displayed.Event:connect(function(switchedFromGamepadInput)
	if switchedFromGamepadInput then
		GuiService.SelectedObject = PageInstance.ScreenshotButton
	end
end)


return PageInstance
end;
};
G2L_MODULES[G2L["16"]] = {
Closure = function()
    local script = G2L["16"]; --[[
		Filename: Players.lua
		Written by: Stickmasterluke
		Version 1.0
		Description: Player list inside escape menu, with friend adding functionality.
--]]
-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = _G:GetService("GuiService")
local PlayersService = game:GetService('Players')
local HttpService = game:GetService('HttpService')
local HttpRbxApiService = game:GetService('HttpRbxApiService')
local UserInputService = game:GetService('UserInputService')
local Settings = _G:GetService("UserSettings")
local GameSettings = Settings

----------- UTILITIES --------------
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local utility = require(RobloxGui.Modules.Settings.Utility)
local isTenFootInterface = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

------------ Constants -------------------
local frameDefaultTransparency = .85
local frameSelectedTransparency = .65

------------ Variables -------------------
local PageInstance = nil
local localPlayer = PlayersService.LocalPlayer

----------- CLASS DECLARATION --------------
local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()

	local playerLabelFakeSelection = Instance.new('ImageLabel')
	playerLabelFakeSelection.BackgroundTransparency = 1
	--[[playerLabelFakeSelection.Image = 'rbxasset://textures/ui/SelectionBox.png'
	playerLabelFakeSelection.ScaleType = 'Slice'
	playerLabelFakeSelection.SliceCenter = Rect.new(31,31,31,31)]]
	playerLabelFakeSelection.Image = ''
	playerLabelFakeSelection.Size = UDim2.new(0,0,0,0)

	------ TAB CUSTOMIZATION -------
	this.TabHeader.Name = "PlayersTab"

	this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/PlayersTabIcon.png"
	if utility:IsSmallTouchScreen() then
		this.TabHeader.Icon.Size = UDim2.new(0,34,0,28)
		this.TabHeader.Icon.Position = UDim2.new(this.TabHeader.Icon.Position.X.Scale,this.TabHeader.Icon.Position.X.Offset,0.5,-14)
		this.TabHeader.Size = UDim2.new(0,115,1,0)
	elseif isTenFootInterface then
		this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/PlayersTabIcon@2x.png"
		this.TabHeader.Icon.Size = UDim2.new(0,88,0,74)
		this.TabHeader.Icon.Position = UDim2.new(0,0,0.5,-43)
		this.TabHeader.Size = UDim2.new(0,280,1,0)
	else
		this.TabHeader.Icon.Size = UDim2.new(0,44,0,37)
		this.TabHeader.Icon.Position = UDim2.new(0,15,0.5,-18)	-- -22
		this.TabHeader.Size = UDim2.new(0,150,1,0)
	end

	this.TabHeader.Icon.Title.Text = "Players"

	----- FRIENDSHIP FUNCTIONS ------
	local function getFriendStatus(selectedPlayer)
		if selectedPlayer == localPlayer then
			return Enum.FriendStatus.NotFriend
		else
			local success, result = pcall(function()
				-- NOTE: Core script only
				return localPlayer:GetFriendStatus(selectedPlayer)
			end)
			if success then
				return result
			else
				return Enum.FriendStatus.NotFriend
			end
		end
	end

	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "Players"

	local selectionFound = nil
	local function friendStatusCreate(playerLabel, player)
		if playerLabel then
			-- remove any previous friend status labels
			for _, item in pairs(playerLabel:GetChildren()) do
				if item and item.Name == 'FriendStatus' then
					if GuiService.SelectedObject == item then
						selectionFound = nil
						GuiService.SelectedObject = nil
					end
					item:Destroy()
				end
			end

			-- create new friend status label
			local status = nil
			if player and player ~= localPlayer and player.userId > 1 and localPlayer.userId > 1 then
				status = getFriendStatus(player)
			end

			local friendLabel = nil
			local friendLabelText = nil
			if not status then
				friendLabel = Instance.new('TextButton')
				friendLabel.Text = ''
				friendLabel.BackgroundTransparency = 1
				friendLabel.Position = UDim2.new(1,-198,0,7)
			elseif status == Enum.FriendStatus.Friend then 
				friendLabel = Instance.new('TextButton')
				friendLabel.Text = 'Friend'
				friendLabel.BackgroundTransparency = 1
				friendLabel.FontSize = 'Size24'
				friendLabel.Font = 'SourceSans'
				friendLabel.TextColor3 = Color3.new(1,1,1)
				friendLabel.Position = UDim2.new(1,-198,0,7)
			elseif status == Enum.FriendStatus.Unknown or status == Enum.FriendStatus.NotFriend or status == Enum.FriendStatus.FriendRequestReceived then
				local addFriendFunc = function()
					if friendLabel and friendLabelText and friendLabelText.Text ~= '' then
						friendLabel.ImageTransparency = 1
						friendLabelText.Text = ''
						if localPlayer and player then
							localPlayer:RequestFriendship(player)
						end
					end
				end
				local friendLabel2, friendLabelText2 = utility:MakeStyledButton("FriendStatus", "Add Friend", UDim2.new(0, 182, 0, 46), addFriendFunc)
				friendLabel = friendLabel2
				friendLabelText = friendLabelText2
				friendLabelText.ZIndex = 3
				friendLabelText.Position = friendLabelText.Position + UDim2.new(0,0,0,1)
				friendLabel.Position = UDim2.new(1,-198,0,7)
			elseif status == Enum.FriendStatus.FriendRequestSent then
				friendLabel = Instance.new('TextButton')
				friendLabel.Text = 'Request Sent'
				friendLabel.BackgroundTransparency = 1
				friendLabel.FontSize = 'Size24'
				friendLabel.Font = 'SourceSans'
				friendLabel.TextColor3 = Color3.new(1,1,1)
				friendLabel.Position = UDim2.new(1,-198,0,7)
			end

			if friendLabel then
				friendLabel.Name = 'FriendStatus'
				friendLabel.Size = UDim2.new(0,182,0,46)
				friendLabel.ZIndex = 3
				friendLabel.Parent = playerLabel
				friendLabel.SelectionImageObject = playerLabelFakeSelection

				local updateHighlight = function()
					if playerLabel then
						playerLabel.ImageTransparency = friendLabel and GuiService.SelectedObject == friendLabel and frameSelectedTransparency or frameDefaultTransparency
					end
				end
				friendLabel.SelectionGained:connect(updateHighlight)
				friendLabel.SelectionLost:connect(updateHighlight)

				if UserInputService.GamepadEnabled and not selectionFound then
					selectionFound = true
					local fakeSize = 20
					playerLabelFakeSelection.Size = UDim2.new(0,playerLabel.AbsoluteSize.X+fakeSize,0,playerLabel.AbsoluteSize.Y+fakeSize)
					playerLabelFakeSelection.Position = UDim2.new(0, -(playerLabel.AbsoluteSize.X-198)-fakeSize*.5, 0, -8-fakeSize*.5)
					GuiService.SelectedObject = friendLabel
				end
			end

		end
	end
	--[[
		localPlayer.FriendStatusChanged:connect(function(player, friendStatus)
			if player then
				local playerLabel = this.Page:FindFirstChild('PlayerLabel'..player.Name)
				if playerLabel then
					friendStatusCreate(playerLabel, player)
				end
			end
		end)
	--]]

	if utility:IsSmallTouchScreen() then
		local spaceFor3Buttons = RobloxGui.AbsoluteSize.x >= 720	-- else there is only space for 2

		local resetFunc = function()
			this.HubRef:SwitchToPage(this.HubRef.ResetCharacterPage, false, 1)
		end
		local resetButton, resetLabel = utility:MakeStyledButton("ResetButton", "Reset Character", UDim2.new(0, 200, 0, 62), resetFunc)
		resetLabel.Size = UDim2.new(1, 0, 1, -6)
		resetLabel.FontSize = Enum.FontSize.Size24
		resetButton.Position = UDim2.new(0.5,spaceFor3Buttons and -340 or -220,0,14)
		resetButton.Parent = this.Page

		local leaveGameFunc = function()
			this.HubRef:SwitchToPage(this.HubRef.LeaveGamePage, false, 1)
		end
		local leaveButton, leaveLabel = utility:MakeStyledButton("LeaveButton", "Leave Game", UDim2.new(0, 200, 0, 62), leaveGameFunc)
		leaveLabel.Size = UDim2.new(1, 0, 1, -6)
		leaveLabel.FontSize = Enum.FontSize.Size24
		leaveButton.Position = UDim2.new(0.5,spaceFor3Buttons and -100 or 20,0,14)
		leaveButton.Parent = this.Page

		if spaceFor3Buttons then
			local resumeGameFunc = function()
				this.HubRef:SetVisibility(false)
			end
			resumeButton, resumeLabel = utility:MakeStyledButton("ResumeButton", "Resume Game", UDim2.new(0, 200, 0, 62), resumeGameFunc)
			resumeLabel.Size = UDim2.new(1, 0, 1, -6)
			resumeLabel.FontSize = Enum.FontSize.Size24
			resumeButton.Position = UDim2.new(0.5,140,0,14)
			resumeButton.Parent = this.Page
		end
	end

	local existingPlayerLabels = {}
	this.Displayed.Event:connect(function(switchedFromGamepadInput)
		local sortedPlayers = game.Players:GetPlayers()
		table.sort(sortedPlayers,function(item1,item2)
			return item1.Name < item2.Name
		end)

		local extraOffset = 20
		if utility:IsSmallTouchScreen() then
			extraOffset = 85
		end

		selectionFound = nil


		-- iterate through players to reuse or create labels for players
		for index=1, #sortedPlayers do
			local player = sortedPlayers[index]
			local frame = existingPlayerLabels[index]
			if player then
				-- create label (frame) for this player index if one does not exist
				if not frame or not frame.Parent then
					frame = Instance.new('ImageLabel')
					frame.Image = "rbxasset://textures/ui/dialog_white.png"
					frame.ScaleType = 'Slice'
					frame.SliceCenter = Rect.new(10,10,10,10)
					frame.Size = UDim2.new(1,0,0,60)
					frame.Position = UDim2.new(0,0,0,(index-1)*80 + extraOffset)
					frame.BackgroundTransparency = 1
					frame.ZIndex = 2

					local icon = Instance.new('ImageLabel')
					icon.Name = 'Icon'
					icon.BackgroundTransparency = 1
					icon.Size = UDim2.new(0,36,0,36)
					icon.Position = UDim2.new(0,12,0,12)
					icon.ZIndex = 3
					icon.Parent = frame

					local nameLabel = Instance.new('TextLabel')
					nameLabel.Name = 'NameLabel'
					nameLabel.TextXAlignment = Enum.TextXAlignment.Left
					nameLabel.Font = 'SourceSans'
					nameLabel.FontSize = 'Size24'
					nameLabel.TextColor3 = Color3.new(1,1,1)
					nameLabel.BackgroundTransparency = 1
					nameLabel.Position = UDim2.new(0,60,.5,0)
					nameLabel.Size = UDim2.new(0,0,0,0)
					nameLabel.ZIndex = 3
					nameLabel.Parent = frame

					frame.MouseEnter:connect(function()
						frame.ImageTransparency = frameSelectedTransparency
					end)
					frame.MouseLeave:connect(function()
						frame.ImageTransparency = frameDefaultTransparency
					end)

					frame.Parent = this.Page
					table.insert(existingPlayerLabels, index, frame)
				end
				frame.Name = 'PlayerLabel'.._G:GetTrueName(player)
				frame.Icon.Image = 'http://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&userId='..math.max(1, player.userId)
				frame.NameLabel.Text = _G:GetTrueName(player)
				frame.ImageTransparency = frameDefaultTransparency

				friendStatusCreate(frame, player)
			end
		end

		-- iterate through existing labels in reverse to destroy and remove unused labels
		for index=#existingPlayerLabels, 1, -1 do
			local player = sortedPlayers[index]
			local frame = existingPlayerLabels[index]
			if frame and not player then
				table.remove(existingPlayerLabels, i)
				frame:Destroy()
			end
		end

		this.Page.Size = UDim2.new(1,0,0, extraOffset + 80 * #sortedPlayers - 5)
	end)

	return this
end


----------- Public Facing API Additions --------------
PageInstance = Initialize()

return PageInstance



end;
};
G2L_MODULES[G2L["17"]] = {
Closure = function()
    local script = G2L["17"];--[[
		Filename: ReportAbuseMenu.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the report abuse page in Settings Menu
--]]

-------------- SERVICES --------------
local CoreGui = _G:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = _G:GetService("GuiService")
local PlayersService = game:GetService("Players")

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Settings.Utility)

------------ CONSTANTS -------------------
local ABUSE_TYPES_PLAYER = {
	"Swearing",
	"Inappropriate Username",
	"Bullying",
	"Scamming",
	"Dating",
	"Cheating/Exploiting",
	"Personal Question",
	"Offsite Links",
}

local ABUSE_TYPES_GAME = {
	"Inappropriate Content",
	"Bad Model or Script",
	"Offsite Link",
}
local DEFAULT_ABUSE_DESC_TEXT = "   Short Description (Optional)"
if utility:IsSmallTouchScreen() then
	DEFAULT_ABUSE_DESC_TEXT = "   (Optional)"
end

------------ VARIABLES -------------------
local PageInstance = nil

----------- CLASS DECLARATION --------------
local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()

	local playerNames = {}
	local nameToRbxPlayer = {}

	function this:GetPlayerFromIndex(index)
		local playerName = playerNames[index]
		if playerName then
			return nameToRbxPlayer[nameToRbxPlayer]
		end

		return nil
	end

	function this:UpdatePlayerDropDown()
		playerNames = {}
		nameToRbxPlayer = {}

		local players = PlayersService:GetPlayers()
		local index = 1
		for i = 1, #players do
			local player = players[i]
			if player ~= PlayersService.LocalPlayer and player.UserId > 0 then
				playerNames[index] = player.Name
				nameToRbxPlayer[player.Name] = player
				index = index + 1
			end
		end

		this.WhichPlayerMode:UpdateDropDownList(playerNames)

		if index == 1 then
			this.GameOrPlayerMode:SetSelectionIndex(1)
			this.TypeOfAbuseMode:UpdateDropDownList(ABUSE_TYPES_GAME)
		end

		this.WhichPlayerMode:SetInteractable(index > 1 and this.GameOrPlayerMode.CurrentIndex ~= 1)
		this.GameOrPlayerMode:SetInteractable(index > 1)
	end

	------ TAB CUSTOMIZATION -------
	this.TabHeader.Name = "ReportAbuseTab"

	this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/ReportAbuseTab.png"
	if utility:IsSmallTouchScreen() then
		this.TabHeader.Icon.Size = UDim2.new(0,27,0,32)
		this.TabHeader.Size = UDim2.new(0,120,1,0)
	else
		this.TabHeader.Size = UDim2.new(0,150,1,0)
		this.TabHeader.Icon.Size = UDim2.new(0,36,0,43)
	end
	this.TabHeader.Icon.Position = UDim2.new(this.TabHeader.Icon.Position.X.Scale, this.TabHeader.Icon.Position.X.Offset + 10, 0.5,-this.TabHeader.Icon.Size.Y.Offset/2)

	this.TabHeader.Icon.Title.Text = "Report"

	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "ReportAbusePage"

	-- need to override this function from SettingsPageFactory
	-- DropDown menus require hub to to be set when they are initialized
	function this:SetHub(newHubRef)
		this.HubRef = newHubRef

		if utility:IsSmallTouchScreen() then
			this.GameOrPlayerFrame, 
			this.GameOrPlayerLabel,
			this.GameOrPlayerMode = utility:AddNewRow(this, "Game or Player?", "Selector", {"Game", "Player"}, 1)
		else
			this.GameOrPlayerFrame, 
			this.GameOrPlayerLabel,
			this.GameOrPlayerMode = utility:AddNewRow(this, "Game or Player?", "Selector", {"Game", "Player"}, 1, 3)
		end

		this.WhichPlayerFrame, 
		this.WhichPlayerLabel,
		this.WhichPlayerMode = utility:AddNewRow(this, "Which Player?", "DropDown", {"update me"})
		this.WhichPlayerMode:SetInteractable(false)
		this.WhichPlayerLabel.ZIndex = 1

		this.TypeOfAbuseFrame, 
		this.TypeOfAbuseLabel,
		this.TypeOfAbuseMode = utility:AddNewRow(this, "Type Of Abuse", "DropDown", ABUSE_TYPES_GAME)

		if utility:IsSmallTouchScreen() then
			this.AbuseDescriptionFrame, 
			this.AbuseDescriptionLabel,
			this.AbuseDescription = utility:AddNewRow(this, DEFAULT_ABUSE_DESC_TEXT, "TextBox", nil, nil)
		else
			this.AbuseDescriptionFrame, 
			this.AbuseDescriptionLabel,
			this.AbuseDescription = utility:AddNewRow(this, DEFAULT_ABUSE_DESC_TEXT, "TextBox", nil, nil, 5)
		end

		if utility:IsSmallTouchScreen() then
			this.AbuseDescription.Selection.Size = UDim2.new(0, 290, 0, 30)
			this.AbuseDescription.Selection.Position = UDim2.new(1,-345,this.AbuseDescription.Selection.Position.Y.Scale, this.AbuseDescription.Selection.Position.Y.Offset)

			this.AbuseDescriptionLabel = this.TypeOfAbuseLabel:clone()
			this.AbuseDescriptionLabel.Text = "Abuse Description"
			this.AbuseDescriptionLabel.Position = UDim2.new(this.AbuseDescriptionLabel.Position.X.Scale, this.AbuseDescriptionLabel.Position.X.Offset,
				0,50)
			this.AbuseDescriptionLabel.Parent = this.Page
		end

		local SelectionOverrideObject = utility:Create'ImageLabel'
		{
			Image = "",
			BackgroundTransparency = 1
		};

		local submitButton, submitText = nil, nil

		local function makeSubmitButtonActive()
			submitButton.ZIndex = 2
			submitButton.Selectable = true
			submitText.ZIndex = 2
		end

		local function makeSubmitButtonInactive()
			submitButton.ZIndex = 1
			submitButton.Selectable = false
			submitText.ZIndex = 1
		end

		local function updateAbuseDropDown()
			this.WhichPlayerMode:ResetSelectionIndex()
			this.TypeOfAbuseMode:ResetSelectionIndex()

			if this.GameOrPlayerMode.CurrentIndex == 1 then
				this.TypeOfAbuseMode:UpdateDropDownList(ABUSE_TYPES_GAME)
				this.WhichPlayerMode:SetInteractable(false)
				this.WhichPlayerLabel.ZIndex = 1
				this.GameOrPlayerMode.SelectorFrame.NextSelectionDown = this.TypeOfAbuseMode.DropDownFrame
			else
				this.TypeOfAbuseMode:UpdateDropDownList(ABUSE_TYPES_PLAYER)
				this.WhichPlayerMode:SetInteractable(true)
				this.WhichPlayerLabel.ZIndex = 2
				this.GameOrPlayerMode.SelectorFrame.NextSelectionDown = this.WhichPlayerMode.DropDownFrame
			end
			makeSubmitButtonInactive()
		end

		local function cleanupReportAbuseMenu()
			updateAbuseDropDown()
			this.AbuseDescription.Selection.Text = DEFAULT_ABUSE_DESC_TEXT
			this.HubRef:SetVisibility(false, true)
		end

		local function onReportSubmitted()
			local abuseReason = nil
			if this.GameOrPlayerMode.CurrentIndex == 2 then
				abuseReason = ABUSE_TYPES_PLAYER[this.TypeOfAbuseMode.CurrentIndex]

				local currentAbusingPlayer = this:GetPlayerFromIndex(this.WhichPlayerMode.CurrentIndex)
				if currentAbusingPlayer and abuseReason then
					spawn(function()
						game.Players:ReportAbuse(currentAbusingPlayer, abuseReason, this.AbuseDescription.Selection.Text)
					end)
				end
			else
				abuseReason = ABUSE_TYPES_GAME[this.TypeOfAbuseMode.CurrentIndex]
				if abuseReason then
					spawn(function()
						game.Players:ReportAbuse(nil, abuseReason, this.AbuseDescription.Selection.Text)
					end)
				end
			end

			if abuseReason then
				local alertText = "Thanks for your report! Our moderators will review the chat logs and evaluate what happened."

				if abuseReason == 'Cheating/Exploiting' then
					alertText = "Thanks for your report! We've recorded your report for evaluation."
				elseif abuseReason == 'Inappropriate Username' then
					alertText = "Thanks for your report! Our moderators will evaluate the username."
				elseif abuseReason == "Bad Model or Script" or  abuseReason == "Inappropriate Content" or abuseReason == "Offsite Link" or abuseReason == "Offsite Links" then
					alertText = "Thanks for your report! Our moderators will review the place and make a determination."
				end

				utility:ShowAlert(alertText, "Ok", this.HubRef, cleanupReportAbuseMenu)

				this.LastSelectedObject = nil
			end
		end

		submitButton, submitText = utility:MakeStyledButton("SubmitButton", "Submit", UDim2.new(0,198,0,50), onReportSubmitted, this)
		if utility:IsSmallTouchScreen() then
			submitButton.Position = UDim2.new(1,-220,1,5)
		else
			submitButton.Position = UDim2.new(1,-194,1,5)
		end
		submitButton.Selectable = false
		submitButton.ZIndex = 1
		submitText.ZIndex = 1
		submitButton.Parent = this.AbuseDescription.Selection

		local function playerSelectionChanged(newIndex)
			if newIndex ~= nil and this.TypeOfAbuseMode:GetSelectedIndex() ~= nil then
				makeSubmitButtonActive()
			else
				makeSubmitButtonInactive()
			end
		end
		this.WhichPlayerMode.IndexChanged:connect(playerSelectionChanged)

		local function typeOfAbuseChanged(newIndex)
			if newIndex ~= nil then
				if this.GameOrPlayerMode.CurrentIndex == 1 or this.WhichPlayerMode:GetSelectedIndex() ~= nil then
					makeSubmitButtonActive()
				else
					makeSubmitButtonInactive()
				end
			else
				makeSubmitButtonInactive()
			end
		end
		this.TypeOfAbuseMode.IndexChanged:connect(typeOfAbuseChanged)

		this.GameOrPlayerMode.IndexChanged:connect(updateAbuseDropDown)

		this:AddRow(nil, nil, this.AbuseDescription)

		this.Page.Size = UDim2.new(1,0,0,submitButton.AbsolutePosition.Y + submitButton.AbsoluteSize.Y)
	end

	return this
end


----------- Public Facing API Additions --------------
do
	PageInstance = Initialize()

	PageInstance.Displayed.Event:connect(function()
		PageInstance:UpdatePlayerDropDown()
	end)
end


return PageInstance

end;
};
-- StarterGui.RobloxGui.LoadingScreen
local function C_2()
local script = G2L["2"];
	-- Creates the generic "ROBLOX" loading screen on startup
	-- Written by ArceusInator & Ben Tkacheff, 2014
	--
	
	-- Constants
	local PLACEID = game.PlaceId
	
	local MPS = game:GetService('MarketplaceService')
	local UIS = game:GetService('UserInputService')
	local guiService = game:GetService("GuiService")
	local ContextActionService = game:GetService('ContextActionService')
	local RobloxGui = game.Players.LocalPlayer.PlayerGui
	
	game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()
	
	local startTime = tick()
	
	local COLORS = {
		BLACK = Color3.new(0, 0, 0),
		BACKGROUND_COLOR = Color3.new(45/255, 45/255, 45/255),
		WHITE = Color3.new(1, 1, 1),
		ERROR = Color3.new(253/255,68/255,72/255)
	}
	
	local function getViewportSize()
		while not game.Workspace.CurrentCamera do
			game.Workspace.Changed:wait()
		end
	
		while game.Workspace.CurrentCamera.ViewportSize == Vector2.new(0,0) do
			game.Workspace.CurrentCamera.Changed:wait()
		end
	
		return game.Workspace.CurrentCamera.ViewportSize
	end
	
	--
	-- Variables
	local GameAssetInfo -- loaded by InfoProvider:LoadAssets()
	local currScreenGui, renderSteppedConnection = nil, nil
	local destroyingBackground, destroyedLoadingGui, hasReplicatedFirstElements = false, false, false
	local backgroundImageTransparency = 0
	local isMobile = (UIS.TouchEnabled == true and UIS.MouseEnabled == false and getViewportSize().Y <= 500)
	local isTenFootInterface = guiService:IsTenFootInterface()
	local gamepadConnected = UIS.GamepadEnabled
	
	local function IsConvertMyPlaceNameInXboxAppEnabled()
		if UIS.GamepadEnabled then
			local success, flagValue = pcall(function() return settings():GetFFlag("ConvertMyPlaceNameInXboxApp") end)
			return (success and flagValue == true)
		end
		return false
	end
	
	--
	-- Utility functions
	local create = function(className, defaultParent)
		return function(propertyList)
			local object = Instance.new(className)
	
			for index, value in next, propertyList do
				if type(index) == 'string' then
					object[index] = value
				else
					if type(value) == 'function' then
						value(object)
					elseif type(value) == 'userdata' then
						value.Parent = object
					end
				end
			end
	
			if object.Parent == nil then
				object.Parent = defaultParent
			end
	
			return object
		end
	end
	
	--
	-- Create objects
	
	local MainGui = {}
	local InfoProvider = {}
	
	
	function ExtractGeneratedUsername(gameName)
		local tempUsername = string.match(gameName, "^([0-9a-fA-F]+)'s Place$")
		if tempUsername and #tempUsername == 32 then
			return tempUsername
		end
	end
	
	-- Fix places that have been made with incorrect temporary usernames
	function GetFilteredGameName(gameName, creatorName)
		if gameName and type(gameName) == 'string' then
			local tempUsername = ExtractGeneratedUsername(gameName)
			if tempUsername then
				local newGameName = string.gsub(gameName, tempUsername, creatorName, 1)
				if newGameName then
					return newGameName
				end
			end
		end
		return gameName
	end
	
	
	function InfoProvider:GetGameName()
		if GameAssetInfo ~= nil then
			if IsConvertMyPlaceNameInXboxAppEnabled() then
				return GetFilteredGameName(GameAssetInfo.Name, self:GetCreatorName())
			else
				return GameAssetInfo.Name
			end
		else
			return ''
		end
	end
	
	function InfoProvider:GetCreatorName()
		if GameAssetInfo ~= nil then
			return GameAssetInfo.Creator.Name
		else
			return ''
		end
	end
	
	function InfoProvider:LoadAssets()
		spawn(function()
			if PLACEID <= 0 then
				while game.PlaceId <= 0 do
					wait()
				end
				PLACEID = game.PlaceId
			end
	
			-- load game asset info
			coroutine.resume(coroutine.create(function()
				local success, result = pcall(function()
					GameAssetInfo = MPS:GetProductInfo(PLACEID)
				end)
				if not success then
					print("LoadingScript->InfoProvider:LoadAssets:", result)
				end
			end))
		end)
	end
	
	function MainGui:tileBackgroundTexture(frameToFill)
		if not frameToFill then return end
		frameToFill:ClearAllChildren()
		if backgroundImageTransparency < 1 then
			local backgroundTextureSize = Vector2.new(512, 512)
			for i = 0, math.ceil(frameToFill.AbsoluteSize.X/backgroundTextureSize.X) do
				for j = 0, math.ceil(frameToFill.AbsoluteSize.Y/backgroundTextureSize.Y) do
					create 'ImageLabel' {
						Name = 'BackgroundTextureImage',
						BackgroundTransparency = 1,
						ImageTransparency = backgroundImageTransparency,
						Image = 'rbxasset://textures/loading/darkLoadingTexture.png',
						Position = UDim2.new(0, i*backgroundTextureSize.X, 0, j*backgroundTextureSize.Y),
						Size = UDim2.new(0, backgroundTextureSize.X, 0, backgroundTextureSize.Y),
						ZIndex = 1,
						Parent = frameToFill
					}
				end
			end
		end
	end
	
	-- create a cancel binding for console to be able to cancel anytime while loading
	local function createTenfootCancelGui()
		local cancelLabel = create'ImageLabel'
		{
			Name = "CancelLabel";
			Size = UDim2.new(0, 83, 0, 83);
			Position = UDim2.new(1, -32 - 83, 0, 32);
			BackgroundTransparency = 1;
			Image = 'rbxasset://textures/ui/Settings/Help/BButtonLight@2x.png';
		}
		local cancelText = create'TextLabel'
		{
			Name = "CancelText";
			Size = UDim2.new(0, 0, 0, 0);
			Position = UDim2.new(1, -131, 0, 64);
			BackgroundTransparency = 1;
			FontSize = Enum.FontSize.Size36;
			TextXAlignment = Enum.TextXAlignment.Right;
			TextColor3 = COLORS.WHITE;
			Text = "Cancel";
		}
	
		-- bind cancel action
		local platformService = nil
		pcall(function()
			platformService = game:GetService('PlatformService')
		end)
	
		if platformService then
			if not game:IsLoaded() then
				local seenBButtonBegin = false
				ContextActionService:BindAction("CancelGameLoad",
					function(actionName, inputState, inputObject)
						if inputState == Enum.UserInputState.Begin then
							seenBButtonBegin = true
						elseif inputState == Enum.UserInputState.End and seenBButtonBegin then
							cancelLabel:Destroy()
							cancelText.Text = "Canceling..."
							cancelText.Position = UDim2.new(1, -32, 0, 64)
							ContextActionService:UnBindAction('CancelGameLoad')
							platformService:RequestGameShutdown()
						end
					end,
					false,
					Enum.KeyCode.ButtonB)
			end
		end
	
		while cancelLabel.Parent == nil do
			if currScreenGui then
				local blackFrame = currScreenGui:FindFirstChild('BlackFrame')
				if blackFrame then
					cancelLabel.Parent = blackFrame
					cancelText.Parent = blackFrame
					break
				end
			end
			wait()
		end
	end
	
	--
	-- Declare member functions
	function MainGui:GenerateMain()
		local screenGui = create 'ScreenGui' {
			Name = 'RobloxLoadingGui'
		}
	
		--
		-- create descendant frames
		local mainBackgroundContainer = create 'Frame' {
			Name = 'BlackFrame',
			BackgroundColor3 = COLORS.BACKGROUND_COLOR,
			BackgroundTransparency = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			Active = true,
			Parent = screenGui,
		}
	
		local closeButton =	create 'ImageButton' {
			Name = 'CloseButton',
			Image = 'rbxasset://textures/loading/cancelButton.png',
			ImageTransparency = 1,
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -37, 0, 5),
			Size = UDim2.new(0, 32, 0, 32),
			Active = false,
			ZIndex = 10,
			Parent = mainBackgroundContainer,
		}
	
		local graphicsFrame = create 'Frame' {
			Name = 'GraphicsFrame',
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(1, (isMobile == true and -75 or (isTenFootInterface and -245 or -225)), 1, (isMobile == true and -75 or (isTenFootInterface and -185 or -165))),
			Size = UDim2.new(0, (isMobile == true and 70 or (isTenFootInterface and 140 or 120)), 0, (isMobile == true and 70 or (isTenFootInterface and 140 or 120))),
			ZIndex = 2,
			Parent = mainBackgroundContainer,
		}
	
		local loadingImage = create 'ImageLabel' {
			Name = 'LoadingImage',
			BackgroundTransparency = 1,
			Image = 'rbxasset://textures/loading/loadingCircle.png',
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 2,
			Parent = graphicsFrame,
		}
	
		local loadingText = create 'TextLabel' {
			Name = 'LoadingText',
			BackgroundTransparency = 1,
			Size = UDim2.new(1, (isMobile == true and -14 or -56), 1, 0),
			Position = UDim2.new(0, (isMobile == true and 12 or 28), 0, 0),
			Font = Enum.Font.SourceSans,
			FontSize = (isMobile == true and Enum.FontSize.Size12 or Enum.FontSize.Size18),
			TextWrapped = true,
			TextColor3 = COLORS.WHITE,
			TextXAlignment = Enum.TextXAlignment.Left,
			Visible = not isTenFootInterface,
			Text = "Loading...",
			ZIndex = 2,
			Parent = graphicsFrame,
		}
	
		local uiMessageFrame = create 'Frame' {
			Name = 'UiMessageFrame',
			BackgroundTransparency = 1,
			Position = UDim2.new(0.25, 0, 1, -120),
			Size = UDim2.new(0.5, 0, 0, 80),
			ZIndex = 2,
			Parent = mainBackgroundContainer,
		}
	
		local uiMessage = create 'TextLabel' {
			Name = 'UiMessage',
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size18,
			TextWrapped = true,
			TextColor3 = COLORS.WHITE,
			Text = "",
			ZIndex = 2,
			Parent = uiMessageFrame,
		}
	
		local infoFrame = create 'Frame' {
			Name = 'InfoFrame',
			BackgroundTransparency = 1,
			Position = UDim2.new(0, (isMobile == true and 20 or 100), 1, (isMobile == true and -120 or -150)),
			Size = UDim2.new(0.4, 0, 0, 110),
			ZIndex = 2,
			Parent = mainBackgroundContainer,
		}
	
		local placeLabel = create 'TextLabel' {
			Name = 'PlaceLabel',
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 80),
			Position = UDim2.new(0, 0, 0, 0),
			Font = Enum.Font.SourceSans,
			FontSize = (isTenFootInterface and Enum.FontSize.Size48 or Enum.FontSize.Size24),
			TextWrapped = true,
			TextScaled = true,
			TextColor3 = COLORS.WHITE,
			TextStrokeTransparency = 0,
			Text = "",
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Bottom,
			ZIndex = 2,
			Parent = infoFrame,
		}
	
		if isTenFootInterface then
			local byLabel = create'TextLabel' {
				Name = "ByLabel",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 36, 0, 30),
				Position = UDim2.new(0, 0, 0, 80),
				Font = Enum.Font.SourceSans,
				FontSize = Enum.FontSize.Size36,
				TextScaled = true,
				TextColor3 = COLORS.WHITE,
				TextStrokeTransparency = 0,
				Text = "By",
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				ZIndex = 2,
				Visible = false,
				Parent = infoFrame,
			}
			local creatorIcon = create'ImageLabel' {
				Name = "CreatorIcon",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 30, 0, 30),
				Position = UDim2.new(0, 38, 0, 80),
				ImageTransparency = 0,
				Image = 'rbxasset://textures/ui/Shell/Icons/RobloxIcon32.png',
				ZIndex = 2,
				Visible = false,
				Parent = infoFrame,
			}
		end
	
		local creatorLabel = create 'TextLabel' {
			Name = 'CreatorLabel',
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 30),
			Position = UDim2.new(0, isTenFootInterface and 72 or 0, 0, 80),
			Font = Enum.Font.SourceSans,
			FontSize = (isTenFootInterface and Enum.FontSize.Size36 or Enum.FontSize.Size18),
			TextWrapped = true,
			TextScaled = true,
			TextColor3 = COLORS.WHITE,
			TextStrokeTransparency = 0,
			Text = "",
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			ZIndex = 2,
			Parent = infoFrame,
		}
	
		local backgroundTextureFrame = create 'Frame' {
			Name = 'BackgroundTextureFrame',
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			ClipsDescendants = true,
			ZIndex = 1,
			BackgroundTransparency = 1,
			Parent = mainBackgroundContainer,
		}
	
		local errorFrame = create 'Frame' {
			Name = 'ErrorFrame',
			BackgroundColor3 = COLORS.ERROR,
			BorderSizePixel = 0,
			Position = UDim2.new(0.25,0,0,36),
			Size = UDim2.new(0.5, 0, 0, 80),
			ZIndex = 8,
			Visible = false,
			Parent = screenGui,
		}
	
		local errorText = create 'TextLabel' {
			Name = "ErrorText",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size14,
			TextWrapped = true,
			TextColor3 = COLORS.WHITE,
			Text = "",
			ZIndex = 8,
			Parent = errorFrame,
		}
	
		--[[while not game.Players.LocalPlayer.PlayerGui.CoreGui do
			wait()
		end
		screenGui.Parent = game.Players.LocalPlayer.PlayerGui.CoreGui]]
		screenGui.DisplayOrder = 2147483647
		screenGui.ResetOnSpawn = false
		screenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
		screenGui.Parent = game.Players.LocalPlayer.PlayerGui
		currScreenGui = screenGui
	end
	
	function round(num, idp)
		local mult = 10^(idp or 0)
		return math.floor(num * mult + 0.5) / mult
	end
	
	---------------------------------------------------------
	-- Main Script (show something now + setup connections)
	
	-- start loading assets asap
	InfoProvider:LoadAssets()
	MainGui:GenerateMain()
	if isTenFootInterface then
		createTenfootCancelGui()
	end
	
	local setVerb = false
	local lastRenderTime, lastDotUpdateTime, brickCountChange = nil, nil, nil
	local fadeCycleTime = 1.7
	local turnCycleTime = 2
	local lastAbsoluteSize = Vector2.new(0, 0)
	local loadingDots = "..."
	local dotChangeTime = .2
	local lastBrickCount = 0
	
	renderSteppedConnection = game:GetService("RunService").RenderStepped:connect(function()
		if not currScreenGui then return end
		if not currScreenGui:FindFirstChild("BlackFrame") then return end
	
		if setVerb then
			currScreenGui.BlackFrame.CloseButton:SetVerb("Exit")
			setVerb = false
		end
	
		if currScreenGui.BlackFrame:FindFirstChild("BackgroundTextureFrame") and currScreenGui.BlackFrame.BackgroundTextureFrame.AbsoluteSize ~= lastAbsoluteSize then
			lastAbsoluteSize = currScreenGui.BlackFrame.BackgroundTextureFrame.AbsoluteSize
			MainGui:tileBackgroundTexture(currScreenGui.BlackFrame.BackgroundTextureFrame)
		end
	
		local infoFrame = currScreenGui.BlackFrame:FindFirstChild('InfoFrame')
		if infoFrame then
			-- set place name
			local placeLabel = infoFrame:FindFirstChild('PlaceLabel')
			if placeLabel and placeLabel.Text == "" then
				placeLabel.Text = InfoProvider:GetGameName()
			end
	
			-- set creator name
			local creatorLabel = infoFrame:FindFirstChild('CreatorLabel')
			if creatorLabel and creatorLabel.Text == "" then
				local creatorName = InfoProvider:GetCreatorName()
				if creatorName ~= "" then
					if isTenFootInterface then
						local showDevName = true
						if gamepadConnected == true then
							local success, result = pcall(function()
								return settings():GetFFlag("ShowDevNameInXboxApp")
							end)
							if success then
								showDevName = result
							end
						end
						creatorLabel.Text = showDevName and creatorName or ""
						local creatorIcon = infoFrame:FindFirstChild('CreatorIcon')
						local byLabel = infoFrame:FindFirstChild('ByLabel')
						if creatorIcon then creatorIcon.Visible = showDevName end
						if byLabel then byLabel.Visible = showDevName end
					else
						creatorLabel.Text = "By "..creatorName
					end
				end
			end
		end
	
		if not lastRenderTime then
			lastRenderTime = tick()
			lastDotUpdateTime = lastRenderTime
			return
		end
	
		local currentTime = tick()
		local fadeAmount = (currentTime - lastRenderTime) * fadeCycleTime
		local turnAmount = (currentTime - lastRenderTime) * (360/turnCycleTime)
		lastRenderTime = currentTime
	
		currScreenGui.BlackFrame.GraphicsFrame.LoadingImage.Rotation = currScreenGui.BlackFrame.GraphicsFrame.LoadingImage.Rotation + turnAmount
	
		local updateLoadingDots =  function()
			loadingDots = loadingDots.. "."
			if loadingDots == "...." then
				loadingDots = ""
			end
			currScreenGui.BlackFrame.GraphicsFrame.LoadingText.Text = "Loading" ..loadingDots
		end
	
		local function GetBrickCount()
			local Bricks = 0
			for _,part in pairs(workspace:GetDescendants()) do
				if part:IsA("BasePart") then Bricks += 1 return Bricks end
			end
		end
	
		if currentTime - lastDotUpdateTime >= dotChangeTime and InfoProvider:GetCreatorName() == "" then
			lastDotUpdateTime = currentTime
			updateLoadingDots()
		else
			if GetBrickCount() > 0 then
				if brickCountChange == nil then
					brickCountChange = GetBrickCount()
				end
				if GetBrickCount() - lastBrickCount >= brickCountChange then
					lastBrickCount = GetBrickCount()
					updateLoadingDots()
				end
			end
		end
	
		if not isTenFootInterface then
			if currentTime - startTime > 5 and currScreenGui.BlackFrame.CloseButton.ImageTransparency > 0 then
				currScreenGui.BlackFrame.CloseButton.ImageTransparency = currScreenGui.BlackFrame.CloseButton.ImageTransparency - fadeAmount
	
				if currScreenGui.BlackFrame.CloseButton.ImageTransparency <= 0 then
					currScreenGui.BlackFrame.CloseButton.Active = true
				end
			end
		end
	end)
	
	spawn(function()
		local CoreGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("CoreGui")
		local RobloxGui = CoreGui:WaitForChild("RobloxGui")
		local guiInsetChangedEvent = Instance.new("BindableEvent")
		guiInsetChangedEvent.Name = "GuiInsetChanged"
		guiInsetChangedEvent.Parent = RobloxGui
		guiInsetChangedEvent.Event:connect(function(x1, y1, x2, y2)
			if currScreenGui and currScreenGui:FindFirstChild("BlackFrame") then
				currScreenGui.BlackFrame.Position = UDim2.new(0, -x1, 0, -y1)
				currScreenGui.BlackFrame.Size = UDim2.new(1, x1 + x2, 1, y1 + y2)
			end
		end)
	end)
	
	local leaveGameButton, leaveGameTextLabel, errorImage = nil
	
	--[[guiService.ErrorMessageChanged:connect(function()
		if guiService:GetErrorMessage() ~= '' then
			if isTenFootInterface then
				currScreenGui.ErrorFrame.Size = UDim2.new(1, 0, 0, 144)
				currScreenGui.ErrorFrame.Position = UDim2.new(0, 0, 0, 0)
				currScreenGui.ErrorFrame.BackgroundColor3 = COLORS.BLACK
				currScreenGui.ErrorFrame.BackgroundTransparency = 0.5
				currScreenGui.ErrorFrame.ErrorText.FontSize = Enum.FontSize.Size36
				currScreenGui.ErrorFrame.ErrorText.Position = UDim2.new(.3, 0, 0, 0)
				currScreenGui.ErrorFrame.ErrorText.Size = UDim2.new(.4, 0, 0, 144)
				if errorImage == nil then
					errorImage = Instance.new("ImageLabel")
					errorImage.Image = "rbxasset://textures/ui/ErrorIconSmall.png"
					errorImage.Size = UDim2.new(0, 96, 0, 79)
					errorImage.Position = UDim2.new(0.228125, 0, 0, 32)
					errorImage.ZIndex = 9
					errorImage.BackgroundTransparency = 1
					errorImage.Parent = currScreenGui.ErrorFrame
				end
				-- we show a B button to kill game data model on console
				if not isTenFootInterface then
					if leaveGameButton == nil then
						local RobloxGui = game.Players.LocalPlayer.PlayerGui.CoreGui:WaitForChild("RobloxGui")
						local utility = require(RobloxGui.Modules.Settings.Utility)
						local textLabel = nil
						leaveGameButton, leaveGameTextLabel = utility:MakeStyledButton("LeaveGame", "Leave", UDim2.new(0, 288, 0, 78))
						leaveGameButton:SetVerb("Exit")
						leaveGameButton.NextSelectionDown = leaveGameButton
						leaveGameButton.NextSelectionLeft = leaveGameButton
						leaveGameButton.NextSelectionRight = leaveGameButton
						leaveGameButton.NextSelectionUp = leaveGameButton
						leaveGameButton.ZIndex = 9
						leaveGameButton.Position = UDim2.new(0.771875, 0, 0, 37)
						leaveGameButton.Parent = currScreenGui.ErrorFrame
						leaveGameTextLabel.FontSize = Enum.FontSize.Size36
						leaveGameTextLabel.ZIndex = 10
						game:GetService("GuiService").SelectedCoreObject = leaveGameButton
					else
						game:GetService("GuiService").SelectedCoreObject = leaveGameButton
					end
				end
			end
			currScreenGui.ErrorFrame.ErrorText.Text = guiService:GetErrorMessage()
			currScreenGui.ErrorFrame.Visible = true
			local blackFrame = currScreenGui:FindFirstChild('BlackFrame')
			if blackFrame then
				blackFrame.CloseButton.ImageTransparency = 0
				blackFrame.CloseButton.Active = true
			end
		else
			currScreenGui.ErrorFrame.Visible = false
		end
	end)]]
	
	local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remote")
	
	if Remote then
		Remote.OnClientEvent:Connect(function(event, GetErrorMessage)
			if event == "ErrorMessageChanged" then
				if GetErrorMessage ~= '' then
					if isTenFootInterface then
						currScreenGui.ErrorFrame.Size = UDim2.new(1, 0, 0, 144)
						currScreenGui.ErrorFrame.Position = UDim2.new(0, 0, 0, 0)
						currScreenGui.ErrorFrame.BackgroundColor3 = COLORS.BLACK
						currScreenGui.ErrorFrame.BackgroundTransparency = 0.5
						currScreenGui.ErrorFrame.ErrorText.FontSize = Enum.FontSize.Size36
						currScreenGui.ErrorFrame.ErrorText.Position = UDim2.new(.3, 0, 0, 0)
						currScreenGui.ErrorFrame.ErrorText.Size = UDim2.new(.4, 0, 0, 144)
						if errorImage == nil then
							errorImage = Instance.new("ImageLabel")
							errorImage.Image = "rbxasset://textures/ui/ErrorIconSmall.png"
							errorImage.Size = UDim2.new(0, 96, 0, 79)
							errorImage.Position = UDim2.new(0.228125, 0, 0, 32)
							errorImage.ZIndex = 9
							errorImage.BackgroundTransparency = 1
							errorImage.Parent = currScreenGui.ErrorFrame
						end
						-- we show a B button to kill game data model on console
						if not isTenFootInterface then
							if leaveGameButton == nil then
								local RobloxGui = game.Players.LocalPlayer.PlayerGui.CoreGui:WaitForChild("RobloxGui")
								local utility = require(RobloxGui.Modules.Settings.Utility)
								local textLabel = nil
								leaveGameButton, leaveGameTextLabel = utility:MakeStyledButton("LeaveGame", "Leave", UDim2.new(0, 288, 0, 78))
								--leaveGameButton:SetVerb("Exit")
								leaveGameButton.NextSelectionDown = leaveGameButton
								leaveGameButton.NextSelectionLeft = leaveGameButton
								leaveGameButton.NextSelectionRight = leaveGameButton
								leaveGameButton.NextSelectionUp = leaveGameButton
								leaveGameButton.ZIndex = 9
								leaveGameButton.Position = UDim2.new(0.771875, 0, 0, 37)
								leaveGameButton.Parent = currScreenGui.ErrorFrame
								leaveGameTextLabel.FontSize = Enum.FontSize.Size36
								leaveGameTextLabel.ZIndex = 10
								game:GetService("GuiService").SelectedObject = leaveGameButton
							else
								game:GetService("GuiService").SelectedObject = leaveGameButton
							end
						end
					end
					currScreenGui.ErrorFrame.ErrorText.Text = GetErrorMessage
					currScreenGui.ErrorFrame.Visible = true
					local blackFrame = currScreenGui:FindFirstChild('BlackFrame')
					if blackFrame then
						blackFrame.CloseButton.ImageTransparency = 0
						blackFrame.CloseButton.Active = true
					end
				else
					currScreenGui.ErrorFrame.Visible = false
				end
			end
		end)
	end
	
	--[[guiService.UiMessageChanged:connect(function(type, newMessage)
		if type == Enum.UiMessageType.UiMessageInfo then
			local blackFrame = currScreenGui and currScreenGui:FindFirstChild('BlackFrame')
			if blackFrame then
				blackFrame.UiMessageFrame.UiMessage.Text = newMessage
				if newMessage ~= '' then
					blackFrame.UiMessageFrame.Visible = true
				else
					blackFrame.UiMessageFrame.Visible = false
				end
			end
		end
	end)
	
	if guiService:GetErrorMessage() ~= '' then
		currScreenGui.ErrorFrame.ErrorText.Text = guiService:GetErrorMessage()
		currScreenGui.ErrorFrame.Visible = true
	end]]
	
	
	function stopListeningToRenderingStep()
		if renderSteppedConnection then
			renderSteppedConnection:disconnect()
			renderSteppedConnection = nil
		end
	end
	
	function fadeAndDestroyBlackFrame(blackFrame)
		if destroyingBackground then return end
		destroyingBackground = true
		spawn(function()
			local infoFrame = blackFrame:FindFirstChild("InfoFrame")
			local graphicsFrame = blackFrame:FindFirstChild("GraphicsFrame")
	
			local infoFrameChildren = infoFrame:GetChildren()
			local transparency = 0
			local rateChange = 1.8
			local lastUpdateTime = nil
	
			while transparency < 1 do
				if not lastUpdateTime then
					lastUpdateTime = tick()
				else
					local newTime = tick()
					transparency = transparency + rateChange * (newTime - lastUpdateTime)
					for i = 1, #infoFrameChildren do
						local child = infoFrameChildren[i]
						if child:IsA('TextLabel') then
							child.TextTransparency = transparency
							child.TextStrokeTransparency = transparency
						elseif child:IsA('ImageLabel') then
							child.ImageTransparency = transparency
						end
					end
					graphicsFrame.LoadingImage.ImageTransparency = transparency
					blackFrame.BackgroundTransparency = transparency
	
					if backgroundImageTransparency < 1 then
						backgroundImageTransparency = transparency
						local backgroundImages = blackFrame.BackgroundTextureFrame:GetChildren()
						for i = 1, #backgroundImages do
							backgroundImages[i].ImageTransparency = backgroundImageTransparency
						end
					end
	
					lastUpdateTime = newTime
				end
				wait()
			end
			if blackFrame ~= nil then
				stopListeningToRenderingStep()
				blackFrame:Destroy()
			end
		end)
	end
	
	function destroyLoadingElements(instant)
		if not currScreenGui then return end
		if destroyedLoadingGui then return end
		destroyedLoadingGui = true
	
		local guiChildren = currScreenGui:GetChildren()
		for i=1, #guiChildren do
			-- need to keep this around in case we get a connection error later
			if guiChildren[i].Name ~= "ErrorFrame" then
				if guiChildren[i].Name == "BlackFrame" and not instant then
					fadeAndDestroyBlackFrame(guiChildren[i])
				else
					guiChildren[i]:Destroy()
				end
			end
		end
	end
	
	function handleFinishedReplicating()
		hasReplicatedFirstElements = (#game:GetService("ReplicatedFirst"):GetChildren() > 0)
	
		if not hasReplicatedFirstElements then
			if game:IsLoaded() then
				handleRemoveDefaultLoadingGui()
			else
				local gameLoadedCon = nil
				gameLoadedCon = game:IsLoaded():connect(function()
					gameLoadedCon:disconnect()
					gameLoadedCon = nil
					handleRemoveDefaultLoadingGui()
				end)
			end
		else
			wait(5) -- make sure after 5 seconds we remove the default gui, even if the user doesn't
			handleRemoveDefaultLoadingGui()
		end
	end
	
	function handleRemoveDefaultLoadingGui(instant)
		if isTenFootInterface then
			ContextActionService:UnbindAction('CancelGameLoad')
		end
		destroyLoadingElements(instant)
	end
	
	game.Loaded:connect(handleFinishedReplicating)
	if game:IsLoaded() then
		handleFinishedReplicating()
	end
	
	--game:GetService("ReplicatedFirst").RemoveDefaultLoadingGuiSignal:connect(handleRemoveDefaultLoadingGui)
	--if game:GetService("ReplicatedFirst"):IsDefaultLoadingGuiRemoved() then
	--handleRemoveDefaultLoadingGui()
	--end
	
	local UserInputServiceChangedConn;
	local function onUserInputServiceChanged(prop)
		if prop == 'VREnabled' then
			local UseVr = false
			pcall(function() UseVr = UIS.VREnabled end)
	
			if UseVr then
				if UserInputServiceChangedConn then
					UserInputServiceChangedConn:disconnect()
					UserInputServiceChangedConn = nil
				end
				handleRemoveDefaultLoadingGui(true)
				require(RobloxGui.Modules.LoadingScreen3D)
			end
		end
	end
	
	
	UserInputServiceChangedConn = UIS.Changed:connect(onUserInputServiceChanged)
	onUserInputServiceChanged('VREnabled')
end;
task.spawn(C_2);
-- StarterGui.RobloxGui.Topbar
local function C_3()
local script = G2L["3"];
	--!nocheck
	
	--[[
		// FileName: Topbar.lua
	
		// Written by: SolarCrane
		// Description: Code for lua side Top Menu items in ROBLOX.
	]]
	
	
	--[[ CONSTANTS ]]
	
	local TOPBAR_THICKNESS = 36
	local USERNAME_CONTAINER_WIDTH = 170
	local COLUMN_WIDTH = 75
	local NAME_LEADERBOARD_SEP_WIDTH = 2
	
	local ITEM_SPACING = 0
	local VR_ITEM_SPACING = 3
	
	local FONT_COLOR = Color3.new(1,1,1)
	local TOPBAR_BACKGROUND_COLOR = Color3.new(31/255,31/255,31/255)
	local TOPBAR_OPAQUE_TRANSPARENCY = 0
	local TOPBAR_TRANSLUCENT_TRANSPARENCY = 0.5
	
	local HEALTH_BACKGROUND_COLOR = Color3.new(228/255, 236/255, 246/255)
	local HEALTH_RED_COLOR = Color3.new(255/255, 28/255, 0/255)
	local HEALTH_YELLOW_COLOR = Color3.new(250/255, 235/255, 0)
	local HEALTH_GREEN_COLOR = Color3.new(27/255, 252/255, 107/255)
	
	local HEALTH_PERCANTAGE_FOR_OVERLAY = 5 / 100
	
	local HURT_OVERLAY_IMAGE = "http://www.roblox.com/asset/?id=34854607"
	
	local DEBOUNCE_TIME = 0.25
	
	--[[ END OF CONSTANTS ]]
	
	--[[ FFLAG VALUES ]]
	
	--local defeatableTopbarSuccess, defeatableTopbarFlagValue = pcall(function() return settings():GetFFlag("EnableSetCoreTopbarEnabled") end)
	local defeatableTopbar = false --(defeatableTopbarSuccess and defeatableTopbarFlagValue == true)
	
	--local vr3dGuisSuccess, vr3dGuisFlagValue = pcall(function() return settings():GetFFlag("RenderUserGuiIn3DSpace") end)
	local vr3dGuis = false --(vr3dGuisSuccess and vr3dGuisFlagValue == true)
	
	--[[ END OF FFLAG VALUES ]]
	
	--[[DISABLE SOME COREGUI STUFF (ADDED BY programmerandgamer, ADDED BECAUSE TO DISABLE SOME UNUSED COREGUI STUFF THAT ISNT USED)]]
	local modules = script.Parent:WaitForChild("Modules")
	local StarterGui = game:GetService("StarterGui")
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	
	
	--[[ SERVICES ]]
	
	local PlayersService = game:GetService('Players')
	local Player = PlayersService.LocalPlayer
	while Player == nil do
		PlayersService:GetPropertyChangedSignal("LocalPlayer"):Wait()
		Player = PlayersService.LocalPlayer
	end
	local CoreGuiService = Player:WaitForChild("PlayerGui")
	local GuiService = game:GetService('GuiService')
	local InputService = game:GetService('UserInputService')
	local StarterGui = game:GetService('StarterGui')
	local ContextActionService = game:GetService("ContextActionService")
	local RunService = game:GetService('RunService')
	local TextService = game:GetService('TextService')
	local TextChatService = game:GetService('TextChatService')
	
	--[[ END OF SERVICES ]]
	
	
	local topbarEnabled = true
	local topbarEnabledChangedEvent = Instance.new('BindableEvent')
	
	local settingsActive = false
	
	--local GameSettings = UserSettings().GameSettings
	
	local GuiRoot = CoreGuiService:WaitForChild('RobloxGui')
	local Modules = GuiRoot:WaitForChild('Modules')
	
	local VREnabled = InputService.VREnabled
	
	local function SafeRequire(moduleScript, label)
		if not moduleScript then
			warn("[Topbar] Missing module:", label)
			return nil
		end
	
		local ok, result = pcall(require, moduleScript)
		if not ok then
			warn("[Topbar] Failed to require " .. tostring(label) .. ":", result)
			return nil
		end
	
		return result
	end
	
	local TenFootInterface = nil
	local isTenFootInterface = false
	do
		local flag = game:GetService("Lighting"):FindFirstChild("TenFootInterface")
		if flag and flag:IsA("BoolValue") then
			isTenFootInterface = flag.Value
		end
	end
	
	local PlayerlistModule = nil
	local PlayerlistLoading = false
	local SettingsHub = nil
	local ChatModule = nil
	local BackpackModule = nil
	
	local LegacyCompatReady = false
	local LegacyGlobalSettings = nil
	local LegacyUserSettings = nil
	
	
	local function EnsureSettingsHubRuntimeObjects()
		-- SettingsHub dereferences game.Lighting.TenFootInterface.Value during require().
		-- In the old CoreScript environment this BoolValue existed already.
		local lighting = game:GetService("Lighting")
	
		local tenFootFlag = lighting:FindFirstChild("TenFootInterface")
		if not tenFootFlag then
			tenFootFlag = Instance.new("BoolValue")
			tenFootFlag.Name = "TenFootInterface"
			tenFootFlag.Value = false
			tenFootFlag.Parent = lighting
		elseif tenFootFlag:IsA("BoolValue") == false then
			warn("[Topbar] Lighting.TenFootInterface exists but is not a BoolValue")
		end
	
		-- Do NOT create Lighting.MacClient when absent. SettingsHub only tests
		-- whether that object exists; creating a false BoolValue would still be truthy.
		-- If one already exists, leave the prototype's value/object untouched.
	
		-- SettingsHub waits for ControlFrame during require().
		local controlFrame = GuiRoot:FindFirstChild("ControlFrame")
		if not controlFrame then
			controlFrame = Instance.new("Frame")
			controlFrame.Name = "ControlFrame"
			controlFrame.BackgroundTransparency = 1
			controlFrame.Size = UDim2.fromOffset(0, 0)
			controlFrame.Visible = false
			controlFrame.Parent = GuiRoot
		end
	
		if not controlFrame:FindFirstChild("ToggleDevConsole") then
			local toggle = Instance.new("BindableFunction")
			toggle.Name = "ToggleDevConsole"
			toggle.OnInvoke = function()
				return nil
			end
			toggle.Parent = controlFrame
		end
	
		-- GameSettings.lua creates a Sound inside _G.CoreGui.RobloxGui.Sounds.
		-- Ensure the Sounds folder exists so that path does not yield or error.
		if not GuiRoot:FindFirstChild("Sounds") then
			local soundsFolder = Instance.new("Folder")
			soundsFolder.Name = "Sounds"
			soundsFolder.Parent = GuiRoot
		end
	
		return true
	end
	
	local function PrepareLegacyCoreCompat()
		EnsureSettingsHubRuntimeObjects()
	
		if LegacyCompatReady then
			return
		end
		LegacyCompatReady = true
	
		-- The prototype modules were CoreScripts and call _G:GetService().
		LegacyGlobalSettings = {
			GetFFlag = function(self, flagName)
				-- Keep risky/removed feature flags off unless the old module can
				-- safely support them in a normal LocalScript.
				local enabledFlags = {
					UseInGameTopBar = true,
				}
				return enabledFlags[flagName] == true
			end,
			GetFVariable = function(self, variableName)
				return ""
			end,
			GetMaxQualityLevel = function(self)
				return 21
			end,
			EnableFRM = false,
			QualityLevel = Enum.QualityLevel.Automatic,
		}
	
		do
			local ok, realSettings = pcall(function()
				return UserSettings():GetService("UserGameSettings")
			end)
	
			-- Default values used when the real UserGameSettings property is
			-- inaccessible (e.g. MasterVolume requires RobloxScript capability).
			local defaults = {
				SavedQualityLevel = Enum.SavedQualitySetting.Automatic,
				ControlMode = Enum.ControlMode.Classic,
				TouchCameraMovementMode = Enum.TouchCameraMovementMode.Default,
				ComputerCameraMovementMode = Enum.ComputerCameraMovementMode.Default,
				TouchMovementMode = Enum.TouchMovementMode.Default,
				ComputerMovementMode = Enum.ComputerMovementMode.Default,
				MasterVolume = 1,
				MouseSensitivity = 1,
			}
	
			if ok and realSettings then
				-- Wrap the real UserGameSettings in a safe proxy because some
				-- properties (e.g. MasterVolume) require CoreScript/RobloxScript
				-- capabilities that a normal LocalScript does not have.
				LegacyUserSettings = setmetatable({
					RequestUpdate = function()
						pcall(function() realSettings:RequestUpdate() end)
					end,
					InFullScreen = function()
						local ok2, result = pcall(function()
							return realSettings:InFullScreen()
						end)
						if ok2 then return result end
						return false
					end,
				}, {
					__index = function(_, key)
						local ok2, result = pcall(function()
							return realSettings[key]
						end)
						if ok2 and result ~= nil then
							return result
						end
						return defaults[key]
					end,
					__newindex = function(_, key, value)
						pcall(function()
							realSettings[key] = value
						end)
						defaults[key] = value
					end,
				})
			else
				LegacyUserSettings = {
					SavedQualityLevel = Enum.SavedQualitySetting.Automatic,
					ControlMode = Enum.ControlMode.Classic,
					TouchCameraMovementMode = Enum.TouchCameraMovementMode.Default,
					ComputerCameraMovementMode = Enum.ComputerCameraMovementMode.Default,
					TouchMovementMode = Enum.TouchMovementMode.Default,
					ComputerMovementMode = Enum.ComputerMovementMode.Default,
					MasterVolume = 1,
					MouseSensitivity = 1,
					RequestUpdate = function() end,
					InFullScreen = function() return false end,
				}
			end
		end
	
		local previousGetService = rawget(_G, "GetService")
		-- Some legacy modules access _G.CoreGui directly instead of _G:GetService("CoreGui").
		_G.CoreGui = CoreGuiService
	
		_G.GetService = function(self, serviceName)
			if serviceName == "CoreGui" then
				-- Port CoreGui.RobloxGui -> LocalPlayer.PlayerGui.RobloxGui.
				return CoreGuiService
			elseif serviceName == "GuiService" then
				return GuiService
			elseif serviceName == "StarterGui" then
				return StarterGui
			elseif serviceName == "GlobalSettings" then
				return LegacyGlobalSettings
			elseif serviceName == "UserSettings" then
				return LegacyUserSettings
			end
	
			if type(previousGetService) == "function" then
				local ok, result = pcall(previousGetService, self, serviceName)
				if ok and result ~= nil then
					return result
				end
			end
	
			local ok, result = pcall(function()
				return game:GetService(serviceName)
			end)
			return ok and result or nil
		end
	
		-- PlayerlistModule calls _G:LoadLibrary("RbxGui"), but this prototype
		-- only stores the result and never uses it. Return an empty compatibility table.
		local previousLoadLibrary = rawget(_G, "LoadLibrary")
		-- Players page calls _G:GetTrueName(player) to obtain display names.
		_G.GetTrueName = function(self, player)
			if type(player) == "table" or typeof(player) == "Instance" then
				local ok, name = pcall(function()
					return player.DisplayName or player.Name
				end)
				if ok and name then
					return name
				end
			end
			return tostring(player)
		end
	
		_G.LoadLibrary = function(self, libraryName)
			if libraryName == "RbxGui" then
				return {}
			end
			if type(previousLoadLibrary) == "function" then
				local ok, result = pcall(previousLoadLibrary, self, libraryName)
				if ok then return result end
			end
			return {}
		end
	
		-- In the prototype, DeveloperConsole creates this before SettingsHub is used.
		-- The standalone port does not have that CoreScript, so create the API object.
		local controlFrame = GuiRoot:FindFirstChild("ControlFrame")
		if not controlFrame then
			controlFrame = Instance.new("Frame")
			controlFrame.Name = "ControlFrame"
			controlFrame.BackgroundTransparency = 1
			controlFrame.Size = UDim2.fromOffset(0, 0)
			controlFrame.Visible = false
			controlFrame.Parent = GuiRoot
		end
	
		local toggleDevConsole = controlFrame:FindFirstChild("ToggleDevConsole")
		if not toggleDevConsole then
			toggleDevConsole = Instance.new("BindableFunction")
			toggleDevConsole.Name = "ToggleDevConsole"
			toggleDevConsole.OnInvoke = function()
				-- F9 remains handled by modern Roblox/Studio. This satisfies the
				-- exact 2016 SettingsHub API expected by the prototype.
				return nil
			end
			toggleDevConsole.Parent = controlFrame
		end
	end
	
	local CompleteTenFootAPI
	
	local function LoadTenFootInterface()
		if TenFootInterface then
			return TenFootInterface
		end
	
		PrepareLegacyCoreCompat()
		TenFootInterface = CompleteTenFootAPI(SafeRequire(
			Modules:FindFirstChild("TenFootInterface"),
			"TenFootInterface"
			))
	
		if TenFootInterface and type(TenFootInterface.IsEnabled) == "function" then
			local ok, enabled = pcall(function()
				return TenFootInterface:IsEnabled()
			end)
			if ok then
				isTenFootInterface = enabled == true
			end
		end
	
		return TenFootInterface
	end
	
	
	local function CompletePlayerlistAPI(module)
		if type(module) ~= "table" then return module end
	
		if type(module.GetVisibility) ~= "function" then
			function module:GetVisibility()
				if type(self.IsOpen) == "function" then
					local ok, value = pcall(self.IsOpen)
					return ok and value == true or false
				end
				return false
			end
		end
	
		if type(module.SetVisible) ~= "function" then
			function module:SetVisible(visible)
				local current = false
				if type(self.IsOpen) == "function" then
					local ok, value = pcall(self.IsOpen)
					current = ok and value == true or false
				end
				if current ~= (visible == true) and type(self.ToggleVisibility) == "function" then
					self.ToggleVisibility()
				end
			end
		end
	
		if type(module.Show) ~= "function" then
			function module:Show()
				self:SetVisible(true)
			end
		end
	
		if type(module.Hide) ~= "function" then
			function module:Hide()
				self:SetVisible(false)
			end
		end
	
		return module
	end
	
	local function CompleteChatAPI(module)
		if type(module) ~= "table" then return module end
	
		local focused = false
	
		-- Original Topbar.lua calls these two, but this exact prototype's Chat
		-- public module table does not export them.
		if type(module.SetVisible) ~= "function" then
			function module:SetVisible(visible)
				local current = false
				if type(self.GetVisibility) == "function" then
					local ok, value = pcall(function()
						return self:GetVisibility()
					end)
					current = ok and value == true or false
				end
	
				if current ~= (visible == true) and type(self.ToggleVisibility) == "function" then
					self:ToggleVisibility()
				end
			end
		end
	
		if module.ChatBarFocusChanged then
			local signal = module.ChatBarFocusChanged
			pcall(function()
				if type(signal.connect) == "function" then
					signal:connect(function(value)
						focused = value == true
					end)
				elseif type(signal.Connect) == "function" then
					signal:Connect(function(value)
						focused = value == true
					end)
				elseif typeof(signal) == "RBXScriptSignal" then
					signal:Connect(function(value)
						focused = value == true
					end)
				end
			end)
		end
	
		if type(module.IsFocused) ~= "function" then
			function module:IsFocused()
				return focused
			end
		end
	
		if type(module.Show) ~= "function" then
			function module:Show()
				self:SetVisible(true)
			end
		end
	
		if type(module.Hide) ~= "function" then
			function module:Hide()
				self:SetVisible(false)
			end
		end
	
		return module
	end
	
	local function CompleteBackpackAPI(module)
		if type(module) ~= "table" then return module end
	
		if type(module.GetVisibility) ~= "function" then
			function module:GetVisibility()
				return self.IsOpen == true
			end
		end
	
		if type(module.SetVisible) ~= "function" then
			function module:SetVisible(visible)
				local current = self.IsOpen == true
				if current ~= (visible == true) and type(self.OpenClose) == "function" then
					self:OpenClose()
				end
			end
		end
	
		if type(module.ToggleVisibility) ~= "function" then
			function module:ToggleVisibility()
				if type(self.OpenClose) == "function" then
					self:OpenClose()
				end
			end
		end
	
		if type(module.Show) ~= "function" then
			function module:Show()
				self:SetVisible(true)
			end
		end
	
		if type(module.Hide) ~= "function" then
			function module:Hide()
				self:SetVisible(false)
			end
		end
	
		return module
	end
	
	CompleteTenFootAPI = function(module)
		if type(module) ~= "table" then return module end
	
		if type(module.GetEnabled) ~= "function" then
			function module:GetEnabled()
				if type(self.IsEnabled) == "function" then
					local ok, value = pcall(function()
						return self:IsEnabled()
					end)
					return ok and value == true or false
				end
				return false
			end
		end
	
		return module
	end
	
	local function CompleteSettingsHubAPI(hub)
		if type(hub) ~= "table" then return hub end
	
		local function instance()
			return hub.Instance
		end
	
		-- Forward EVERY callable SettingsHub.Instance API found in the prototype.
		local forwards = {
			"AddPage",
			"RemovePage",
			"HideBar",
			"ShowBar",
			"ScrollPixels",
			"ScrollToFrame",
			"SwitchToPage",
			"SetActive",
			"SetVisibility",
			"ToggleVisibility",
			"AddToMenuStack",
			"PopMenu",
			"ShowShield",
			"HideShield",
		}
	
		for _, methodName in ipairs(forwards) do
			if type(hub[methodName]) ~= "function" then
				hub[methodName] = function(self, ...)
					local inst = instance()
					if inst and type(inst[methodName]) == "function" then
						return inst[methodName](inst, ...)
					end
				end
			end
		end
	
		-- Dynamic state/event accessors for fields that live on Instance.
	
		-- Aliases for old code paths/pages that use inconsistent field names.
		if hub.Instance then
			if hub.Instance.PlayersPage and not hub.Instance.PlayerPage then
				hub.Instance.PlayerPage = hub.Instance.PlayersPage
			end
		end
	
		if type(hub.GetInstance) ~= "function" then
			function hub:GetInstance()
				return instance()
			end
		end
	
		if type(hub.GetPages) ~= "function" then
			function hub:GetPages()
				local inst = instance()
				return inst and inst.Pages or nil
			end
		end
	
		if type(hub.GetCurrentPage) ~= "function" then
			function hub:GetCurrentPage()
				local inst = instance()
				return inst and inst.Pages and inst.Pages.CurrentPage or nil
			end
		end
	
		if type(hub.GetMenuStack) ~= "function" then
			function hub:GetMenuStack()
				local inst = instance()
				return inst and inst.MenuStack or nil
			end
		end
	
		if type(hub.GetTabHeaders) ~= "function" then
			function hub:GetTabHeaders()
				local inst = instance()
				return inst and inst.TabHeaders or nil
			end
		end
	
		if type(hub.GetBottomBarButtons) ~= "function" then
			function hub:GetBottomBarButtons()
				local inst = instance()
				return inst and inst.BottomBarButtons or nil
			end
		end
	
		if type(hub.GetPoppedMenuSignal) ~= "function" then
			function hub:GetPoppedMenuSignal()
				local inst = instance()
				return inst and inst.PoppedMenu or nil
			end
		end
	
		if type(hub.GetPage) ~= "function" then
			function hub:GetPage(name)
				local inst = instance()
				if not inst or type(name) ~= "string" then return nil end
	
				local aliases = {
					LeaveGame = "LeaveGamePage",
					ResetCharacter = "ResetCharacterPage",
					Home = "HomePage",
					GameSettings = "GameSettingsPage",
					ReportAbuse = "ReportAbusePage",
					ReportAbuseMenu = "ReportAbusePage",
					Help = "HelpPage",
					Record = "RecordPage",
					Players = "PlayersPage",
				}
				return inst[aliases[name] or name]
			end
		end
	
		if type(hub.GetGuiObject) ~= "function" then
			function hub:GetGuiObject(name)
				local inst = instance()
				if not inst then return nil end
				return inst[name]
			end
		end
	
		return hub
	end
	
	local SettingsUtility = nil
	local SettingsPageFactory = nil
	local SettingsPageModules = {}
	
	local function LoadSettingsUtility()
		if SettingsUtility then return SettingsUtility end
		local settingsFolder = Modules:FindFirstChild("Settings")
		if not settingsFolder then return nil end
		SettingsUtility = SafeRequire(settingsFolder:FindFirstChild("Utility"), "Settings.Utility")
		return SettingsUtility
	end
	
	local function LoadSettingsPageFactory()
		if SettingsPageFactory then return SettingsPageFactory end
		local settingsFolder = Modules:FindFirstChild("Settings")
		if not settingsFolder then return nil end
		SettingsPageFactory = SafeRequire(settingsFolder:FindFirstChild("SettingsPageFactory"), "Settings.SettingsPageFactory")
		return SettingsPageFactory
	end
	
	local function LoadSettingsPageModule(pageName)
		if SettingsPageModules[pageName] then
			return SettingsPageModules[pageName]
		end
	
		local settingsFolder = Modules:FindFirstChild("Settings")
		local pages = settingsFolder and settingsFolder:FindFirstChild("Pages")
		local moduleScript = pages and pages:FindFirstChild(pageName)
		if not moduleScript then
			warn("[Topbar] Missing Settings page module:", pageName)
			return nil
		end
	
		local result = SafeRequire(moduleScript, "Settings.Pages." .. tostring(pageName))
		SettingsPageModules[pageName] = result
		return result
	end
	
	local function LoadPlayerlistModule()
		PrepareLegacyCoreCompat()
		LoadTenFootInterface()
	
		if PlayerlistModule then
			return PlayerlistModule
		end
		if PlayerlistLoading then
			return nil
		end
	
		PlayerlistLoading = true
	
		-- The 2016 Playerlist reads this state during initialization.
		pcall(function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end)
	
		local moduleScript = Modules:FindFirstChild("PlayerlistModule")
			or Modules:WaitForChild("PlayerlistModule", 10)
	
		PlayerlistModule = CompletePlayerlistAPI(SafeRequire(moduleScript, "PlayerlistModule"))
		PlayerlistLoading = false
		return PlayerlistModule
	end
	
	local function TogglePlayerlist()
		-- Load/use the real 2016 Playerlist module first. On mobile a
		-- PlayerListToggle BindableEvent may already exist before anything is
		-- connected to it, which made the old code fire a no-op and return.
		local module = PlayerlistModule or LoadPlayerlistModule()
		if module and type(module.ToggleVisibility) == "function" then
			local ok, err = pcall(function()
				module.ToggleVisibility()
			end)
			if ok then
				return true
			end
			warn("[Topbar] PlayerlistModule.ToggleVisibility failed:", err)
		end
	
		-- Keep the bridge as a fallback for builds that implement playerlist
		-- toggling through RobloxGui.PlayerListToggle.
		local bridge = GuiRoot:FindFirstChild("PlayerListToggle")
		if bridge and bridge:IsA("BindableEvent") then
			bridge:Fire()
			return true
		end
	
		warn("[Topbar] PlayerlistModule is unavailable")
		return false
	end
	
	
	local function PreflightSettingsHubDependencies()
		PrepareLegacyCoreCompat()
	
		local settingsFolder = Modules:FindFirstChild("Settings")
		if not settingsFolder then
			return false, "Modules.Settings is missing"
		end
	
		local pagesFolder = settingsFolder:FindFirstChild("Pages")
		if not pagesFolder then
			return false, "Modules.Settings.Pages is missing"
		end
	
		local checks = {
			{Modules:FindFirstChild("TenFootInterface"), "TenFootInterface"},
			{Modules:FindFirstChild("Chat"), "Chat"},
			{Modules:FindFirstChild("PlayerlistModule"), "PlayerlistModule"},
			{Modules:FindFirstChild("BackpackScript"), "BackpackScript"},
			{settingsFolder:FindFirstChild("Utility"), "Settings.Utility"},
			{settingsFolder:FindFirstChild("SettingsPageFactory"), "Settings.SettingsPageFactory"},
			{pagesFolder:FindFirstChild("LeaveGame"), "Settings.Pages.LeaveGame"},
			{pagesFolder:FindFirstChild("ResetCharacter"), "Settings.Pages.ResetCharacter"},
			{pagesFolder:FindFirstChild("GameSettings"), "Settings.Pages.GameSettings"},
			{pagesFolder:FindFirstChild("ReportAbuseMenu"), "Settings.Pages.ReportAbuseMenu"},
			{pagesFolder:FindFirstChild("Help"), "Settings.Pages.Help"},
			{pagesFolder:FindFirstChild("Record"), "Settings.Pages.Record"},
			{pagesFolder:FindFirstChild("Players"), "Settings.Pages.Players"},
		}
	
		for _, pair in ipairs(checks) do
			local moduleScript, label = pair[1], pair[2]
	
			-- Some pages are platform-conditional, but preflighting them is useful
			-- because SettingsHub may require them on Windows.
			if moduleScript then
				local ok, result = pcall(require, moduleScript)
				if not ok then
					warn("[Topbar][SettingsHub preflight] " .. label .. " failed:", result)
					return false, label .. ": " .. tostring(result)
				end
	
				if label == "Chat" then
					CompleteChatAPI(result)
				elseif label == "PlayerlistModule" then
					PlayerlistModule = CompletePlayerlistAPI(result)
				elseif label == "BackpackScript" then
					BackpackModule = CompleteBackpackAPI(result)
				elseif label == "TenFootInterface" then
					TenFootInterface = CompleteTenFootAPI(result)
				elseif label == "Settings.Utility" then
					SettingsUtility = result
				elseif label == "Settings.SettingsPageFactory" then
					SettingsPageFactory = result
				end
			elseif label ~= "Settings.Pages.Home" then
				warn("[Topbar][SettingsHub preflight] Missing:", label)
			end
		end
	
		return true
	end
	
	local function LoadSettingsHub()
		PrepareLegacyCoreCompat()
		LoadTenFootInterface()
	
		if SettingsHub then
			return SettingsHub
		end
	
		local okPreflight, preflightError = PreflightSettingsHubDependencies()
		if not okPreflight then
			warn("[Topbar] SettingsHub dependency preflight failed:", preflightError)
			return nil
		end
	
		local settingsFolder = Modules:FindFirstChild("Settings")
			or Modules:WaitForChild("Settings", 10)
		if not settingsFolder then
			warn("[Topbar] Modules.Settings is missing")
			return nil
		end
	
		local moduleScript = settingsFolder:FindFirstChild("SettingsHub")
			or settingsFolder:WaitForChild("SettingsHub", 10)
		local hub = nil
		do
			local ok, result = pcall(require, moduleScript)
			if not ok then
				warn("[Topbar] SettingsHub itself failed after dependency preflight:", result)
				return nil
			end
			hub = CompleteSettingsHubAPI(result)
		end
		if type(hub) ~= "table" then
			return nil
		end
	
		-- Exact API exposed by settings2016.rbxm.
		for _, methodName in ipairs({
			"SetVisibility",
			"ToggleVisibility",
			"SwitchToPage",
			"GetVisibility",
			"ShowShield",
			"HideShield",
			"ReportPlayer",
			}) do
			if type(hub[methodName]) ~= "function" then
				warn("[Topbar] SettingsHub missing API:", methodName)
				return nil
			end
		end
	
		if hub.SettingsShowSignal == nil then
			warn("[Topbar] SettingsHub missing SettingsShowSignal")
			return nil
		end
	
		if type(hub.Instance) ~= "table" then
			warn("[Topbar] SettingsHub missing Instance API")
			return nil
		end
	
		for _, methodName in ipairs({
			"AddPage",
			"RemovePage",
			"HideBar",
			"ShowBar",
			"ScrollPixels",
			"ScrollToFrame",
			"SwitchToPage",
			"SetActive",
			"SetVisibility",
			"ToggleVisibility",
			"AddToMenuStack",
			"PopMenu",
			"ShowShield",
			"HideShield",
			}) do
			if type(hub.Instance[methodName]) ~= "function" then
				warn("[Topbar] SettingsHub.Instance missing API:", methodName)
				return nil
			end
		end
	
		SettingsHub = hub
		return SettingsHub
	end
	
	local Panel3D = nil
	local Topbar3DPanel = nil
	
	local Util = {}
	do
		-- Check if we are running on a touch device
		function Util.IsTouchDevice()
			return InputService.TouchEnabled
		end
	
		-- Modern mobile compatibility.
		-- The old 2016 topbar assumed a much wider desktop viewport.
		function Util.GetViewportSize()
			local camera = workspace.CurrentCamera
			if camera then
				return camera.ViewportSize
			end
	
			local ok, resolution = pcall(function()
				return GuiService:GetScreenResolution()
			end)
			if ok and resolution then
				return resolution
			end
	
			return Vector2.new(1280, 720)
		end
	
		function Util.IsCompactTouchDevice()
			if not InputService.TouchEnabled then
				return false
			end
	
			local viewport = Util.GetViewportSize()
			return viewport.X < 900 or viewport.Y < 600
		end
	
		function Util.IsVerySmallTouchDevice()
			if not InputService.TouchEnabled then
				return false
			end
	
			local viewport = Util.GetViewportSize()
			return viewport.X < 520
		end
	
		function Util.Create(instanceType)
			return function(data)
				local obj = Instance.new(instanceType)
				for k, v in pairs(data) do
					if type(k) == 'number' then
						v.Parent = obj
					else
						obj[k] = v
					end
				end
				return obj
			end
		end
	
		function Util.Clamp(low, high, input)
			return math.max(low, math.min(high, input))
		end
	
		function Util.DisconnectEvent(conn)
			if conn then
				conn:disconnect()
			end
			return nil
		end
	
		function Util.SetGUIInsetBounds(x1, y1, x2, y2)
			--GuiService:SetGlobalGuiInset(x1, y1, x2, y2)
			if GuiRoot:FindFirstChild("GuiInsetChanged") then
				GuiRoot.GuiInsetChanged:Fire(x1, y1, x2, y2)
			end
		end
	
		local humanoidCache = {}
		function Util.FindPlayerHumanoid(player)
			local character = player and player.Character
			if character then
				local resultHumanoid = humanoidCache[player]
				if resultHumanoid and resultHumanoid.Parent == character then
					return resultHumanoid
				else
					humanoidCache[player] = nil -- Bust Old Cache
					for _, child in pairs(character:GetChildren()) do
						if child:IsA('Humanoid') then
							humanoidCache[player] = child
							return child
						end
					end
				end
			end
		end
	end
	
	local selectionRing = Util.Create "ImageLabel" {
		Name = "SelectionRing",
		Position = UDim2.new(0.5, -23, 0.5, -23),
		Size = UDim2.new(0, 46, 0, 46),
		BackgroundTransparency = 1,
		Image = "rbxasset://textures/ui/menu/buttonHover.png"
	}
	
	local function CreateTopBar()
		local this = {}
	
		local playerGuiChangedConn = nil
	
		local topbarContainer = Util.Create'Frame'{
			Name = "TopBarContainer";
			Size = UDim2.new(1, 0, 0, TOPBAR_THICKNESS);
			Position = UDim2.new(0, 0, 0, 0);
			BackgroundTransparency = TOPBAR_OPAQUE_TRANSPARENCY;
			BackgroundColor3 = TOPBAR_BACKGROUND_COLOR;
			BorderSizePixel = 0;
			Active = true;
			ZIndex = 10;
			Parent = GuiRoot;
		};
	
		local topbarShadow = Util.Create'ImageLabel'{
			Name = "TopBarShadow";
			Size = UDim2.new(1, 0, 0, 3);
			Position = UDim2.new(0, 0, 1, 0);
			Image = "rbxasset://textures/ui/TopBar/dropshadow.png";
			BackgroundTransparency = 1;
			Active = false;
			Visible = false;
			Parent = topbarContainer;
		};
	
		local function ComputeTransparency()
			if not topbarEnabled then
				return 1
			end
	
			local playerGui = Player:FindFirstChild('PlayerGui')
			if playerGui then
				local ok, transparency = pcall(function()
					return playerGui:GetTopbarTransparency()
				end)
				if ok and type(transparency) == "number" then
					return transparency
				end
			end
	
			return TOPBAR_TRANSLUCENT_TRANSPARENCY
		end
	
		function this:UpdateBackgroundTransparency()
			if settingsActive and not VREnabled then
				topbarContainer.BackgroundTransparency = TOPBAR_OPAQUE_TRANSPARENCY
				topbarShadow.Visible = false
			else
				topbarContainer.BackgroundTransparency = ComputeTransparency()
				topbarShadow.Visible = (topbarContainer.BackgroundTransparency == 0)
			end
		end
	
		function this:GetInstance()
			return topbarContainer
		end
	
		spawn(function()
			local playerGui = Player:WaitForChild('PlayerGui')
			playerGuiChangedConn = Util.DisconnectEvent(playerGuiChangedConn)
			pcall(function()
				playerGuiChangedConn = playerGui.TopbarTransparencyChangedSignal:connect(this.UpdateBackgroundTransparency)
			end)
			this:UpdateBackgroundTransparency()
		end)
	
		return this
	end
	
	
	local BarAlignmentEnum =
		{
			Right = 0;
			Left = 1;
			Middle = 2;
		}
	
	local function CreateMenuBar(barAlignment)
		local this = {}
		local thickness = TOPBAR_THICKNESS
		local alignment = barAlignment or BarAlignmentEnum.Right
		local items = {}
		local propertyChangedConnections = {}
		local dock = nil
	
		function this:ArrangeItems()
			local totalWidth = 0
	
			local spacing = ITEM_SPACING
			if InputService.VREnabled then
				spacing = VR_ITEM_SPACING
			end
	
			for i, item in ipairs(items) do
				local width = item:GetWidth()
	
				if alignment == BarAlignmentEnum.Left then
					item.Position = UDim2.new(0, totalWidth, 0, 0)
				elseif alignment == BarAlignmentEnum.Right then
					item.Position = UDim2.new(1, -totalWidth - width, 0, 0)
				end
	
				if i ~= #items then
					width = width + spacing
				end
	
				totalWidth = totalWidth + width
			end
	
			if alignment == BarAlignmentEnum.Middle then
				local currentX = -totalWidth / 2
				for _, item in ipairs(items) do
					item.Position = UDim2.new(0, currentX, 0, 0)
	
					currentX = currentX + item:GetWidth() + spacing
				end
			end
	
			return totalWidth
		end
	
		function this:GetThickness()
			return thickness
		end
	
		function this:GetNumberOfItems()
			return #items
		end
	
		function this:SetDock(newDock)
			dock = newDock
			for _, item in pairs(items) do
				item.Parent = dock
			end
		end
	
		function this:IndexOfItem(searchItem)
			for index, item in pairs(items) do
				if item == searchItem then
					return index
				end
			end
			return nil
		end
	
		function this:ItemAtIndex(index)
			return items[index]
		end
	
		function this:GetItems()
			return items
		end
	
		function this:AddItem(item, index)
			local numItems = self:GetNumberOfItems()
			index = Util.Clamp(1, numItems + 1, (index or numItems + 1))
	
			local alreadyFoundIndex = self:IndexOfItem(item)
			if alreadyFoundIndex then
				return item, index
			end
	
			table.insert(items, index, item)
			Util.DisconnectEvent(propertyChangedConnections[item])
			propertyChangedConnections[item] = item.Changed:connect(function(property)
				if property == 'AbsoluteSize' then
					self:ArrangeItems()
				end
			end)
			self:ArrangeItems()
	
			if dock then
				item.Parent = dock
			end
	
			return item, index
		end
	
		function this:RemoveItem(item)
			local index = self:IndexOfItem(item)
			if index then
				local removedItem = table.remove(items, index)
	
				removedItem.Parent = nil
				Util.DisconnectEvent(propertyChangedConnections[removedItem])
	
				self:ArrangeItems()
				return removedItem, index
			end
		end
	
	
		return this
	end
	
	local function Create3DMenuBar(barAlignment, threeDPanel)
		local this = CreateMenuBar(barAlignment)
	
		local superArrangeItems = this.ArrangeItems
		function this:ArrangeItems()
			local totalWidth = superArrangeItems(self)
			if threeDPanel then
				threeDPanel:ResizePixels(totalWidth, 120)
			end
			for _, v in pairs(this:GetItems()) do
				v:UpdateHoverText()
			end
			return totalWidth
		end
	
		function this:CloseAllExcept(item)
			for _, v in pairs(this:GetItems()) do
				if v ~= item then
					v:SetActive(false)
				end
			end
		end
	
		return this
	end
	
	
	local function CreateMenuItem(origInstance)
		local this = {}
		local instance = origInstance
	
		function this:SetInstance(newInstance)
			if not instance then
				instance = newInstance
			else
				print("Trying to set an Instance of a Menu Item that already has an instance; doing nothing.")
			end
		end
	
		function this:GetWidth()
			return self.Size.X.Offset
		end
	
		-- We are extending a regular instance.
		do
			local mt =
				{
					__index = function (t, k)
						return instance[k]
					end;
	
					__newindex = function (t, k, v)
						--if instance[k] ~= nil then
						instance[k] = v
						--else
						--	rawset(t, k, v)
						--end
					end;
				}
			setmetatable(this, mt)
		end
	
		return this
	end
	
	local function Create3DMenuItem()
		local menuItem = {}
	
		local backgroundButton = Util.Create 'ImageButton' {
			Name = "ButtonBackground",
			Size = UDim2.new(0, 52, 0, 52),
	
			BackgroundTransparency = 1,
			SelectionImageObject = selectionRing:Clone(),
	
			ClipsDescendants = false
		}
	
		local isActive = false
	
		function menuItem:SetActive(active)
			isActive = active
			if active then
				backgroundButton.Image = "rbxasset://textures/ui/menu/buttonActive.png"
			else
				backgroundButton.Image = "rbxasset://textures/ui/menu/buttonBackground.png"
			end
			backgroundButton.SelectionImageObject.Visible = not active
		end
	
		function menuItem:GetWidth()
			return backgroundButton.AbsoluteSize.X
		end
	
		function menuItem:GetInstance()
			return backgroundButton
		end
	
		local function setTransparency(parent, transparency)
			if parent:IsA("ImageLabel") or parent:IsA("ImageButton") then
				parent.ImageTransparency = transparency
			elseif parent:IsA("TextLabel") or parent:IsA("TextButton") then
				parent.TextTransparency = transparency
			end
			for _, v in pairs(parent:GetChildren()) do
				if v:IsA("GuiObject") then
					setTransparency(v, transparency)
				end
			end
		end
		function menuItem:SetTransparency(transparency)
			setTransparency(backgroundButton, transparency)
		end
	
		menuItem:SetActive(false)
	
		local hoverTextFrame = Util.Create 'Frame' {
			Name = "ButtonHoverText",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
	
			Position = UDim2.new(0.5, -45, 0, 55),
			Size = UDim2.new(0, 90, 0, 60),
	
			Visible = false,
			Parent = backgroundButton
		}
		local hoverMid = Util.Create 'ImageLabel' {
			Name = "HoverMid",
			BackgroundTransparency = 1,
	
			Image = "rbxasset://textures/ui/Menu/hoverPopupMid.png",
	
			Position = UDim2.new(0.5, -12, 0, 0),
			Size = UDim2.new(0, 24, 1, 0),
			Parent = hoverTextFrame
		}
		local hoverLeft = Util.Create 'ImageLabel' {
			Name = "HoverLeft",
			BackgroundTransparency = 1,
	
			Image = "rbxasset://textures/ui/Menu/hoverPopupLeft.png",
	
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0.5, -12, 1, 0),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(1, 1, 33, 59),
			Parent = hoverTextFrame
		}
		local hoverRight = Util.Create 'ImageLabel' {
			Name = "HoverRight",
			BackgroundTransparency = 1,
	
			Image = "rbxasset://textures/ui/Menu/hoverPopupRight.png",
	
			Position = UDim2.new(0.5, 12, 0, 0),
			Size = UDim2.new(0.5, -12, 1, 0),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(0, 1, 32, 59),
			Parent = hoverTextFrame
		}
	
		local hoverTextLabel = Util.Create 'TextLabel' {
			Name = "ButtonHoverTextLabel",
			BackgroundTransparency = 1,
	
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size24,
			Text = "",
			TextColor3 = Color3.new(1, 1, 1),
	
			Position = UDim2.new(0, 0, 0, 8),
			Size = UDim2.new(1, 0, 1, -5),
	
			Parent = hoverTextFrame
		}
	
		function menuItem:SetHoverText(text)
			hoverTextLabel.Text = text
			local textSize = TextService:GetTextSize(
				hoverTextLabel.Text,
				24,
				hoverTextLabel.Font,
				Vector2.new(1000, 10000))
			local frameWidth = textSize.x + 20
			hoverTextFrame.Position = UDim2.new(0.5, -frameWidth / 2, 0, 55)
			hoverTextFrame.Size = UDim2.new(0, frameWidth, 0, 60)
		end
	
		backgroundButton.SelectionGained:connect(function()
			hoverTextFrame.Visible = true
		end)
		backgroundButton.SelectionLost:connect(function()
			hoverTextFrame.Visible = false
		end)
	
		function menuItem:UpdateHoverText()
			self:SetHoverText(hoverTextLabel.Text)
		end
	
		setmetatable(menuItem, {
			__index = function(t, k)
				return backgroundButton[k]
			end,
			__newindex = function(t, k, v)
				backgroundButton[k] = v
			end
		})
	
		return menuItem
	end
	
	local function createNormalHealthBar()
		local container = Util.Create'ImageButton'
		{
			Name = "NameHealthContainer";
			Size = UDim2.new(0, USERNAME_CONTAINER_WIDTH, 1, 0);
			AutoButtonColor = false;
			Image = "";
			BackgroundTransparency = 1;
		}
	
		local username = Util.Create'TextLabel'{
			Name = "Username";
			Text = Player.Name;
			Size = UDim2.new(1, -14, 0, 22);
			Position = UDim2.new(0, 7, 0, 0);
			Font = Enum.Font.SourceSansBold;
			FontSize = Enum.FontSize.Size14;
			BackgroundTransparency = 1;
			TextColor3 = FONT_COLOR;
			TextYAlignment = Enum.TextYAlignment.Bottom;
			TextXAlignment = Enum.TextXAlignment.Left;
			Parent = container;
		};
	
		local healthContainer = Util.Create'Frame'{
			Name = "HealthContainer";
			Size = UDim2.new(1, -14, 0, 3);
			Position = UDim2.new(0, 7, 1, -9);
			BorderSizePixel = 0;
			BackgroundColor3 = HEALTH_BACKGROUND_COLOR;
			Parent = container;
		};
	
		local healthFill = Util.Create'Frame'{
			Name = "HealthFill";
			Size = UDim2.new(1, 0, 1, 0);
			BorderSizePixel = 0;
			BackgroundColor3 = HEALTH_GREEN_COLOR;
			Parent = healthContainer;
		};
	
		return container, username, healthContainer, healthFill
	end
	
	----- HEALTH -----
	local function CreateUsernameHealthMenuItem()
	
		local container, username, healthContainer, healthFill = nil
	
		if isTenFootInterface and TenFootInterface and type(TenFootInterface.CreateHealthBar) == "function" then
			container, username, healthContainer, healthFill = TenFootInterface:CreateHealthBar()
		else
			container, username, healthContainer, healthFill = createNormalHealthBar()
		end
	
		local hurtOverlay = Util.Create'ImageLabel'
		{
			Name = "HurtOverlay";
			BackgroundTransparency = 1;
			Image = HURT_OVERLAY_IMAGE;
			Position = UDim2.new(-10,0,-10,0);
			Size = UDim2.new(20,0,20,0);
			Visible = false;
			Parent = GuiRoot;
		};
	
		local this = CreateMenuItem(container)
	
		--- EVENTS ---
		local humanoidChangedConn, childAddedConn, childRemovedConn = nil
		--------------
	
		local function AnimateHurtOverlay()
			if hurtOverlay and not VREnabled then
				local newSize = UDim2.new(20, 0, 20, 0)
				local newPos = UDim2.new(-10, 0, -10, 0)
	
				if hurtOverlay:IsDescendantOf(game) then
					-- stop any tweens on overlay
					hurtOverlay:TweenSizeAndPosition(newSize, newPos, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0, true, function()
						-- show the gui
						hurtOverlay.Size = UDim2.new(1,0,1,0)
						hurtOverlay.Position = UDim2.new(0,0,0,0)
						hurtOverlay.Visible = true
						-- now tween the hide
						if hurtOverlay:IsDescendantOf(game) then
							hurtOverlay:TweenSizeAndPosition(newSize, newPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 10, false, function()
								hurtOverlay.Visible = false
							end)
						else
							hurtOverlay.Size = newSize
							hurtOverlay.Position = newPos
						end
					end)
				end
			end
		end
	
		local healthColorToPosition = {
			[Vector3.new(HEALTH_RED_COLOR.r, HEALTH_RED_COLOR.g, HEALTH_RED_COLOR.b)] = 0.1;
			[Vector3.new(HEALTH_YELLOW_COLOR.r, HEALTH_YELLOW_COLOR.g, HEALTH_YELLOW_COLOR.b)] = 0.5;
			[Vector3.new(HEALTH_GREEN_COLOR.r, HEALTH_GREEN_COLOR.g, HEALTH_GREEN_COLOR.b)] = 0.8;
		}
		local min = 0.1
		local minColor = HEALTH_RED_COLOR
		local max = 0.8
		local maxColor = HEALTH_GREEN_COLOR
	
		local function HealthbarColorTransferFunction(healthPercent)
			if healthPercent < min then
				return minColor
			elseif healthPercent > max then
				return maxColor
			end
	
			-- Shepard's Interpolation
			local numeratorSum = Vector3.new(0,0,0)
			local denominatorSum = 0
			for colorSampleValue, samplePoint in pairs(healthColorToPosition) do
				local distance = healthPercent - samplePoint
				if distance == 0 then
					-- If we are exactly on an existing sample value then we don't need to interpolate
					return Color3.new(colorSampleValue.x, colorSampleValue.y, colorSampleValue.z)
				else
					local wi = 1 / (distance*distance)
					numeratorSum = numeratorSum + wi * colorSampleValue
					denominatorSum = denominatorSum + wi
				end
			end
			local result = numeratorSum / denominatorSum
			return Color3.new(result.x, result.y, result.z)
		end
	
		local function OnHumanoidAdded(humanoid)
			local lastHealth = humanoid.Health
			local function OnHumanoidHealthChanged(health)
				if humanoid then
					local healthDelta = lastHealth - health
					local healthPercent = health / humanoid.MaxHealth
					if humanoid.MaxHealth <= 0 then
						healthPercent = 0
					end
					healthPercent = Util.Clamp(0, 1, healthPercent)
					local healthColor = HealthbarColorTransferFunction(healthPercent)
					local thresholdForHurtOverlay = humanoid.MaxHealth * HEALTH_PERCANTAGE_FOR_OVERLAY
	
					if healthDelta >= thresholdForHurtOverlay and health ~= humanoid.MaxHealth and true then
						AnimateHurtOverlay()
					end
	
					healthFill.Size = UDim2.new(healthPercent, 0, 1, 0)
					healthFill.BackgroundColor3 = healthColor
	
					lastHealth = health
				end
			end
			Util.DisconnectEvent(humanoidChangedConn)
			humanoidChangedConn = humanoid.HealthChanged:connect(OnHumanoidHealthChanged)
			OnHumanoidHealthChanged(lastHealth)
		end
	
		local function OnCharacterAdded(character)
			local humanoid = Util.FindPlayerHumanoid(Player)
			if humanoid then
				OnHumanoidAdded(humanoid)
			end
	
			local function onChildAddedOrRemoved()
				local tempHumanoid = Util.FindPlayerHumanoid(Player)
				if tempHumanoid and tempHumanoid ~= humanoid then
					humanoid = tempHumanoid
					OnHumanoidAdded(humanoid)
				end
			end
			Util.DisconnectEvent(childAddedConn)
			Util.DisconnectEvent(childRemovedConn)
			childAddedConn = character.ChildAdded:connect(onChildAddedOrRemoved)
			childRemovedConn = character.ChildRemoved:connect(onChildAddedOrRemoved)
		end
	
		rawset(this, "SetHealthbarEnabled",
			function(self, enabled)
				healthContainer.Visible = enabled
				if enabled then
					username.Size = UDim2.new(1, -14, 0, 22);
					username.TextYAlignment = Enum.TextYAlignment.Bottom;
				else
					username.Size = UDim2.new(1, -14, 1, 0);
					username.TextYAlignment = Enum.TextYAlignment.Center;
				end
			end)
	
		rawset(this, "SetNameVisible",
			function(self, visible)
				username.Visible = visible
			end)
	
		-- Don't need to disconnect this one because we never reconnect it.
		Player.CharacterAdded:connect(OnCharacterAdded)
		if Player.Character then
			OnCharacterAdded(Player.Character)
		end
	
		container.Activated:Connect(function()
			if topbarEnabled then
				TogglePlayerlist()
			end
		end)
	
		return this
	end
	----- END OF HEALTH -----
	
	----- LEADERSTATS -----
	local function CreateLeaderstatsMenuItem()
	
		local leaderstatsContainer = Util.Create'ImageButton'
		{
			Name = "LeaderstatsContainer";
			Size = UDim2.new(0, 0, 1, 0);
			AutoButtonColor = false;
			Image = "";
			BackgroundTransparency = 1;
		};
	
		local this = CreateMenuItem(leaderstatsContainer)
		local columns = {}
	
		rawset(this, "SetColumns",
			function(self, columnsList)
				-- Should we handle is the screen dimensions change and it is no longer a small touch device after we set columns?
				local isSmallTouchDevice = Util.IsTouchDevice() and GuiService:GetScreenResolution().Y < 500
				local numColumns = #columnsList
	
				-- Destroy old columns
				for _, oldColumn in pairs(columns) do
					oldColumn:Destroy()
				end
				columns = {}
				-- End destroy old columns
				local count = 0
				for index, columnData in pairs(columnsList) do  -- i = 1, numColumns do
					if not isSmallTouchDevice or index <= 1 then
						local columnName = columnData.Name
						local columnValue = columnData.Text
	
						local columnframe = Util.Create'Frame'
						{
							Name = "Column" .. tostring(index);
							Size = UDim2.new(0, COLUMN_WIDTH + (index == numColumns and 0 or NAME_LEADERBOARD_SEP_WIDTH), 1, 0);
							Position = UDim2.new(0, NAME_LEADERBOARD_SEP_WIDTH + (COLUMN_WIDTH + NAME_LEADERBOARD_SEP_WIDTH) * (index-1), 0, 0);
							BackgroundTransparency = 1;
							Parent = leaderstatsContainer;
	
							Util.Create'TextLabel'
							{
								Name = "ColumnName";
								Text = columnName;
								Size = UDim2.new(1, 0, 0, 10);
								Position = UDim2.new(0, 0, 0, 4);
								Font = Enum.Font.SourceSans;
								FontSize = Enum.FontSize.Size14;
								BorderSizePixel = 0;
								BackgroundTransparency = 1;
								TextColor3 = FONT_COLOR;
								TextYAlignment = Enum.TextYAlignment.Center;
								TextXAlignment = Enum.TextXAlignment.Center;
							};
	
							Util.Create'TextLabel'
							{
								Name = "ColumnValue";
								Text = columnValue;
								Size = UDim2.new(1, 0, 0, 10);
								Position = UDim2.new(0, 0, 0, 19);
								Font = Enum.Font.SourceSansBold;
								FontSize = Enum.FontSize.Size14;
								BorderSizePixel = 0;
								BackgroundTransparency = 1;
								TextColor3 = FONT_COLOR;
								TextYAlignment = Enum.TextYAlignment.Center;
								TextXAlignment = Enum.TextXAlignment.Center;
							};
						};
						columns[columnName] = columnframe
						count = count + 1
					end
				end
				leaderstatsContainer.Size = UDim2.new(0, COLUMN_WIDTH * count + NAME_LEADERBOARD_SEP_WIDTH * count, 1, 0)
			end)
	
		rawset(this, "UpdateColumnValue",
			function(self, columnName, value)
				local column = columns[columnName]
				local columnValue = column and column:FindFirstChild('ColumnValue')
				if columnValue then
					columnValue.Text = tostring(value)
				end
			end)
	
		local playerlistConnectionsAttached = false
	
		local function attachPlayerlistModule(module)
			if not module or playerlistConnectionsAttached then
				return
			end
			playerlistConnectionsAttached = true
	
			-- IMPORTANT: do not call module.TopbarEnabledChanged().
			-- That old API re-reads CoreGuiType.PlayerList and can disable this
			-- custom list when the bootstrapper hides Roblox's native player list.
	
			if type(module.GetStats) == "function" then
				local ok, stats = pcall(module.GetStats)
				if ok and type(stats) == "table" then
					this:SetColumns(stats)
				end
			end
	
			if module.OnLeaderstatsChanged and module.OnLeaderstatsChanged.Event then
				module.OnLeaderstatsChanged.Event:connect(function(newStatColumns)
					this:SetColumns(newStatColumns)
				end)
			end
	
			if module.OnStatChanged and module.OnStatChanged.Event then
				module.OnStatChanged.Event:connect(function(statName, statValueAsString)
					this:UpdateColumnValue(statName, statValueAsString)
				end)
			end
		end
	
		rawset(this, "AttachPlayerlistModule", function(self, module)
			attachPlayerlistModule(module)
		end)
	
		rawset(this, "TogglePlayerlist", function(self)
			return TogglePlayerlist()
		end)
	
		rawset(this, "IsPlayerlistOpen", function(self)
			local module = PlayerlistModule
			if module and type(module.IsOpen) == "function" then
				local ok, value = pcall(module.IsOpen)
				if ok then return value == true end
			end
			return false
		end)
	
		rawset(this, "HidePlayerlistTemp", function(self, key, hidden)
			local module = PlayerlistModule or LoadPlayerlistModule()
			if module and type(module.HideTemp) == "function" then
				return pcall(function()
					module:HideTemp(key, hidden)
				end)
			end
			return false
		end)
	
		rawset(this, "GetPlayerlistModule", function(self)
			return PlayerlistModule
		end)
	
		leaderstatsContainer.Activated:Connect(function()
			if topbarEnabled then
				TogglePlayerlist()
			end
		end)
	
		return this
	end
	----- END OF LEADERSTATS -----
	
	--- SETTINGS ---
	local function CreateSettingsIcon(topBarInstance)
		local MenuModule = nil
		local settingsSignalConnection = nil
	
		local settingsIconButton = Util.Create'ImageButton'
		{
			Name = "Settings";
			Size = UDim2.new(0, 50, 0, TOPBAR_THICKNESS);
			Image = "";
			AutoButtonColor = false;
			BackgroundTransparency = 1;
			Active = true;
			Selectable = true;
			ZIndex = 50;
		}
	
		local settingsIconImage = Util.Create'ImageLabel'
		{
			Name = "SettingsIcon";
			Size = UDim2.new(0, 32, 0, 25);
			Position = UDim2.new(0.5, -16, 0.5, -12);
			BackgroundTransparency = 1;
			ZIndex = 51;
			Active = false;
			Image = "rbxasset://textures/ui/Menu/Hamburger.png";
			Parent = settingsIconButton;
		};
	
		local function UpdateHamburgerIcon()
			if settingsActive then
				settingsIconImage.Image = "rbxasset://textures/ui/Menu/HamburgerDown.png";
			else
				settingsIconImage.Image = "rbxasset://textures/ui/Menu/Hamburger.png";
			end
		end
	
		local function readVisibility()
			if MenuModule and type(MenuModule.GetVisibility) == "function" then
				local ok, visible = pcall(function()
					return MenuModule:GetVisibility()
				end)
				if ok then
					return visible == true
				end
			end
			return settingsActive
		end
	
		local function onVisibilityChanged(active)
			settingsActive = active == true
			UpdateHamburgerIcon()
			topBarInstance:UpdateBackgroundTransparency()
		end
	
		local function connectSignal()
			if settingsSignalConnection or not MenuModule then
				return
			end
	
			local signal = MenuModule.SettingsShowSignal
			if not signal then
				return
			end
	
			if type(signal.connect) == "function" then
				local ok, connection = pcall(function()
					return signal:connect(onVisibilityChanged)
				end)
				if ok then
					settingsSignalConnection = connection
					return
				end
			end
	
			if type(signal.Connect) == "function" then
				local ok, connection = pcall(function()
					return signal:Connect(onVisibilityChanged)
				end)
				if ok then
					settingsSignalConnection = connection
					return
				end
			end
	
			if typeof(signal) == "RBXScriptSignal" then
				settingsSignalConnection = signal:Connect(onVisibilityChanged)
			elseif typeof(signal) == "Instance" and signal:IsA("BindableEvent") then
				settingsSignalConnection = signal.Event:Connect(onVisibilityChanged)
			end
		end
	
		local function ensureHub()
			if MenuModule then
				return MenuModule
			end
	
			MenuModule = LoadSettingsHub()
			if MenuModule then
				connectSignal()
				onVisibilityChanged(readVisibility())
			end
			return MenuModule
		end
	
		local function forceHubVisualState(hub, visible, customStartPage)
			if not hub then return false end
			local instance = hub.Instance
			if type(instance) ~= "table" then return false end
	
			instance.Visible = visible == true
			instance.Active = visible == true
	
			if instance.Modal then
				instance.Modal.Visible = visible == true
			end
	
			if instance.ClippingShield then
				instance.ClippingShield.Visible = visible == true
			end
	
			if instance.Shield then
				instance.Shield.Visible = visible == true
				if visible then
					instance.Shield.Position = UDim2.new(0, 0, 0, 0)
				else
					instance.Shield.Position = UDim2.new(0, 0, -1, -36)
				end
			end
	
			if visible then
				local targetPage = customStartPage
					or (instance.Pages and instance.Pages.CurrentPage)
					or instance.PlayersPage
					or instance.HomePage
					or instance.GameSettingsPage
					or instance.HelpPage
	
				if targetPage and type(instance.SwitchToPage) == "function" then
					pcall(function()
						instance:SwitchToPage(targetPage, true, 1, true)
					end)
				end
	
				if type(instance.ShowBar) == "function" then
					pcall(function()
						instance:ShowBar()
					end)
				end
			else
				-- Kill any orphaned 2016 dropdown overlay before doing anything else.
				pcall(function()
					local rg = G2L["1"]
					if rg then
						for _, obj in ipairs(rg:GetDescendants()) do
							if obj.Name == "DropDownFullscreenFrame" and obj:IsA("GuiObject") then
								obj.Visible = false
							end
						end
					end
				end)
				pcall(function()
					if type(instance.SetActive) == "function" then instance:SetActive(true) end
				end)

				if type(instance.HideBar) == "function" then
					pcall(function()
						instance:HideBar()
					end)
				end

				-- If the old close path failed, don't leave the player controls captured.
				pcall(function() ContextActionService:UnbindAction("RbxSettingsHubSwitchTab") end)
				pcall(function() ContextActionService:UnbindAction("RbxSettingsHubStopCharacter") end)
				pcall(function() ContextActionService:UnbindAction("RbxSettingsScrollHotkey") end)
				pcall(function() GuiService:SetMenuIsOpen(false) end)
				pcall(function() GuiService.SelectedObject = nil end)
				pcall(function() UserInputService.OverrideMouseIconEnabled = false end)
				pcall(function() UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None end)
			end
	
			-- Keep the old SettingsShowSignal consumers synchronized.
			local signal = hub.SettingsShowSignal
			if signal then
				pcall(function()
					if type(signal.fire) == "function" then
						signal:fire(visible == true)
					elseif type(signal.Fire) == "function" then
						signal:Fire(visible == true)
					elseif typeof(signal) == "Instance" and signal:IsA("BindableEvent") then
						signal:Fire(visible == true)
					end
				end)
			end
	
			return true
		end
	
		local function setVisible(visible, noAnimation, customStartPage, switchedFromGamepadInput)
			local hub = ensureHub()
			if not hub then
				warn("[Topbar] SettingsHub unavailable")
				return false
			end
	
			-- Prefer the real 2016 API first.
			local ok, err = pcall(function()
				hub:SetVisibility(visible, noAnimation, customStartPage, switchedFromGamepadInput)
			end)
	
			if not ok then
				warn("[Topbar] SettingsHub:SetVisibility failed; using visual fallback:", err)
				forceHubVisualState(hub, visible, customStartPage)
			end
	
			-- Verify the state because some old SettingsHub code paths can return
			-- successfully without making the PlayerGui version visible.
			local actual = nil
			local readOk, readResult = pcall(function()
				return hub:GetVisibility()
			end)
			if readOk then
				actual = readResult == true
			elseif hub.Instance then
				actual = hub.Instance.Visible == true
			end
	
			if actual ~= (visible == true) then
				warn("[Topbar] SettingsHub visibility did not change; forcing GUI state")
				forceHubVisualState(hub, visible, customStartPage)
			end
	
			onVisibilityChanged(visible == true)
			return true
		end
	
		local function toggleSettings(switchedFromGamepadInput)
			local hub = ensureHub()
			if not hub then
				warn("[Topbar] SettingsHub unavailable")
				return settingsActive
			end
	
			local currentlyVisible = false
			local ok, value = pcall(function()
				return hub:GetVisibility()
			end)
	
			if ok then
				currentlyVisible = value == true
			elseif hub.Instance then
				currentlyVisible = hub.Instance.Visible == true
			else
				currentlyVisible = settingsActive
			end
	
			setVisible(not currentlyVisible, false, nil, switchedFromGamepadInput)
			return not currentlyVisible
		end
	
		-- Dedicated capture button so no other transparent topbar GUI can eat the click.
		local settingsClickCapture = Util.Create'TextButton'
		{
			Name = "SettingsClickCapture";
			Size = UDim2.new(1, 0, 1, 0);
			Position = UDim2.new(0, 0, 0, 0);
			BackgroundTransparency = 1;
			Text = "";
			AutoButtonColor = false;
			Active = true;
			Selectable = true;
			ZIndex = 100;
			Parent = settingsIconButton;
		}
	
		local hamburgerBusy = false
	
		local function hamburgerActivated()
			if hamburgerBusy then return end
			hamburgerBusy = true
	
			task.spawn(function()
				local hub = LoadSettingsHub()
				if not hub then
					warn("[Topbar] Hamburger: SettingsHub failed to load")
					hamburgerBusy = false
					return
				end
	
				MenuModule = hub
				connectSignal()
	
				local ok, err = pcall(function()
					hub:ToggleVisibility(false)
				end)
	
				if not ok then
					warn("[Topbar] Hamburger: SettingsHub:ToggleVisibility failed:", err)
				end
	
				-- The hub's SettingsShowSignal is authoritative for the icon.
				task.delay(0.1, function()
					onVisibilityChanged(readVisibility())
					hamburgerBusy = false
				end)
			end)
		end
	
		settingsClickCapture.Activated:Connect(hamburgerActivated)
	
		local menuItem = CreateMenuItem(settingsIconButton)
	
		rawset(menuItem, "SetTransparency", function(self, transparency)
			settingsIconImage.ImageTransparency = transparency
		end)
	
		rawset(menuItem, "SetImage", function(self, image)
			settingsIconImage.Image = image
		end)
	
		rawset(menuItem, "SetSettingsActive", function(self, active)
			setVisible(active == true)
			return readVisibility()
		end)
	
		-- Exact SettingsHub API helpers from settings2016.rbxm.
		rawset(menuItem, "OpenSettings", function(self, customStartPage)
			return setVisible(true, false, customStartPage, false)
		end)
	
		rawset(menuItem, "CloseSettings", function(self)
			return setVisible(false)
		end)
	
		rawset(menuItem, "ToggleSettings", function(self, switchedFromGamepadInput)
			local hub = LoadSettingsHub()
			if not hub then return false end
	
			local ok, err = pcall(function()
				hub:ToggleVisibility(switchedFromGamepadInput)
			end)
			if not ok then
				warn("[Topbar] SettingsHub:ToggleVisibility failed:", err)
				return false
			end
	
			MenuModule = hub
			connectSignal()
			onVisibilityChanged(readVisibility())
			return readVisibility()
		end)
	
		rawset(menuItem, "GetSettingsVisibility", function(self)
			ensureHub()
			return readVisibility()
		end)
	
		rawset(menuItem, "SwitchSettingsPage", function(self, pageToSwitchTo, ignoreStack)
			local hub = ensureHub()
			if not hub then return false end
			return pcall(function()
				hub:SwitchToPage(pageToSwitchTo, ignoreStack)
			end)
		end)
	
		rawset(menuItem, "ReportPlayer", function(self, player)
			local hub = ensureHub()
			if not hub or type(hub.ReportPlayer) ~= "function" then
				return false
			end
			return pcall(function()
				hub:ReportPlayer(player)
			end)
		end)
	
		rawset(menuItem, "ShowSettingsShield", function(self)
			local hub = ensureHub()
			if not hub then return false end
			return pcall(function()
				hub:ShowShield()
			end)
		end)
	
		rawset(menuItem, "HideSettingsShield", function(self)
			local hub = ensureHub()
			if not hub then return false end
			return pcall(function()
				hub:HideShield()
			end)
		end)
	
		-- Full SettingsHub.Instance compatibility API.
		local function getInstance()
			local hub = ensureHub()
			return hub and hub.Instance or nil
		end
	
		rawset(menuItem, "GetSettingsInstance", function(self)
			return getInstance()
		end)
	
		rawset(menuItem, "AddSettingsPage", function(self, pageToAdd)
			local instance = getInstance()
			if not instance or type(instance.AddPage) ~= "function" then return false end
			return pcall(function()
				instance:AddPage(pageToAdd)
			end)
		end)
	
		rawset(menuItem, "RemoveSettingsPage", function(self, pageToRemove)
			local instance = getInstance()
			if not instance or type(instance.RemovePage) ~= "function" then return false end
			return pcall(function()
				instance:RemovePage(pageToRemove)
			end)
		end)
	
		rawset(menuItem, "HideSettingsBar", function(self)
			local instance = getInstance()
			if not instance or type(instance.HideBar) ~= "function" then return false end
			return pcall(function()
				instance:HideBar()
			end)
		end)
	
		rawset(menuItem, "ShowSettingsBar", function(self)
			local instance = getInstance()
			if not instance or type(instance.ShowBar) ~= "function" then return false end
			return pcall(function()
				instance:ShowBar()
			end)
		end)
	
		rawset(menuItem, "ScrollSettingsPixels", function(self, pixels)
			local instance = getInstance()
			if not instance or type(instance.ScrollPixels) ~= "function" then return false end
			return pcall(function()
				instance:ScrollPixels(pixels)
			end)
		end)
	
		rawset(menuItem, "ScrollSettingsToFrame", function(self, frame, forced)
			local instance = getInstance()
			if not instance or type(instance.ScrollToFrame) ~= "function" then return false end
			return pcall(function()
				instance:ScrollToFrame(frame, forced)
			end)
		end)
	
		rawset(menuItem, "SwitchSettingsPageFull", function(self, pageToSwitchTo, ignoreStack, direction, skipAnimation)
			local instance = getInstance()
			if not instance or type(instance.SwitchToPage) ~= "function" then return false end
			return pcall(function()
				instance:SwitchToPage(pageToSwitchTo, ignoreStack, direction, skipAnimation)
			end)
		end)
	
		rawset(menuItem, "SetSettingsHubActive", function(self, active)
			local instance = getInstance()
			if not instance or type(instance.SetActive) ~= "function" then return false end
			return pcall(function()
				instance:SetActive(active == true)
			end)
		end)
	
		rawset(menuItem, "AddToSettingsMenuStack", function(self, newItem)
			local instance = getInstance()
			if not instance or type(instance.AddToMenuStack) ~= "function" then return false end
			return pcall(function()
				instance:AddToMenuStack(newItem)
			end)
		end)
	
		rawset(menuItem, "PopSettingsMenu", function(self, switchedFromGamepadInput, skipAnimation)
			local instance = getInstance()
			if not instance or type(instance.PopMenu) ~= "function" then return false end
			return pcall(function()
				instance:PopMenu(switchedFromGamepadInput, skipAnimation)
			end)
		end)
	
		rawset(menuItem, "GetSettingsPoppedMenuSignal", function(self)
			local instance = getInstance()
			return instance and instance.PoppedMenu or nil
		end)
	
		rawset(menuItem, "GetSettingsShowSignal", function(self)
			local hub = ensureHub()
			return hub and hub.SettingsShowSignal or nil
		end)
	
		rawset(menuItem, "GetSettingsPages", function(self)
			local instance = getInstance()
			return instance and instance.Pages or nil
		end)
	
		rawset(menuItem, "GetCurrentSettingsPage", function(self)
			local instance = getInstance()
			return instance and instance.Pages and instance.Pages.CurrentPage or nil
		end)
	
		rawset(menuItem, "GetSettingsMenuStack", function(self)
			local instance = getInstance()
			return instance and instance.MenuStack or nil
		end)
	
		rawset(menuItem, "GetSettingsTabHeaders", function(self)
			local instance = getInstance()
			return instance and instance.TabHeaders or nil
		end)
	
		rawset(menuItem, "GetSettingsBottomBarButtons", function(self)
			local instance = getInstance()
			return instance and instance.BottomBarButtons or nil
		end)
	
		rawset(menuItem, "GetSettingsPageByName", function(self, pageName)
			local instance = getInstance()
			if not instance or type(pageName) ~= "string" then return nil end
	
			local pageMap = {
				LeaveGame = "LeaveGamePage",
				ResetCharacter = "ResetCharacterPage",
				Home = "HomePage",
				GameSettings = "GameSettingsPage",
				ReportAbuse = "ReportAbusePage",
				Help = "HelpPage",
				Record = "RecordPage",
				Players = "PlayersPage",
			}
	
			local field = pageMap[pageName] or pageName
			return instance[field]
		end)
	
		rawset(menuItem, "GetSettingsGuiObject", function(self, objectName)
			local instance = getInstance()
			if not instance or type(objectName) ~= "string" then return nil end
	
			local allowed = {
				ClippingShield = true,
				Shield = true,
				Modal = true,
				HubBar = true,
				PageViewClipper = true,
				PageView = true,
				BottomButtonFrame = true,
			}
	
			if allowed[objectName] then
				return instance[objectName]
			end
			return nil
		end)
	
		rawset(menuItem, "AddPage", function(self, ...)
			local hub = ensureHub()
			return hub and hub:AddPage(...) or nil
		end)
	
		rawset(menuItem, "RemovePage", function(self, ...)
			local hub = ensureHub()
			return hub and hub:RemovePage(...) or nil
		end)
	
		rawset(menuItem, "HideBar", function(self, ...)
			local hub = ensureHub()
			return hub and hub:HideBar(...) or nil
		end)
	
		rawset(menuItem, "ShowBar", function(self, ...)
			local hub = ensureHub()
			return hub and hub:ShowBar(...) or nil
		end)
	
		rawset(menuItem, "ScrollPixels", function(self, ...)
			local hub = ensureHub()
			return hub and hub:ScrollPixels(...) or nil
		end)
	
		rawset(menuItem, "ScrollToFrame", function(self, ...)
			local hub = ensureHub()
			return hub and hub:ScrollToFrame(...) or nil
		end)
	
		rawset(menuItem, "SetActive", function(self, ...)
			local hub = ensureHub()
			return hub and hub:SetActive(...) or nil
		end)
	
		rawset(menuItem, "AddToMenuStack", function(self, ...)
			local hub = ensureHub()
			return hub and hub:AddToMenuStack(...) or nil
		end)
	
		rawset(menuItem, "PopMenu", function(self, ...)
			local hub = ensureHub()
			return hub and hub:PopMenu(...) or nil
		end)
	
		rawset(menuItem, "GetSettingsState", function(self)
			local instance = getInstance()
			if not instance then return nil end
	
			return {
				Visible = instance.Visible,
				Active = instance.Active,
				OpenStateChangedCount = instance.OpenStateChangedCount,
				CurrentPage = instance.Pages and instance.Pages.CurrentPage or nil,
				MenuStack = instance.MenuStack,
			}
		end)
	
		rawset(menuItem, "PreflightSettingsHub", function(self)
			return PreflightSettingsHubDependencies()
		end)
	
		rawset(menuItem, "GetSettingsHub", function(self)
			return ensureHub()
		end)
	
		rawset(menuItem, "GetSettingsUtility", function(self)
			PrepareLegacyCoreCompat()
			return LoadSettingsUtility()
		end)
	
		rawset(menuItem, "GetSettingsPageFactory", function(self)
			PrepareLegacyCoreCompat()
			return LoadSettingsPageFactory()
		end)
	
		rawset(menuItem, "GetSettingsPageModule", function(self, pageName)
			PrepareLegacyCoreCompat()
			if type(pageName) ~= "string" then return nil end
			return LoadSettingsPageModule(pageName)
		end)
	
		rawset(menuItem, "GetSettingsModule", function(self, moduleName)
			PrepareLegacyCoreCompat()
			if type(moduleName) ~= "string" then return nil end
	
			if moduleName == "SettingsHub" then
				return ensureHub()
			elseif moduleName == "Utility" then
				return LoadSettingsUtility()
			elseif moduleName == "SettingsPageFactory" then
				return LoadSettingsPageFactory()
			end
	
			return LoadSettingsPageModule(moduleName)
		end)
	
		rawset(menuItem, "GetAllSettingsPages", function(self)
			PrepareLegacyCoreCompat()
			local result = {}
			for _, pageName in ipairs({
				"GameSettings",
				"Help",
				"Home",
				"LeaveGame",
				"ResetCharacter",
				"Record",
				"Players",
				"ReportAbuseMenu",
				}) do
				result[pageName] = LoadSettingsPageModule(pageName)
			end
			return result
		end)
	
		return menuItem
	end
	
	local function Create3DSettingsIcon(topBarInstance, panel, menubar)
		local MenuModule = LoadSettingsHub()
		if not MenuModule then return nil end
		local menuItem = Create3DMenuItem()
		menuItem:SetHoverText("Settings")
	
		local icon = Util.Create "ImageLabel" {
			Parent = menuItem:GetInstance(),
	
			Position = UDim2.new(0.5, -15, 0.5, -11),
			Size = UDim2.new(0, 30, 0, 22),
	
			BackgroundTransparency = 1,
	
			Image = "rbxasset://textures/ui/Menu/hamburger3D.png"
		}
	
		menuItem.MouseButton1Click:connect(function()
			MenuModule:SetVisibility(true)
			menubar:CloseAllExcept(menuItem)
		end)
	
		local settingsPanel = Panel3D.Get("SettingsMenu")
		function settingsPanel:OnVisibilityChanged(visible)
			menuItem:SetActive(visible)
		end
	
		return menuItem
	end
	
	------------
	
	--- CHAT ---
	local function CreateUnreadMessagesNotifier(ChatModule)
		local chatActive = false
		local lastMessageCount = 0
	
		local chatCounter = Util.Create'ImageLabel'
		{
			Name = "ChatCounter";
			Size = UDim2.new(0, 18, 0, 18);
			Position = UDim2.new(1, -12, 0, -4);
			BackgroundTransparency = 1;
			Image = "rbxasset://textures/ui/Chat/MessageCounter.png";
			Visible = false;
		};
	
		local chatCountText = Util.Create'TextLabel'
		{
			Name = "ChatCounterText";
			Text = '';
			Size = UDim2.new(0, 13, 0, 9);
			Position = UDim2.new(0.5, -7, 0.5, -7);
			Font = Enum.Font.SourceSansBold;
			FontSize = Enum.FontSize.Size14;
			BorderSizePixel = 0;
			BackgroundTransparency = 1;
			TextColor3 = FONT_COLOR;
			TextYAlignment = Enum.TextYAlignment.Center;
			TextXAlignment = Enum.TextXAlignment.Center;
			Parent = chatCounter;
		};
	
		local function OnUnreadMessagesChanged(count)
			if chatActive then
				lastMessageCount = count
			end
			local unreadCount = count - lastMessageCount
	
			if unreadCount <= 0 then
				chatCountText.Text = ""
				chatCounter.Visible = false
			else
				if unreadCount < 100 then
					chatCountText.Text = tostring(unreadCount)
				else
					chatCountText.Text = "!"
				end
				chatCounter.Visible = true
			end
		end
	
		local function onChatStateChanged(visible)
			chatActive = visible
			if ChatModule then
				OnUnreadMessagesChanged(ChatModule:GetMessageCount())
			end
		end
	
	
		if ChatModule then
			if ChatModule.VisibilityStateChanged then
				ChatModule.VisibilityStateChanged:connect(onChatStateChanged)
			end
			if ChatModule.MessagesChanged then
				ChatModule.MessagesChanged:connect(OnUnreadMessagesChanged)
			end
	
			onChatStateChanged(ChatModule:GetVisibility())
			OnUnreadMessagesChanged(ChatModule:GetMessageCount())
		end
	
		return chatCounter
	end
	
	local function CreateChatIcon()
		local chatIconButton = Util.Create'ImageButton'
		{
			Name = "Chat";
			Size = UDim2.new(0, 50, 0, TOPBAR_THICKNESS);
			Image = "";
			AutoButtonColor = false;
			BackgroundTransparency = 1;
			Active = true;
			Selectable = true;
			ZIndex = 50;
		};
	
		local chatIconImage = Util.Create'ImageLabel'
		{
			Name = "ChatIcon";
			Size = UDim2.new(0, 28, 0, 27);
			ZIndex = 51;
			Active = false;
			Position = UDim2.new(0.5, -14, 0.5, -13);
			BackgroundTransparency = 1;
			Image = "rbxasset://textures/ui/Chat/Chat.png";
			Parent = chatIconButton;
		};
	
		local function getTextButton()
			local button = GuiRoot:FindFirstChild("TextButton")
			if button and button:IsA("TextButton") then
				return button
			end
			return nil
		end
	
		local function getWindow()
			return TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
				or TextChatService:FindFirstChild("ChatWindowConfiguration")
		end
	
		local function getInput()
			return TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
				or TextChatService:FindFirstChild("ChatInputBarConfiguration")
		end
	
		local function getVisible()
			local button = getTextButton()
			if button then
				return button.Visible
			end
	
			if ChatModule and type(ChatModule.GetVisibility) == "function" then
				local ok, visible = pcall(function()
					return ChatModule:GetVisibility()
				end)
				if ok then return visible == true end
			end
	
			local window = getWindow()
			return window and window.Enabled or false
		end
	
		local function updateIcon(visible)
			chatIconImage.Image = visible
				and "rbxasset://textures/ui/Chat/ChatDown.png"
				or "rbxasset://textures/ui/Chat/Chat.png"
		end
	
		local function setVisible(visible)
			local button = getTextButton()
			if button then
				button.Visible = visible
			end
	
			if ChatModule then
				pcall(function()
					if type(ChatModule.SetVisible) == "function" then
						ChatModule:SetVisible(visible)
					elseif type(ChatModule.GetVisibility) == "function"
						and type(ChatModule.ToggleVisibility) == "function"
						and (ChatModule:GetVisibility() == true) ~= visible then
						ChatModule:ToggleVisibility()
					end
				end)
			else
				local window = getWindow()
				local input = getInput()
				if window then window.Enabled = visible end
				if input then input.Enabled = visible end
			end
	
			updateIcon(visible)
		end
	
		local chatIconActive = false
	
		chatIconButton.Activated:Connect(function()
			-- On mobile, the Chat button should ONLY focus the chat bar for
			-- typing mode (2016 Roblox behavior). It must NOT toggle chat
			-- visibility — that is handled by the separate Show/Hide Chat button.
			if Util.IsTouchDevice() then
				chatIconActive = not chatIconActive
				updateIcon(chatIconActive)
				if ChatModule and type(ChatModule.FocusChatBar) == "function" then
					pcall(function()
						ChatModule:FocusChatBar()
					end)
				end
				return
			end
	
			-- Desktop keeps the normal visibility toggle behavior.
			if ChatModule and type(ChatModule.ToggleVisibility) == "function" then
				local ok = pcall(function()
					ChatModule:ToggleVisibility()
				end)
				if ok then
					local visible = getVisible()
					local button = getTextButton()
					if button then button.Visible = visible end
					updateIcon(visible)
					return
				end
			end
	
			setVisible(not getVisible())
		end)
	
		local menuItem = CreateMenuItem(chatIconButton)
	
		rawset(menuItem, "ToggleChat", function(self)
			setVisible(not getVisible())
		end)
	
		rawset(menuItem, "SetTransparency", function(self, transparency)
			chatIconImage.ImageTransparency = transparency
		end)
	
		rawset(menuItem, "SetImage", function(self, newImage)
			chatIconImage.Image = newImage
		end)
	
		rawset(menuItem, "AttachChatModule", function(self, module)
			ChatModule = CompleteChatAPI(module)
			if not module then
				return
			end
	
			-- Exact public API/events exposed by Chat in 2016prototype.rbxm.
			if module.VisibilityStateChanged then
				pcall(function()
					module.VisibilityStateChanged:connect(function(visible)
						local button = getTextButton()
						if button then button.Visible = visible == true end
						-- Do NOT update the Chat icon here on mobile — the Chat icon
						-- is controlled by the Chat button click, not by visibility.
						if not Util.IsTouchDevice() then
							updateIcon(visible == true)
						end
					end)
				end)
			end
	
			if module.ChatBarFocusChanged then
				pcall(function()
					module.ChatBarFocusChanged:connect(function(isFocused)
						if Util.IsTouchDevice() then
							-- On mobile, the Chat icon follows focus state, not visibility.
							chatIconActive = isFocused == true
							updateIcon(chatIconActive)
						else
							updateIcon(getVisible())
						end
					end)
				end)
			end
	
			if not Util.IsTouchDevice()
				and type(module.GetMessageCount) == "function"
				and module.MessagesChanged then
				local chatCounter = CreateUnreadMessagesNotifier(module)
				chatCounter.Parent = chatIconImage
			end
	
			if Util.IsTouchDevice() then
				updateIcon(false)
			else
				updateIcon(getVisible())
			end
		end)
	
		rawset(menuItem, "FocusChatBar", function(self)
			if ChatModule and type(ChatModule.FocusChatBar) == "function" then
				return pcall(function()
					ChatModule:FocusChatBar()
				end)
			end
			return false
		end)
	
		rawset(menuItem, "GetChatVisibility", function(self)
			return getVisible()
		end)
	
		rawset(menuItem, "GetChatMessageCount", function(self)
			if ChatModule and type(ChatModule.GetMessageCount) == "function" then
				local ok, count = pcall(function()
					return ChatModule:GetMessageCount()
				end)
				if ok then return count end
			end
			return 0
		end)
	
		rawset(menuItem, "GetChatModule", function(self)
			return ChatModule
		end)
	
		topbarEnabledChangedEvent.Event:connect(function()
			if ChatModule and type(ChatModule.TopbarEnabledChanged) == "function" then
				pcall(function()
					ChatModule:TopbarEnabledChanged(topbarEnabled)
				end)
			end
		end)
	
		if Util.IsTouchDevice() then
			updateIcon(false)
		else
			updateIcon(getVisible())
		end
		return menuItem
	end
	
	local function CreateMobileHideChatIcon()
		if not Util.IsTouchDevice() then
			return nil
		end
	
		local button = Util.Create'ImageButton'
		{
			Name = "ShowChat";
			Size = UDim2.new(0, 50, 0, TOPBAR_THICKNESS);
			BackgroundTransparency = 1;
			BorderSizePixel = 0;
			Image = "";
			AutoButtonColor = false;
			Active = true;
			Selectable = true;
			ZIndex = 50;
		};
	
		local icon = Util.Create'ImageLabel'
		{
			Name = "ToggleChatIcon";
			Size = UDim2.new(0, 28, 0, 28);
			Position = UDim2.new(0.5, -14, 0.5, -14);
			BackgroundTransparency = 1;
			Image = "rbxasset://textures/ui/Chat/ToggleChat.png";
			Active = false;
			ZIndex = 51;
			Parent = button;
		};
	
		local menuItem = CreateMenuItem(button)
	
		local function getWindow()
			return TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
				or TextChatService:FindFirstChild("ChatWindowConfiguration")
		end
	
		local function getInput()
			return TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
				or TextChatService:FindFirstChild("ChatInputBarConfiguration")
		end
	
		local function forceLegacyChatWindowVisible(visible)
			-- The 2016 Chat module can update its own Visible state before its
			-- ChatWindowContainer catches up on mobile. Force the actual window too.
			local chatWindow = GuiRoot:FindFirstChild("ChatWindowContainer", true)
			if chatWindow and chatWindow:IsA("GuiObject") then
				chatWindow.Visible = visible == true
			end
		end
	
		local function queryVisible()
			if ChatModule and type(ChatModule.GetVisibility) == "function" then
				local ok, visible = pcall(function()
					return ChatModule:GetVisibility()
				end)
				if ok then
					return visible == true
				end
			end
	
			local window = getWindow()
			if window then
				return window.Enabled == true
			end
	
			return false
		end
	
		local mobileChatVisible = queryVisible()
	
		local function updateIcon()
			icon.Image = mobileChatVisible
				and "rbxasset://textures/ui/Chat/ToggleChatDown.png"
				or "rbxasset://textures/ui/Chat/ToggleChat.png"
		end
	
		local function applyVisible(visible)
			mobileChatVisible = visible == true
	
			if ChatModule then
				if type(ChatModule.SetVisible) == "function" then
					pcall(function()
						ChatModule:SetVisible(mobileChatVisible)
					end)
				elseif type(ChatModule.ToggleVisibility) == "function" then
					local current = queryVisible()
					if current ~= mobileChatVisible then
						pcall(function()
							ChatModule:ToggleVisibility()
						end)
					end
				end
			end
	
			-- This is the important mobile fix: make the actual 2016
			-- ChatWindowContainer follow the Show Chat toggle immediately.
			forceLegacyChatWindowVisible(mobileChatVisible)
	
			-- Some old chat code updates one task later, so enforce it once more
			-- after the module has processed SetVisible().
			task.defer(function()
				forceLegacyChatWindowVisible(mobileChatVisible)
			end)
	
			-- The generic Chat icon remains responsible for focusing the input.
			-- Do not focus the chat bar here.
			local input = getInput()
			if input then
				input.Enabled = true
			end
	
			updateIcon()
		end
	
		button.Activated:Connect(function()
			-- IMPORTANT: toggle our own state instead of immediately re-reading the
			-- chat module. The old chat module can report its previous state for a frame.
			applyVisible(not mobileChatVisible)
		end)
	
		rawset(menuItem, "SetChatVisible", function(self, visible)
			applyVisible(visible == true)
		end)
	
		rawset(menuItem, "GetChatVisibility", function(self)
			return mobileChatVisible
		end)
	
		rawset(menuItem, "SetTransparency", function(self, transparency)
			icon.ImageTransparency = transparency
		end)
	
		rawset(menuItem, "AttachChatModule", function(self, module)
			ChatModule = CompleteChatAPI(module)
			mobileChatVisible = queryVisible()
			updateIcon()
	
			if ChatModule and ChatModule.VisibilityStateChanged then
				pcall(function()
					ChatModule.VisibilityStateChanged:connect(function(visible)
						mobileChatVisible = visible == true
						forceLegacyChatWindowVisible(mobileChatVisible)
						updateIcon()
					end)
				end)
			end
		end)
	
		updateIcon()
		return menuItem
	end
	
	
	local function Create3DChatIcon(topBarInstance, panel, menubar)
		local chatEnabled = game:GetService("UserInputService"):GetPlatform() ~= Enum.Platform.XBoxOne
		if not chatEnabled then return end
	
		local ChatModule = require(GuiRoot.Modules.Chat)
	
		local menuItem = Create3DMenuItem()
		menuItem:SetHoverText("Chat")
	
		local icon = Util.Create "ImageLabel" {
			Parent = menuItem:GetInstance(),
	
			Position = UDim2.new(0.5, -14, 0.5, -12),
			Size = UDim2.new(0, 28, 0, 28),
	
			BackgroundTransparency = 1,
	
			Image = "rbxasset://textures/ui/Chat/Chat.png"
		}
	
		menuItem.MouseButton1Click:connect(function()
			ChatModule:SetVisible(not ChatModule:GetVisibility())
			if ChatModule:GetVisibility() then
				ChatModule:FocusChatBar()
			end
			menubar:CloseAllExcept(menuItem)
		end)
	
		local closedEventConn = nil
		local function OnVREnabled(prop)
			if prop == 'VREnabled' then
				if closedEventConn then
					closedEventConn:disconnect()
					closedEventConn = nil
				end
				if InputService.VREnabled then
					local VirtualKeyboardModule = require(GuiRoot.Modules.VR.VirtualKeyboard)
					closedEventConn = VirtualKeyboardModule.ClosedEvent:connect(function()
						if ChatModule:IsFocused(true) then
							ChatModule:SetVisible(false)
						end
					end)
				end
			end
		end
		InputService.Changed:connect(OnVREnabled)
		spawn(function() OnVREnabled("VREnabled") end)
	
	
		local chatPanel = Panel3D.Get("Chat")
		function chatPanel:OnVisibilityChanged(visible)
			menuItem:SetActive(visible)
		end
	
		return menuItem
	end
	
	local function Create3DUserGuiToggleIcon(topBarInstance, panel, menubar)
		local menuItem = Create3DMenuItem()
		menuItem:SetHoverText("2D UI")
	
		local icon = Util.Create "ImageLabel" {
			Parent = menuItem:GetInstance(),
	
			Position = UDim2.new(0.5, -14, 0.5, -14),
			Size = UDim2.new(0, 28, 0, 28),
	
			BackgroundTransparency = 1,
	
			Image = "rbxasset://textures/ui/VR/toggle2D.png"
		}
	
		local userGuiPanel = Panel3D.Get("UserGui")
		userGuiPanel:SetType(Panel3D.Type.Fixed)
		userGuiPanel:ResizePixels(300, 125)
		userGuiPanel:SetVisible(false, false)
	
		menuItem.MouseButton1Click:connect(function()
			if InputService.VREnabled then
				userGuiPanel:SetVisible(not userGuiPanel.isVisible, false)
			end
		end)
	
		function userGuiPanel:OnVisibilityChanged(visible)
			if visible then
				local headLook = Panel3D.GetHeadLookXZ(true)
				userGuiPanel.localCF = headLook * CFrame.Angles(math.rad(5), 0, 0) * CFrame.new(0, 0, 5)
			end
			menuItem:SetActive(visible)
			local success, msg = pcall(function()
				CoreGuiService:SetUserGuiRendering(true, visible and userGuiPanel:GetPart() or nil, Enum.NormalId.Front)
			end)
		end
	
		local function OnVREnabled(prop)
			if prop == 'VREnabled' then
				local guiPart = nil
				if InputService.VREnabled then
					if userGuiPanel.isVisible then
						guiPart = userGuiPanel:GetPart()
					end
				else
					userGuiPanel:SetVisible(false, false)
				end
				local success, msg = pcall(function()
					CoreGuiService:SetUserGuiRendering(InputService.VREnabled, guiPart, Enum.NormalId.Front)
				end)
			end
		end
		InputService.Changed:connect(OnVREnabled)
		spawn(function() OnVREnabled("VREnabled") end)
	
		return menuItem
	end
	
	-----------
	
	--- Backpack ---
	local function CreateBackpackIcon()
		local backpackIconButton = Util.Create'ImageButton'
		{
			Name = "Backpack";
			Size = UDim2.new(0, 50, 0, TOPBAR_THICKNESS);
			Image = "";
			AutoButtonColor = false;
			BackgroundTransparency = 1;
			Active = true;
			Selectable = true;
			ZIndex = 50;
		};
	
		local backpackIconImage = Util.Create'ImageLabel'
		{
			Name = "BackpackIcon";
			Size = UDim2.new(0, 22, 0, 28);
			ZIndex = 51;
			Active = false;
			Position = UDim2.new(0.5, -11, 0.5, -14);
			BackgroundTransparency = 1;
			Image = "rbxasset://textures/ui/Backpack/Backpack.png";
			Parent = backpackIconButton;
		};
	
		local function loadBackpack()
			PrepareLegacyCoreCompat()
			LoadTenFootInterface()
	
			if BackpackModule then
				return BackpackModule
			end
			BackpackModule = CompleteBackpackAPI(SafeRequire(Modules:FindFirstChild("BackpackScript"), "BackpackScript"))
			return BackpackModule
		end
	
		local function updateState(open)
			backpackIconImage.Image = open
				and "rbxasset://textures/ui/Backpack/Backpack_Down.png"
				or "rbxasset://textures/ui/Backpack/Backpack.png"
		end
	
		backpackIconButton.Activated:Connect(function()
			local module = loadBackpack()
			if module and type(module.OpenClose) == "function" then
				module:OpenClose()
			end
		end)
	
		local menuItem = CreateMenuItem(backpackIconButton)
	
		rawset(menuItem, "AttachBackpackModule", function(self, module)
			BackpackModule = module
			if not module then return end
	
			if module.StateChanged and module.StateChanged.Event then
				module.StateChanged.Event:connect(updateState)
			end
	
			if module.IsOpen ~= nil then
				updateState(module.IsOpen == true)
			end
		end)
	
		rawset(menuItem, "ToggleBackpack", function(self)
			local module = BackpackModule or loadBackpack()
			if module and type(module.OpenClose) == "function" then
				return pcall(function()
					module:OpenClose()
				end)
			end
			return false
		end)
	
		rawset(menuItem, "GetBackpackOpen", function(self)
			local module = BackpackModule
			return module and module.IsOpen == true or false
		end)
	
		rawset(menuItem, "GetBackpackStateChanged", function(self)
			local module = BackpackModule
			return module and module.StateChanged or nil
		end)
	
		rawset(menuItem, "GetBackpackModule", function(self)
			return BackpackModule
		end)
	
		topbarEnabledChangedEvent.Event:connect(function()
			if BackpackModule and type(BackpackModule.TopbarEnabledChanged) == "function" then
				pcall(function()
					BackpackModule:TopbarEnabledChanged(topbarEnabled)
				end)
			end
		end)
	
		return menuItem
	end
	
	--------------
	
	----- Stop Recording --
	local function CreateStopRecordIcon()
		local stopRecordIconButton = Util.Create'ImageButton'
		{
			Name = "StopRecording";
			Size = UDim2.new(0, 50, 0, TOPBAR_THICKNESS);
			Image = "";
			Visible = true;
			BackgroundTransparency = 1;
		};
		--stopRecordIconButton:SetVerb("RecordToggle")
	
		local stopRecordIconLabel = Util.Create'ImageLabel'
		{
			Name = "StopRecordingIcon";
			Size = UDim2.new(0, 28, 0, 28);
			Position = UDim2.new(0.5, -14, 0.5, -14);
			BackgroundTransparency = 1;
			Image = "rbxasset://textures/ui/RecordDown.png";
			Parent = stopRecordIconButton;
		};
	
		return CreateMenuItem(stopRecordIconButton)
	end
	-----------------------
	
	local TopBar = CreateTopBar()
	TopBar:GetInstance().Position = UDim2.new(0, 0, 0, 0)
	TopBar:GetInstance().Visible = true
	TopBar:GetInstance().ClipsDescendants = false
	
	-- Keep the shared RobloxGui's inset behavior untouched; SettingsHub and other
	-- 2016 modules live under the same ScreenGui. We only make the topbar itself
	-- responsive instead of forcing IgnoreGuiInset for the whole UI.
	local LeftMenubar = CreateMenuBar(BarAlignmentEnum.Left)
	local RightMenubar = CreateMenuBar(BarAlignmentEnum.Right)
	--local ThreeDMenubar = Create3DMenuBar(BarAlignmentEnum.Left, Topbar3DPanel)
	
	local settingsIcon = CreateSettingsIcon(TopBar)
	
	-- Live Roblox consumes Escape for its own menu before ContextActionService,
	-- so listen directly to UserInputService and intentionally ignore gameProcessedEvent.
	local escapeBusy = false
	
	InputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
		if inputObject.KeyCode ~= Enum.KeyCode.Escape then
			return
		end
	
		if escapeBusy or not settingsIcon then
			return
		end
	
		escapeBusy = true
	
		local isOpen = false
		local okVisibility, visibility = pcall(function()
			return settingsIcon:GetSettingsVisibility()
		end)
	
		if okVisibility then
			isOpen = visibility == true
		end
	
		if isOpen then
			pcall(function()
				settingsIcon:CloseSettings()
			end)
		else
			pcall(function()
				settingsIcon:OpenSettings()
			end)
		end
	
		-- If the modern Roblox Escape menu also tried to open, close it.
		-- This is wrapped because availability/security differs between environments.
		task.defer(function()
			pcall(function()
				GuiService:SetMenuIsOpen(false)
			end)
	
			task.wait(0.15)
			escapeBusy = false
		end)
	end)
	
	local mobileShowChatIcon = Util.IsTouchDevice() and CreateMobileHideChatIcon() or nil
	local chatIcon = CreateChatIcon()
	local backpackIcon = CreateBackpackIcon()
	local stopRecordingIcon = CreateStopRecordIcon()
	
	local leaderstatsMenuItem = CreateLeaderstatsMenuItem()
	local nameAndHealthMenuItem = CreateUsernameHealthMenuItem()
	
	local settingsIcon3D = nil
	local chatIcon3D = nil
	local userGuiIcon3D = nil
	
	local LEFT_ITEM_ORDER = {}
	local RIGHT_ITEM_ORDER = {}
	local THREE_D_ITEM_ORDER = {}
	
	
	-- Set Item Orders
	if settingsIcon then
		LEFT_ITEM_ORDER[settingsIcon] = 1
	end
	if mobileShowChatIcon then
		LEFT_ITEM_ORDER[mobileShowChatIcon] = 2
	end
	if chatIcon then
		LEFT_ITEM_ORDER[chatIcon] = 3
	end
	if backpackIcon then
		LEFT_ITEM_ORDER[backpackIcon] = 4
	end
	if stopRecordingIcon then
		LEFT_ITEM_ORDER[stopRecordingIcon] = 5
	end
	
	if leaderstatsMenuItem then
		RIGHT_ITEM_ORDER[leaderstatsMenuItem] = 1
	end
	if nameAndHealthMenuItem and not isTenFootInterface then
		RIGHT_ITEM_ORDER[nameAndHealthMenuItem] = 2
	end
	
	if settingsIcon3D then
		THREE_D_ITEM_ORDER[settingsIcon3D] = 1
	end
	if chatIcon3D then
		THREE_D_ITEM_ORDER[chatIcon3D] = 2
	end
	if userGuiIcon3D then
		THREE_D_ITEM_ORDER[userGuiIcon3D] = 3
	end
	
	-------------------------
	
	
	local function AddItemInOrder(Bar, Item, ItemOrder)
		local index = 1
		while ItemOrder[Bar:ItemAtIndex(index)] and ItemOrder[Bar:ItemAtIndex(index)] < ItemOrder[Item] do
			index = index + 1
		end
		Bar:AddItem(Item, index)
	end
	
	local function OnCoreGuiChanged(coreGuiType, coreGuiEnabled)
		local enabled = coreGuiEnabled and topbarEnabled
		enabled = true
		if coreGuiType == Enum.CoreGuiType.PlayerList or coreGuiType == Enum.CoreGuiType.All then
			if leaderstatsMenuItem then
				if enabled then
					AddItemInOrder(RightMenubar, leaderstatsMenuItem, RIGHT_ITEM_ORDER)
				else
					RightMenubar:RemoveItem(leaderstatsMenuItem)
				end
			end
		end
		if coreGuiType == Enum.CoreGuiType.Health or coreGuiType == Enum.CoreGuiType.All then
			if nameAndHealthMenuItem then
				nameAndHealthMenuItem:SetHealthbarEnabled(enabled)
			end
		end
		if coreGuiType == Enum.CoreGuiType.Backpack or coreGuiType == Enum.CoreGuiType.All then
			if backpackIcon then
				if enabled then
					AddItemInOrder(LeftMenubar, backpackIcon, LEFT_ITEM_ORDER)
				else
					LeftMenubar:RemoveItem(backpackIcon)
				end
			end
		end
		if coreGuiType == Enum.CoreGuiType.Chat or coreGuiType == Enum.CoreGuiType.All then
			local showTopbarChatIcon = enabled
			local showThree3DChatIcon = coreGuiEnabled and InputService.VREnabled
	
			if showThree3DChatIcon then
				if chatIcon3D then
					AddItemInOrder(ThreeDMenubar, chatIcon3D, THREE_D_ITEM_ORDER)
				end
			else
				if chatIcon3D then
					ThreeDMenubar:RemoveItem(chatIcon3D)
				end
			end
			if showTopbarChatIcon then
				if chatIcon then
					AddItemInOrder(LeftMenubar, chatIcon, LEFT_ITEM_ORDER)
				end
				if mobileShowChatIcon and PlayersService.ClassicChat then
					AddItemInOrder(LeftMenubar, mobileShowChatIcon, LEFT_ITEM_ORDER)
				end
			else
				if chatIcon then
					LeftMenubar:RemoveItem(chatIcon)
				end
				if mobileShowChatIcon then
					LeftMenubar:RemoveItem(mobileShowChatIcon)
				end
			end
		end
	
		if nameAndHealthMenuItem then
			local playerListOn = true
			local healthbarOn = true
			-- Left-align the player's name if either playerlist or healthbar is shown
			nameAndHealthMenuItem:SetNameVisible((playerListOn or healthbarOn) and topbarEnabled)
		end
	end
	
	
	TopBar:UpdateBackgroundTransparency()
	
	LeftMenubar:SetDock(TopBar:GetInstance())
	RightMenubar:SetDock(TopBar:GetInstance())
	--ThreeDMenubar:SetDock(Topbar3DPanel:GetGUI())
	
	
	if not isTenFootInterface then
		Util.SetGUIInsetBounds(0, TOPBAR_THICKNESS, 0, 0)
	end
	
	if settingsIcon then
		AddItemInOrder(LeftMenubar, settingsIcon, LEFT_ITEM_ORDER)
	end
	if nameAndHealthMenuItem and topbarEnabled and not isTenFootInterface then
		AddItemInOrder(RightMenubar, nameAndHealthMenuItem, RIGHT_ITEM_ORDER)
	end
	
	
	-- --------------------------------------------------------------------------
	-- IMPORTANT: PlayerlistModule itself originally returns early on small touch screens.
	-- Use OldRobloxify_PlayerlistModule_MobileEnabled.lua as Modules.PlayerlistModule
	-- or the topbar button will fire correctly but the module will intentionally refuse to open.
	-- -- MOBILE / TOUCH TOPBAR COMPATIBILITY
	-- --------------------------------------------------------------------------
	local function SetBarItemPresent(bar, item, orderTable, shouldBePresent)
		if not item then return end
	
		local existingIndex = bar:IndexOfItem(item)
		if shouldBePresent then
			if not existingIndex then
				AddItemInOrder(bar, item, orderTable)
			end
		else
			if existingIndex then
				bar:RemoveItem(item)
			end
		end
	end
	
	local function ApplyResponsiveTopbarLayout()
		local isTouch = Util.IsTouchDevice()
		local compactTouch = Util.IsCompactTouchDevice()
		local verySmallTouch = Util.IsVerySmallTouchDevice()
		local viewport = Util.GetViewportSize()
	
		-- Keep the classic 36px appearance, but make the available controls
		-- large enough to tap reliably on phones.
		if settingsIcon then
			settingsIcon.Size = UDim2.new(0, isTouch and 52 or 50, 0, TOPBAR_THICKNESS)
		end
		if chatIcon then
			chatIcon.Size = UDim2.new(0, isTouch and 52 or 50, 0, TOPBAR_THICKNESS)
		end
		if backpackIcon then
			backpackIcon.Size = UDim2.new(0, isTouch and 52 or 50, 0, TOPBAR_THICKNESS)
		end
	
		-- Desktop-only information takes a huge amount of horizontal space.
		-- On phones, prioritize controls over username/health/leaderstats.
		if compactTouch then
			-- Keep the username/health item as the mobile Playerlist button.
			-- The previous mobile patch removed BOTH right-side items, which meant
			-- there was no control left that could open the custom 2016 playerlist.
			if nameAndHealthMenuItem and topbarEnabled and not isTenFootInterface then
				nameAndHealthMenuItem.Size = UDim2.new(0, math.min(120, math.max(88, viewport.X * 0.28)), 1, 0)
				nameAndHealthMenuItem:SetNameVisible(true)
				nameAndHealthMenuItem:SetHealthbarEnabled(false)
				SetBarItemPresent(RightMenubar, nameAndHealthMenuItem, RIGHT_ITEM_ORDER, true)
			end
			SetBarItemPresent(RightMenubar, leaderstatsMenuItem, RIGHT_ITEM_ORDER, false)
	
			-- Recording is not useful enough to steal scarce mobile topbar space.
			SetBarItemPresent(LeftMenubar, stopRecordingIcon, LEFT_ITEM_ORDER, false)
	
			-- Settings and Chat always stay available.
			SetBarItemPresent(LeftMenubar, settingsIcon, LEFT_ITEM_ORDER, settingsIcon ~= nil)
			SetBarItemPresent(LeftMenubar, chatIcon, LEFT_ITEM_ORDER, chatIcon ~= nil)
	
			-- On very narrow phones keep Backpack too if there is still room;
			-- three 52px buttons fit comfortably on common phone widths.
			SetBarItemPresent(LeftMenubar, backpackIcon, LEFT_ITEM_ORDER,
				backpackIcon ~= nil and viewport.X >= 260)
		else
			-- Tablet / desktop restores the normal layout.
			if nameAndHealthMenuItem and topbarEnabled and not isTenFootInterface then
				nameAndHealthMenuItem.Size = UDim2.new(0, USERNAME_CONTAINER_WIDTH, 1, 0)
				nameAndHealthMenuItem:SetNameVisible(true)
				nameAndHealthMenuItem:SetHealthbarEnabled(true)
				SetBarItemPresent(RightMenubar, nameAndHealthMenuItem, RIGHT_ITEM_ORDER, true)
			end
	
			SetBarItemPresent(LeftMenubar, settingsIcon, LEFT_ITEM_ORDER, settingsIcon ~= nil)
			SetBarItemPresent(LeftMenubar, chatIcon, LEFT_ITEM_ORDER, chatIcon ~= nil)
			SetBarItemPresent(LeftMenubar, backpackIcon, LEFT_ITEM_ORDER, backpackIcon ~= nil)
		end
	
		LeftMenubar:ArrangeItems()
		RightMenubar:ArrangeItems()
	
		-- Avoid stale selections after rotating/resizing on touch.
		if isTouch then
			pcall(function()
				GuiService.SelectedObject = nil
			end)
		end
	end
	
	ApplyResponsiveTopbarLayout()
	
	-- Mobile can tap the Playerlist control immediately after the topbar appears.
	-- Start loading the old module now so the first tap has a real target.
	if Util.IsTouchDevice() then
		task.defer(function()
			local module = LoadPlayerlistModule()
			if module and leaderstatsMenuItem and leaderstatsMenuItem.AttachPlayerlistModule then
				leaderstatsMenuItem:AttachPlayerlistModule(module)
			end
		end)
	end
	
	-- Re-layout when rotating a phone/tablet or resizing Studio's emulator.
	local viewportConnection = nil
	local function ConnectViewportListener()
		if viewportConnection then
			viewportConnection:Disconnect()
			viewportConnection = nil
		end
	
		local camera = workspace.CurrentCamera
		if camera then
			viewportConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				task.defer(ApplyResponsiveTopbarLayout)
			end)
		end
	end
	
	ConnectViewportListener()
	
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		ConnectViewportListener()
		task.defer(ApplyResponsiveTopbarLayout)
	end)
	
	InputService:GetPropertyChangedSignal("TouchEnabled"):Connect(function()
		task.defer(ApplyResponsiveTopbarLayout)
	end)
	
	if userGuiIcon3D and vr3dGuis then
		local function FindScreenGuiChild(object)
			for _, child in pairs(object:GetChildren()) do
				if child:IsA('ScreenGui') then
					return child
				end
			end
		end
	
		local function onPlayerGuiAdded(playerGui)
			playerGui.ChildAdded:connect(function(child)
				if FindScreenGuiChild(playerGui) then
					AddItemInOrder(ThreeDMenubar, userGuiIcon3D, THREE_D_ITEM_ORDER)
				end
			end)
			playerGui.ChildRemoved:connect(function(child)
				if child:IsA('ScreenGui') and not FindScreenGuiChild(playerGui) then
					ThreeDMenubar:RemoveItem(userGuiIcon3D)
				end
			end)
			if FindScreenGuiChild(playerGui) then
				AddItemInOrder(ThreeDMenubar, userGuiIcon3D, THREE_D_ITEM_ORDER)
			end
		end
		Player.ChildAdded:connect(function(child)
			if child:IsA('PlayerGui') then
				onPlayerGuiAdded(child)
			end
		end)
		if Player:FindFirstChild('PlayerGui') then
			onPlayerGuiAdded(Player:FindFirstChild('PlayerGui'))
		end
	end
	
	
	local function MoveHamburgerTo3D()
		--Topbar3DPanel:SetType(Panel3D.Type.Fixed)
		--Topbar3DPanel:LinkTo("Backpack")
		--Topbar3DPanel:SetVisible(true)
	
		local backpackPanel = Panel3D.Get("Backpack")
		local panelLocalCF = CFrame.Angles(math.rad(5), 0, 0) * CFrame.new(0, -1.625, 0) * CFrame.Angles(math.rad(5), 0, 0)
		--function Topbar3DPanel:PreUpdate(cameraCF, cameraRenderCF, userHeadCF, lookRay)
		--	local panelOriginCF = backpackPanel.localCF or CFrame.new()
		--	self.localCF = panelOriginCF * panelLocalCF
		--end
	
		--function Topbar3DPanel:OnUpdate()
		--	for _, item in pairs(ThreeDMenubar:GetItems()) do
		--		item:SetTransparency(self.transparency)
		--	end
		--end
	
		LeftMenubar:RemoveItem(settingsIcon)
		AddItemInOrder(ThreeDMenubar, settingsIcon3D, THREE_D_ITEM_ORDER)
	end
	
	--local gameOptions = settings():FindFirstChild("Game Options")
	--if gameOptions and not isTenFootInterface then
	--	local success, result = pcall(function()
	--		gameOptions.VideoRecordingChangeRequest:connect(function(recording)
	--			if recording and topbarEnabled then
	--				AddItemInOrder(LeftMenubar, stopRecordingIcon, LEFT_ITEM_ORDER)
	--			else
	--				LeftMenubar:RemoveItem(stopRecordingIcon)
	--			end
	--		end)
	--	end)
	--end
	
	local function topBarEnabledChanged()
		topbarEnabledChangedEvent:Fire(topbarEnabled)
		TopBar:UpdateBackgroundTransparency()
		for _, enumItem in pairs(Enum.CoreGuiType:GetEnumItems()) do
			-- The All enum will be false if any of the coreguis are false
			-- therefore by force updating it we are clobbering the previous sets
			if enumItem ~= Enum.CoreGuiType.All then
				OnCoreGuiChanged(enumItem, true)
			end
		end
	end
	
	local UISChanged;
	local function OnVREnabled(prop)
		--if prop == "VREnabled" and InputService.VREnabled then
		--	VREnabled = true
		--	topbarEnabled = false
		--	MoveHamburgerTo3D()
		--	topBarEnabledChanged()
		--	if UISChanged then
		--		UISChanged:disconnect()
		--		UISChanged = nil
		--	end
		--end
	end
	--UISChanged = InputService.Changed:connect(OnVREnabled)
	--OnVREnabled("VREnabled")
	
	
	local function SetTopbarEnabledCompat(enabled)
		if type(enabled) ~= "boolean" then
			return
		end
		topbarEnabled = enabled
		topBarEnabledChanged()
	end
	
	do
		-- Local fallback API for non-CoreScript environments.
		local api = GuiRoot:FindFirstChild("TopbarEnabled")
		if not api then
			api = Instance.new("BindableFunction")
			api.Name = "TopbarEnabled"
			api.Parent = GuiRoot
		end
		if api:IsA("BindableFunction") then
			api.OnInvoke = function(enabled)
				SetTopbarEnabledCompat(enabled)
				return topbarEnabled
			end
		end
	
		-- Use the historical SetCore API when Roblox permits it.
		pcall(function()
			StarterGui:RegisterSetCore("TopbarEnabled", function(enabled)
				SetTopbarEnabledCompat(enabled)
			end)
		end)
	end
	
	if defeatableTopbar then
		--StarterGui:RegisterSetCore("TopbarEnabled", function(enabled)
		--	if type(enabled) == "boolean" then
		--		topbarEnabled = enabled
		--		topBarEnabledChanged()
		--	end
		--end)
	end
	
	-- Hook-up coregui changing
	--StarterGui.CoreGuiChangedSignal:connect(OnCoreGuiChanged)
	topBarEnabledChanged()
	
	
	-- Load old modules only after the original topbar has been created and docked.
	task.defer(function()
		local module = LoadPlayerlistModule()
		if module and leaderstatsMenuItem and leaderstatsMenuItem.AttachPlayerlistModule then
			leaderstatsMenuItem:AttachPlayerlistModule(module)
		end
	end)
	
	task.defer(function()
		PrepareLegacyCoreCompat()
		LoadTenFootInterface()
		local moduleScript = Modules:FindFirstChild("Chat")
		if moduleScript then
			local module = CompleteChatAPI(SafeRequire(moduleScript, "Chat"))
			if module and chatIcon and chatIcon.AttachChatModule then
				chatIcon:AttachChatModule(module)
			end
			if module and mobileShowChatIcon and mobileShowChatIcon.AttachChatModule then
				mobileShowChatIcon:AttachChatModule(module)
			end
	
			-- Activate the chat UI after gameplay starts so the topbar
			-- effectively becomes the chat interface.
			if module then
				task.spawn(function()
					-- Wait for the game to be running (Play mode / live game)
					while not RunService:IsRunning() do
						task.wait(0.5)
					end
					-- Small grace period after gameplay starts so the chat
					-- doesn't pop in during the loading screen.
					task.wait(2)
	
					pcall(function()
						if type(module.GetVisibility) == "function" and not module:GetVisibility() then
							if type(module.ToggleVisibility) == "function" then
								module:ToggleVisibility()
							end
						end
					end)
	
					-- Sync the chat icon state with the now-visible chat.
					-- On mobile, the chat icon follows focus state (not visibility),
					-- so we skip this override to avoid showing ChatDown when the
					-- keyboard isn't actually active.
					if not Util.IsTouchDevice() then
						if chatIcon and chatIcon.GetChatVisibility then
							local visible = chatIcon:GetChatVisibility()
							if visible and chatIcon.SetImage then
								chatIcon:SetImage("rbxasset://textures/ui/Chat/ChatDown.png")
							end
						end
					end
				end)
			end
		end
	end)
	
	task.defer(function()
		PrepareLegacyCoreCompat()
		LoadTenFootInterface()
		local moduleScript = Modules:FindFirstChild("BackpackScript")
		if moduleScript then
			local module = CompleteBackpackAPI(SafeRequire(moduleScript, "BackpackScript"))
			if module and backpackIcon and backpackIcon.AttachBackpackModule then
				backpackIcon:AttachBackpackModule(module)
			end
		end
	end)
	
	task.defer(function()
		LoadTenFootInterface()
	end)
	
	print("[Topbar] 2016 prototype API compatibility loaded; legacy modules are post-start/lazy")
	
end;
task.spawn(C_3);

return G2L["1"], require;
