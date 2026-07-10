local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'All Components Demo',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Basics')

LeftGroupBox:AddToggle('DemoToggle', {
    Text = 'Toggle',
    Default = false,
    Tooltip = 'A basic toggle',
    Callback = function(Value) end
})

LeftGroupBox:AddButton({
    Text = 'Button',
    Func = function() end,
    DoubleClick = false,
    Tooltip = 'A basic button'
})

LeftGroupBox:AddLabel('This is a label')
LeftGroupBox:AddLabel('This label wraps its text across multiple lines when the content is long enough to require it', true)
LeftGroupBox:AddDivider()

LeftGroupBox:AddSlider('DemoSlider', {
    Text = 'Slider',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) end
})

LeftGroupBox:AddInput('DemoInput', {
    Default = '',
    Numeric = false,
    Finished = false,
    Text = 'Textbox',
    Tooltip = 'A text input',
    Placeholder = 'Enter text',
    Callback = function(Value) end
})

LeftGroupBox:AddDropdown('DemoDropdown', {
    Values = { 'Option 1', 'Option 2', 'Option 3' },
    Default = 1,
    Text = 'Dropdown',
    Callback = function(Value) end
})

LeftGroupBox:AddDropdown('DemoMultiDropdown', {
    Values = { 'Item A', 'Item B', 'Item C' },
    Multi = true,
    Default = {},
    Text = 'Multi Dropdown',
    Callback = function(Value) end
})

LeftGroupBox:AddLabel('Color'):AddColorPicker('DemoColorPicker', {
    Default = Color3.fromRGB(255, 0, 0),
    Title = 'Demo Color',
    Transparency = 0,
    Callback = function(Value) end
})

LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('DemoKeyPicker', {
    Default = 'None',
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Demo Keybind',
    Callback = function(Value) end
})

local RightGroupBox = Tabs.Main:AddRightGroupbox('Tabbox')

local TabBox = Tabs.Main:AddRightTabbox()
local InnerTab1 = TabBox:AddTab('Tab 1')
local InnerTab2 = TabBox:AddTab('Tab 2')

InnerTab1:AddToggle('Tab1Toggle', { Text = 'Tab 1 Toggle' })
InnerTab2:AddToggle('Tab2Toggle', { Text = 'Tab 2 Toggle' })

RightGroupBox:AddToggle('ControlToggle', { Text = 'Dependency Box Control' })

local Depbox = RightGroupBox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Sub-dependency Toggle' })

local SubDepbox = Depbox:AddDependencyBox()
SubDepbox:AddSlider('DepboxSlider', { Text = 'Nested Slider', Default = 50, Min = 0, Max = 100, Rounding = 0 })
SubDepbox:AddDropdown('DepboxDropdown', { Text = 'Nested Dropdown', Default = 1, Values = { 'a', 'b', 'c' } })

Library:GetDependencyBox({
    { ['DemoToggle'] = true }
}, {
    RightGroupBox
})

local SettingsGroup = Tabs.Settings:AddLeftGroupbox('Menu')
SettingsGroup:AddButton('Unload', function() Library:Unload() end)
SettingsGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

ThemeManager:SetFolder('LinoriaLibDemo')
SaveManager:SetFolder('LinoriaLibDemo/configs')

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

Library:SetWatermarkVisibility(true)
Library:SetWatermark('LinoriaLib Demo')

Library.ToggleKeybind = Enum.KeyCode.RightControl

Library:OnUnload(function() end)

SaveManager:LoadAutoloadConfig()
