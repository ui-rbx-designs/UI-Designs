--[[ 
     skidded by github.com/ui-rbx-designs
     ts chatgpt bro :sob:
]]--
local Players       = game:GetService("Players")
local TweenService  = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService    = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

local RAW_ICONS = {
	["sword"]              = "rbxassetid://7733765224",
	["person-standing"]    = "rbxassetid://7743871002",
	["eye"]                = "rbxassetid://7733771982",
	["scan-line"]          = "rbxassetid://8997386772",
	["palette"]            = "rbxassetid://7734021680",
	["settings"]           = "rbxassetid://7734053495",
	["sliders-horizontal"] = "rbxassetid://7734058345",
	["home"]               = "rbxassetid://7733960981",
	["star"]               = "rbxassetid://7734068321",
	["info"]               = "rbxassetid://7733964719",
	["target"]             = "rbxassetid://7743872758",
	["terminal"]           = "rbxassetid://7743872929",
	["book-open"]          = "rbxassetid://7733687281",
	["save"]               = "rbxassetid://7734052335",
	["refresh-cw"]         = "rbxassetid://7734051052",
	["shield-check"]       = "rbxassetid://7734056411",
	["user"]               = "rbxassetid://7743875503",
	["alert-triangle"]     = "rbxassetid://7733658504",
	["copy"]               = "rbxassetid://7733764083",
	["log-out"]            = "rbxassetid://7733992677",
	["crosshair"]          = "rbxassetid://7743872758",
	["layers"]             = "rbxassetid://7733965313",
	["cpu"]                = "rbxassetid://7743872929",
	["zap"]                = "rbxassetid://7733771563",
	["check"]              = "rbxassetid://7733715400",
	["search"]             = "rbxassetid://7734052570",
	["hash"]               = "rbxassetid://7733955906",
}

local C = {
	BG         = Color3.fromHex("18181d"),
	SIDEBAR    = Color3.fromHex("101014"),
	SURFACE    = Color3.fromHex("101014"),
	BORDER     = Color3.fromHex("27272f"),
	ACCENT     = Color3.fromHex("2563eb"),
	ACCENT_DIM = Color3.fromHex("162040"),
	TEXT       = Color3.fromHex("dcdce8"),
	MUTED      = Color3.fromHex("55556a"),
	HOVER      = Color3.fromHex("1c1c24"),
	ACTIVE_BG  = Color3.fromHex("172040"),
	WHITE      = Color3.fromHex("ffffff"),
	RED        = Color3.fromHex("ff5f57"),
	YELLOW     = Color3.fromHex("febc2e"),
	GREEN      = Color3.fromHex("28c840"),
	TOFF       = Color3.fromHex("2a2a38"),
	TTHUMB     = Color3.fromHex("55556a"),
	TABBAR     = Color3.fromHex("141418"),
}

local TW = {
	SNAP   = TweenInfo.new(0.12, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	FAST   = TweenInfo.new(0.18, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	MED    = TweenInfo.new(0.26, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	OPEN   = TweenInfo.new(0.38, Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
	CLOSE  = TweenInfo.new(0.24, Enum.EasingStyle.Quad,  Enum.EasingDirection.In),
	SLIDE  = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	FULL   = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
}

local function tw(obj, info, props) TweenService:Create(obj, info, props):Play() end

local function mkCorner(p, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = p
	return c
end

local function mkStroke(p, col, t)
	local s = Instance.new("UIStroke")
	s.Color = col or C.BORDER
	s.Thickness = t or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = p
	return s
end

local function mkPad(p, t, r, b, l)
	local pad = Instance.new("UIPadding")
	pad.PaddingTop    = UDim.new(0, t or 0)
	pad.PaddingRight  = UDim.new(0, r or 0)
	pad.PaddingBottom = UDim.new(0, b or 0)
	pad.PaddingLeft   = UDim.new(0, l or 0)
	pad.Parent = p
end

local function mkVList(p, sp)
	local l = Instance.new("UIListLayout")
	l.FillDirection = Enum.FillDirection.Vertical
	l.Padding = UDim.new(0, sp or 0)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	l.Parent = p
	return l
end

local function mkHList(p, sp)
	local l = Instance.new("UIListLayout")
	l.FillDirection = Enum.FillDirection.Horizontal
	l.Padding = UDim.new(0, sp or 0)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	l.Parent = p
	return l
end

local function mkFrame(p, sz, pos, col, name)
	local f = Instance.new("Frame")
	f.Size = sz or UDim2.new(1,0,1,0)
	f.Position = pos or UDim2.new(0,0,0,0)
	f.BackgroundColor3 = col or C.BG
	f.BorderSizePixel = 0
	f.Name = name or "Frame"
	f.Parent = p
	return f
end

local function mkLabel(p, text, sz, pos, col, fs, bold, name)
	local l = Instance.new("TextLabel")
	l.Size = sz or UDim2.new(1,0,0,20)
	l.Position = pos or UDim2.new(0,0,0,0)
	l.BackgroundTransparency = 1
	l.Text = text or ""
	l.TextColor3 = col or C.TEXT
	l.TextSize = fs or 13
	l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Name = name or "Label"
	l.Parent = p
	return l
end

local function mkBtn(p, text, sz, pos, bg, tc, name)
	local b = Instance.new("TextButton")
	b.Size = sz or UDim2.new(1,0,0,30)
	b.Position = pos or UDim2.new(0,0,0,0)
	b.BackgroundColor3 = bg or C.SURFACE
	b.BorderSizePixel = 0
	b.Text = text or ""
	b.TextColor3 = tc or C.TEXT
	b.TextSize = 13
	b.Font = Enum.Font.Gotham
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.AutoButtonColor = false
	b.Name = name or "Btn"
	b.Parent = p
	return b
end

local function mkIcon(p, key, sz)
	local img = Instance.new("ImageLabel")
	img.Size = UDim2.new(0, sz or 16, 0, sz or 16)
	img.BackgroundTransparency = 1
	img.Image = RAW_ICONS[key] or ""
	img.ImageColor3 = C.MUTED
	img.ScaleType = Enum.ScaleType.Fit
	img.Name = "Icon"
	img.Parent = p
	return img
end

local function mkScroll(p)
	local s = Instance.new("ScrollingFrame")
	s.Size = UDim2.new(1,0,1,0)
	s.BackgroundTransparency = 1
	s.BorderSizePixel = 0
	s.ScrollBarThickness = 3
	s.ScrollBarImageColor3 = C.BORDER
	s.ScrollBarImageTransparency = 0
	s.CanvasSize = UDim2.new(0,0,0,0)
	s.AutomaticCanvasSize = Enum.AutomaticSize.Y
	s.Visible = false
	s.Parent = p
	mkVList(s, 6)
	mkPad(s, 14, 12, 14, 12)
	return s
end

local function mkRow(p, labelText)
	local row = mkFrame(p, UDim2.new(1,0,0,36), nil, C.SURFACE, "Row")
	mkCorner(row, 7)
	mkStroke(row, Color3.fromHex("212128"), 1)
	mkPad(row, 0, 10, 0, 10)
	local lbl = mkLabel(row, labelText, UDim2.new(0.6,0,1,0), nil, C.TEXT, 13)
	lbl.TextYAlignment = Enum.TextYAlignment.Center
	return row
end

local Hub = {}
Hub.__index = Hub

function Hub.new(title, toggleKey)
	local self = setmetatable({}, Hub)
	self._pages     = {}
	self._active    = nil
	self._visible   = true
	self._full      = false
	self._key       = toggleKey or Enum.KeyCode.K
	self._title     = title or "Hub"
	self._normSize  = UDim2.new(0, 660, 0, 480)
	self._normPos   = UDim2.new(0.5, -330, 0.5, -240)

	local gui = Instance.new("ScreenGui")
	gui.Name = "HubGui"
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent = PlayerGui
	self._gui = gui

	local canvas = Instance.new("CanvasGroup")
	canvas.Name = "Canvas"
	canvas.Size = self._normSize
	canvas.Position = self._normPos
	canvas.BackgroundTransparency = 1
	canvas.BorderSizePixel = 0
	canvas.GroupTransparency = 1
	canvas.Parent = gui
	self._canvas = canvas

	local win = mkFrame(canvas, UDim2.new(1,0,1,0), nil, C.BG, "Window")
	win.ClipsDescendants = true
	mkCorner(win, 12)
	mkStroke(win, C.BORDER, 1)
	self._win = win

	local titlebar = mkFrame(win, UDim2.new(1,0,0,38), nil, C.SIDEBAR, "Titlebar")
	self._titlebar = titlebar

	local titleLbl = mkLabel(titlebar, "", UDim2.new(1,-90,1,0), UDim2.new(0,12,0,0), C.MUTED, 12, false, "Title")
	titleLbl.TextYAlignment = Enum.TextYAlignment.Center
	self._titleLbl = titleLbl

	local function trafficLight(col, xOff)
		local dot = mkFrame(titlebar, UDim2.new(0,12,0,12), UDim2.new(1, xOff, 0.5, -6), col, "Dot")
		mkCorner(dot, 6)
		local hitbox = mkBtn(dot, "", UDim2.new(1,0,1,0), nil, col, C.WHITE, "Hit")
		hitbox.BackgroundTransparency = 1
		hitbox.ZIndex = dot.ZIndex + 1
		hitbox.MouseEnter:Connect(function() tw(dot, TW.SNAP, {BackgroundTransparency = 0.4}) end)
		hitbox.MouseLeave:Connect(function() tw(dot, TW.SNAP, {BackgroundTransparency = 0}) end)
		return dot, hitbox
	end

	local _,  redHit    = trafficLight(C.RED,    -60)
	local _,  yellowHit = trafficLight(C.YELLOW, -42)
	local _,  greenHit  = trafficLight(C.GREEN,  -24)

	redHit.MouseButton1Click:Connect(function() self:Close() end)
	yellowHit.MouseButton1Click:Connect(function() self:Fullscreen() end)
	greenHit.MouseButton1Click:Connect(function() self:Toggle() end)

	local dragZone = mkBtn(titlebar, "", UDim2.new(1,-80,1,0), nil, C.SIDEBAR, C.WHITE, "Drag")
	dragZone.BackgroundTransparency = 1
	dragZone.ZIndex = titlebar.ZIndex + 1

	local dragging, dragOff = false, Vector2.new()
	dragZone.MouseButton1Down:Connect(function()
		if self._full then return end
		dragging = true
		local m = UserInputService:GetMouseLocation()
		dragOff = m - Vector2.new(canvas.AbsolutePosition.X, canvas.AbsolutePosition.Y)
	end)
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
			local m = UserInputService:GetMouseLocation()
			canvas.Position = UDim2.new(0, m.X - dragOff.X, 0, m.Y - dragOff.Y)
		end
	end)

	local body = mkFrame(win, UDim2.new(1,0,1,-38), UDim2.new(0,0,0,38), C.BG, "Body")
	body.ClipsDescendants = true
	mkHList(body, 0)
	self._body = body

	local sidebar = mkFrame(body, UDim2.new(0,140,1,0), nil, C.SIDEBAR, "Sidebar")
	sidebar.LayoutOrder = 1
	mkVList(sidebar, 2)
	mkPad(sidebar, 8, 0, 8, 0)
	self._sidebar = sidebar

	local sideBorder = mkFrame(sidebar, UDim2.new(0,1,1,0), UDim2.new(1,-1,0,0), C.BORDER, "Border")
	sideBorder.ZIndex = sidebar.ZIndex + 10

	local main = mkFrame(body, UDim2.new(1,-140,1,0), nil, C.BG, "Main")
	main.LayoutOrder = 2
	main.ClipsDescendants = true
	self._main = main

	local fps = 0
	RunService.RenderStepped:Connect(function(dt)
		fps = math.round(1 / dt)
	end)

	task.spawn(function()
		while gui.Parent do
			local t = os.date("%H:%M:%S")
			titleLbl.Text = self._title .. "  |  " .. t .. "  |  " .. fps .. " FPS"
			task.wait(0.2)
		end
	end)

	UserInputService.InputBegan:Connect(function(inp, gp)
		if gp then return end
		if inp.KeyCode == self._key then self:Toggle() end
	end)

	canvas.Size = UDim2.new(0, self._normSize.X.Offset * 0.94, 0, self._normSize.Y.Offset * 0.94)
	canvas.Position = UDim2.new(
		self._normPos.X.Scale, self._normPos.X.Offset + self._normSize.X.Offset * 0.03,
		self._normPos.Y.Scale, self._normPos.Y.Offset + self._normSize.Y.Offset * 0.03
	)

	task.defer(function()
		tw(canvas, TW.OPEN, {
			GroupTransparency = 0,
			Size = self._normSize,
			Position = self._normPos,
		})
	end)

	return self
end

function Hub:Toggle()
	if self._visible then
		tw(self._canvas, TW.CLOSE, {
			GroupTransparency = 1,
			Size = UDim2.new(0, self._normSize.X.Offset * 0.96, 0, self._normSize.Y.Offset * 0.96),
			Position = UDim2.new(
				self._normPos.X.Scale, self._normPos.X.Offset + self._normSize.X.Offset * 0.02,
				self._normPos.Y.Scale, self._normPos.Y.Offset + self._normSize.Y.Offset * 0.02
			),
		})
		task.delay(0.25, function() self._canvas.Visible = false end)
	else
		self._canvas.Visible = true
		tw(self._canvas, TW.OPEN, {
			GroupTransparency = 0,
			Size = self._normSize,
			Position = self._normPos,
		})
	end
	self._visible = not self._visible
end

function Hub:Fullscreen()
	if not self._full then
		self._savedPos  = self._canvas.Position
		self._savedSize = self._canvas.Size
		tw(self._canvas, TW.FULL, {
			Size     = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
		})
		self._full = true
	else
		tw(self._canvas, TW.FULL, {
			Size     = self._savedSize or self._normSize,
			Position = self._savedPos  or self._normPos,
		})
		self._full = false
	end
end

function Hub:Close()
	tw(self._canvas, TW.CLOSE, {
		GroupTransparency = 1,
		Size = UDim2.new(0, self._normSize.X.Offset * 0.92, 0, self._normSize.Y.Offset * 0.92),
		Position = UDim2.new(
			self._normPos.X.Scale, self._normPos.X.Offset + self._normSize.X.Offset * 0.04,
			self._normPos.Y.Scale, self._normPos.Y.Offset + self._normSize.Y.Offset * 0.04
		),
	})
	task.delay(0.28, function()
		self._gui:Destroy()
	end)
end

function Hub:Page(name, iconKey)
	local idx = #self._pages + 1

	local sideBtn = mkBtn(self._sidebar, "", UDim2.new(1,0,0,34), nil, C.SIDEBAR, C.MUTED, "S_"..name)
	sideBtn.LayoutOrder = idx + 1

	local accent = mkFrame(sideBtn, UDim2.new(0,2,1,0), nil, C.ACCENT, "Acc")
	accent.BackgroundTransparency = 1
	accent.ZIndex = sideBtn.ZIndex + 2

	local ic = mkIcon(sideBtn, iconKey or "settings", 15)
	ic.Position = UDim2.new(0, 12, 0.5, -7)

	local nameLbl = mkLabel(sideBtn, name, UDim2.new(1,-34,1,0), UDim2.new(0,34,0,0), C.MUTED, 13)
	nameLbl.TextYAlignment = Enum.TextYAlignment.Center

	local container = mkFrame(self._main, UDim2.new(1,0,1,0), nil, C.BG, "P_"..name)
	container.Visible = false
	container.ClipsDescendants = true

	local tabBar = mkFrame(container, UDim2.new(1,0,0,38), nil, C.TABBAR, "TabBar")
	tabBar.Visible = false
	mkFrame(tabBar, UDim2.new(1,0,0,1), UDim2.new(0,0,1,-1), C.BORDER, "Line")
	mkHList(tabBar, 4)
	mkPad(tabBar, 8, 10, 0, 10)

	local contentHost = mkFrame(container, UDim2.new(1,0,1,0), nil, C.BG, "Host")
	contentHost.ClipsDescendants = true

	local page = {
		_hub         = self,
		_name        = name,
		_btn         = sideBtn,
		_accent      = accent,
		_icon        = ic,
		_lbl         = nameLbl,
		_container   = container,
		_tabBar      = tabBar,
		_host        = contentHost,
		_tabs        = {},
		_activeTab   = nil,
		_defScroll   = nil,
	}

	local function activatePage(page)
		if self._active then
			local prev = self._active
			tw(prev._btn,    TW.FAST, {BackgroundColor3 = C.SIDEBAR})
			tw(prev._accent, TW.FAST, {BackgroundTransparency = 1})
			tw(prev._lbl,    TW.FAST, {TextColor3 = C.MUTED})
			tw(prev._icon,   TW.FAST, {ImageColor3 = C.MUTED})
			prev._container.Visible = false
		end
		tw(sideBtn,  TW.FAST, {BackgroundColor3 = C.ACTIVE_BG})
		tw(accent,   TW.FAST, {BackgroundTransparency = 0})
		tw(nameLbl,  TW.FAST, {TextColor3 = C.WHITE})
		tw(ic,       TW.FAST, {ImageColor3 = C.WHITE})
		container.Visible = true
		self._active = page
	end

	sideBtn.MouseButton1Click:Connect(function() activatePage(page) end)
	sideBtn.MouseEnter:Connect(function()
		if self._active ~= page then tw(sideBtn, TW.SNAP, {BackgroundColor3 = C.HOVER}) end
	end)
	sideBtn.MouseLeave:Connect(function()
		if self._active ~= page then tw(sideBtn, TW.SNAP, {BackgroundColor3 = C.SIDEBAR}) end
	end)

	if idx == 1 then
		task.defer(function() activatePage(page) end)
	end

	table.insert(self._pages, page)

	local pageAPI = {}

	function pageAPI:Tab(tabName)
		tabBar.Visible = true
		contentHost.Size     = UDim2.new(1,0,1,-38)
		contentHost.Position = UDim2.new(0,0,0,38)

		local tabBtn = mkBtn(tabBar, tabName, UDim2.new(0,86,1,0), nil, C.TABBAR, C.MUTED, "T_"..tabName)
		tabBtn.TextXAlignment = Enum.TextXAlignment.Center
		tabBtn.TextSize = 12
		tabBtn.Font = Enum.Font.GothamMedium
		tabBtn.LayoutOrder = #page._tabs + 1

		local underline = mkFrame(tabBtn, UDim2.new(0,0,0,2), UDim2.new(0.5,0,1,-2), C.ACCENT, "UL")
		underline.AnchorPoint = Vector2.new(0.5,0)

		local scroll = mkScroll(contentHost)

		local tabData = {
			_btn      = tabBtn,
			_ul       = underline,
			_scroll   = scroll,
		}

		local function activateTab(t)
			if page._activeTab then
				local pt = page._activeTab
				tw(pt._btn, TW.FAST, {BackgroundColor3 = C.TABBAR, TextColor3 = C.MUTED})
				tw(pt._ul,  TW.MED,  {Size = UDim2.new(0,0,0,2)})
				pt._scroll.Visible = false
			end
			tw(tabBtn, TW.FAST, {BackgroundColor3 = C.BG, TextColor3 = C.WHITE})
			tw(underline, TW.MED, {Size = UDim2.new(0.78,0,0,2)})
			scroll.Visible = true
			scroll.CanvasPosition = Vector2.new(0,0)
			page._activeTab = t
		end

		tabBtn.MouseButton1Click:Connect(function() activateTab(tabData) end)
		tabBtn.MouseEnter:Connect(function()
			if page._activeTab ~= tabData then
				tw(tabBtn, TW.SNAP, {BackgroundColor3 = C.HOVER, TextColor3 = C.TEXT})
			end
		end)
		tabBtn.MouseLeave:Connect(function()
			if page._activeTab ~= tabData then
				tw(tabBtn, TW.SNAP, {BackgroundColor3 = C.TABBAR, TextColor3 = C.MUTED})
			end
		end)

		if #page._tabs == 0 then
			task.defer(function() activateTab(tabData) end)
		end

		table.insert(page._tabs, tabData)

		local tabAPI = {}

		function tabAPI:Section(title)
			local s = mkLabel(scroll, string.upper(title), UDim2.new(1,0,0,18), nil, C.MUTED, 10, true, "Sec")
			s.LetterSpacing = 1.5
			return s
		end

		function tabAPI:Toggle(lText, default, cb)
			local state = default or false
			local row = mkRow(scroll, lText)

			local track = mkFrame(row, UDim2.new(0,36,0,20), UDim2.new(1,-36,0.5,-10), state and C.ACCENT_DIM or C.TOFF, "Tr")
			mkCorner(track, 10)
			local thumb = mkFrame(track, UDim2.new(0,14,0,14), UDim2.new(0, state and 19 or 3, 0.5,-7), state and C.ACCENT or C.TTHUMB, "Th")
			mkCorner(thumb, 7)

			local hitbox = mkBtn(row, "", UDim2.new(0,36,0,20), UDim2.new(1,-36,0.5,-10), C.SURFACE, C.WHITE, "Hit")
			hitbox.BackgroundTransparency = 1
			hitbox.ZIndex = track.ZIndex + 2

			hitbox.MouseButton1Click:Connect(function()
				state = not state
				tw(track, TW.FAST, {BackgroundColor3 = state and C.ACCENT_DIM or C.TOFF})
				tw(thumb, TW.FAST, {
					Position = UDim2.new(0, state and 19 or 3, 0.5, -7),
					BackgroundColor3 = state and C.ACCENT or C.TTHUMB,
				})
				if cb then cb(state) end
			end)

			return row
		end

		function tabAPI:Slider(lText, minV, maxV, defV, suffix, cb)
			local wrap = mkFrame(scroll, UDim2.new(1,0,0,52), nil, C.SURFACE, "Sl")
			mkCorner(wrap, 7)
			mkStroke(wrap, Color3.fromHex("212128"), 1)
			mkPad(wrap, 8, 10, 8, 10)

			local hdr = mkFrame(wrap, UDim2.new(1,0,0,18), nil, C.SURFACE, "H")
			local lbl2 = mkLabel(hdr, lText, UDim2.new(0.7,0,1,0), nil, C.TEXT, 13)
			lbl2.TextYAlignment = Enum.TextYAlignment.Center
			local vLbl = mkLabel(hdr, tostring(defV)..(suffix or ""), UDim2.new(0.3,0,1,0), UDim2.new(0.7,0,0,0), C.ACCENT, 13, true, "V")
			vLbl.TextXAlignment = Enum.TextXAlignment.Right

			local trk = mkFrame(wrap, UDim2.new(1,0,0,4), UDim2.new(0,0,1,-4), Color3.fromHex("252530"), "T")
			mkCorner(trk, 2)
			local fill = mkFrame(trk, UDim2.new((defV-minV)/(maxV-minV),0,1,0), nil, C.ACCENT, "F")
			mkCorner(fill, 2)
			local knob = mkFrame(trk, UDim2.new(0,14,0,14), UDim2.new((defV-minV)/(maxV-minV),-7,0.5,-7), C.ACCENT, "K")
			mkCorner(knob, 7)

			local dragging = false
			local function update(x)
				local ratio = math.clamp((x - trk.AbsolutePosition.X)/trk.AbsoluteSize.X, 0, 1)
				local val = math.round(minV + ratio*(maxV-minV))
				fill.Size = UDim2.new(ratio,0,1,0)
				knob.Position = UDim2.new(ratio,-7,0.5,-7)
				vLbl.Text = tostring(val)..(suffix or "")
				if cb then cb(val) end
			end

			local dBtn = mkBtn(trk, "", UDim2.new(1,0,1,14), UDim2.new(0,0,0,-7), C.SURFACE, C.WHITE, "D")
			dBtn.BackgroundTransparency = 1
			dBtn.ZIndex = knob.ZIndex + 2
			dBtn.MouseButton1Down:Connect(function()
				dragging = true
				update(UserInputService:GetMouseLocation().X)
			end)
			UserInputService.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
			end)
			UserInputService.InputChanged:Connect(function(inp)
				if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
					update(inp.Position.X)
				end
			end)

			return wrap
		end

		function tabAPI:Dropdown(lText, opts, def, cb)
			local row = mkRow(scroll, lText)
			local sel = def or opts[1]

			local dbtn = mkBtn(row, sel.."  ▾", UDim2.new(0,110,0,24), UDim2.new(1,-110,0.5,-12), Color3.fromHex("1b1b24"), C.TEXT, "D")
			dbtn.TextXAlignment = Enum.TextXAlignment.Center
			dbtn.TextSize = 12
			mkCorner(dbtn, 4)
			mkStroke(dbtn, C.BORDER, 1)

			local open, dList = false, nil

			dbtn.MouseButton1Click:Connect(function()
				open = not open
				if open then
					dList = mkFrame(row, UDim2.new(0,110,0,#opts*26), UDim2.new(1,-110,1,2), Color3.fromHex("1b1b24"), "DL")
					dList.ZIndex = 30
					mkCorner(dList, 5)
					mkStroke(dList, C.BORDER, 1)
					mkVList(dList, 0)

					for _, opt in ipairs(opts) do
						local item = mkBtn(dList, opt, UDim2.new(1,0,0,26), nil, Color3.fromHex("1b1b24"), C.TEXT, "I")
						item.TextSize = 12
						item.TextXAlignment = Enum.TextXAlignment.Center
						item.ZIndex = 31
						item.MouseButton1Click:Connect(function()
							sel = opt
							dbtn.Text = opt.."  ▾"
							dList:Destroy() dList = nil open = false
							if cb then cb(opt) end
						end)
						item.MouseEnter:Connect(function() tw(item, TW.SNAP, {BackgroundColor3 = C.HOVER}) end)
						item.MouseLeave:Connect(function() tw(item, TW.SNAP, {BackgroundColor3 = Color3.fromHex("1b1b24")}) end)
					end
				else
					if dList then dList:Destroy() dList = nil end
				end
			end)

			return row
		end

		function tabAPI:ColorPicker(lText, hexList, cb)
			local row = mkRow(scroll, lText)
			local n = #hexList
			local swWrap = mkFrame(row, UDim2.new(0,n*22,0,20), UDim2.new(1,-(n*22),0.5,-10), C.BG, "SW")
			swWrap.BackgroundTransparency = 1
			mkHList(swWrap, 4)

			local selRing = nil
			for i, hex in ipairs(hexList) do
				local sw = mkFrame(swWrap, UDim2.new(0,16,0,16), nil, Color3.fromHex(hex), "S"..i)
				mkCorner(sw, 8)
				local ring = mkStroke(sw, C.WHITE, 0)
				local sbtn = mkBtn(sw, "", UDim2.new(1,0,1,0), nil, Color3.fromHex(hex), C.WHITE, "B")
				sbtn.BackgroundTransparency = 1
				sbtn.MouseButton1Click:Connect(function()
					if selRing then tw(selRing, TW.FAST, {Thickness=0}) end
					selRing = ring
					tw(ring, TW.FAST, {Thickness=2})
					if cb then cb(hex) end
				end)
				if i==1 then ring.Thickness=2 selRing=ring end
			end

			return row
		end

		return tabAPI
	end

	return pageAPI
end

return Hub
