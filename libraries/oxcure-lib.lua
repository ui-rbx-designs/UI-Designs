--[[ 
     skidded by github.com/ui-rbx-designs
     ts chatgpt bro :sob:
]]--
--[[ 
     skidded by github.com/ui-rbx-designs
     ts chatgpt bro :sob:
]]--
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local ICONS = {
	sword                  = "rbxassetid://7733765224",
	["person-standing"]    = "rbxassetid://7743871002",
	eye                    = "rbxassetid://7733771982",
	["scan-line"]          = "rbxassetid://8997386772",
	palette                = "rbxassetid://7734021680",
	settings               = "rbxassetid://7734053495",
	["sliders-horizontal"] = "rbxassetid://7734058345",
	home                   = "rbxassetid://7733960981",
	star                   = "rbxassetid://7734068321",
	info                   = "rbxassetid://7733964719",
	target                 = "rbxassetid://7743872758",
	terminal               = "rbxassetid://7743872929",
	save                   = "rbxassetid://7734052335",
	user                   = "rbxassetid://7743875503",
	["alert-triangle"]     = "rbxassetid://7733658504",
	copy                   = "rbxassetid://7733764083",
	zap                    = "rbxassetid://7733771563",
	hash                   = "rbxassetid://7733955906",
	shield                 = "rbxassetid://7734056411",
	layers                 = "rbxassetid://7733965313",
	crosshair              = "rbxassetid://7743872758",
}

local C = {
	BG         = Color3.fromHex("16161b"),
	SIDEBAR    = Color3.fromHex("0f0f13"),
	SURFACE    = Color3.fromHex("0f0f13"),
	BORDER     = Color3.fromHex("232330"),
	ACCENT     = Color3.fromHex("2563eb"),
	ACCENT_DIM = Color3.fromHex("122040"),
	TEXT       = Color3.fromHex("dcdce8"),
	MUTED      = Color3.fromHex("50506a"),
	HOVER      = Color3.fromHex("1c1c26"),
	ACTIVE     = Color3.fromHex("16203e"),
	WHITE      = Color3.fromHex("ffffff"),
	RED        = Color3.fromHex("ff5f57"),
	YELLOW     = Color3.fromHex("febc2e"),
	GREEN      = Color3.fromHex("28c840"),
	TOFF       = Color3.fromHex("252535"),
	TTHUMB     = Color3.fromHex("50506a"),
	TABBAR     = Color3.fromHex("111116"),
	NOTIF_BG   = Color3.fromHex("1a1a22"),
	SUCCESS    = Color3.fromHex("10b981"),
	WARNING    = Color3.fromHex("f59e0b"),
	ERR        = Color3.fromHex("ef4444"),
	DROP_BG    = Color3.fromHex("141419"),
}

local TW = {
	SNAP  = TweenInfo.new(0.1,  Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	FAST  = TweenInfo.new(0.18, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	MED   = TweenInfo.new(0.25, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	OPEN  = TweenInfo.new(0.38, Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
	CLOSE = TweenInfo.new(0.2,  Enum.EasingStyle.Quad,  Enum.EasingDirection.In),
	FULL  = TweenInfo.new(0.3,  Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	SLIDE = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	LOAD  = TweenInfo.new(0.22, Enum.EasingStyle.Quad,  Enum.EasingDirection.InOut),
}

local function tw(o, i, p) TweenService:Create(o, i, p):Play() end

local function newFrame(parent, size, pos, color, name)
	local f = Instance.new("Frame")
	f.Size             = size  or UDim2.new(1,0,1,0)
	f.Position         = pos   or UDim2.new(0,0,0,0)
	f.BackgroundColor3 = color or C.BG
	f.BorderSizePixel  = 0
	f.Name             = name  or "Frame"
	f.Parent           = parent
	return f
end

local function newLabel(parent, text, size, pos, color, fs, bold, name)
	local l = Instance.new("TextLabel")
	l.Size                   = size  or UDim2.new(1,0,0,20)
	l.Position               = pos   or UDim2.new(0,0,0,0)
	l.BackgroundTransparency = 1
	l.Text                   = text  or ""
	l.TextColor3             = color or C.TEXT
	l.TextSize               = fs    or 13
	l.Font                   = bold and Enum.Font.GothamBold or Enum.Font.Gotham
	l.TextXAlignment         = Enum.TextXAlignment.Left
	l.Name                   = name  or "Label"
	l.Parent                 = parent
	return l
end

local function newBtn(parent, text, size, pos, bg, tc, name)
	local b = Instance.new("TextButton")
	b.Size             = size or UDim2.new(1,0,0,30)
	b.Position         = pos  or UDim2.new(0,0,0,0)
	b.BackgroundColor3 = bg   or C.SURFACE
	b.BorderSizePixel  = 0
	b.Text             = text or ""
	b.TextColor3       = tc   or C.TEXT
	b.TextSize         = 13
	b.Font             = Enum.Font.Gotham
	b.TextXAlignment   = Enum.TextXAlignment.Left
	b.AutoButtonColor  = false
	b.Name             = name or "Btn"
	b.Parent           = parent
	return b
end

local function newImg(parent, key, sz)
	local i = Instance.new("ImageLabel")
	i.Size                   = UDim2.new(0, sz or 16, 0, sz or 16)
	i.BackgroundTransparency = 1
	i.Image                  = ICONS[key] or ""
	i.ImageColor3            = C.MUTED
	i.ScaleType              = Enum.ScaleType.Fit
	i.Name                   = "Icon"
	i.Parent                 = parent
	return i
end

local function corn(p, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = p
	return c
end

local function strk(p, col, t)
	local s = Instance.new("UIStroke")
	s.Color           = col or C.BORDER
	s.Thickness       = t   or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent          = p
	return s
end

local function pad(p, t, r, b, l)
	local u = Instance.new("UIPadding")
	u.PaddingTop    = UDim.new(0, t or 0)
	u.PaddingRight  = UDim.new(0, r or 0)
	u.PaddingBottom = UDim.new(0, b or 0)
	u.PaddingLeft   = UDim.new(0, l or 0)
	u.Parent = p
end

local function vlist(p, sp)
	local l = Instance.new("UIListLayout")
	l.FillDirection = Enum.FillDirection.Vertical
	l.Padding       = UDim.new(0, sp or 0)
	l.SortOrder     = Enum.SortOrder.LayoutOrder
	l.Parent        = p
	return l
end

local function hlist(p, sp)
	local l = Instance.new("UIListLayout")
	l.FillDirection = Enum.FillDirection.Horizontal
	l.Padding       = UDim.new(0, sp or 0)
	l.SortOrder     = Enum.SortOrder.LayoutOrder
	l.Parent        = p
	return l
end

local function newScroll(parent)
	local s = Instance.new("ScrollingFrame")
	s.Size                 = UDim2.new(1,0,1,0)
	s.Position             = UDim2.new(0,0,0,0)
	s.BackgroundTransparency = 1
	s.BorderSizePixel      = 0
	s.ScrollBarThickness   = 3
	s.ScrollBarImageColor3 = Color3.fromHex("303040")
	s.CanvasSize           = UDim2.new(0,0,0,0)
	s.AutomaticCanvasSize  = Enum.AutomaticSize.Y
	s.Visible              = false
	s.Name                 = "Scroll"
	s.Parent               = parent
	vlist(s, 6)
	pad(s, 14, 12, 14, 12)
	return s
end

local function newRow(parent, labelText)
	local row = newFrame(parent, UDim2.new(1,0,0,36), nil, C.SURFACE, "Row")
	corn(row, 7)
	strk(row, C.BORDER, 1)
	pad(row, 0, 10, 0, 10)
	local lbl = newLabel(row, labelText, UDim2.new(0.6,0,1,0), nil, C.TEXT, 13)
	lbl.TextYAlignment = Enum.TextYAlignment.Center
	return row
end

local function newToggle(parent, row, default, cb)
	local state = default == true
	local track = newFrame(row, UDim2.new(0,36,0,20), UDim2.new(1,-36,0.5,-10), state and C.ACCENT_DIM or C.TOFF, "Track")
	corn(track, 10)
	local thumb = newFrame(track, UDim2.new(0,14,0,14), UDim2.new(0, state and 19 or 3, 0.5,-7), state and C.ACCENT or C.TTHUMB, "Thumb")
	corn(thumb, 7)
	local hit = newBtn(row, "", UDim2.new(0,36,0,20), UDim2.new(1,-36,0.5,-10), C.SURFACE, C.WHITE, "Hit")
	hit.BackgroundTransparency = 1
	hit.ZIndex = track.ZIndex + 2
	hit.MouseButton1Click:Connect(function()
		state = not state
		tw(track, TW.FAST, {BackgroundColor3 = state and C.ACCENT_DIM or C.TOFF})
		tw(thumb, TW.FAST, {
			Position         = UDim2.new(0, state and 19 or 3, 0.5, -7),
			BackgroundColor3 = state and C.ACCENT or C.TTHUMB,
		})
		if cb then cb(state) end
	end)
end

local function newSlider(scroll, label, minV, maxV, defV, suffix, cb)
	local wrap = newFrame(scroll, UDim2.new(1,0,0,52), nil, C.SURFACE, "Slider")
	corn(wrap, 7)
	strk(wrap, C.BORDER, 1)
	pad(wrap, 8, 10, 8, 10)
	local hdr  = newFrame(wrap, UDim2.new(1,0,0,18), nil, C.SURFACE, "H")
	local lbl  = newLabel(hdr, label, UDim2.new(0.7,0,1,0), nil, C.TEXT, 13)
	lbl.TextYAlignment = Enum.TextYAlignment.Center
	local vLbl = newLabel(hdr, tostring(defV)..(suffix or ""), UDim2.new(0.3,0,1,0), UDim2.new(0.7,0,0,0), C.ACCENT, 13, true, "Val")
	vLbl.TextXAlignment = Enum.TextXAlignment.Right
	local trk  = newFrame(wrap, UDim2.new(1,0,0,4), UDim2.new(0,0,1,-4), Color3.fromHex("222232"), "T")
	corn(trk, 2)
	local fill = newFrame(trk, UDim2.new((defV-minV)/(maxV-minV),0,1,0), nil, C.ACCENT, "F")
	corn(fill, 2)
	local knob = newFrame(trk, UDim2.new(0,14,0,14), UDim2.new((defV-minV)/(maxV-minV),-7,0.5,-7), C.ACCENT, "K")
	corn(knob, 7)
	local dragging = false
	local function update(x)
		local ratio = math.clamp((x - trk.AbsolutePosition.X) / trk.AbsoluteSize.X, 0, 1)
		local val   = math.round(minV + ratio * (maxV - minV))
		fill.Size     = UDim2.new(ratio, 0, 1, 0)
		knob.Position = UDim2.new(ratio, -7, 0.5, -7)
		vLbl.Text     = tostring(val) .. (suffix or "")
		if cb then cb(val) end
	end
	local db = newBtn(trk, "", UDim2.new(1,0,1,14), UDim2.new(0,0,0,-7), C.SURFACE, C.WHITE, "D")
	db.BackgroundTransparency = 1
	db.ZIndex = knob.ZIndex + 2
	db.MouseButton1Down:Connect(function()
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
end

local function newDropdown(scroll, label, opts, def, cb)
	local row  = newRow(scroll, label)
	local sel  = def or opts[1]
	local dBtn = newBtn(row, sel.." >", UDim2.new(0,120,0,24), UDim2.new(1,-120,0.5,-12), C.DROP_BG, C.TEXT, "D")
	dBtn.TextXAlignment = Enum.TextXAlignment.Center
	dBtn.TextSize = 12
	corn(dBtn, 4)
	strk(dBtn, C.BORDER, 1)
	local open, dl = false, nil
	dBtn.MouseButton1Click:Connect(function()
		open = not open
		if open then
			dl = newFrame(row, UDim2.new(0,120,0,#opts*26), UDim2.new(1,-120,1,2), C.DROP_BG, "DL")
			dl.ZIndex = 30
			corn(dl, 5)
			strk(dl, C.BORDER, 1)
			vlist(dl, 0)
			for _, o in ipairs(opts) do
				local it = newBtn(dl, o, UDim2.new(1,0,0,26), nil, C.DROP_BG, C.TEXT, "I")
				it.TextXAlignment = Enum.TextXAlignment.Center
				it.TextSize = 12
				it.ZIndex   = 31
				it.MouseButton1Click:Connect(function()
					sel = o
					dBtn.Text = o .. " >"
					if dl then dl:Destroy() dl = nil end
					open = false
					if cb then cb(o) end
				end)
				it.MouseEnter:Connect(function() tw(it, TW.SNAP, {BackgroundColor3 = C.HOVER})    end)
				it.MouseLeave:Connect(function() tw(it, TW.SNAP, {BackgroundColor3 = C.DROP_BG}) end)
			end
		else
			if dl then dl:Destroy() dl = nil end
		end
	end)
end

local function newMultiDropdown(scroll, label, opts, cb)
	local row      = newRow(scroll, label)
	local selected = {}
	local function countText()
		local n = 0
		for _ in pairs(selected) do n += 1 end
		return (n == 0 and "None" or n .. " Selected") .. " >"
	end
	local dBtn = newBtn(row, countText(), UDim2.new(0,130,0,24), UDim2.new(1,-130,0.5,-12), C.DROP_BG, C.TEXT, "D")
	dBtn.TextXAlignment = Enum.TextXAlignment.Center
	dBtn.TextSize = 12
	corn(dBtn, 4)
	strk(dBtn, C.BORDER, 1)
	local open, dl = false, nil
	dBtn.MouseButton1Click:Connect(function()
		open = not open
		if open then
			local panelH = math.min(#opts, 5) * 28 + 6
			dl = newFrame(row, UDim2.new(0,130,0,panelH), UDim2.new(1,-130,1,2), C.DROP_BG, "MDL")
			dl.ZIndex = 30
			corn(dl, 5)
			strk(dl, C.BORDER, 1)
			vlist(dl, 2)
			pad(dl, 3, 3, 3, 3)
			for _, o in ipairs(opts) do
				local ir = newFrame(dl, UDim2.new(1,0,0,26), nil, C.DROP_BG, "IR")
				ir.ZIndex = 31
				corn(ir, 4)
				local chk = newFrame(ir, UDim2.new(0,14,0,14), UDim2.new(0,6,0.5,-7), selected[o] and C.ACCENT or C.TOFF, "Chk")
				corn(chk, 3)
				chk.ZIndex = 32
				local inner = newFrame(chk, UDim2.new(0,6,0,6), UDim2.new(0.5,0,0.5,0), C.WHITE, "In")
				corn(inner, 2)
				inner.AnchorPoint = Vector2.new(0.5, 0.5)
				inner.ZIndex      = 33
				inner.Visible     = selected[o] == true
				local oLbl = newLabel(ir, o, UDim2.new(1,-28,1,0), UDim2.new(0,26,0,0), C.TEXT, 12)
				oLbl.TextYAlignment = Enum.TextYAlignment.Center
				oLbl.ZIndex         = 32
				local ib = newBtn(ir, "", UDim2.new(1,0,1,0), nil, C.DROP_BG, C.WHITE, "IB")
				ib.BackgroundTransparency = 1
				ib.ZIndex = 33
				ib.MouseEnter:Connect(function() tw(ir, TW.SNAP, {BackgroundColor3 = C.HOVER})    end)
				ib.MouseLeave:Connect(function() tw(ir, TW.SNAP, {BackgroundColor3 = C.DROP_BG}) end)
				ib.MouseButton1Click:Connect(function()
					if selected[o] then
						selected[o] = nil
						tw(chk, TW.SNAP, {BackgroundColor3 = C.TOFF})
						inner.Visible = false
					else
						selected[o] = true
						tw(chk, TW.SNAP, {BackgroundColor3 = C.ACCENT})
						inner.Visible = true
					end
					dBtn.Text = countText()
					if cb then cb(selected) end
				end)
			end
		else
			if dl then dl:Destroy() dl = nil end
		end
	end)
end

local function newColorPicker(scroll, label, defaultHex, cb)
	local hex = defaultHex or "2563eb"
	local r   = tonumber(hex:sub(1,2), 16) / 255
	local g   = tonumber(hex:sub(3,4), 16) / 255
	local b   = tonumber(hex:sub(5,6), 16) / 255
	local row  = newRow(scroll, label)
	local prev = newFrame(row, UDim2.new(0,20,0,20), UDim2.new(1,-24,0.5,-10), Color3.new(r,g,b), "Prev")
	corn(prev, 5)
	strk(prev, C.BORDER, 1)
	local pBtn = newBtn(row, "", UDim2.new(0,20,0,20), UDim2.new(1,-24,0.5,-10), C.SURFACE, C.WHITE, "PBtn")
	pBtn.BackgroundTransparency = 1
	pBtn.ZIndex = prev.ZIndex + 1
	local open, panel = false, nil
	local bigPrev = nil  -- upvalue so refresh() can always reach it

	local function refresh()
		local col = Color3.fromRGB(math.round(r*255), math.round(g*255), math.round(b*255))
		prev.BackgroundColor3 = col
		if bigPrev and bigPrev.Parent then bigPrev.BackgroundColor3 = col end
		if cb then cb(col) end
	end

	local function rgbSlider(parent, ch, val, yPos)
		local bg = newFrame(parent, UDim2.new(1,-16,0,34), UDim2.new(8,0,0,yPos), Color3.fromHex("131318"), "RS")
		corn(bg, 5)
		bg.ZIndex = 32
		local lbL = newLabel(bg, ch, UDim2.new(0,14,0,14), UDim2.new(0,0,0,0), C.MUTED, 10, true, "L")
		lbL.TextXAlignment = Enum.TextXAlignment.Center
		lbL.ZIndex = 33
		local vLbl = newLabel(bg, tostring(math.round(val*255)), UDim2.new(0,30,0,14), UDim2.new(1,-30,0,0), C.ACCENT, 10, true, "V")
		vLbl.TextXAlignment = Enum.TextXAlignment.Right
		vLbl.ZIndex = 33
		local trk = newFrame(bg, UDim2.new(1,-16,0,4), UDim2.new(8,0,0,22), Color3.fromHex("252535"), "T")
		corn(trk, 2)
		trk.ZIndex = 33
		local fill = newFrame(trk, UDim2.new(val,0,1,0), nil, C.ACCENT, "F")
		corn(fill, 2)
		fill.ZIndex = 34
		local knob = newFrame(trk, UDim2.new(0,10,0,10), UDim2.new(val,-5,0.5,-5), C.WHITE, "K")
		corn(knob, 5)
		knob.ZIndex = 35
		local drag2 = false
		local function upd(x)
			local rv = math.clamp((x - trk.AbsolutePosition.X) / trk.AbsoluteSize.X, 0, 1)
			fill.Size     = UDim2.new(rv, 0, 1, 0)
			knob.Position = UDim2.new(rv, -5, 0.5, -5)
			vLbl.Text     = tostring(math.round(rv * 255))
			if ch == "R" then r = rv
			elseif ch == "G" then g = rv
			else b = rv end
			refresh()
		end
		local db = newBtn(trk, "", UDim2.new(1,0,1,12), UDim2.new(0,0,0,-6), C.SURFACE, C.WHITE, "D")
		db.BackgroundTransparency = 1
		db.ZIndex = 36
		db.MouseButton1Down:Connect(function() drag2 = true upd(UserInputService:GetMouseLocation().X) end)
		UserInputService.InputEnded:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then drag2 = false end
		end)
		UserInputService.InputChanged:Connect(function(inp)
			if drag2 and inp.UserInputType == Enum.UserInputType.MouseMovement then upd(inp.Position.X) end
		end)
	end

	pBtn.MouseButton1Click:Connect(function()
		open = not open
		if open then
			panel = newFrame(row, UDim2.new(0,210,0,126), UDim2.new(1,-214,1,2), Color3.fromHex("131318"), "CP")
			panel.ZIndex = 30
			corn(panel, 8)
			strk(panel, C.BORDER, 1)
			bigPrev = newFrame(panel, UDim2.new(0,24,0,24), UDim2.new(1,-30,0,6), prev.BackgroundColor3, "BP")
			corn(bigPrev, 6)
			bigPrev.ZIndex = 31
			rgbSlider(panel, "R", r, 6)
			rgbSlider(panel, "G", g, 44)
			rgbSlider(panel, "B", b, 82)
		else
			if panel then panel:Destroy() panel = nil end
			bigPrev = nil
		end
	end)
end

local notifGui = Instance.new("ScreenGui")
notifGui.Name           = "HubNotifs"
notifGui.ResetOnSpawn   = false
notifGui.DisplayOrder   = 100
notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
notifGui.Parent         = PG

local notifHolder = newFrame(notifGui, UDim2.new(0,280,1,0), UDim2.new(1,-292,0,0), C.BG, "NH")
notifHolder.BackgroundTransparency = 1
local notifLayout = vlist(notifHolder, 8)
notifLayout.VerticalAlignment   = Enum.VerticalAlignment.Bottom
notifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
pad(notifHolder, 0, 0, 12, 0)

local function pushNotif(title, text, duration, accent)
	local notif = Instance.new("CanvasGroup")
	notif.Size              = UDim2.new(1,0,0,72)
	notif.BackgroundColor3  = C.NOTIF_BG
	notif.BorderSizePixel   = 0
	notif.GroupTransparency = 1
	notif.Name              = "Notif"
	notif.Parent            = notifHolder
	corn(notif, 8)
	strk(notif, C.BORDER, 1)

	local bar = newFrame(notif, UDim2.new(0,3,1,0), nil, accent or C.ACCENT, "Bar")
	corn(bar, 0)

	local tLbl = newLabel(notif, title, UDim2.new(1,-46,0,20), UDim2.new(0,14,0,10), C.WHITE, 13, true, "T")
	tLbl.TextYAlignment = Enum.TextYAlignment.Center

	local msgLbl = newLabel(notif, text, UDim2.new(1,-46,0,18), UDim2.new(0,14,0,32), C.MUTED, 12, false, "M")
	msgLbl.TextYAlignment = Enum.TextYAlignment.Center

	local prog = newFrame(notif, UDim2.new(1,0,0,2), UDim2.new(0,0,1,-2), C.BORDER, "Prog")
	local fill = newFrame(prog, UDim2.new(1,0,1,0), nil, accent or C.ACCENT, "Fill")

	local xBtn = newBtn(notif, "x", UDim2.new(0,18,0,18), UDim2.new(1,-24,0,8), C.NOTIF_BG, C.MUTED, "X")
	xBtn.TextSize       = 10
	xBtn.TextXAlignment = Enum.TextXAlignment.Center

	local dismissed = false
	local function dismiss()
		if dismissed then return end
		dismissed = true
		tw(notif, TW.SLIDE, {GroupTransparency = 1})
		task.delay(0.32, function() notif:Destroy() end)
	end

	xBtn.MouseButton1Click:Connect(dismiss)
	tw(notif, TW.SLIDE, {GroupTransparency = 0})
	tw(fill, TweenInfo.new(duration or 3, Enum.EasingStyle.Linear), {Size = UDim2.new(0,0,1,0)})
	task.delay(duration or 3, dismiss)
end

local Lib = {}

function Lib:Window(title, subtitle, key)
	local gui = Instance.new("ScreenGui")
	gui.Name           = "HubGui"
	gui.ResetOnSpawn   = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent         = PG

	local loadCanvas = Instance.new("CanvasGroup")
	loadCanvas.Size             = UDim2.new(0,460,0,82)
	loadCanvas.Position         = UDim2.new(0.5,-230,0.5,-41)
	loadCanvas.BackgroundColor3 = C.SURFACE
	loadCanvas.BorderSizePixel  = 0
	loadCanvas.GroupTransparency = 1
	loadCanvas.Name             = "Load"
	loadCanvas.Parent           = gui
	corn(loadCanvas, 12)
	strk(loadCanvas, C.BORDER, 1)

	newLabel(loadCanvas, title or "Hub", UDim2.new(1,-80,0,36), UDim2.new(0,20,0,8),  C.WHITE, 15, true,  "LT")
	newLabel(loadCanvas, subtitle or "", UDim2.new(1,-80,0,22), UDim2.new(0,20,0,48), C.MUTED, 12, false, "LS")

	local dots = newLabel(loadCanvas, ".", UDim2.new(0,50,0,36), UDim2.new(1,-62,0,8), C.ACCENT, 15, true, "LD")
	dots.TextXAlignment = Enum.TextXAlignment.Right

	local dotThread = task.spawn(function()
		local seq = {".", "..", "..."}
		local i = 1
		while loadCanvas.Parent do
			dots.Text = seq[i]
			i = (i % 3) + 1
			task.wait(0.38)
		end
	end)

	local NORM_W, NORM_H = 700, 500
	local NORM_SIZE = UDim2.new(0, NORM_W, 0, NORM_H)
	local NORM_POS  = UDim2.new(0.5, -NORM_W/2, 0.5, -NORM_H/2)

	local winCanvas = Instance.new("CanvasGroup")
	winCanvas.Size             = UDim2.new(1, 0, 1, 0)
	winCanvas.Position         = UDim2.new(0, 0, 0, 0)
	winCanvas.BackgroundTransparency = 1
	winCanvas.BorderSizePixel  = 0
	winCanvas.GroupTransparency = 1
	winCanvas.Visible          = false
	winCanvas.Name             = "Canvas"
	winCanvas.Parent           = gui

	local win = newFrame(winCanvas, NORM_SIZE, NORM_POS, C.BG, "Win")
	win.ClipsDescendants = true
	corn(win, 14)
	strk(win, C.BORDER, 1)

	local titlebar = newFrame(win, UDim2.new(1,0,0,40), nil, Color3.fromHex("0d0d11"), "TB")

	local titleLbl = newLabel(titlebar, "", UDim2.new(1,-90,1,0), UDim2.new(0,14,0,0), C.MUTED, 12, false, "TL")
	titleLbl.TextYAlignment = Enum.TextYAlignment.Center

	local visible    = true
	local fullscreen = false
	local savedSize, savedPos

	local function doClose()
		tw(winCanvas, TW.CLOSE, {GroupTransparency = 1})
		task.delay(0.25, function() gui:Destroy() end)
	end

	local function doFullscreen()
		if not fullscreen then
			savedSize = win.Size
			savedPos  = win.Position
			tw(win, TW.FULL, {Size = UDim2.new(1,0,1,0), Position = UDim2.new(0,0,0,0)})
		else
			tw(win, TW.FULL, {Size = savedSize, Position = savedPos})
		end
		fullscreen = not fullscreen
	end

	local function doToggle()
		visible = not visible
		if visible then
			winCanvas.Visible = true
			win.Size     = UDim2.new(0, NORM_W*0.95, 0, NORM_H*0.95)
			win.Position = UDim2.new(0.5, -(NORM_W*0.95)/2, 0.5, -(NORM_H*0.95)/2)
			tw(winCanvas, TW.OPEN, {GroupTransparency = 0})
			tw(win, TW.OPEN, {Size = NORM_SIZE, Position = NORM_POS})
		else
			tw(winCanvas, TW.CLOSE, {GroupTransparency = 1})
			task.delay(0.22, function() winCanvas.Visible = false end)
		end
	end

	local function mkLight(col, xOff, fn)
		local dot = newFrame(titlebar, UDim2.new(0,12,0,12), UDim2.new(1,xOff,0.5,-6), col, "TL")
		corn(dot, 6)
		local hit = newBtn(dot, "", UDim2.new(1,0,1,0), nil, col, C.WHITE, "Hit")
		hit.BackgroundTransparency = 1
		hit.ZIndex = dot.ZIndex + 1
		hit.MouseEnter:Connect(function()  tw(dot, TW.SNAP, {BackgroundTransparency = 0.4}) end)
		hit.MouseLeave:Connect(function()  tw(dot, TW.SNAP, {BackgroundTransparency = 0})   end)
		hit.MouseButton1Click:Connect(fn)
	end

	mkLight(C.RED,    -62, doClose)
	mkLight(C.YELLOW, -44, doFullscreen)
	mkLight(C.GREEN,  -26, doToggle)

	local dragging, dragOff = false, Vector2.new()
	local dragHit = newBtn(titlebar, "", UDim2.new(1,-80,1,0), nil, Color3.fromHex("0d0d11"), C.WHITE, "Drag")
	dragHit.BackgroundTransparency = 1
	dragHit.ZIndex = titlebar.ZIndex + 1
	dragHit.MouseButton1Down:Connect(function()
		if fullscreen then return end
		dragging = true
		local m = UserInputService:GetMouseLocation()
		dragOff  = m - Vector2.new(win.AbsolutePosition.X, win.AbsolutePosition.Y)
	end)
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
			local m = UserInputService:GetMouseLocation()
			win.Position = UDim2.new(0, m.X - dragOff.X, 0, m.Y - dragOff.Y)
		end
	end)

	local fps = 0
	RunService.RenderStepped:Connect(function(dt) fps = math.round(1 / dt) end)
	task.spawn(function()
		while gui.Parent do
			titleLbl.Text = (title or "Hub") .. "  |  " .. os.date("%H:%M:%S") .. "  |  " .. fps .. " FPS"
			task.wait(0.2)
		end
	end)

	local toggleKey = key or Enum.KeyCode.K
	UserInputService.InputBegan:Connect(function(inp, gp)
		if gp then return end
		if inp.KeyCode == toggleKey then doToggle() end
	end)

	local sidebar = newFrame(win, UDim2.new(0,144,1,-40), UDim2.new(0,0,0,40), C.SIDEBAR, "Sidebar")
	sidebar.ClipsDescendants = true
	vlist(sidebar, 2)
	pad(sidebar, 8, 0, 8, 0)

	newFrame(win, UDim2.new(0,1,1,-40), UDim2.new(0,144,0,40), C.BORDER, "SBorder")

	local main = newFrame(win, UDim2.new(1,-145,1,-40), UDim2.new(0,145,0,40), C.BG, "Main")

	local pages    = {}
	local activePg = nil

	tw(loadCanvas, TW.LOAD, {GroupTransparency = 0})
	task.delay(1.75, function()
		tw(loadCanvas, TW.LOAD, {GroupTransparency = 1})
		task.delay(0.28, function()
			task.cancel(dotThread)
			loadCanvas:Destroy()
			winCanvas.Visible = true
			win.Size     = UDim2.new(0, NORM_W*0.94, 0, NORM_H*0.94)
			win.Position = UDim2.new(0.5, -(NORM_W*0.94)/2, 0.5, -(NORM_H*0.94)/2)
			tw(winCanvas, TW.OPEN, {GroupTransparency = 0})
			tw(win, TW.OPEN, {Size = NORM_SIZE, Position = NORM_POS})
		end)
	end)

	local winAPI = {}

	function winAPI:Page(name, icon)
		local idx = #pages + 1

		local sBtn = newBtn(sidebar, "", UDim2.new(1,0,0,34), nil, C.SIDEBAR, C.MUTED, "S"..name)
		sBtn.LayoutOrder = idx

		local acc = newFrame(sBtn, UDim2.new(0,2,1,0), nil, C.ACCENT, "Acc")
		acc.BackgroundTransparency = 1
		acc.ZIndex = sBtn.ZIndex + 2

		local ic = newImg(sBtn, icon or "settings", 15)
		ic.Position = UDim2.new(0,12,0.5,-7)

		local nLbl = newLabel(sBtn, name, UDim2.new(1,-34,1,0), UDim2.new(0,34,0,0), C.MUTED, 13)
		nLbl.TextYAlignment = Enum.TextYAlignment.Center

		local content = newFrame(main, UDim2.new(1,0,1,0), nil, C.BG, "C"..name)
		content.Visible = false

		local tabBar = newFrame(content, UDim2.new(1,0,0,36), nil, C.TABBAR, "TabBar")
		tabBar.Visible = false
		newFrame(tabBar, UDim2.new(1,0,0,1), UDim2.new(0,0,1,-1), C.BORDER, "Line")
		hlist(tabBar, 4)
		pad(tabBar, 8, 10, 0, 10)

		local host = newFrame(content, UDim2.new(1,0,1,0), nil, C.BG, "Host")

		local tabList   = {}
		local activeTab = nil

		local function activatePage()
			if activePg then
				local p = activePg
				tw(p.btn,  TW.FAST, {BackgroundColor3 = C.SIDEBAR})
				tw(p.acc,  TW.FAST, {BackgroundTransparency = 1})
				tw(p.lbl,  TW.FAST, {TextColor3 = C.MUTED})
				tw(p.ic,   TW.FAST, {ImageColor3 = C.MUTED})
				p.content.Visible = false
			end
			tw(sBtn, TW.FAST, {BackgroundColor3 = C.ACTIVE})
			tw(acc,  TW.FAST, {BackgroundTransparency = 0})
			tw(nLbl, TW.FAST, {TextColor3 = C.WHITE})
			tw(ic,   TW.FAST, {ImageColor3 = C.WHITE})
			content.Visible = true
			activePg = {btn = sBtn, acc = acc, lbl = nLbl, ic = ic, content = content}
		end

		sBtn.MouseButton1Click:Connect(activatePage)
		sBtn.MouseEnter:Connect(function()
			if not activePg or activePg.btn ~= sBtn then
				tw(sBtn, TW.SNAP, {BackgroundColor3 = C.HOVER})
			end
		end)
		sBtn.MouseLeave:Connect(function()
			if not activePg or activePg.btn ~= sBtn then
				tw(sBtn, TW.SNAP, {BackgroundColor3 = C.SIDEBAR})
			end
		end)

		if idx == 1 then task.defer(activatePage) end
		table.insert(pages, {btn=sBtn, acc=acc, lbl=nLbl, ic=ic, content=content})

		local pageAPI = {}

		function pageAPI:Tab(tabName)
			tabBar.Visible = true
			host.Size      = UDim2.new(1,0,1,-36)
			host.Position  = UDim2.new(0,0,0,36)

			local tBtn = newBtn(tabBar, tabName, UDim2.new(0,88,1,0), nil, C.TABBAR, C.MUTED, "T"..tabName)
			tBtn.TextXAlignment = Enum.TextXAlignment.Center
			tBtn.TextSize       = 12
			tBtn.Font           = Enum.Font.GothamMedium
			tBtn.LayoutOrder    = #tabList + 1

			local ul = newFrame(tBtn, UDim2.new(0,0,0,2), UDim2.new(0.5,0,1,-2), C.ACCENT, "UL")
			ul.AnchorPoint = Vector2.new(0.5, 0)

			local sc = newScroll(host)

			local tabData = {btn = tBtn, ul = ul, scroll = sc}

			local function activateTab()
				if activeTab then
					local pt = activeTab
					tw(pt.btn, TW.FAST, {BackgroundColor3 = C.TABBAR, TextColor3 = C.MUTED})
					tw(pt.ul,  TW.MED,  {Size = UDim2.new(0,0,0,2)})
					pt.scroll.Visible = false
				end
				tw(tBtn, TW.FAST, {BackgroundColor3 = C.BG, TextColor3 = C.WHITE})
				tw(ul,   TW.MED,  {Size = UDim2.new(0.8,0,0,2)})
				sc.Visible = true
				sc.CanvasPosition = Vector2.new(0,0)
				activeTab = tabData
			end

			tBtn.MouseButton1Click:Connect(activateTab)
			tBtn.MouseEnter:Connect(function()
				if activeTab ~= tabData then
					tw(tBtn, TW.SNAP, {BackgroundColor3 = C.HOVER, TextColor3 = C.TEXT})
				end
			end)
			tBtn.MouseLeave:Connect(function()
				if activeTab ~= tabData then
					tw(tBtn, TW.SNAP, {BackgroundColor3 = C.TABBAR, TextColor3 = C.MUTED})
				end
			end)

			if #tabList == 0 then task.defer(activateTab) end
			table.insert(tabList, tabData)

			local tabAPI = {}

			function tabAPI:Section(sectionTitle)
				newLabel(sc, "> " .. string.upper(sectionTitle), UDim2.new(1,0,0,16), nil, C.MUTED, 10, true, "Sec")
			end

			function tabAPI:Toggle(lbl, default, cb)
				local row = newRow(sc, lbl)
				newToggle(sc, row, default, cb)
			end

			function tabAPI:Slider(lbl, mn, mx, def, sfx, cb)
				newSlider(sc, lbl, mn, mx, def, sfx, cb)
			end

			function tabAPI:Dropdown(lbl, opts, def, cb)
				newDropdown(sc, lbl, opts, def, cb)
			end

			function tabAPI:MultiDropdown(lbl, opts, cb)
				newMultiDropdown(sc, lbl, opts, cb)
			end

			function tabAPI:ColorPicker(lbl, defHex, cb)
				newColorPicker(sc, lbl, defHex, cb)
			end

			return tabAPI
		end

		return pageAPI
	end

	function winAPI:Notify(title, text, duration, notifType)
		local accent = C.ACCENT
		if notifType == "success" then accent = C.SUCCESS
		elseif notifType == "warning" then accent = C.WARNING
		elseif notifType == "error"   then accent = C.ERR end
		pushNotif(title, text, duration or 3, accent)
	end

	return winAPI
end

return Lib
