local O = "Accent"
local aa = game:GetService("TweenService")
local p = game:GetService("UserInputService")
local ao = game:GetService("GuiService")
local ab = game:GetService("RunService")
local H = game:GetService("HttpService")
local I = game:GetService("Players")
local J = I.LocalPlayer
local e = {}
e.Flags = {}
e.Windows = {}
local function n(b, c)
	local a = {}
	if type(b) == "string" then
		a.Name = b
	elseif type(b) == "table" then
		for b, c in pairs(b) do
			a[b] = c
		end
	end
	for b, c in pairs(c or {}) do
		if a[c] == nil and a[b] ~= nil then
			a[c] = a[b]
		end
	end
	if a.Range then
		a.Min = a.Min or a.Range[1]
		a.Max = a.Max or a.Range[2]
	end
	return a
end
local ac
local function q(g, b, a, d, h, f)
	a._type = h
	a._frame = d
	a._listeners = a._listeners or {}
	local c = g and g.Window
	if b.Flag then
		e.Flags[b.Flag] = a
		if c then
			c.Flags[b.Flag] = a
			f = f or "Callback"
			local d = b[f]
			b[f] = function(...)
				if type(d) == "function" then
					d(...)
				end
				c:_autoSave()
			end
		end
	end
	function a:Destroy()
		if a._destroyed then
			return
		end
		a._destroyed = true
		for b, a in ipairs(a._listeners) do
			a()
		end
		a._listeners = {}
		if b.Flag then
			if e.Flags[b.Flag] == a then
				e.Flags[b.Flag] = nil
			end
			if c and c.Flags[b.Flag] == a then
				c.Flags[b.Flag] = nil
			end
		end
		if c then
			c._controlsDirty = true
		end
		if d then
			d:Destroy()
		end
	end
	if d then
		ac(a, d, b)
	end
	return a
end
local K = {
	"Background",
	"Surface",
	"Surface2",
	"Surface3",
	"Stroke",
	"StrokeHover",
	O,
	"AccentDark",
	"Text",
	"Muted",
	"Glow",
	"Warning",
	"Success",
	"Error",
}
local function d(a, b, c)
	return Color3.fromRGB(a, b, c)
end
local ap = { Warning = d(244, 184, 96), Success = d(95, 211, 141), Error = d(255, 107, 107) }
local function x(a)
	for b, c in pairs(ap) do
		if a[b] == nil then
			a[b] = c
		end
	end
	return a
end
e.Themes = {
	Default = x({
		Background = d(11, 12, 14),
		Surface = d(16, 17, 20),
		Surface2 = d(21, 23, 26),
		Surface3 = d(33, 36, 41),
		Stroke = d(34, 37, 42),
		StrokeHover = d(58, 63, 70),
		Accent = d(62, 196, 130),
		AccentDark = d(5, 24, 14),
		Text = d(236, 238, 241),
		Muted = d(138, 144, 153),
		Glow = d(150, 232, 190),
	}),
	Mono = x({
		Background = d(11, 12, 14),
		Surface = d(16, 17, 20),
		Surface2 = d(21, 23, 26),
		Surface3 = d(33, 36, 41),
		Stroke = d(34, 37, 42),
		StrokeHover = d(84, 88, 86),
		Accent = d(232, 234, 233),
		AccentDark = d(14, 15, 15),
		Text = d(236, 238, 241),
		Muted = d(138, 144, 153),
		Glow = d(220, 222, 221),
	}),
	Midnight = x({
		Background = d(11, 12, 14),
		Surface = d(16, 17, 20),
		Surface2 = d(21, 23, 26),
		Surface3 = d(33, 36, 41),
		Stroke = d(34, 37, 42),
		StrokeHover = d(58, 86, 116),
		Accent = d(107, 184, 255),
		AccentDark = d(6, 18, 32),
		Text = d(236, 238, 241),
		Muted = d(138, 144, 153),
		Glow = d(190, 220, 255),
	}),
	Moss = x({
		Background = d(11, 12, 14),
		Surface = d(16, 17, 20),
		Surface2 = d(21, 23, 26),
		Surface3 = d(33, 36, 41),
		Stroke = d(34, 37, 42),
		StrokeHover = d(80, 104, 64),
		Accent = d(150, 214, 110),
		AccentDark = d(14, 26, 8),
		Text = d(236, 238, 241),
		Muted = d(138, 144, 153),
		Glow = d(206, 236, 186),
	}),
	Ember = x({
		Background = d(11, 12, 14),
		Surface = d(16, 17, 20),
		Surface2 = d(21, 23, 26),
		Surface3 = d(33, 36, 41),
		Stroke = d(34, 37, 42),
		StrokeHover = d(116, 88, 40),
		Accent = d(255, 178, 26),
		AccentDark = d(30, 18, 0),
		Text = d(236, 238, 241),
		Muted = d(138, 144, 153),
		Glow = d(255, 220, 160),
	}),
	Rose = x({
		Background = d(11, 12, 14),
		Surface = d(16, 17, 20),
		Surface2 = d(21, 23, 26),
		Surface3 = d(33, 36, 41),
		Stroke = d(34, 37, 42),
		StrokeHover = d(116, 64, 78),
		Accent = d(255, 120, 150),
		AccentDark = d(32, 8, 14),
		Text = d(236, 238, 241),
		Muted = d(138, 144, 153),
		Glow = d(255, 200, 214),
	}),
}
e.Theme = table.clone(e.Themes.Default)
e.ThemeName = "Default"
e.Assets = { Shadow = "rbxassetid://6014261993", Glow = "rbxassetid://8992230677", Logo = "triangle" }
e.Assets.ShadowSlice = Rect.new(49, 49, 450, 450)
-- writes a baked base64 png to the workspace folder and returns a custom asset id
local function bake(data, path)
	local ok, id = pcall(function()
		if not (writefile and getcustomasset) then
			return nil
		end
		local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		local map = {}
		for i = 1, 64 do
			map[chars:byte(i)] = i - 1
		end
		local out = table.create(#data // 4)
		for i = 1, #data, 4 do
			local a, b, c, d = data:byte(i, i + 3)
			local v = map[a] * 262144 + map[b] * 4096 + (map[c] or 0) * 64 + (map[d] or 0)
			if not map[c] then
				out[#out + 1] = string.char(v // 65536)
			elseif not map[d] then
				out[#out + 1] = string.char(v // 65536, v // 256 % 256)
			else
				out[#out + 1] = string.char(v // 65536, v // 256 % 256, v % 256)
			end
		end
		if isfolder and makefolder and not isfolder("AstrisUI") then
			makefolder("AstrisUI")
		end
		if not (isfile and isfile(path)) then
			writefile(path, table.concat(out))
		end
		return getcustomasset(path)
	end)
	return ok and id or nil
end
e.Assets.Logo = bake("@@LOGO@@", "AstrisUI/logo_@@LOGOVER@@.png") or e.Assets.Logo
-- soft shadow drawn around a radius 14 rounded rect, so it follows the window corners
do
	local id = bake("@@SHADOW@@", "AstrisUI/shadow_@@SHADOWVER@@.png")
	if id then
		e.Assets.Shadow = id
		e.Assets.ShadowSlice = Rect.new(60, 60, 140, 140)
	end
end
local E
local function P()
	if E ~= nil then
		return E
	end
	local b, a = pcall(function()
		local a =
			game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua")
		return loadstring(a)()
	end)
	if b and type(a) == "table" then
		E = a
	else
		E = false
		warn("[Astris] lucide icons unavailable: " .. tostring(a))
	end
	return E
end
local aq = {
	ValleySans = {
		Regular = "https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-Regular.ttf",
		Medium = "https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-Medium.ttf",
		SemiBold = "https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-SemiBold.ttf",
	},
}
local ad = {
	Regular = { 400, Enum.FontWeight.Regular },
	Medium = { 500, Enum.FontWeight.Medium },
	SemiBold = { 600, Enum.FontWeight.SemiBold },
	Bold = { 700, Enum.FontWeight.Bold },
}
function e:LoadFont(b)
	local f = "function"
	b = n(b, {})
	if type(writefile) ~= f or type(isfile) ~= f or typeof(getcustomasset) ~= f then
		warn("[Astris] custom fonts need writefile, isfile and getcustomasset")
		return false
	end
	local a = b.Name or "CustomFont"
	local g = b.Weights or aq[a]
	if type(g) ~= "table" then
		warn("[Astris] no font weights for " .. a)
		return false
	end
	local d = b.Folder or "AstrisUI/fonts"
	pcall(function()
		if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder(d) then
			makefolder(d)
		end
	end)
	local h = {}
	for b, e in pairs(g) do
		local c = ad[b]
		if c then
			local f, g = d .. "/" .. a .. "-" .. b .. ".ttf", true
			if not isfile(f) then
				g = pcall(function()
					writefile(f, game:HttpGet(e))
				end)
			end
			if g then
				table.insert(h, { name = b, weight = c[1], style = "normal", assetId = getcustomasset(f) })
			else
				warn("[Astris] could not download " .. b .. " weight of " .. a)
			end
		end
	end
	if #h == 0 then
		return false
	end
	local i = d .. "/" .. a .. ".json"
	local j = pcall(function()
		writefile(i, H:JSONEncode({ name = a, faces = h }))
	end)
	if not j then
		return false
	end
	local k = getcustomasset(i)
	local function c(a, c)
		local b = ad[a]
		if b and g[a] then
			return Font.new(k, b[2])
		end
		return c
	end
	e.Fonts.Regular = c("Regular", e.Fonts.Regular)
	e.Fonts.Medium = c("Medium", c("Regular", e.Fonts.Medium))
	e.Fonts.Bold = c("SemiBold", c("Bold", e.Fonts.Bold))
	return true
end
function e:PreloadIcons()
	return P() ~= false
end
local function ar(a)
	if typeof(a) == "table" then
		return a.Image, a.RectOffset, a.RectSize
	end
	if type(a) ~= "string" then
		return nil
	end
	if a:find("^rbxassetid://") or a:find("^rbxasset://") or a:find("^http") then
		return a
	end
	local d = a:gsub("^lucide:", "")
	local b = P()
	if not b then
		return nil
	end
	local c = b.Icons and b.Icons[d] or b[d]
	if type(c) == "table" then
		local a = c.Image
		if type(a) == "number" then
			a = "rbxassetid://" .. tostring(a)
		end
		local d = b.Spritesheets and b.Spritesheets[tostring(a)] or a
		return d, c.ImageRectPosition, c.ImageRectSize
	elseif type(c) == "string" then
		return c
	end
	warn("[Astris] unknown lucide icon: " .. d)
	return nil
end
local Q = "rbxasset://fonts/families/BuilderSans.json"
e.Fonts = {
	Regular = Font.new(Q, Enum.FontWeight.Regular),
	Medium = Font.new(Q, Enum.FontWeight.Medium),
	Bold = Font.new(Q, Enum.FontWeight.SemiBold),
}
local a = e.Theme
local v = e.Assets
local j = e.Fonts
local m = p.TouchEnabled and not p.KeyboardEnabled
e.Touch = m
local R = m and 54 or 48
local y = m and 70 or 64
local S = m and 40 or 34
local t = m and 34 or 28
local ae = {}
local function b(e, f, a, b, c)
	a = a or 0.2
	if a <= 0 then
		for a, b in pairs(f) do
			e[a] = b
		end
		return nil
	end
	b = b or Enum.EasingStyle.Quart
	c = c or Enum.EasingDirection.Out
	local g = a .. b.Name .. c.Name
	local d = ae[g]
	if not d then
		d = TweenInfo.new(a, b, c)
		ae[g] = d
	end
	local h = aa:Create(e, d, f)
	h:Play()
	return h
end
local function c(d, b, c)
	local a = Instance.new(d)
	for b, c in pairs(b) do
		if b ~= "Parent" then
			a[b] = c
		end
	end
	if c then
		for c, b in ipairs(c) do
			b.Parent = a
		end
	end
	if b.Parent then
		a.Parent = b.Parent
	end
	return a
end
local function g(a, b)
	return c("UICorner", { CornerRadius = b or UDim.new(0, 8), Parent = a })
end
local function i(b, d, e, f)
	local s = c(
		"UIStroke",
		{ Color = d or a.Stroke, Transparency = e or 0, Thickness = f or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = b }
	)
	pcall(function()
		s.BorderStrokePosition = Enum.BorderStrokePosition.Inner
	end)
	return s
end
local function o(a, b, d, e, f)
	return c(
		"UIPadding",
		{
			PaddingLeft = UDim.new(0, b or 0),
			PaddingRight = UDim.new(0, d or 0),
			PaddingTop = UDim.new(0, e or 0),
			PaddingBottom = UDim.new(0, f or 0),
			Parent = a,
		}
	)
end
local function f(d)
	local b = {
		BackgroundTransparency = 1,
		TextColor3 = a.Text,
		TextSize = 14,
		FontFace = j.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}
	for a, c in pairs(d) do
		b[a] = c
	end
	return c("TextLabel", b)
end
local function z(d, e, f, g, h)
	local b = c(
		"ImageLabel",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = f,
			Size = e,
			BackgroundTransparency = 1,
			Image = v.Glow,
			ImageColor3 = a.Glow,
			ImageTransparency = g,
			ZIndex = 0,
			Parent = d,
		}
	)
	c(
		"UIGradient",
		{ Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), a.Accent), Rotation = h or 90, Parent = b }
	)
	return b
end
local function T(a)
	return c(
		"Frame",
		{
			Position = UDim2.fromOffset(0, 0),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 0.93,
			BorderSizePixel = 0,
			ZIndex = 0,
			Parent = a,
		}
	)
end
local function u(a, c)
	local b, d, e = ar(c)
	if not b then
		return
	end
	a.Image = b
	a.ImageRectOffset = d or Vector2.zero
	a.ImageRectSize = e or Vector2.zero
end
local function as()
	local b
	pcall(function()
		if typeof(gethui) == "function" then
			b = gethui()
		end
	end)
	if typeof(b) == "Instance" then
		return b
	end
	local a
	pcall(function()
		a = game:GetService("CoreGui")
		local b = Instance.new("Folder")
		b.Parent = a
		b:Destroy()
	end)
	if a then
		return a
	end
	return J:WaitForChild("PlayerGui")
end
local af, ag = nil, Vector2.zero
local function s()
	local a = time()
	if af ~= a then
		af = a
		ag = ao:GetGuiInset()
	end
	return p:GetMouseLocation() - ag
end
local function r(a)
	return a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch
end
local function U(a)
	return a.UserInputType == Enum.UserInputType.MouseMovement or a.UserInputType == Enum.UserInputType.Touch
end
local function A(d, e, f, g)
	local a = c(
		"Frame",
		{ AnchorPoint = Vector2.new(0, 0.5), Position = g, Size = UDim2.fromOffset(16, 16), BackgroundTransparency = 1, Parent = d }
	)
	local b = c(
		"ImageLabel",
		{ Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ImageColor3 = f, ScaleType = Enum.ScaleType.Fit, Parent = a }
	)
	u(b, e)
	return a, b
end
local function ah(j, g, k)
	local h = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(g, 0.5),
			Position = UDim2.new(g, k, 0.5, 0),
			Size = UDim2.fromOffset(18, 18),
			BackgroundTransparency = 1,
			Parent = j,
		}
	)
	local d = {}
	local e = c(
		"ImageLabel",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(16, 16),
			BackgroundTransparency = 1,
			ImageColor3 = a.Muted,
			ScaleType = Enum.ScaleType.Fit,
			Parent = h,
		}
	)
	u(e, "chevron-down")
	if e.Image ~= "" then
		function d:Set(c)
			b(e, { Rotation = c and 180 or 0, ImageColor3 = c and a.Accent or a.Muted }, 0.3, Enum.EasingStyle.Quint)
		end
		return d
	end
	e:Destroy()
	local function i(b, c)
		return f({
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(18, 18),
			Text = "›",
			TextSize = 22,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextColor3 = a.Muted,
			TextTransparency = c,
			Rotation = b,
			Parent = h,
		})
	end
	local l = i(90, 0)
	local m = i(270, 1)
	function d:Set(c)
		b(l, { TextTransparency = c and 1 or 0 }, 0.2)
		b(m, { TextTransparency = c and 0 or 1, TextColor3 = c and a.Accent or a.Muted }, 0.2)
	end
	return d
end
local V = {}
local function at(e, i)
	local f = s()
	local h = math.max(e.AbsoluteSize.X, e.AbsoluteSize.Y) * 2.2
	local d = table.remove(V)
	if not d then
		d = c("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0 })
		g(d, UDim.new(1, 0))
	end
	d.BackgroundColor3 = i or a.Accent
	d.Position = UDim2.fromOffset(f.X - e.AbsolutePosition.X, f.Y - e.AbsolutePosition.Y)
	d.Size = UDim2.fromOffset(0, 0)
	d.BackgroundTransparency = 0.82
	d.ZIndex = e.ZIndex + 1
	d.Parent = e
	b(d, { Size = UDim2.fromOffset(h, h), BackgroundTransparency = 1 }, 0.55)
	task.delay(0.55, function()
		if d.Parent ~= e then
			return
		end
		d.Parent = nil
		if #V < 4 then
			table.insert(V, d)
		else
			d:Destroy()
		end
	end)
end
local function w(c)
	if not c then
		return
	end
	b(c, { Color = a.Accent, Transparency = 0.2 }, 0.08)
	task.delay(0.12, function()
		b(c, { Color = a.Stroke, Transparency = 0 }, 0.35)
	end)
end
local function L(c, d)
	c.MouseEnter:Connect(function()
		b(d, { Color = a.StrokeHover }, 0.12)
	end)
	c.MouseLeave:Connect(function()
		b(d, { Color = a.Stroke }, 0.25)
	end)
end
local au = {
	[Enum.KeyCode.LeftControl] = "LCtrl",
	[Enum.KeyCode.RightControl] = "RCtrl",
	[Enum.KeyCode.LeftShift] = "LShift",
	[Enum.KeyCode.RightShift] = "RShift",
	[Enum.KeyCode.LeftAlt] = "LAlt",
	[Enum.KeyCode.RightAlt] = "RAlt",
	[Enum.KeyCode.Return] = "Enter",
	[Enum.KeyCode.Escape] = "Esc",
	[Enum.KeyCode.Backspace] = "Backspace",
}
local function W(a)
	if a == nil then
		return "None"
	end
	return au[a] or a.Name
end
local function F(a)
	if typeof(a) == "EnumItem" then
		return a
	end
	if type(a) ~= "string" or a == "" or a == "None" then
		return nil
	end
	local b, c = pcall(function()
		return Enum.KeyCode[a]
	end)
	if b then
		return c
	end
	warn("[Astris] unknown key name: " .. a)
	return nil
end
local function l(a, ...)
	if type(a) ~= "function" then
		return
	end
	local b, c = pcall(a, ...)
	if not b then
		warn("[Astris] callback error: " .. tostring(c))
	end
end
local function ai(b, c, a)
	if c < b then
		b, c = c, b
	end
	if not a or a <= 0 then
		a = 1
	end
	local d = 0
	while d < 6 do
		local b = a * 10 ^ d
		if math.abs(b - math.floor(b + 0.5)) < 1e-9 then
			break
		end
		d += 1
	end
	local e = "%." .. d .. "f"
	return {
		snap = function(d)
			d = math.floor(d / a + 0.5) * a
			d = tonumber(string.format(e, d)) or d
			return math.clamp(d, b, c)
		end,
		format = function(a)
			return string.format(e, a)
		end,
	}
end
local function G(e, f, h, k)
	local d = {
		Size = UDim2.new(1, 0, 0, h),
		BackgroundColor3 = a.Surface2,
		BorderSizePixel = 0,
		LayoutOrder = e:_nextOrder(),
		Parent = e.List,
	}
	if f == "TextButton" then
		d.AutoButtonColor = false
		d.Text = ""
	end
	local b = c(f, d)
	b:SetAttribute("NoDrag", true)
	g(b, UDim.new(0, 10))
	local j = i(b, a.Stroke)
	return b, j
end
local function M(b, e, g, c)
	local d, h
	if g then
		local i = (y - 38) / 2
		d =
			f({ Name = "Title", Position = UDim2.fromOffset(14, i), Size = UDim2.new(1, -(14 + c), 0, 18), Text = e, Parent = b })
		h = f({
			Name = "Desc",
			Position = UDim2.fromOffset(14, i + 20),
			Size = UDim2.new(1, -(14 + c), 0, 17),
			Text = g,
			TextSize = 13,
			FontFace = j.Regular,
			TextColor3 = a.Muted,
			Parent = b,
		})
	else
		d =
			f({ Name = "Title", Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -(14 + c), 1, 0), Text = e, Parent = b })
	end
	return d, h
end
local function B(h, a, i, j, c, k)
	a = n(a, i)
	local d = a.Desc and y or R
	local b, e = G(h, j or "Frame", d, a)
	L(b, e)
	local f, g
	if c then
		f, g = M(b, a.Name or k, a.Desc, c)
	end
	return a, b, e, d, f, g
end
local function N(a, b, c)
	if a then
		a.Size = UDim2.new(1, -(14 + c), a.Size.Y.Scale, a.Size.Y.Offset)
	end
	if b then
		b.Size = UDim2.new(1, -(14 + c), 0, b.Size.Y.Offset)
	end
end
ac = function(b, e, h)
	local function j(a)
		return e:FindFirstChild(a, true)
	end
	if b.SetTitle == nil then
		function b:SetTitle(b)
			local a = j("Title")
			if a then
				a.Text = tostring(b)
			end
		end
	end
	if b.SetDesc == nil then
		function b:SetDesc(b)
			local a = j("Desc")
			if a then
				a.Text = tostring(b)
			else
				warn("[Astris] SetDesc needs the element to be created with a Desc")
			end
		end
	end
	b.Visible = true
	function b:SetVisible(a)
		b.Visible = a ~= false
		e.Visible = b.Visible
	end
	b.Locked = false
	local d, k
	function b:SetLocked(h, j)
		b.Locked = h == true
		if b.Locked and type(b.SetOpen) == "function" then
			b:SetOpen(false)
		end
		if not d then
			if not b.Locked then
				return
			end
			d = c(
				"TextButton",
				{
					Name = "Lock",
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = a.Background,
					BackgroundTransparency = 1,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 20,
					Parent = e,
				}
			)
			g(d)
			local h = c(
				"Frame",
				{
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -10, 0.5, 0),
					Size = UDim2.fromOffset(0, t),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = a.Surface,
					BorderSizePixel = 0,
					ZIndex = 21,
					Parent = d,
				}
			)
			g(h, UDim.new(0, 6))
			i(h)
			o(h, 8, 10)
			c(
				"UIListLayout",
				{
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 6),
					Parent = h,
				}
			)
			local j = c(
				"ImageLabel",
				{
					Size = UDim2.fromOffset(14, 14),
					BackgroundTransparency = 1,
					ImageColor3 = a.Muted,
					ScaleType = Enum.ScaleType.Fit,
					LayoutOrder = 1,
					ZIndex = 22,
					Parent = h,
				}
			)
			u(j, "lock")
			k = f({
				Size = UDim2.new(0, 0, 1, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				TextColor3 = a.Muted,
				TextTruncate = Enum.TextTruncate.None,
				LayoutOrder = 2,
				ZIndex = 22,
				Parent = h,
			})
		end
		k.Text = j or "Locked"
		d.Visible = b.Locked
		d.BackgroundTransparency = b.Locked and 0.35 or 1
	end
	if h.Locked then
		b:SetLocked(true, h.LockedReason)
	end
	if h.Visible == false then
		b:SetVisible(false)
	end
end
local k = {}
k.__index = k
function k:_nextOrder()
	self._order += 1
	return self._order
end
function k:Section(b)
	if type(b) == "table" then
		b = b.Name or b.Title or ""
	end
	local d = c(
		"Frame",
		{ Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, LayoutOrder = self:_nextOrder(), Parent = self.List }
	)
	local e = f({
		Position = UDim2.fromOffset(2, 8),
		Size = UDim2.new(0, 0, 0, 16),
		AutomaticSize = Enum.AutomaticSize.X,
		Text = string.upper(b),
		TextSize = 12,
		TextColor3 = a.Muted,
		TextTruncate = Enum.TextTruncate.None,
		Parent = d,
	})
	local h = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 0, 0, 16),
			Size = UDim2.new(1, -12, 0, 1),
			BackgroundColor3 = a.Stroke,
			BorderSizePixel = 0,
			Parent = d,
		}
	)
	local i = self.Window
	local function g()
		h.Size = UDim2.new(1, -(e.AbsoluteSize.X / i.Scale.Scale + 14), 0, 1)
	end
	e:GetPropertyChangedSignal("AbsoluteSize"):Connect(g)
	task.defer(g)
	return q(self, {}, {
		Set = function(b, a)
			e.Text = string.upper(a)
		end,
	}, d, "Section")
end
function k:Divider()
	local b = c(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = a.Stroke,
			BorderSizePixel = 0,
			LayoutOrder = self:_nextOrder(),
			Parent = self.List,
		}
	)
	return q(self, {}, {}, b, "Divider")
end
function k:Label(b)
	b = n(b, { Name = "Text", Title = "Text" })
	local c = f({
		Size = UDim2.new(1, 0, 0, 18),
		Text = b.Text or "",
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = b.Color or a.Muted,
		LayoutOrder = self:_nextOrder(),
		Parent = self.List,
	})
	o(c, 2)
	local d = {
		Set = function(b, a)
			c.Text = tostring(a)
		end,
		Get = function()
			return c.Text
		end,
	}
	if type(b.Update) == "function" then
		local a, e = math.max(tonumber(b.UpdateRate) or 1, 0.05), true
		d._listeners = d._listeners or {}
		table.insert(d._listeners, function()
			e = false
		end)
		task.spawn(function()
			while e and c.Parent do
				local e, d = pcall(b.Update)
				if e and d ~= nil then
					c.Text = tostring(d)
				elseif not e then
					warn("[Astris] label update error: " .. tostring(d))
				end
				task.wait(a)
			end
		end)
		function d:SetUpdateRate(b)
			a = math.max(tonumber(b) or a, 0.05)
		end
	end
	return q(self, b, d, c, "Label")
end
function k:Paragraph(b)
	b = n(b, { Title = "Name" })
	local d = G(self, "Frame", 0, b)
	d.AutomaticSize = Enum.AutomaticSize.Y
	o(d, 14, 14, 11, 12)
	c("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = d })
	f({ Name = "Title", Size = UDim2.new(1, 0, 0, 14), Text = b.Name or "", LayoutOrder = 1, Parent = d })
	local e = f({
		Name = "Content",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = b.Content or "",
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.None,
		TextYAlignment = Enum.TextYAlignment.Top,
		LayoutOrder = 2,
		Parent = d,
	})
	return q(self, b, {
		Set = function(b, a)
			e.Text = tostring(a)
		end,
		Get = function()
			return e.Text
		end,
	}, d, "Paragraph")
end
local av = { Primary = O, Danger = "Error" }
function k:Button(d)
	d = n(d, { Title = "Name", Description = "Desc" })
	local i = av[d.Style]
	local e = i ~= nil
	local j = d.Desc and y or R
	local c, f = G(self, "TextButton", j, d)
	c.ClipsDescendants = true
	if e then
		c.BackgroundColor3 = a[i]
		c.BackgroundTransparency = 0.12
		f.Color = a[i]
		f.Transparency = 0.4
		c.MouseEnter:Connect(function()
			b(c, { BackgroundTransparency = 0 }, 0.12)
			b(f, { Transparency = 0 }, 0.12)
		end)
		c.MouseLeave:Connect(function()
			b(c, { BackgroundTransparency = 0.12 }, 0.25)
			b(f, { Transparency = 0.4 }, 0.25)
		end)
	else
		L(c, f)
	end
	local k, g = e and a.AccentDark or a.Text, 0
	if d.Icon then
		A(c, d.Icon, e and a.AccentDark or a.Accent, UDim2.new(0, 14, 0.5, 0))
		g = 26
	end
	local m = M(c, d.Name or "Button", d.Desc, 30)
	if g > 0 then
		for b, a in ipairs(c:GetChildren()) do
			if a:IsA("TextLabel") then
				a.Position += UDim2.fromOffset(g, 0)
				a.Size -= UDim2.fromOffset(g, 0)
			end
		end
	end
	if e then
		for b, a in ipairs(c:GetChildren()) do
			if a:IsA("TextLabel") then
				a.TextColor3 = k
			end
		end
	end
	A(c, "chevron-right", e and a.AccentDark or a.Muted, UDim2.new(1, -30, 0.5, 0))
	c.MouseButton1Click:Connect(function()
		at(c, e and a.AccentDark or a.Accent)
		l(d.Callback)
	end)
	local h = {}
	function h:SetText(a)
		m.Text = tostring(a)
	end
	h.SetTitle = h.SetText
	return q(self, d, h, c, "Button")
end
function k:Toggle(e)
	local j, n
	e, j, n = B(
		self,
		e,
		{ Title = "Name", Description = "Desc", CurrentValue = "Default", Value = "Default" },
		"TextButton",
		56,
		"Toggle"
	)
	local f = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -14, 0.5, 0),
			Size = m and UDim2.fromOffset(44, 24) or UDim2.fromOffset(36, 20),
			BackgroundColor3 = a.Surface3,
			BorderSizePixel = 0,
			Parent = j,
		}
	)
	g(f, UDim.new(1, 0))
	i(f, a.Stroke)
	local h = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 3, 0.5, 0),
			Size = m and UDim2.fromOffset(18, 18) or UDim2.fromOffset(14, 14),
			BackgroundColor3 = a.Muted,
			BorderSizePixel = 0,
			Parent = f,
		}
	)
	g(h, UDim.new(1, 0))
	local p = c(
		"ImageLabel",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 24, 1, 24),
			BackgroundTransparency = 1,
			Image = v.Glow,
			ImageColor3 = a.Accent,
			ImageTransparency = 1,
			ZIndex = 0,
			Parent = f,
		}
	)
	local d = { Value = e.Default == true }
	local function o(i)
		local e = d.Value
		local g = i and 0.25 or 0
		b(f, { BackgroundColor3 = e and a.Accent or a.Surface3 }, g)
		b(p, { ImageTransparency = e and 0.75 or 1 }, g)
		local c = m and 18 or 14
		b(
			h,
			{ Position = e and UDim2.new(0, (m and 44 or 36) - 3 - c, 0.5, 0) or UDim2.new(0, 3, 0.5, 0) },
			g,
			Enum.EasingStyle.Back
		)
		b(h, { BackgroundColor3 = e and a.AccentDark or a.Muted }, g)
		if i then
			b(h, { Size = UDim2.fromOffset(c + 4, c - 2) }, 0.08)
			task.delay(0.08, function()
				b(h, { Size = UDim2.fromOffset(c, c) }, 0.2, Enum.EasingStyle.Back)
			end)
		end
	end
	local k = false
	function d:Set(a, b)
		a = a == true
		if a == d.Value then
			return
		end
		d.Value = a
		o(true)
		if not k then
			w(n)
		end
		if not b then
			l(e.Callback, a)
		end
	end
	function d:Get()
		return d.Value
	end
	o(false)
	j.MouseButton1Click:Connect(function()
		k = true
		d:Set(not d.Value)
		k = false
	end)
	local r = q(self, e, d, j, "Toggle")
	if d.Value then
		l(e.Callback, true)
	end
	return r
end
function k:Slider(d)
	local B = "Frame"
	d = n(d, { Title = "Name", Description = "Desc", CurrentValue = "Default", Value = "Default", Increment = "Step" })
	local k = math.min(d.Min or 0, d.Max or 100)
	local C = math.max(d.Min or 0, d.Max or 100)
	local W = d.Step or 1
	local H = d.Suffix or ""
	local I = ai(k, C, W)
	local N = y + (d.Desc and 18 or 0)
	local t, Q = G(self, B, N, d)
	L(t, Q)
	f({ Name = "Title", Position = UDim2.fromOffset(14, 12), Size = UDim2.new(1, -120, 0, 18), Text = d.Name or "Slider", Parent = t })
	if d.Desc then
		f({
			Name = "Desc",
			Position = UDim2.fromOffset(14, 31),
			Size = UDim2.new(1, -28, 0, 17),
			Text = d.Desc,
			TextSize = 13,
			FontFace = j.Regular,
			TextColor3 = a.Muted,
			Parent = t,
		})
	end
	local o = c(
		B,
		{
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -10, 0, 9),
			Size = UDim2.fromOffset(40, 24),
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Parent = t,
		}
	)
	g(o, UDim.new(0, 6))
	local J = i(o)
	local z = f({
		Size = UDim2.new(1, 0, 1, 0),
		TextSize = 13,
		TextColor3 = a.Accent,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.None,
		Parent = o,
	})
	local h = c(
		"TextBox",
		{
			Position = UDim2.fromOffset(9, 0),
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Text = "",
			TextColor3 = a.Text,
			TextSize = 13,
			FontFace = j.Medium,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = false,
			Visible = false,
			Parent = o,
		}
	)
	c("UISizeConstraint", { MinSize = Vector2.new(14, 0), Parent = h })
	local K = f({
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		Text = H,
		TextSize = 13,
		TextColor3 = a.Accent,
		TextTruncate = Enum.TextTruncate.None,
		Visible = false,
		Parent = o,
	})
	local D, E =
		c(
			"TextButton",
			{ Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 2, Parent = o }
		),
		false
	local function F(c)
		local a
		if E then
			a = 9 + h.AbsoluteSize.X / self.Window.Scale.Scale + K.TextBounds.X + 9
			K.Position = UDim2.fromOffset(9 + h.AbsoluteSize.X / self.Window.Scale.Scale, 0)
		else
			a = z.TextBounds.X + 18
		end
		a = math.max(a, 36)
		if c then
			o.Size = UDim2.fromOffset(a, 24)
		else
			b(o, { Size = UDim2.fromOffset(a, 24) }, 0.2)
		end
	end
	z:GetPropertyChangedSignal("TextBounds"):Connect(function()
		if not E then
			F(false)
		end
	end)
	h:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if E then
			F(false)
		end
	end)
	local u = c(
		B,
		{
			Position = UDim2.new(0, 14, 0, N - 18),
			Size = UDim2.new(1, -28, 0, 5),
			BackgroundColor3 = a.Surface3,
			BorderSizePixel = 0,
			Parent = t,
		}
	)
	g(u, UDim.new(1, 0))
	local R = c(B, { Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = a.Accent, BorderSizePixel = 0, Parent = u })
	g(R, UDim.new(1, 0))
	local x = c(
		"ImageLabel",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(28, 28),
			BackgroundTransparency = 1,
			Image = v.Glow,
			ImageColor3 = a.Accent,
			ImageTransparency = 0.85,
			ZIndex = 2,
			Parent = u,
		}
	)
	local A = c(
		B,
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(12, 12),
			BackgroundColor3 = a.Accent,
			BorderSizePixel = 0,
			ZIndex = 3,
			Parent = u,
		}
	)
	g(A, UDim.new(1, 0))
	local O = c(
		"TextButton",
		{
			Position = UDim2.new(0, 8, 0, N - (m and 37 or 31)),
			Size = UDim2.new(1, -16, 0, m and 40 or 28),
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			ZIndex = 4,
			Parent = t,
		}
	)
	local e, p = { Value = math.clamp(d.Default or k, k, C) }, false
	D.MouseEnter:Connect(function()
		b(J, { Color = a.StrokeHover }, 0.12)
	end)
	D.MouseLeave:Connect(function()
		if not h:IsFocused() then
			b(J, { Color = a.Stroke }, 0.2)
		end
	end)
	D.MouseButton1Click:Connect(function()
		E = true
		h.Text = I.format(e.Value)
		z.Visible = false
		h.Visible = true
		K.Visible = H ~= ""
		D.Visible = false
		b(J, { Color = a.StrokeHover }, 0.12)
		h:CaptureFocus()
		task.defer(F, false)
	end)
	h.FocusLost:Connect(function()
		local c = tonumber(h.Text)
		E = false
		h.Visible = false
		K.Visible = false
		z.Visible = true
		D.Visible = true
		b(J, { Color = a.Stroke }, 0.2)
		if c then
			e:Set(c)
		end
		F(false)
	end)
	O.MouseEnter:Connect(function()
		if not p then
			b(x, { ImageTransparency = 0.78, Size = UDim2.fromOffset(34, 34) }, 0.15)
		end
	end)
	O.MouseLeave:Connect(function()
		if not p then
			b(x, { ImageTransparency = 0.85, Size = UDim2.fromOffset(28, 28) }, 0.2)
		end
	end)
	local S = I.snap
	local function M()
		return C - k == 0 and 0 or (e.Value - k) / (C - k)
	end
	local function P(c, d, a)
		a = a or Enum.EasingStyle.Linear
		b(R, { Size = UDim2.new(c, 0, 1, 0) }, d, a)
		b(A, { Position = UDim2.new(c, 0, 0.5, 0) }, d, a)
		b(x, { Position = UDim2.new(c, 0, 0.5, 0) }, d, a)
	end
	local function T(a, b)
		P(M(), a, b)
		z.Text = I.format(e.Value) .. H
	end
	local function X(b)
		local a = M()
		local c = math.max(u.AbsoluteSize.X, 1)
		local d = (a >= b and 1 or -1) * (5 / c)
		P(math.clamp(a + d, 0, 1), 0.22, Enum.EasingStyle.Quint)
		task.delay(0.22, function()
			if not p then
				P(M(), 0.18, Enum.EasingStyle.Quint)
			end
		end)
		z.Text = I.format(e.Value) .. H
	end
	local function Y()
		b(A, { Size = UDim2.fromOffset(14, 12) }, 0.08)
		b(x, { Size = UDim2.fromOffset(32, 32), ImageTransparency = 0.78 }, 0.12)
		task.delay(0.1, function()
			b(A, { Size = UDim2.fromOffset(12, 12) }, 0.25, Enum.EasingStyle.Quint)
			b(x, { Size = UDim2.fromOffset(28, 28), ImageTransparency = 0.85 }, 0.25)
		end)
	end
	function e:Set(a, b)
		a = S(tonumber(a) or k)
		if a == e.Value then
			return
		end
		local c = M()
		e.Value = a
		if p then
			T(0.05)
		else
			X(c)
			Y()
			w(Q)
		end
		if not b then
			l(d.Callback, a)
		end
	end
	function e:Get()
		return e.Value
	end
	local function V(b)
		local a = u.AbsoluteSize.X
		if a <= 0 then
			return
		end
		local c = math.clamp((b - u.AbsolutePosition.X) / a, 0, 1)
		e:Set(k + (C - k) * c)
	end
	O.InputBegan:Connect(function(a)
		if r(a) then
			p = true
			b(A, { Size = UDim2.fromOffset(16, 16) }, 0.15, Enum.EasingStyle.Back)
			b(x, { Size = UDim2.fromOffset(44, 44), ImageTransparency = 0.7 }, 0.15)
			V(s().X)
		end
	end)
	self.Window:_listen("Changed", function(a)
		if p and U(a) then
			V(s().X)
		end
	end, e)
	self.Window:_listen("Ended", function(a)
		if p and r(a) then
			p = false
			b(A, { Size = UDim2.fromOffset(12, 12) }, 0.2)
			b(x, { Size = UDim2.fromOffset(28, 28), ImageTransparency = 0.85 }, 0.2)
			l(d.OnRelease, e.Value)
		end
	end, e)
	e.Value = S(e.Value)
	T(0)
	task.defer(F, true)
	return q(self, d, e, t, "Slider")
end
function k:Dropdown(d)
	local y = "Frame"
	d = n(
		d,
		{
			Title = "Name",
			Description = "Desc",
			CurrentOption = "Default",
			Value = "Default",
			MultipleOptions = "Multi",
			Values = "Options",
		}
	)
	if d.Multi and type(d.Default) ~= "table" and d.Default ~= nil then
		d.Default = { d.Default }
	elseif not d.Multi and type(d.Default) == "table" then
		d.Default = d.Default[1]
	end
	local s = d.Multi == true
	local o = d.Options or {}
	local p, L, x
	d, p, L, x = B(self, d, {}, y)
	p.ClipsDescendants = true
	local G = c(
		"TextButton",
		{ Size = UDim2.new(1, 0, 0, x), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Parent = p }
	)
	local T, U = M(G, d.Name or "Dropdown", d.Desc, 180)
	local r = c(
		y,
		{
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(60, t),
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Parent = G,
		}
	)
	g(r, UDim.new(0, 6))
	local V = i(r)
	local H = f({
		Position = UDim2.fromOffset(10, 0),
		Size = UDim2.new(1, -34, 1, 0),
		TextColor3 = a.Muted,
		TextSize = 13,
		TextTruncate = Enum.TextTruncate.None,
		ClipsDescendants = true,
		Parent = r,
	})
	local W = ah(r, 1, -6)
	local z, k =
		f({ Size = UDim2.fromOffset(0, t), AutomaticSize = Enum.AutomaticSize.X, TextSize = 13, Visible = false, Parent = r }),
		""
	local function X()
		z.Text = k
		if z.TextBounds.X <= 146 then
			return k
		end
		local c = utf8.len(k)
		local function d(a)
			if not c then
				return k:sub(1, a)
			end
			return k:sub(1, (utf8.offset(k, a + 1) or #k + 1) - 1)
		end
		local a, b = 0, (c or #k) - 1
		while a < b do
			local c = math.ceil((a + b) / 2)
			z.Text = d(c) .. ".."
			if z.TextBounds.X <= 146 then
				a = c
			else
				b = c - 1
			end
		end
		return d(a) .. ".."
	end
	local function O(c)
		local a = math.clamp(H.TextBounds.X + 10 + 34, 60, 190)
		N(T, U, a + 20)
		if c then
			r.Size = UDim2.fromOffset(a, t)
		else
			b(r, { Size = UDim2.fromOffset(a, t) }, 0.2)
		end
	end
	H:GetPropertyChangedSignal("TextBounds"):Connect(function()
		O(false)
	end)
	local I = c(
		y,
		{ Position = UDim2.new(0, 10, 0, x), Size = UDim2.new(1, -20, 0, 0), BackgroundTransparency = 1, Parent = p }
	)
	c("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = I })
	local e = { Open = false }
	local h = {}
	local m, A = {}, ""
	local Y = d.SearchAfter or 6
	local P = d.Placeholder or "None"
	local v = c(
		y,
		{
			Size = UDim2.new(1, 0, 0, S),
			BackgroundColor3 = a.Surface,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = 0,
			Visible = false,
			Parent = I,
		}
	)
	g(v, UDim.new(0, 6))
	local Z = i(v, a.Stroke, 1)
	local C = c(
		"TextBox",
		{
			Position = UDim2.fromOffset(12, 0),
			Size = UDim2.new(1, -20, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			PlaceholderText = "Search",
			PlaceholderColor3 = a.Muted,
			TextColor3 = a.Text,
			TextSize = 13,
			FontFace = j.Regular,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = false,
			TextTransparency = 1,
			Parent = v,
		}
	)
	local function Q(a)
		return A == "" or string.find(string.lower(tostring(a)), A, 1, true) ~= nil
	end
	if s then
		for b, a in ipairs(d.Default or {}) do
			h[a] = true
		end
	elseif d.Default ~= nil then
		h[d.Default] = true
	end
	local function D()
		if s then
			local a = {}
			for c, b in ipairs(o) do
				if h[b] then
					table.insert(a, b)
				end
			end
			return a
		end
		for b, a in ipairs(o) do
			if h[a] then
				return a
			end
		end
		return nil
	end
	local function E()
		local c = D()
		if s then
			local a = {}
			for b, c in ipairs(c) do
				a[b] = tostring(c)
			end
			k = #a > 0 and table.concat(a, ", ") or P
		else
			k = c ~= nil and tostring(c) or P
		end
		H.Text = X()
		for f, d in pairs(m) do
			local c = h[f] == true
			if d.On ~= c then
				d.On = c
				b(d.Label, { TextColor3 = c and a.Text or a.Muted }, 0.15)
				if e.Open then
					b(d.Check, { ImageTransparency = c and 0 or 1 }, 0.15)
					b(
						d.CheckScale,
						{ Scale = c and 1 or 0.6 },
						c and 0.3 or 0.15,
						c and Enum.EasingStyle.Back or Enum.EasingStyle.Quint
					)
				end
			end
		end
	end
	local function aa()
		local a = 0
		for c, b in ipairs(o) do
			if Q(b) then
				a += 1
			end
		end
		return a
	end
	local function J()
		for a, b in pairs(m) do
			b.Frame.Visible = Q(a)
		end
	end
	local function K()
		local a = aa() + (v.Visible and 1 or 0)
		return x + a * (S + 4) + 8
	end
	local function F(c)
		e.Open = c
		v.Visible = #o > Y
		if not c then
			A = ""
			C.Text = ""
			J()
		end
		b(p, { Size = UDim2.new(1, 0, 0, c and K() or x) }, 0.3, Enum.EasingStyle.Quint)
		b(v, { BackgroundTransparency = c and 0 or 1 }, 0.2)
		b(Z, { Transparency = c and 0 or 1 }, 0.2)
		b(C, { TextTransparency = c and 0 or 1 }, 0.2)
		W:Set(c)
		b(V, { Color = c and a.StrokeHover or a.Stroke }, 0.2)
		local function d(d)
			if not d.Stroke then
				d.Stroke = i(d.Frame, a.Stroke, 1)
			end
			local e = c and d.On
			b(d.Check, { ImageTransparency = e and 0 or 1 }, 0.18)
			d.CheckScale.Scale = e and 1 or 0.6
			b(d.Label, { TextTransparency = c and 0 or 1 }, 0.18)
			b(d.Stroke, { Transparency = c and 0 or 1 }, 0.18)
			b(d.Frame, { BackgroundTransparency = c and 0 or 1 }, 0.18)
		end
		if c then
			local a = (e._openGeneration or 0) + 1
			e._openGeneration = a
			task.spawn(function()
				local b = true
				for g, f in ipairs(o) do
					local c = m[f]
					if c and c.Frame.Visible then
						if not b then
							task.wait(0.025)
							if e._openGeneration ~= a or not e.Open then
								return
							end
						end
						b = false
						d(c)
					end
				end
			end)
		else
			local b = (e._openGeneration or 0) + 1
			e._openGeneration = b
			local a = {}
			for d, c in ipairs(o) do
				local b = m[c]
				if b and b.Frame.Visible then
					table.insert(a, b)
				end
			end
			task.spawn(function()
				for c = #a, 1, -1 do
					d(a[c])
					if c > 1 then
						task.wait(0.015)
						if e._openGeneration ~= b or e.Open then
							return
						end
					end
				end
			end)
		end
	end
	local function R()
		local i = {}
		for a, b in ipairs(o) do
			i[b] = a
		end
		for a, b in pairs(m) do
			if not i[a] then
				b.Frame:Destroy()
				m[a] = nil
			end
		end
		for n, e in ipairs(o) do
			local o = m[e]
			if o then
				o.Frame.LayoutOrder = n
				continue
			end
			local i = c(
				"TextButton",
				{
					Size = UDim2.new(1, 0, 0, S),
					BackgroundColor3 = a.Surface,
					BackgroundTransparency = 1,
					Text = "",
					AutoButtonColor = false,
					LayoutOrder = n,
					Parent = I,
				}
			)
			g(i, UDim.new(0, 6))
			local j = c(
				"ImageLabel",
				{
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -10, 0.5, 0),
					Size = UDim2.fromOffset(14, 14),
					BackgroundTransparency = 1,
					ImageColor3 = a.Accent,
					ImageTransparency = 1,
					ScaleType = Enum.ScaleType.Fit,
					Parent = i,
				}
			)
			u(j, "check")
			local p = c("UIScale", { Scale = 0.6, Parent = j })
			local k = f({
				Position = UDim2.fromOffset(12, -1),
				Size = UDim2.new(1, -36, 1, 0),
				Text = tostring(e),
				TextSize = 13,
				TextColor3 = a.Muted,
				TextTransparency = 1,
				Parent = i,
			})
			i.MouseEnter:Connect(function()
				b(k, { TextColor3 = a.Text }, 0.15)
				local c = m[e]
				if c and c.Stroke then
					b(c.Stroke, { Color = a.StrokeHover }, 0.12)
				end
			end)
			i.MouseLeave:Connect(function()
				b(k, { TextColor3 = h[e] and a.Text or a.Muted }, 0.2)
				local c = m[e]
				if c and c.Stroke then
					b(c.Stroke, { Color = a.Stroke }, 0.2)
				end
			end)
			i.MouseButton1Click:Connect(function()
				if h[e] then
					h[e] = nil
				else
					if not s then
						h = {}
					end
					h[e] = true
				end
				E()
				l(d.Callback, D())
				if not s and h[e] then
					F(false)
				end
			end)
			m[e] = { Frame = i, Label = k, Check = j, CheckScale = p, Stroke = nil, On = nil }
		end
		J()
		if e.Open then
			p.Size = UDim2.new(1, 0, 0, K())
		end
	end
	function e:Set(a, b)
		h = {}
		if s then
			for b, a in ipairs(type(a) == "table" and a or { a }) do
				h[a] = true
			end
		elseif a ~= nil then
			h[a] = true
		end
		E()
		w(L)
		if not b then
			l(d.Callback, D())
		end
	end
	function e:Get()
		return D()
	end
	function e:Refresh(a, b)
		o = a or {}
		if not b then
			h = {}
		end
		R()
		E()
		if e.Open then
			F(true)
		end
	end
	function e:SetOpen(a)
		F(a == true)
	end
	G.MouseButton1Click:Connect(function()
		F(not e.Open)
	end)
	C:GetPropertyChangedSignal("Text"):Connect(function()
		A = string.lower(C.Text)
		J()
		if e.Open then
			b(p, { Size = UDim2.new(1, 0, 0, K()) }, 0.2, Enum.EasingStyle.Quint)
		end
	end)
	R()
	E()
	task.defer(O, true)
	return q(self, d, e, p, "Dropdown")
end
function k:Input(e)
	local k, s, x, t, u
	e, k, s, x, t, u = B(
		self,
		e,
		{ Title = "Name", Description = "Desc", PlaceholderText = "Placeholder", CurrentValue = "Default", Value = "Default" },
		"Frame",
		160,
		"Input"
	)
	local f = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(170, 30),
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			Parent = k,
		}
	)
	g(f, UDim.new(0, 6))
	local v = i(f)
	local m = e.Icon
	if m then
		A(f, m, a.Muted, UDim2.new(0, 8, 0.5, 0))
	end
	local o = tonumber(e.MaxLength)
	local function p(a)
		a = tostring(a or "")
		if o and #a > o then
			return a:sub(1, o)
		end
		return a
	end
	local d = c(
		"TextBox",
		{
			Position = UDim2.fromOffset(m and 30 or 8, 0),
			Size = UDim2.new(1, m and -38 or -16, 1, 0),
			BackgroundTransparency = 1,
			Text = p(e.Default),
			PlaceholderText = e.Placeholder or "",
			PlaceholderColor3 = a.Muted,
			TextColor3 = a.Text,
			TextSize = 14,
			FontFace = j.Regular,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = e.ClearOnFocus == true,
			TextTruncate = Enum.TextTruncate.None,
			ClipsDescendants = true,
			Parent = f,
		}
	)
	f.ClipsDescendants = true
	local r = false
	local y = (m and 30 or 8) + 8
	local function h(g)
		local h = k.AbsoluteSize.X / self.Window.Scale.Scale
		local c = math.clamp(h - 14 - 110 - 20, 100, 200)
		local i = d.Text
		local e = d.TextBounds.X
		if #i == 0 then
			e = math.min(d.TextBounds.X, 90)
		end
		local a = math.clamp(e + y + 12, 90, c) + (r and 8 or 0)
		a = math.min(a, c + 8)
		N(t, u, a + 20)
		if g then
			f.Size = UDim2.fromOffset(a, 30)
		else
			b(f, { Size = UDim2.fromOffset(a, 30) }, 0.18)
		end
	end
	k:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		h(true)
	end)
	d:GetPropertyChangedSignal("Text"):Connect(function()
		local a = p(d.Text)
		if a ~= d.Text then
			d.Text = a
			return
		end
		h(false)
		if d:IsFocused() then
			l(e.OnChanged, d.Text)
		end
	end)
	d:GetPropertyChangedSignal("TextBounds"):Connect(function()
		h(false)
	end)
	task.defer(h, true)
	d.Focused:Connect(function()
		r = true
		b(v, { Color = a.StrokeHover }, 0.15)
		h(false)
	end)
	d.FocusLost:Connect(function(c)
		r = false
		b(v, { Color = a.Stroke }, 0.15)
		h(false)
		if e.Numeric and not tonumber(d.Text) then
			d.Text = ""
			return
		end
		l(e.Callback, d.Text, c)
	end)
	local n = {}
	function n:Set(a, b)
		d.Text = p(a)
		w(s)
		if not b then
			l(e.Callback, d.Text, false)
		end
	end
	function n:Get()
		return d.Text
	end
	function n:SetPlaceholder(a)
		d.PlaceholderText = tostring(a)
	end
	return q(self, e, n, k, "Input")
end
function k:Keybind(e)
	local n, o, y, r, s
	e, n, o, y, r, s = B(
		self,
		e,
		{ Title = "Name", Description = "Desc", CurrentKeybind = "Default", Value = "Default" },
		"Frame",
		110,
		"Keybind"
	)
	e.Default = F(e.Default)
	local u = e.Mode == "Hold"
	local h = c(
		"TextButton",
		{
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(44, t),
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			ClipsDescendants = true,
			Parent = n,
		}
	)
	g(h, UDim.new(0, 6))
	local z = i(h)
	local k = f({
		Size = UDim2.new(1, 0, 1, 0),
		TextSize = 13,
		TextColor3 = a.Muted,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.None,
		Parent = h,
	})
	local d = { Value = e.Default, Listening = false, Held = false }
	local function v(c)
		local a = math.max(k.TextBounds.X + 20, m and 44 or 36)
		N(r, s, a + 20)
		if c then
			h.Size = UDim2.fromOffset(a, t)
		else
			b(h, { Size = UDim2.fromOffset(a, t) }, 0.2)
		end
	end
	k:GetPropertyChangedSignal("TextBounds"):Connect(function()
		v(false)
	end)
	local function j()
		k.Text = d.Listening and "..." or W(d.Value)
		b(z, { Color = d.Listening and a.StrokeHover or a.Stroke }, 0.15)
		b(k, { TextColor3 = d.Listening and a.Accent or a.Muted }, 0.15)
	end
	local function x()
		if d.Held then
			d.Held = false
			l(e.Callback, false)
		end
	end
	function d:Set(a, b)
		local c = d.Listening
		x()
		a = F(a)
		d.Value = a
		d.Listening = false
		j()
		if not c then
			w(o)
		end
		if not b then
			l(e.OnChanged, a)
		end
	end
	h.MouseButton1Click:Connect(function()
		d.Listening = not d.Listening
		j()
	end)
	self.Window:_listen("Began", function(a, b)
		if a.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end
		if d.Listening and p:GetFocusedTextBox() then
			d.Listening = false
			j()
			return
		end
		if d.Listening then
			self.Window._consumedKey = a.KeyCode
			self.Window._consumedAt = os.clock()
			if a.KeyCode == Enum.KeyCode.Escape then
				d.Listening = false
				j()
			elseif a.KeyCode == Enum.KeyCode.Backspace or a.KeyCode == Enum.KeyCode.Delete then
				d:Set(nil)
			else
				d:Set(a.KeyCode)
			end
			return
		end
		if b or d.Locked or d.Value == nil or a.KeyCode ~= d.Value then
			return
		end
		if u then
			d.Held = true
			l(e.Callback, true)
		else
			l(e.Callback, a.KeyCode)
		end
	end, d)
	if u then
		self.Window:_listen("Ended", function(a)
			if a.KeyCode == d.Value then
				x()
			end
		end, d)
	end
	j()
	task.defer(v, true)
	function d:Get()
		return d.Value
	end
	return q(self, e, d, n, "Keybind", "OnChanged")
end
function k:ColorPicker(h)
	local F, k, G, H = "Default", "Frame", "TextButton", "UIGradient"
	local m, K, v
	h, m, K, v = B(self, h, { Title = "Name", Description = "Desc", Color = F, CurrentValue = F, Value = F }, k)
	m.ClipsDescendants = true
	local A = c(
		G,
		{ Size = UDim2.new(1, 0, 0, v), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Parent = m }
	)
	M(A, h.Name or "Color", h.Desc, 90)
	local C = c(
		k,
		{
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -34, 0.5, 0),
			Size = UDim2.fromOffset(36, 20),
			BorderSizePixel = 0,
			Parent = A,
		}
	)
	C:SetAttribute("AstrisNoTheme", true)
	g(C, UDim.new(0, 6))
	i(C, a.Stroke)
	local S = ah(A, 1, -12)
	local n = c(
		k,
		{ Position = UDim2.fromOffset(14, v + 2), Size = UDim2.new(1, -28, 0, 156), BackgroundTransparency = 1, Visible = false, Parent = m }
	)
	local e = c(
		G,
		{
			Size = UDim2.new(1, -30, 0, 110),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			ClipsDescendants = true,
			Parent = n,
		}
	)
	g(e, UDim.new(0, 6))
	local T = c(H, { Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 0, 0)), Parent = e })
	local V =
		c(k, { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Parent = e })
	c(
		H,
		{
			Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }),
			Rotation = 90,
			Parent = V,
		}
	)
	local x = c(
		k,
		{ AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(10, 10), BackgroundTransparency = 1, ZIndex = 3, Parent = e }
	)
	g(x, UDim.new(1, 0))
	i(x, Color3.new(1, 1, 1), 0, 2)
	local o = c(
		G,
		{
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 0, 0, 0),
			Size = UDim2.fromOffset(14, 110),
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			Parent = n,
		}
	)
	g(o, UDim.new(0, 6))
	c(
		H,
		{
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
				ColorSequenceKeypoint.new(0.16666666666666666, Color3.fromRGB(255, 255, 0)),
				ColorSequenceKeypoint.new(0.3333333333333333, Color3.fromRGB(0, 255, 0)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
				ColorSequenceKeypoint.new(0.6666666666666666, Color3.fromRGB(0, 0, 255)),
				ColorSequenceKeypoint.new(0.8333333333333334, Color3.fromRGB(255, 0, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
			}),
			Rotation = 90,
			Parent = o,
		}
	)
	local y = c(
		k,
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.fromOffset(18, 5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			ZIndex = 3,
			Parent = o,
		}
	)
	g(y, UDim.new(1, 0))
	i(y, a.AccentDark, 0.4)
	local I = c(
		k,
		{
			Position = UDim2.fromOffset(6, 122),
			Size = UDim2.fromOffset(118, 28),
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			Parent = n,
		}
	)
	g(I, UDim.new(0, 6))
	local L = i(I)
	local p = c(
		"TextBox",
		{
			Position = UDim2.fromOffset(14, 0),
			Size = UDim2.new(1, -24, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			TextTruncate = Enum.TextTruncate.None,
			ClipsDescendants = false,
			TextColor3 = a.Text,
			TextSize = 13,
			FontFace = j.Regular,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = false,
			Parent = I,
		}
	)
	local W = f({
		Position = UDim2.fromOffset(134, 122),
		Size = UDim2.new(1, -134, 0, 28),
		TextXAlignment = Enum.TextXAlignment.Right,
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		Parent = n,
	})
	local d = { Open = false }
	local t = h.Default
	if type(t) == "string" then
		local a, b = pcall(Color3.fromHex, t)
		t = a and b or nil
	end
	if typeof(t) ~= "Color3" then
		t = a.Accent
	end
	local z, D, E = Color3.toHSV(t)
	local u
	local function N(a)
		return string.format(
			"#%02X%02X%02X",
			math.floor(a.R * 255 + 0.5),
			math.floor(a.G * 255 + 0.5),
			math.floor(a.B * 255 + 0.5)
		)
	end
	local function O(c)
		local a = Color3.fromHSV(z, D, E)
		d.Value = a
		C.BackgroundColor3 = a
		T.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromHSV(z, 1, 1))
		b(x, { Position = UDim2.fromScale(D, 1 - E) }, c, Enum.EasingStyle.Linear)
		b(y, { Position = UDim2.new(0.5, 0, z, 0) }, c, Enum.EasingStyle.Linear)
		if not p:IsFocused() then
			p.Text = N(a)
		end
		W.Text = string.format(
			"RGB %d, %d, %d",
			math.floor(a.R * 255 + 0.5),
			math.floor(a.G * 255 + 0.5),
			math.floor(a.B * 255 + 0.5)
		)
	end
	local function J(a, b)
		O(a)
		if not b then
			l(h.Callback, d.Value)
		end
	end
	function d:Set(a, b)
		if type(a) == "string" then
			local b, c = pcall(Color3.fromHex, a)
			a = b and c or nil
		end
		if typeof(a) ~= "Color3" then
			warn("[Astris] ColorPicker:Set expects a Color3 or hex string")
			return
		end
		z, D, E = Color3.toHSV(a)
		J(0.25, b)
		w(K)
	end
	function d:Get()
		return d.Value
	end
	local function P(a)
		d.Open = a
		b(m, { Size = UDim2.new(1, 0, 0, a and v + 168 or v) }, 0.35, Enum.EasingStyle.Quint)
		S:Set(a)
		if a then
			n.Visible = true
		else
			task.delay(0.35, function()
				if not d.Open then
					n.Visible = false
				end
			end)
		end
	end
	function d:SetOpen(a)
		P(a == true)
	end
	A.MouseButton1Click:Connect(function()
		P(not d.Open)
	end)
	local function Q(a)
		D = math.clamp((a.X - e.AbsolutePosition.X) / e.AbsoluteSize.X, 0, 1)
		E = 1 - math.clamp((a.Y - e.AbsolutePosition.Y) / e.AbsoluteSize.Y, 0, 1)
		J(0.04)
	end
	local function R(a)
		z = math.clamp((a.Y - o.AbsolutePosition.Y) / o.AbsoluteSize.Y, 0, 0.999)
		J(0.04)
	end
	e.InputBegan:Connect(function(a)
		if r(a) then
			u = "sv"
			b(x, { Size = UDim2.fromOffset(14, 14) }, 0.15, Enum.EasingStyle.Back)
			Q(s())
		end
	end)
	o.InputBegan:Connect(function(a)
		if r(a) then
			u = "hue"
			b(y, { Size = UDim2.fromOffset(20, 7) }, 0.15, Enum.EasingStyle.Back)
			R(s())
		end
	end)
	self.Window:_listen("Changed", function(b)
		if not u or not U(b) then
			return
		end
		local a = s()
		if u == "sv" then
			Q(a)
		else
			R(a)
		end
	end, d)
	self.Window:_listen("Ended", function(a)
		if u and r(a) then
			u = nil
			b(x, { Size = UDim2.fromOffset(10, 10) }, 0.2)
			b(y, { Size = UDim2.fromOffset(18, 5) }, 0.2)
		end
	end, d)
	p.Focused:Connect(function()
		b(L, { Color = a.StrokeHover }, 0.15)
	end)
	p.FocusLost:Connect(function()
		b(L, { Color = a.Stroke }, 0.15)
		local c, e, f = p.Text:match("^%s*#?(%x%x)(%x%x)(%x%x)%s*$")
		if c then
			d:Set(Color3.fromRGB(tonumber(c, 16), tonumber(e, 16), tonumber(f, 16)))
		else
			p.Text = N(d.Value)
		end
	end)
	O(0)
	return q(self, h, d, m, "ColorPicker")
end
function k:Stepper(e)
	local n, s, I, u, v
	e, n, s, I, u, v = B(
		self,
		e,
		{ Title = "Name", Description = "Desc", CurrentValue = "Default", Value = "Default", Increment = "Step" },
		"Frame",
		150,
		"Stepper"
	)
	local k = math.min(e.Min or 0, e.Max or 100)
	local o = math.max(e.Min or 0, e.Max or 100)
	local x = e.Step or 1
	local J = e.Suffix or ""
	local y = ai(k, o, x)
	local h = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(0, t),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			Parent = n,
		}
	)
	g(h, UDim.new(0, 6))
	local z = i(h)
	c(
		"UIListLayout",
		{
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Parent = h,
		}
	)
	local function A(e, f)
		local d = c(
			"TextButton",
			{
				Size = UDim2.fromOffset(t, t),
				BackgroundTransparency = 1,
				Text = e,
				TextColor3 = a.Muted,
				TextSize = 18,
				FontFace = j.Medium,
				AutoButtonColor = false,
				LayoutOrder = f,
				Parent = h,
			}
		)
		d.MouseEnter:Connect(function()
			b(d, { TextColor3 = a.Accent }, 0.12)
		end)
		d.MouseLeave:Connect(function()
			b(d, { TextColor3 = a.Muted }, 0.2)
		end)
		return d
	end
	local C = A("−", 1)
	local m = f({
		Size = UDim2.new(0, 30, 1, 0),
		TextSize = 13,
		TextColor3 = a.Accent,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.None,
		LayoutOrder = 2,
		Parent = h,
	})
	local D = A("+", 3)
	local function E(c)
		local a = math.max(m.TextBounds.X + 12, 30)
		if c then
			m.Size = UDim2.new(0, a, 1, 0)
		else
			b(m, { Size = UDim2.new(0, a, 1, 0) }, 0.2)
		end
	end
	m:GetPropertyChangedSignal("TextBounds"):Connect(function()
		E(false)
	end)
	h:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		N(u, v, h.AbsoluteSize.X / self.Window.Scale.Scale + 20)
	end)
	local d = { Value = math.clamp(e.Default or k, k, o) }
	local K, p = y.snap, false
	local function F()
		m.Text = y.format(d.Value) .. J
		b(C, { TextTransparency = d.Value <= k and 0.6 or 0 }, 0.15)
		b(D, { TextTransparency = d.Value >= o and 0.6 or 0 }, 0.15)
	end
	function d:Set(a, b)
		a = K(tonumber(a) or k)
		if a == d.Value then
			return
		end
		d.Value = a
		F()
		if not p then
			w(s)
		end
		if not b then
			l(e.Callback, a)
		end
	end
	function d:Get()
		return d.Value
	end
	local function G(c)
		p = true
		d:Set(d.Value + c * x)
		p = false
		b(z, { Color = a.StrokeHover }, 0.08)
		task.delay(0.12, function()
			b(z, { Color = a.Stroke }, 0.2)
		end)
	end
	local L, M = 0.4, 0.07
	local function H(a, e)
		local c, b = 0, false
		a.InputBegan:Connect(function(f)
			if not r(f) then
				return
			end
			c += 1
			local g = c
			b = true
			G(e)
			task.delay(L, function()
				while b and c == g and not d.Locked and not d._destroyed and a.Parent do
					G(e)
					task.wait(M)
				end
			end)
		end)
		a.InputEnded:Connect(function(a)
			if r(a) then
				b = false
			end
		end)
		a.MouseLeave:Connect(function()
			b = false
		end)
	end
	H(C, -1)
	H(D, 1)
	F()
	task.defer(E, true)
	return q(self, e, d, n, "Stepper")
end
function k:Progress(d)
	d = n(d, { Title = "Name", Description = "Desc", CurrentValue = "Default", Value = "Default" })
	local h, s = G(self, "Frame", d.Desc and y + 10 or R + 10, d)
	L(h, s)
	local i = d.Desc and (y - 38) / 2 - 2 or 12
	f({ Name = "Title", Position = UDim2.fromOffset(14, i), Size = UDim2.new(1, -110, 0, 18), Text = d.Name
		or "Progress", Parent = h })
	if d.Desc then
		f({
			Name = "Desc",
			Position = UDim2.fromOffset(14, i + 20),
			Size = UDim2.new(1, -110, 0, 17),
			Text = d.Desc,
			TextSize = 13,
			FontFace = j.Regular,
			TextColor3 = a.Muted,
			Parent = h,
		})
	end
	local m = f({
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -14, 0, i),
		Size = UDim2.fromOffset(90, 18),
		TextXAlignment = Enum.TextXAlignment.Right,
		TextSize = 13,
		TextColor3 = a.Accent,
		Parent = h,
	})
	local o = c(
		"Frame",
		{
			Position = UDim2.new(0, 14, 1, -16),
			Size = UDim2.new(1, -28, 0, 5),
			BackgroundColor3 = a.Surface3,
			BorderSizePixel = 0,
			Parent = h,
		}
	)
	g(o, UDim.new(1, 0))
	local k = c(
		"Frame",
		{ Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = d.Color or a.Accent, BorderSizePixel = 0, Parent = o }
	)
	g(k, UDim.new(1, 0))
	local e = { Value = math.clamp(d.Default or 0, 0, 1) }
	local p = d.Format
	local function r(c)
		local a = e.Value
		b(k, { Size = UDim2.new(a, 0, 1, 0) }, c, Enum.EasingStyle.Quint)
		if type(p) == "function" then
			m.Text = tostring(p(a))
		else
			m.Text = string.format("%d%%", math.floor(a * 100 + 0.5))
		end
	end
	function e:Set(a, b)
		a = math.clamp(tonumber(a) or 0, 0, 1)
		if a == e.Value then
			return
		end
		e.Value = a
		r(0.35)
		if not b then
			l(d.Callback, a)
		end
	end
	function e:Get()
		return e.Value
	end
	function e:SetColor(a)
		k.BackgroundColor3 = a
	end
	r(0)
	return q(self, d, e, h, "Progress")
end
function k:ConfigManager(d)
	d = n(d, {})
	local a = self.Window
	local b = {}
	self:Section(d.Name or "Configs")
	local e = self:Input({
		Name = "Config name",
		Placeholder = a.ConfigName,
		Callback = function(a, c)
			if c and #a > 0 then
				b:Save(a)
			end
		end,
	})
	local c = self:Dropdown({
		Name = "Saved configs",
		Options = a:ListConfigs(),
		Default = a.ConfigName,
		Callback = function(a)
			if a then
				e:Set(a, true)
			end
		end,
	})
	function b:Refresh()
		c:Refresh(a:ListConfigs(), true)
	end
	function b:Save(e)
		e = e or c:Get() or a.ConfigName
		local d, f = a:SaveConfig(e)
		b:Refresh()
		if d then
			c:Set(a.ConfigName, true)
		end
		a:Notify({
			Title = d and "Config saved" or "Save failed",
			Content = d and a.ConfigName or tostring(f),
			Type = d and "Success" or "Error",
			Duration = 3,
		})
	end
	function b:Load(b)
		b = b or c:Get()
		if not b then
			return
		end
		local d, e = a:LoadConfig(b)
		a:Notify({
			Title = d and "Config loaded" or "Load failed",
			Content = d and b or tostring(e),
			Type = d and "Success" or "Error",
			Duration = 3,
		})
	end
	function b:Delete(d)
		d = d or c:Get()
		if not d then
			return
		end
		local e, f = a:DeleteConfig(d)
		b:Refresh()
		a:Notify({
			Title = e and "Config deleted" or "Delete failed",
			Content = e and d or tostring(f),
			Type = e and "Info" or "Error",
			Duration = 3,
		})
	end
	self:Button({
		Name = "Save",
		Desc = "Writes every flagged element to the selected name",
		Icon = "save",
		Style = "Primary",
		Callback = function()
			local a = e:Get()
			b:Save(#a > 0 and a or nil)
		end,
	})
	self:Button({
		Name = "Load",
		Icon = "folder-open",
		Callback = function()
			b:Load()
		end,
	})
	self:Button({
		Name = "Delete",
		Icon = "trash-2",
		Callback = function()
			local d = c:Get()
			if not d then
				return
			end
			a:Confirm({
				Title = "Delete config",
				Content = "Remove " .. d .. "? This cannot be undone.",
				Icon = "trash-2",
				ConfirmText = "Delete",
				Callback = function()
					b:Delete(d)
				end,
			})
		end,
	})
	self:Toggle({
		Name = "Auto save",
		Desc = "Save whenever a flagged element changes",
		Default = a._autoSaveEnabled,
		Callback = function(b)
			a:SetAutoSave(b)
		end,
	})
	return b
end
function k:ThemePicker(a)
	a = n(a, { Title = "Name", Description = "Desc" })
	local b = a.Callback
	return self:Dropdown({
		Name = a.Name or "Theme",
		Desc = a.Desc,
		Options = e:GetThemes(),
		Default = e.ThemeName,
		Flag = a.Flag,
		Callback = function(a)
			if a then
				e:SetTheme(a)
			end
			l(b, a)
		end,
	})
end
local aw = { Select = true }
function k:Select()
	self.Window:SelectTab(self)
end
for a, b in pairs(table.clone(k)) do
	if type(b) == "function" and a:sub(1, 1) ~= "_" and a:sub(1, 6) ~= "Create" and not aw[a] then
		k["Create" .. a] = b
	end
end
local function ax()
	local a
	pcall(function()
		if typeof(identifyexecutor) == "function" then
			a = (identifyexecutor())
		elseif typeof(getexecutorname) == "function" then
			a = getexecutorname()
		end
	end)
	if type(a) == "string" and #a > 0 then
		return a
	end
	return ab:IsStudio() and "Studio" or "Unknown"
end
local function ay()
	local b, a = pcall(function()
		return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
	end)
	if b and type(a) == "table" and a.Name then
		return a.Name
	end
	return "Unknown game"
end
local aB = { Info = O, Success = "Success", Warning = "Warning", Error = "Error" }
local h = {}
h.__index = h
function e.Window(ac, k)
	local H, q, I, M, J, B = "AstrisUI", "Frame", "CanvasGroup", "UIListLayout", "AbsoluteSize", "table"
	k = n(k, { Name = "Title", LoadingSubtitle = "Subtitle", ToggleUIKeybind = "Keybind" })
	if k.Theme ~= nil then
		e:SetTheme(k.Theme)
	end
	local V = k.Size or UDim2.fromOffset(640, 480)
	local N = F(k.Keybind) or Enum.KeyCode.RightControl
	local d = setmetatable(
		{
			Tabs = {},
			Flags = {},
			CurrentTab = nil,
			Open = true,
			Keybind = N,
			_connections = {},
			_controls = {},
			_inputListeners = { Began = {}, Changed = {}, Ended = {}, Render = {} },
			_frameSteps = {},
			_destroyed = false,
		},
		h
	)
	local function C(a)
		return function(...)
			for b, a in ipairs(d._inputListeners[a]) do
				a(...)
			end
		end
	end
	local X = C("Render")
	table.insert(
		d._connections,
		ab.RenderStepped:Connect(function(a)
			X(a)
			for c, b in ipairs(d._frameSteps) do
				b(a)
			end
		end)
	)
	table.insert(d._connections, p.InputBegan:Connect(C("Began")))
	table.insert(d._connections, p.InputChanged:Connect(C("Changed")))
	table.insert(d._connections, p.InputEnded:Connect(C("Ended")))
	local s = c(
		"ScreenGui",
		{
			Name = k.Name or H,
			IgnoreGuiInset = true,
			ResetOnSpawn = false,
			DisplayOrder = 999,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		}
	)
	d.Gui = s
	local y = c(
		q,
		{
			Name = "Window",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = V,
			BackgroundTransparency = 1,
			Parent = s,
		}
	)
	d.Root = y
	local O = c("UIScale", { Parent = y })
	d.Scale = O
	local P = c(
		"ImageLabel",
		{
			Position = UDim2.fromOffset(-25, -25),
			Size = UDim2.new(1, 50, 1, 50),
			BackgroundTransparency = 1,
			Image = v.Shadow,
			ImageColor3 = Color3.new(0, 0, 0),
			ImageTransparency = 0.6,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = v.ShadowSlice,
			Parent = y,
		}
	)
	d.Shadow = P
	local l = c(
		I,
		{ Name = "Body", Size = UDim2.fromScale(1, 1), BackgroundColor3 = a.Background, BorderSizePixel = 0, Parent = y }
	)
	d.Body = l
	g(l, UDim.new(0, 14))
	d.BodyStroke = i(l, a.Stroke)
	T(l)
	local D = c(q, { Name = "Sidebar", Size = UDim2.new(0, 170, 1, 0), BackgroundTransparency = 1, Parent = l })
	local sp = c(
		q,
		{
			Name = "Panel",
			Position = UDim2.fromOffset(8, 8),
			Size = UDim2.new(1, -12, 1, -16),
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			ZIndex = 0,
			Parent = D,
		}
	)
	g(sp, UDim.new(0, 8))
	i(sp, a.Stroke)
	local K = c(q, { Name = "Header", Size = UDim2.new(1, 0, 0, 72), BackgroundTransparency = 1, Parent = D })
	local Q = c(
		"ImageLabel",
		{
			Position = UDim2.fromOffset(22, 27),
			Size = UDim2.fromOffset(30, 28),
			BackgroundTransparency = 1,
			Image = "",
			ImageColor3 = a.Text,
			ScaleType = Enum.ScaleType.Fit,
			Parent = K,
		}
	)
	u(Q, k.Icon or v.Logo)
	d._logo = Q
	d._titleLabel = f({
		Position = UDim2.fromOffset(60, 25),
		Size = UDim2.new(1, -70, 0, 20),
		Text = k.Title or "Astris Hub",
		TextSize = 20,
		Parent = K,
	})
	d._subtitleLabel = f({
		Position = UDim2.fromOffset(60, 45),
		Size = UDim2.new(1, -70, 0, 14),
		Text = k.Subtitle or "",
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		Parent = K,
	})
	local t = c(
		"ScrollingFrame",
		{
			Name = "Tabs",
			Position = UDim2.fromOffset(0, 80),
			Size = UDim2.new(1, 0, 1, -116),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(),
			Parent = D,
		}
	)
	d.TabList = t
	if m then
		t:SetAttribute("NoDrag", true)
	end
	o(t, 16, 16, 4, 4)
	c(M, { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = t })
	local E = c(
		q,
		{
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromOffset(19, 0),
			Size = UDim2.fromOffset(3, 16),
			BackgroundColor3 = a.Accent,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 2,
			Parent = D,
		}
	)
	g(E, UDim.new(1, 0))
	d.Indicator = E
	local R = t.CanvasPosition.Y
	table.insert(d._frameSteps, function()
		local b = t.CanvasPosition.Y
		if b == R or not d.CurrentTab or not d._introDone then
			return
		end
		R = b
		local a = d:_indicatorY(d.CurrentTab)
		local c = t.Position.Y.Offset
		local e = c + t.AbsoluteSize.Y / d.Scale.Scale
		E.Visible = a > c and a < e
		E.Position = UDim2.fromOffset(19, a)
	end)
	local S = c(
		q,
		{ Position = UDim2.new(0, 22, 1, -36), Size = UDim2.new(1, -44, 0, 22), BackgroundTransparency = 1, Parent = D }
	)
	local x = c(
		q,
		{
			Size = UDim2.fromOffset(0, 22),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			Parent = S,
		}
	)
	g(x, UDim.new(0, 5))
	i(x)
	o(x, 7, 7)
	local Y = f({
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		Text = W(N),
		TextSize = 11,
		TextColor3 = a.Muted,
		TextTruncate = Enum.TextTruncate.None,
		Parent = x,
	})
	d._keyChipLabel = Y
	local Z = f({
		Size = UDim2.new(1, 0, 1, 0),
		Text = m and "or tap the pill" or "to hide",
		TextSize = 12,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		Parent = S,
	})
	local function U()
		Z.Position = UDim2.fromOffset(x.AbsoluteSize.X / d.Scale.Scale + 8, 0)
	end
	x:GetPropertyChangedSignal(J):Connect(U)
	task.defer(U)
	local G = c(
		q,
		{
			Name = "Content",
			Position = UDim2.fromOffset(171, 0),
			Size = UDim2.new(1, -171, 1, 0),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Parent = l,
		}
	)
	d.Content = G
	d._outLayer = c(
		I,
		{ Name = "TransitionOut", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 2, Parent = G }
	)
	d._inLayer = c(
		I,
		{ Name = "TransitionIn", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 3, Parent = G }
	)
	local w = c(
		"TextButton",
		{
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -16, 0, 18),
			Size = UDim2.fromOffset(30, 30),
			BackgroundColor3 = a.Surface3,
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			ZIndex = 5,
			Parent = G,
		}
	)
	g(w, UDim.new(0, 8))
	local wi = c(
		"ImageLabel",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(16, 16),
			BackgroundTransparency = 1,
			ImageColor3 = a.Muted,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 6,
			Parent = w,
		}
	)
	u(wi, "x")
	w.MouseEnter:Connect(function()
		b(w, { BackgroundTransparency = 0.4 }, 0.15)
		b(wi, { ImageColor3 = a.Text }, 0.15)
	end)
	w.MouseLeave:Connect(function()
		b(w, { BackgroundTransparency = 1 }, 0.2)
		b(wi, { ImageColor3 = a.Muted }, 0.2)
	end)
	w.MouseButton1Click:Connect(function()
		d:Toggle(false)
	end)
	local L = c(
		q,
		{
			Name = "Notifications",
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -20, 1, -20),
			Size = UDim2.new(0, 320, 1, -40),
			BackgroundTransparency = 1,
			Parent = s,
		}
	)
	local function aa()
		L.Size = UDim2.new(0, math.min(320, s.AbsoluteSize.X - 40), 1, -40)
	end
	table.insert(d._connections, s:GetPropertyChangedSignal(J):Connect(aa))
	c(
		M,
		{
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
			Padding = UDim.new(0, 8),
			Parent = L,
		}
	)
	d.NotifyHolder = L
	d._notifyOrder = 0
	d._toasts = {}
	d.MaxNotifications = k.MaxNotifications or 4
	d._controlsDirty = true
	table.insert(
		d._connections,
		l.DescendantAdded:Connect(function()
			d._controlsDirty = true
		end)
	)
	table.insert(
		d._connections,
		l.DescendantRemoving:Connect(function()
			d._controlsDirty = true
		end)
	)
	d:_enableDrag()
	d.MaxSize = k.MaxSize
	d.KeepOnScreen = k.KeepOnScreen ~= false
	d:_enableResize(k.MinSize or Vector2.new(480, 360))
	local A = k.ConfigurationSaving
	if type(A) == B and A.Enabled ~= false then
		d.ConfigFolder = A.FolderName or H
		d.ConfigName = A.FileName or "default"
		d._autoSaveEnabled = A.AutoSave == true
	else
		d.ConfigFolder = H
		d.ConfigName = "default"
		d._autoSaveEnabled = false
	end
	table.insert(
		d._connections,
		p.InputBegan:Connect(function(a, b)
			if b then
				return
			end
			if a.KeyCode == Enum.KeyCode.Escape and d._dialog and d._dialog.Dismissable then
				d._dialog.Cancel()
				return
			end
			if a.UserInputType == Enum.UserInputType.Keyboard and a.KeyCode == d.Keybind then
				task.defer(function()
					local b = d._consumedKey == a.KeyCode and os.clock() - (d._consumedAt or 0) < 0.2
					d._consumedKey = nil
					if not b and not d._destroyed then
						d:Toggle(not d.Open)
					end
				end)
			end
		end)
	)
	pcall(function()
		if typeof(syn) == "table" and typeof(syn.protect_gui) == "function" then
			syn.protect_gui(s)
		end
	end)
	s.Parent = k.Parent or as()
	O.Scale = 0.9
	l.GroupTransparency = 1
	P.ImageTransparency = 1
	d.BodyStroke.Transparency = 1
	y.Visible = false
	d:_fitToScreen(true)
	table.insert(
		d._connections,
		s:GetPropertyChangedSignal(J):Connect(function()
			d:_fitToScreen()
			d:_clampToScreen()
		end)
	)
	if k.OpenButton ~= false then
		d:_createOpenButton(type(k.OpenButton) == B and k.OpenButton or {})
	end
	d._introDone = false
	table.insert(e.Windows, d)
	if k.Home then
		d:_buildHome(type(k.Home) == B and k.Home or {})
	end
	for _, name in ipairs({ "Server", "Esp", "Settings" }) do
		local opt = k[name]
		if opt ~= false then
			d["_build" .. name](d, type(opt) == B and opt or {})
		end
	end
	local r = k.Loading
	if type(r) == B then
		k.LoadingDuration = r.Duration or k.LoadingDuration
		k.LoadingText = r.Text or r.Subtitle or k.LoadingText
		k.LoadingSteps = r.Steps or k.LoadingSteps
		k.LoadingTitle = r.Title or k.LoadingTitle
		r = r.Enabled ~= false
	end
	if r == false then
		task.defer(function()
			d:_playIntro()
		end)
	else
		d:_showLoader(k)
	end
	return d
end
e.CreateWindow = e.Window
local function C(a, b, d)
	local e = a[b]:ToHex()
	local c = d[e]
	if c then
		a[b] = c
	end
end
local function aC(a, d)
	local b = false
	local c = {}
	for f, a in ipairs(a.Color.Keypoints) do
		local e = d[a.Value:ToHex()]
		if e then
			b = true
		end
		c[f] = ColorSequenceKeypoint.new(a.Time, e or a.Value)
	end
	if b then
		a.Color = ColorSequence.new(c)
	end
end
local function aD(a, b)
	if a:GetAttribute("AstrisNoTheme") then
		return
	end
	if a:IsA("GuiObject") then
		C(a, "BackgroundColor3", b)
	end
	if a:IsA("TextLabel") or a:IsA("TextButton") or a:IsA("TextBox") then
		C(a, "TextColor3", b)
	end
	if a:IsA("TextBox") then
		C(a, "PlaceholderColor3", b)
	end
	if a:IsA("ImageLabel") or a:IsA("ImageButton") then
		C(a, "ImageColor3", b)
	end
	if a:IsA("ScrollingFrame") then
		C(a, "ScrollBarImageColor3", b)
	end
	if a:IsA("UIStroke") then
		C(a, "Color", b)
	elseif a:IsA("UIGradient") then
		aC(a, b)
	end
end
local function aj(a)
	for c, b in ipairs(e.Windows) do
		if b.Gui and b.Gui.Parent then
			for c, b in ipairs(b.Gui:GetDescendants()) do
				aD(b, a)
			end
		end
	end
end
local function ak(a)
	if type(a) == "string" then
		local b = e.Themes[a]
		if not b then
			warn("[Astris] unknown theme: " .. a)
			return nil
		end
		return table.clone(b), a
	elseif type(a) == "table" then
		local c = e.Themes[a.Base or "Default"] or e.Themes.Default
		local b = table.clone(c)
		for d, c in ipairs(K) do
			if typeof(a[c]) == "Color3" then
				b[c] = a[c]
			end
		end
		return b, a.Name or "Custom"
	end
	warn("[Astris] SetTheme expects a theme name or a table of colours")
	return nil
end
function e:GetThemes()
	local a = {}
	for b in pairs(e.Themes) do
		if b ~= "Default" then
			table.insert(a, b)
		end
	end
	table.sort(a)
	table.insert(a, 1, "Default")
	return a
end
function e:AddTheme(a, c)
	assert(type(a) == "string" and a ~= "", "AddTheme needs a name")
	local b = ak(c)
	if b then
		e.Themes[a] = b
	end
	return b ~= nil
end
local X = 0
function e:SetTheme(g)
	local b, h = ak(g)
	if not b then
		return false
	end
	local c, d = {}, {}
	for c, a in ipairs(K) do
		d[b[a]:ToHex()] = true
	end
	for h, d in ipairs(K) do
		local e, f = a[d], b[d]
		local g = e:ToHex()
		if e ~= f and c[g] == nil then
			c[g] = f
		end
	end
	for d, c in ipairs(K) do
		a[c] = b[c]
	end
	e.ThemeName = h
	aj(c)
	X += 1
	local i = X
	local f = {}
	for a, b in pairs(c) do
		if not d[a] then
			f[a] = b
		end
	end
	task.delay(0.6, function()
		if i == X then
			aj(f)
		end
	end)
	return true
end
function e:Notify(b)
	local a = e.Windows[#e.Windows]
	if a then
		return a:Notify(b)
	end
end
function e:Confirm(b)
	local a = e.Windows[#e.Windows]
	if a then
		return a:Confirm(b)
	end
end
function e:Dialog(b)
	local a = e.Windows[#e.Windows]
	if a then
		return a:Dialog(b)
	end
end
local function D(a, c)
	local b, d = c.AbsolutePosition, c.AbsoluteSize
	return a.X >= b.X and a.X <= b.X + d.X and a.Y >= b.Y and a.Y <= b.Y + d.Y
end
local function aE(c, b, d)
	local a = c
	while a and a ~= b and a:IsA("GuiObject") do
		if not a.Visible then
			return false
		end
		local c = a.Parent
		if c and c ~= b and c:IsA("GuiObject") and (c.ClipsDescendants or c:IsA("ScrollingFrame")) and not D(d, c) then
			return false
		end
		a = c
	end
	return true
end
function h:_refreshControls()
	local a = {}
	for c, b in ipairs(self.Body:GetDescendants()) do
		if b:IsA("GuiButton") or b:IsA("TextBox") or b:GetAttribute("NoDrag") then
			table.insert(a, b)
		end
	end
	self._controls = a
	self._controlsDirty = false
end
function h:_overControl(a)
	if self._dialog then
		return true
	end
	if self._controlsDirty then
		self:_refreshControls()
	end
	for c, b in ipairs(self._controls) do
		if b.Parent and D(a, b) and aE(b, self.Body, a) then
			return true
		end
	end
	return false
end
function h:_overOverlay(a)
	if self._grip and D(a, self._grip) then
		return true
	end
	if self.OpenButton and self.OpenButton.Visible and D(a, self.OpenButton) then
		return true
	end
	for c, b in ipairs(self.NotifyHolder:GetChildren()) do
		if b:IsA("GuiObject") and D(a, b) then
			return true
		end
	end
	return false
end
function h:_enableDrag()
	local a = false
	local c = Vector2.zero
	local b
	local function d()
		local a = self.Root
		return a.AbsolutePosition + a.AbsoluteSize * a.AnchorPoint - self.Gui.AbsolutePosition
	end
	table.insert(
		self._connections,
		p.InputBegan:Connect(function(e)
			if not r(e) then
				return
			end
			if not self.Open or not self.Root.Visible then
				return
			end
			local b = s()
			if not D(b, self.Body) or self:_overControl(b) or self:_overOverlay(b) then
				return
			end
			a = true
			c = b - d()
		end)
	)
	table.insert(
		self._connections,
		p.InputEnded:Connect(function(c)
			if not a then
				return
			end
			if r(c) then
				a, b = false, nil
				self:_clampToScreen()
			end
		end)
	)
	table.insert(self._frameSteps, function(f)
		if not a then
			return
		end
		b = s() - c
		local g = d()
		local h = 1 - math.exp(-f * 45)
		local e = g:Lerp(b, h)
		self.Root.Position = UDim2.fromOffset(e.X, e.Y)
	end)
end
local function al(a, d, e)
	if not a.Visible and not e then
		return
	end
	a.Visible = false
	task.delay(d, function()
		if not a.Parent then
			return
		end
		local d = c("UIScale", { Scale = 0.94, Parent = a })
		a.Visible = true
		b(d, { Scale = 1 }, 0.4, Enum.EasingStyle.Back)
		task.delay(0.4, function()
			d:Destroy()
		end)
	end)
end
function h:_revealCards(a, c)
	if a._revealed then
		return
	end
	a._revealed = true
	local b = 0
	for d, a in ipairs(a.List:GetChildren()) do
		if a:IsA("GuiObject") then
			al(a, (c or 0) + b * 0.035)
			b += 1
		end
	end
end
function h:_playIntro(c)
	if self._introDone then
		return
	end
	self._introDone = true
	task.delay(1, function()
		self._autoSaveReady = true
	end)
	local a, d, e, f = self.Root, self.Body, self.Shadow, self.Scale
	if self.CurrentTab then
		self:_revealCards(self.CurrentTab, c and 0.15 or 0.25)
	end
	a.Visible = true
	if c then
		f.Scale = self._fitScale or 1
		a.Position = UDim2.fromScale(0.5, 0.5)
		b(d, { GroupTransparency = 0 }, 0.3)
		b(self.BodyStroke, { Transparency = 0 }, 0.3)
		b(e, { ImageTransparency = 0.6 }, 0.3)
	else
		a.Position = UDim2.new(0.5, 0, 0.5, 24)
		b(f, { Scale = self._fitScale or 1 }, 0.5, Enum.EasingStyle.Back)
		b(a, { Position = UDim2.fromScale(0.5, 0.5) }, 0.5, Enum.EasingStyle.Quint)
		b(d, { GroupTransparency = 0 }, 0.35)
		b(self.BodyStroke, { Transparency = 0 }, 0.35)
	end
	if not c then
		b(e, { ImageTransparency = 0.6 }, 0.5)
	end
	for a, b in ipairs(self.Tabs) do
		al(b._button, 0.1 + a * 0.05, true)
	end
	self.Indicator.Visible = false
	task.delay(0.15 + #self.Tabs * 0.05, function()
		if self.CurrentTab then
			self:_placeIndicator(self.CurrentTab)
		end
	end)
end
function h:_showLoader(e)
	local h = "Frame"
	local m = e.LoadingDuration or 1.6
	local w = self.Gui
	local d = c(
		"CanvasGroup",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 16),
			Size = UDim2.fromOffset(300, 132),
			BackgroundColor3 = a.Background,
			BorderSizePixel = 0,
			GroupTransparency = 1,
			ZIndex = 10,
			Parent = w,
		}
	)
	d.Size = UDim2.fromOffset(300, 176)
	local x = g(d, UDim.new(0, 14))
	local y = i(d, a.Stroke, 1)
	T(d)
	local p = c("UIScale", { Scale = 0.92, Parent = d })
	-- shadow lives inside the canvas group, so it is clipped; kept only so the fade code below has a target
	local q = c("ImageLabel", { BackgroundTransparency = 1, ImageTransparency = 1, Size = UDim2.fromOffset(0, 0), Parent = d })
	-- logo in an app-icon tile, outline pulses in the accent while loading
	local r = c(
		h,
		{
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 24),
			Size = UDim2.fromOffset(48, 48),
			BackgroundColor3 = a.Surface2,
			BorderSizePixel = 0,
			Parent = d,
		}
	)
	g(r, UDim.new(0, 12))
	local ring = i(r, a.Stroke, 1)
	local n = c(
		"ImageLabel",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(14, 14),
			Rotation = -14,
			BackgroundTransparency = 1,
			ImageColor3 = a.Text,
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Fit,
			Parent = r,
		}
	)
	u(n, e.Icon or v.Logo)
	task.delay(0.15, function()
		b(n, { Size = UDim2.fromOffset(28, 28), Rotation = 0 }, 0.6, Enum.EasingStyle.Back)
		b(n, { ImageTransparency = 0 }, 0.4)
		b(ring, { Color = a.Accent, Transparency = 0.5 }, 0.5)
	end)
	local pulse = aa:Create(
		ring,
		TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0.6),
		{ Transparency = 0.85 }
	)
	task.delay(0.65, function()
		if d.Parent then
			pulse:Play()
		end
	end)
	f({
		Position = UDim2.fromOffset(24, 84),
		Size = UDim2.new(1, -48, 0, 22),
		Text = e.LoadingTitle or e.Title or "Astris Hub",
		TextSize = 18,
		FontFace = j.Bold,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = d,
	})
	local A = f({
		Position = UDim2.fromOffset(24, 108),
		Size = UDim2.new(1, -48, 0, 16),
		Text = e.LoadingText or e.Subtitle or "Loading",
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = d,
	})
	local k = c(
		h,
		{
			Position = UDim2.new(0, 24, 1, -32),
			Size = UDim2.new(1, -48, 0, 4),
			BackgroundColor3 = a.Surface3,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Parent = d,
		}
	)
	g(k, UDim.new(1, 0))
	local l = c(h, { Size = UDim2.fromScale(0, 1), BackgroundColor3 = a.Accent, BorderSizePixel = 0, Parent = k })
	g(l, UDim.new(1, 0))
	local o = c(
		h,
		{
			Position = UDim2.fromScale(-0.4, 0),
			Size = UDim2.fromScale(0.4, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 0.55,
			BorderSizePixel = 0,
			ZIndex = 2,
			Parent = k,
		}
	)
	c(
		"UIGradient",
		{
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(1, 1),
			}),
			Parent = o,
		}
	)
	b(d, { GroupTransparency = 0, Position = UDim2.fromScale(0.5, 0.5) }, 0.4, Enum.EasingStyle.Quint)
	b(p, { Scale = 1 }, 0.5, Enum.EasingStyle.Back)
	b(q, { ImageTransparency = 0.6 }, 0.4)
	local s = aa:Create(
		o,
		TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1),
		{ Position = UDim2.fromScale(1, 0) }
	)
	s:Play()
	b(l, { Size = UDim2.fromScale(0.85, 1) }, m * 0.8, Enum.EasingStyle.Quart)
	task.spawn(P)
	local t = e.LoadingSteps or { "Preparing interface", "Loading icons", "Almost there" }
	for a, b in ipairs(t) do
		task.delay(m * (a - 1) / #t, function()
			if d.Parent and A.Text ~= b then
				-- old step slides up and out, new one rises in
				local base = UDim2.fromOffset(24, 108)
				local t = aa:Create(A, TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.In), { TextTransparency = 1, Position = base - UDim2.fromOffset(0, 4) })
				t:Play()
				t.Completed:Wait()
				if not d.Parent then
					return
				end
				A.Text = b
				A.Position = base + UDim2.fromOffset(0, 4)
				aa:Create(A, TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { TextTransparency = 0, Position = base }):Play()
			end
		end)
	end
	task.delay(m, function()
		b(l, { Size = UDim2.fromScale(1, 1) }, 0.25, Enum.EasingStyle.Quint)
		task.delay(0.25, function()
			s:Cancel()
			pulse:Cancel()
			b(ring, { Transparency = 1 }, 0.15)
			b(r, { BackgroundTransparency = 1 }, 0.15)
			for c, a in ipairs(d:GetChildren()) do
				if a:IsA("TextLabel") then
					b(a, { TextTransparency = 1 }, 0.15)
				end
			end
			b(n, { ImageTransparency = 1 }, 0.15)
			b(k, { BackgroundTransparency = 1 }, 0.15)
			b(l, { BackgroundTransparency = 1 }, 0.15)
			b(o, { BackgroundTransparency = 1 }, 0.1)
			local a = self._fitScale or 1
			local c = self.Root.Size
			b(
				d,
				{ Size = UDim2.fromOffset(c.X.Offset * a, c.Y.Offset * a), Position = UDim2.fromScale(0.5, 0.5) },
				0.5,
				Enum.EasingStyle.Quint
			)
			b(x, { CornerRadius = UDim.new(0, 14) }, 0.5, Enum.EasingStyle.Quint)
			b(p, { Scale = 1 }, 0.5, Enum.EasingStyle.Quint)
			task.delay(0.28, function()
				self:_playIntro(true)
				b(d, { GroupTransparency = 1 }, 0.25)
				b(y, { Transparency = 1 }, 0.2)
				b(q, { ImageTransparency = 1 }, 0.2)
			end)
			task.delay(0.6, function()
				d:Destroy()
			end)
		end)
	end)
end
function h:_fitToScreen(d)
	local a = self.Gui.AbsoluteSize
	if a.X == 0 or a.Y == 0 then
		return
	end
	local c = self.Root.Size
	local e = math.min(1, (a.X - 24) / math.max(c.X.Offset, 1), (a.Y - 24) / math.max(c.Y.Offset, 1))
	self._fitScale = math.max(e, 0.45)
	if self._introDone and self.Open then
		if d then
			self.Scale.Scale = self._fitScale
		else
			b(self.Scale, { Scale = self._fitScale }, 0.2)
		end
	end
end
function h:_clampToScreen()
	if not self.KeepOnScreen then
		return
	end
	local a = self.Gui.AbsoluteSize
	local d = self.Root
	local c = d.AbsoluteSize / 2
	local e = d.AbsolutePosition + c - self.Gui.AbsolutePosition
	local f = Vector2.new(
		math.clamp(e.X, math.min(c.X, a.X / 2), math.max(a.X - c.X, a.X / 2)),
		math.clamp(e.Y, math.min(c.Y, a.Y / 2), math.max(a.Y - c.Y, a.Y / 2))
	)
	if (f - e).Magnitude > 0.5 then
		b(d, { Position = UDim2.fromOffset(f.X, f.Y) }, 0.25, Enum.EasingStyle.Quint)
	end
end
function h:_createOpenButton(k)
	local d = self.Gui
	local size, gap = k.Size or 56, k.Gap or 12
	local btn = c("ImageButton", {
		Name = "Toggle",
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.fromOffset(size, size),
		BackgroundColor3 = a.Surface2,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Image = "",
		ZIndex = 30,
		Parent = d,
	})
	g(btn, UDim.new(0, math.floor(size * 0.32)))
	local stroke = i(btn, a.Stroke)
	local logo = c("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(math.floor(size * 0.54), math.floor(size * 0.54)),
		BackgroundTransparency = 1,
		ImageColor3 = a.Text,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 31,
		Parent = btn,
	})
	u(logo, k.Icon or v.Logo)
	self.OpenButton = btn
	function self:_syncOpenButton(t)
		local open = self.Open ~= false
		b(btn, { BackgroundTransparency = open and 0 or 0.3 }, t or 0.28)
		b(stroke, { Transparency = open and 0 or 0.4 }, t or 0.28)
		b(logo, { ImageTransparency = open and 0 or 0.3 }, t or 0.28)
	end
	self:_syncOpenButton(0)
	-- starts above the window's top centre every time; a drag only moves it for this session
	local free
	local function place(x, y)
		btn.Position = UDim2.fromOffset(
			math.floor(math.clamp(x, size / 2, math.max(d.AbsoluteSize.X - size / 2, size / 2)) + 0.5),
			math.floor(math.clamp(y, size, math.max(d.AbsoluteSize.Y, size)) + 0.5)
		)
	end
	local root = self.Root
	self:_listen("Render", function()
		if free then
			return place(free.X, free.Y)
		end
		local sc = self.Scale.Scale
		if sc <= 0 then
			return
		end
		local rest = (self._fitScale or 1) / sc
		local mid = root.AbsolutePosition + root.AbsoluteSize / 2 - d.AbsolutePosition
		local top = mid.Y - root.AbsoluteSize.Y / 2 * rest - gap
		local x = math.clamp(mid.X, size / 2 + 4, d.AbsoluteSize.X - size / 2 - 4)
		btn.Position = UDim2.fromOffset(math.floor(x + 0.5), math.floor(math.max(top, size + 4) + 0.5))
	end)
	btn.MouseEnter:Connect(function()
		b(stroke, { Color = a.StrokeHover }, 0.15)
	end)
	btn.MouseLeave:Connect(function()
		b(stroke, { Color = a.Stroke }, 0.15)
	end)
	local down, moved, grab, start = false, false, Vector2.zero, Vector2.zero
	btn.InputBegan:Connect(function(a)
		if r(a) then
			down, moved = true, false
			start = s()
			grab = start - (btn.AbsolutePosition + Vector2.new(size / 2, size))
		end
	end)
	table.insert(
		self._connections,
		p.InputChanged:Connect(function(a)
			if not down or not U(a) then
				return
			end
			local m = s()
			if not moved and (m - start).Magnitude < 6 then
				return
			end
			moved = true
			local at = m - grab - d.AbsolutePosition
			free = Vector2.new(math.clamp(at.X, size / 2, d.AbsoluteSize.X - size / 2), math.clamp(at.Y, size, d.AbsoluteSize.Y))
			place(free.X, free.Y)
		end)
	)
	table.insert(
		self._connections,
		p.InputEnded:Connect(function(a)
			if not (down and r(a)) then
				return
			end
			down = false
			if not moved then
				return self:Toggle()
			end
		end)
	)
end
function h:_enableResize(i)
	local j = self.MaxSize or Vector2.new(math.huge, math.huge)
	local f = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(1, 4, 1, 4),
			Size = UDim2.fromOffset(32, 32),
			BackgroundTransparency = 1,
			Active = true,
			ZIndex = 20,
			Parent = self.Root,
		}
	)
	self._grip = f
	local g, d =
		c(
			"ImageLabel",
			{
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, -16, 0.5, -16),
				Size = UDim2.fromOffset(96, 96),
				BackgroundTransparency = 1,
				Image = "rbxassetid://120997033468887",
				ImageColor3 = a.Text,
				ImageTransparency = 0.8,
				ZIndex = 20,
				Parent = f,
			}
		),
		false
	local h = self.Root.Size
	local k = Vector2.zero
	local e
	f.InputBegan:Connect(function(a)
		if r(a) then
			d = true
			h = self.Root.Size
			k = s()
			b(g, { ImageTransparency = 0.35 }, 0.1)
		end
	end)
	f.MouseEnter:Connect(function()
		if not d then
			b(g, { ImageTransparency = 0.35 }, 0.1)
		end
	end)
	f.MouseLeave:Connect(function()
		if not d then
			b(g, { ImageTransparency = 0.8 }, 0.17)
		end
	end)
	table.insert(
		self._connections,
		p.InputEnded:Connect(function(a)
			if d and r(a) then
				d = false
				b(g, { ImageTransparency = 0.8 }, 0.17)
				if e then
					self.Root.Size = UDim2.fromOffset(e.X, e.Y)
					e = nil
				end
				self:_fitToScreen()
				self:_clampToScreen()
			end
		end)
	)
	table.insert(self._frameSteps, function(f)
		if not d then
			return
		end
		local b = (s() - k) / self.Scale.Scale
		e = Vector2.new(math.clamp(h.X.Offset + b.X * 2, i.X, j.X), math.clamp(h.Y.Offset + b.Y * 2, i.Y, j.Y))
		local c = Vector2.new(self.Root.Size.X.Offset, self.Root.Size.Y.Offset)
		local g = 1 - math.exp(-f * 35)
		local a = c:Lerp(e, g)
		a = Vector2.new(math.floor(a.X + 0.5), math.floor(a.Y + 0.5))
		if a ~= c then
			self.Root.Size = UDim2.fromOffset(a.X, a.Y)
		end
	end)
end
local function aF(a)
	a = tostring(a or ""):gsub('[%c/\\:%*%?"<>|]', ""):gsub("%.%.+", "."):gsub("^[%s%.]+", ""):gsub("[%s%.]+$", "")
	if a == "" then
		return nil
	end
	return a
end
local function Y(b, c)
	local a = aF(c)
	if not a then
		return nil, "invalid config name"
	end
	return b.ConfigFolder .. "/" .. a .. ".json", a
end
local function Z()
	local a = "function"
	return type(writefile) == a and type(readfile) == a and type(isfile) == a
end
local function aG(a)
	if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder(a) then
		makefolder(a)
	end
end
local function aH(c)
	local b = c._type
	local a = c:Get()
	if b == "Keybind" then
		return { Type = b, Value = a and a.Name or nil }
	elseif b == "ColorPicker" then
		return { Type = b, Value = { a.R, a.G, a.B } }
	end
	return { Type = b, Value = a }
end
local function aI(b, e, c)
	local d = b._type
	local a = e.Value
	if d == "Keybind" then
		b:Set(F(a), c)
	elseif d == "ColorPicker" then
		if type(a) == "table" then
			b:Set(Color3.new(a[1], a[2], a[3]), c)
		end
	elseif a ~= nil then
		b:Set(a, c)
	end
end
function h:SaveConfig(e)
	if not Z() then
		return false, "file API unavailable"
	end
	local a, b = Y(self, e or self.ConfigName)
	if not a then
		return false, b
	end
	local c = {}
	for b, a in pairs(self.Flags) do
		if a._type and type(a.Get) == "function" then
			c[b] = aH(a)
		end
	end
	local d, f = pcall(function()
		aG(self.ConfigFolder)
		writefile(a, H:JSONEncode(c))
	end)
	if d then
		self.ConfigName = b
	end
	return d, f
end
function h:LoadConfig(a, e)
	if not Z() then
		return false, "file API unavailable"
	end
	local b, c = Y(self, a or self.ConfigName)
	if not b then
		return false, c
	end
	a = c
	if not isfile(b) then
		return false, "no config named " .. a
	end
	local f, d = pcall(function()
		return H:JSONDecode(readfile(b))
	end)
	if not f or type(d) ~= "table" then
		return false, "config is not valid JSON"
	end
	local g = self._autoSaveEnabled
	self._autoSaveEnabled = false
	for c, b in pairs(d) do
		local a = self.Flags[c]
		if a and type(a.Set) == "function" and type(b) == "table" and b.Type == a._type then
			local d, f = pcall(aI, a, b, e == true)
			if not d then
				warn("[Astris] could not load flag " .. tostring(c) .. ": " .. tostring(f))
			end
		end
	end
	self._autoSaveEnabled = g
	self._autoSaveReady = true
	self.ConfigName = a
	return true
end
function h:DeleteConfig(c)
	if not Z() or type(delfile) ~= "function" then
		return false, "file API unavailable"
	end
	local a, b = Y(self, c)
	if not a then
		return false, b
	end
	if not isfile(a) then
		return false, "no config named " .. b
	end
	local d, e = pcall(delfile, a)
	return d, e
end
function h:ListConfigs()
	local a = {}
	if type(listfiles) ~= "function" or type(isfolder) ~= "function" or not isfolder(self.ConfigFolder) then
		return a
	end
	for d, c in ipairs(listfiles(self.ConfigFolder)) do
		local b = c:match("([^/\\]+)%.json$")
		if b then
			table.insert(a, b)
		end
	end
	table.sort(a)
	return a
end
function h:SetAutoSave(a)
	self._autoSaveEnabled = a == true
end
function h:_autoSave()
	if not self._autoSaveEnabled or self._destroyed or not self._autoSaveReady then
		return
	end
	if self._autoSavePending then
		return
	end
	self._autoSavePending = true
	task.delay(0.5, function()
		self._autoSavePending = false
		if not self._destroyed then
			self:SaveConfig(self.ConfigName)
		end
	end)
end
local function aJ(e, g, h)
	local b = c(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, -10),
			Size = UDim2.fromOffset(200, 70),
			BackgroundTransparency = 1,
			Parent = e,
		}
	)
	local d = c(
		"ImageLabel",
		{
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.fromOffset(26, 26),
			BackgroundTransparency = 1,
			ImageColor3 = a.Muted,
			ImageTransparency = 0.15,
			ScaleType = Enum.ScaleType.Fit,
			Parent = b,
		}
	)
	u(d, g)
	local i = f({
		Position = UDim2.fromOffset(0, 36),
		Size = UDim2.new(1, 0, 0, 16),
		Text = h,
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = b,
	})
	return b, i, d
end
local function aK(e, h, d, j)
	local b = c(
		"Frame",
		{ Size = UDim2.new(0.5, -4, 0, 62), BackgroundColor3 = a.Surface2, BorderSizePixel = 0, LayoutOrder = h, Parent = e }
	)
	g(b)
	i(b)
	b:SetAttribute("NoDrag", true)
	if d then
		A(b, d, a.Muted, UDim2.new(0, 14, 0, 21))
	end
	f({
		Position = UDim2.fromOffset(d and 36 or 14, 12),
		Size = UDim2.new(1, -(d and 50 or 28), 0, 16),
		Text = j,
		TextSize = 12,
		TextColor3 = a.Muted,
		Parent = b,
	})
	return f({ Position = UDim2.fromOffset(14, 34), Size = UDim2.new(1, -28, 0, 18), Text = "…", TextSize = 15, Parent = b })
end
local am = setmetatable({}, { __mode = "k" })
local function an(c)
	local d = {}
	local function a(a, c)
		local b = am[a]
		if b == nil then
			b = a[c]
			am[a] = b
		end
		table.insert(d, { a, c, b })
	end
	local function e(b)
		for c, b in ipairs(b:GetChildren()) do
			if b:IsA("TextLabel") or b:IsA("TextButton") or b:IsA("TextBox") then
				a(b, "TextTransparency")
			elseif b:IsA("ImageLabel") or b:IsA("ImageButton") then
				a(b, "ImageTransparency")
			elseif b:IsA("UIStroke") then
				a(b, "Transparency")
			elseif b:IsA("Frame") then
				a(b, "BackgroundTransparency")
			end
			e(b)
		end
	end
	if c:IsA("Frame") then
		a(c, "BackgroundTransparency")
	end
	e(c)
	for c, a in ipairs(d) do
		a[1][a[2]] = 1
		b(a[1], { [a[2]] = a[3] }, 0.28)
	end
end
local function aL(a, c)
	c = c or 0
	a.GroupTransparency = 1
	a.Position = UDim2.fromOffset(0, c + 14)
	a.Visible = true
	b(a, { GroupTransparency = 0, Position = UDim2.fromOffset(0, c) }, 0.32, Enum.EasingStyle.Quint)
end
function h:_buildHome(d)
	local e, n, p, w = "Frame", "UIListLayout", "NoDrag", "Executor"
	local m = self:Tab({ Name = d.Name or "Home", Desc = d.Desc, Icon = d.Icon or "house" })
	local q = m.List
	local x = d.Pages or d.Tabs
	local r = {}
	local s
	if type(x) == "table" and #x > 0 then
		s = c(e, { Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1, LayoutOrder = 1, Parent = q })
		c(
			n,
			{
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
				Parent = s,
			}
		)
	end
	local y = d.Greeting
	if y == nil then
		local a = tonumber(os.date("%H")) or 12
		local b = a < 12 and "morning" or (a < 18 and "afternoon" or "evening")
		y = "Good " .. b .. "."
	end
	local h = c(
		e,
		{ Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = a.Surface2, BorderSizePixel = 0, LayoutOrder = 2, Parent = q }
	)
	h:SetAttribute(p, true)
	g(h)
	i(h)
	local z = c(
		"ImageLabel",
		{
			Position = UDim2.fromOffset(12, 11),
			Size = UDim2.fromOffset(36, 36),
			BackgroundColor3 = a.Surface,
			BorderSizePixel = 0,
			Parent = h,
		}
	)
	g(z, UDim.new(0, 8))
	i(z)
	task.spawn(function()
		local b, a = pcall(function()
			return I:GetUserThumbnailAsync(J.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		end)
		if b and a then
			z.Image = a
		end
	end)
	f({
		Position = UDim2.fromOffset(58, 11),
		Size = UDim2.new(1, -72, 0, 18),
		Text = (d.Welcome or "Hello, ") .. J.DisplayName,
		TextSize = 15,
		Parent = h,
	})
	f({
		Position = UDim2.fromOffset(58, 30),
		Size = UDim2.new(1, -72, 0, 16),
		Text = y,
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		Parent = h,
	})
	local t = c(
		e,
		{ Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 3, Parent = q }
	)
	c(n, { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = t })
	if d.Sections ~= false then
		local b = c(e, { Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, LayoutOrder = 1, Parent = t })
		local g = f({
			Position = UDim2.fromOffset(2, 6),
			Size = UDim2.new(0, 0, 0, 16),
			AutomaticSize = Enum.AutomaticSize.X,
			Text = string.upper(d.SectionName or "System info"),
			TextSize = 12,
			TextColor3 = a.Muted,
			TextTruncate = Enum.TextTruncate.None,
			Parent = b,
		})
		local i = c(
			e,
			{
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, 0, 0, 14),
				Size = UDim2.new(1, -12, 0, 1),
				BackgroundColor3 = a.Stroke,
				BorderSizePixel = 0,
				Parent = b,
			}
		)
		local function h()
			i.Size = UDim2.new(1, -(g.AbsoluteSize.X / self.Scale.Scale + 14), 0, 1)
		end
		g:GetPropertyChangedSignal("AbsoluteSize"):Connect(h)
		task.defer(h)
	end
	local C = c(
		e,
		{ Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 2, Parent = t }
	)
	c(
		"UIGridLayout",
		{
			CellSize = UDim2.new(0.5, -4, 0, 62),
			CellPadding = UDim2.fromOffset(8, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = C,
		}
	)
	local N = d.Stats or { "FPS", "Ping", w, "Game", "Server", "Time" }
	local D = {}
	for b, a in ipairs(N) do
		D[a == "Region" and "Server" or a] = true
	end
	local E = 0
	local function k(a, b, c)
		if not D[a] then
			return nil
		end
		E += 1
		return aK(C, E, b, c)
	end
	local F = k("FPS", "activity", "FPS")
	local G = k("Ping", "wifi", "Ping")
	local H = k(w, "terminal", w)
	local A = k("Game", "gamepad-2", "Game")
	local B = k("Server", "hourglass", "Time in server")
	local K = k("Time", "clock", "Time of day")
	local L = k("Players", "users", "Players")
	local M = k("Uptime", "timer", "Session")
	if H then
		H.Text = ax()
	end
	if A then
		A.Text = "Loading"
		task.spawn(function()
			A.Text = ay()
		end)
	end
	local v = 0
	local O = os.clock()
	self:_listen("Render", function()
		v += 1
	end)
	task.spawn(function()
		while not self._destroyed and m.List.Parent and m._page.Parent do
			if not self.Open or self.CurrentTab ~= m then
				v = 0
				task.wait(1)
				continue
			end
			if F then
				F.Text = tostring(v)
			end
			v = 0
			if G then
				local a, b = pcall(function()
					return math.floor(J:GetNetworkPing() * 1e3)
				end)
				G.Text = (a and b or 0) .. " ms"
			end
			if B then
				local a = math.floor(workspace.DistributedGameTime)
				B.Text = a >= 3600 and string.format("%d:%02d:%02d", a // 3600, a // 60 % 60, a % 60)
					or string.format("%d:%02d", a // 60, a % 60)
			end
			if K then
				K.Text = os.date(d.TimeFormat or "%H:%M")
			end
			if L then
				L.Text = #I:GetPlayers() .. " / " .. I.MaxPlayers
			end
			if M then
				local a = math.floor(os.clock() - O)
				M.Text = string.format("%d:%02d", math.floor(a / 60), a % 60)
			end
			task.wait(1)
		end
	end)
	table.insert(r, { Title = d.SectionName or "Details", Icon = d.TabIcon or "layout-grid", Frame = t })
	if s then
		for h, b in ipairs(x) do
			local d = c(
				e,
				{
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Visible = false,
					LayoutOrder = 3,
					Parent = q,
				}
			)
			c(n, { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = d })
			if type(b.Content) == "string" then
				local h = c(
					e,
					{
						Size = UDim2.new(1, 0, 0, 0),
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = a.Surface2,
						BorderSizePixel = 0,
						LayoutOrder = 1,
						Parent = d,
					}
				)
				h:SetAttribute(p, true)
				g(h)
				i(h)
				o(h, 14, 14, 12, 14)
				f({
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					Text = b.Content,
					TextSize = 13,
					FontFace = j.Regular,
					TextColor3 = a.Muted,
					TextWrapped = true,
					TextTruncate = Enum.TextTruncate.None,
					TextYAlignment = Enum.TextYAlignment.Top,
					Parent = h,
				})
			end
			if type(b.Entries) == "table" then
				for m, b in ipairs(b.Entries) do
					local h = c(
						e,
						{
							Size = UDim2.new(1, 0, 0, 0),
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundColor3 = a.Surface2,
							BorderSizePixel = 0,
							LayoutOrder = m,
							Parent = d,
						}
					)
					h:SetAttribute(p, true)
					g(h)
					i(h)
					o(h, 14, 14, 12, 14)
					c(n, { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = h })
					local l =
						c(e, { Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, LayoutOrder = 1, Parent = h })
					f({ Size = UDim2.new(1, -70, 1, 0), Text = b.Title or b.Version or "Update", TextSize = 14, Parent = l })
					if b.Date or b.Tag then
						local d = c(
							e,
							{
								AnchorPoint = Vector2.new(1, 0.5),
								Position = UDim2.new(1, 0, 0.5, 0),
								Size = UDim2.fromOffset(0, 20),
								AutomaticSize = Enum.AutomaticSize.X,
								BackgroundColor3 = a.Surface,
								BorderSizePixel = 0,
								Parent = l,
							}
						)
						g(d, UDim.new(0, 5))
						i(d)
						o(d, 8, 8)
						f({
							Size = UDim2.new(0, 0, 1, 0),
							AutomaticSize = Enum.AutomaticSize.X,
							Text = b.Tag or b.Date,
							TextSize = 11,
							TextColor3 = a.Muted,
							TextTruncate = Enum.TextTruncate.None,
							Parent = d,
						})
					end
					local k = b.Content or b.Body
					if type(b.Changes) == "table" then
						k = "• " .. table.concat(b.Changes, "\n• ")
					end
					if k then
						f({
							Size = UDim2.new(1, 0, 0, 0),
							AutomaticSize = Enum.AutomaticSize.Y,
							Text = k,
							TextSize = 13,
							FontFace = j.Regular,
							TextColor3 = a.Muted,
							TextWrapped = true,
							TextTruncate = Enum.TextTruncate.None,
							TextYAlignment = Enum.TextYAlignment.Top,
							LayoutOrder = 2,
							Parent = h,
						})
					end
				end
			end
			if type(b.Build) == "function" then
				l(b.Build, d)
				for b, a in ipairs(d:GetChildren()) do
					if a:IsA("GuiObject") then
						a:SetAttribute(p, true)
					end
				end
			end
			table.insert(r, { Title = b.Name or b.Title or "Page", Icon = b.Icon, Frame = d })
		end
		local d = {}
		local function k(c, e)
			local f = self._homeIndex ~= c
			self._homeIndex = c
			h.Visible = c == 1
			if c == 1 and f and not e then
				an(h)
			end
			for i, k in ipairs(r) do
				local g = i == c
				local j = k.Frame
				j.Visible = g
				if g and f and not e then
					for b, a in ipairs(j:GetChildren()) do
						if a:IsA("GuiObject") then
							an(a)
						end
					end
				end
				local h = d[i]
				if h then
					b(h.Frame, { BackgroundTransparency = g and 0 or 1 }, 0.15)
					b(h.Stroke, { Transparency = g and 0 or 1 }, 0.15)
					b(h.Label, { TextColor3 = g and a.Text or a.Muted }, 0.15)
					if h.Icon then
						b(h.Icon, { ImageColor3 = g and a.Accent or a.Muted }, 0.15)
					end
				end
			end
		end
		for h, l in ipairs(r) do
			local e = c(
				"TextButton",
				{
					Size = UDim2.fromOffset(0, 32),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = a.Surface2,
					BackgroundTransparency = 1,
					Text = "",
					AutoButtonColor = false,
					LayoutOrder = h,
					Parent = s,
				}
			)
			g(e, UDim.new(0, 7))
			local m = i(e, a.Stroke, 1)
			o(e, 12, 12)
			local j
			if l.Icon then
				j = c(
					"ImageLabel",
					{
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, 0, 0.5, 0),
						Size = UDim2.fromOffset(14, 14),
						BackgroundTransparency = 1,
						ImageColor3 = a.Muted,
						ScaleType = Enum.ScaleType.Fit,
						Parent = e,
					}
				)
				u(j, l.Icon)
			end
			local n = f({
				Position = UDim2.fromOffset(j and 20 or 0, 0),
				Size = UDim2.new(0, 0, 1, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				Text = l.Title,
				TextSize = 13,
				TextColor3 = a.Muted,
				TextTruncate = Enum.TextTruncate.None,
				Parent = e,
			})
			d[h] = { Frame = e, Stroke = m, Label = n, Icon = j }
			e.MouseEnter:Connect(function()
				if self._homeIndex ~= h then
					b(e, { BackgroundTransparency = 0.4 }, 0.12)
					b(m, { Transparency = 0.5 }, 0.12)
				end
			end)
			e.MouseLeave:Connect(function()
				if self._homeIndex ~= h then
					b(e, { BackgroundTransparency = 1 }, 0.2)
					b(m, { Transparency = 1 }, 0.2)
				end
			end)
			e.MouseButton1Click:Connect(function()
				k(h)
			end)
		end
		k(1)
	end
	m._order = 10
	self.Home = m
	return m
end
function h:_pinTab(tab, order)
	tab._button.LayoutOrder = order
	return tab
end
function h:_card(tab, height, color)
	local card = c("Frame", {
		Size = UDim2.new(1, 0, 0, height),
		BackgroundColor3 = color or a.Surface2,
		BorderSizePixel = 0,
		LayoutOrder = tab:_nextOrder(),
		Parent = tab.List,
	})
	card:SetAttribute("NoDrag", true)
	g(card)
	i(card)
	return card
end
function h:_pill(parent, icon, text, props)
	local btn = c("TextButton", {
		BackgroundColor3 = a.Surface,
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		Parent = parent,
	})
	for key, value in pairs(props or {}) do
		btn[key] = value
	end
	g(btn, UDim.new(0, 7))
	local stroke = i(btn)
	local icon_label
	if icon then
		icon_label = c("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 10, 0.5, 0),
			Size = UDim2.fromOffset(14, 14),
			BackgroundTransparency = 1,
			ImageColor3 = a.Muted,
			ScaleType = Enum.ScaleType.Fit,
			Parent = btn,
		})
		u(icon_label, icon)
	end
	local label = f({
		Position = UDim2.fromOffset(icon and 30 or 0, 0),
		Size = UDim2.new(1, icon and -38 or 0, 1, 0),
		Text = text,
		TextSize = 13,
		TextXAlignment = icon and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
		Parent = btn,
	})
	btn.MouseEnter:Connect(function()
		b(stroke, { Color = a.StrokeHover }, 0.12)
		if icon_label then
			b(icon_label, { ImageColor3 = a.Accent }, 0.12)
		end
	end)
	btn.MouseLeave:Connect(function()
		b(stroke, { Color = a.Stroke }, 0.2)
		if icon_label then
			b(icon_label, { ImageColor3 = a.Muted }, 0.2)
		end
	end)
	return btn, label
end
function h:_buildServer(d)
	local teleport = game:GetService("TeleportService")
	local tab = self:_pinTab(self:Tab({ Name = d.Name or "Server", Desc = d.Desc, Icon = d.Icon or "server" }), 9001)
	local window = self

	local current = self:_card(tab, 88)
	f({ Position = UDim2.fromOffset(14, 12), Size = UDim2.new(1, -120, 0, 18), Text = "This server", TextSize = 15, Parent = current })
	local live = f({
		Position = UDim2.fromOffset(14, 32),
		Size = UDim2.new(1, -120, 0, 16),
		Text = "…",
		TextSize = 13,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		Parent = current,
	})
	local job = game.JobId ~= "" and game.JobId or "studio"
	f({
		Position = UDim2.fromOffset(14, 56),
		Size = UDim2.new(1, -120, 0, 16),
		Text = "ID  " .. job:sub(1, 8) .. "…" .. job:sub(-4),
		TextSize = 12,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		Parent = current,
	})
	local copy = self:_pill(current, "copy", "Copy ID", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(92, 32),
	})
	copy.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard(game.JobId)
			window:Notify({ Title = "Copied", Content = "Server ID is on your clipboard.", Duration = 3 })
		end
	end)

	local function go(id)
		if id then
			teleport:TeleportToPlaceInstance(game.PlaceId, id, J)
		else
			teleport:Teleport(game.PlaceId, J)
		end
	end
	local cache = {}
	local function fetch(order)
		local ok, body = pcall(game.HttpGet, game, ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100"):format(game.PlaceId, order or "Desc"))
		if not ok then
			return nil
		end
		local okj, data = pcall(H.JSONDecode, H, body)
		if not okj or type(data) ~= "table" or type(data.data) ~= "table" then
			return nil
		end
		local out = {}
		for _, s in ipairs(data.data) do
			if s.id ~= game.JobId and (s.playing or 0) < (s.maxPlayers or 0) then
				table.insert(out, s)
			end
		end
		return out
	end

	local actions = c("Frame", {
		Size = UDim2.new(1, 0, 0, 80),
		BackgroundTransparency = 1,
		LayoutOrder = tab:_nextOrder(),
		Parent = tab.List,
	})
	c("UIGridLayout", {
		CellSize = UDim2.new(0.5, -4, 0, 36),
		CellPadding = UDim2.fromOffset(8, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = actions,
	})
	local function action(order, icon, text, fn)
		local btn = self:_pill(actions, icon, text, { LayoutOrder = order, BackgroundColor3 = a.Surface2 })
		btn:SetAttribute("NoDrag", true)
		btn.MouseButton1Click:Connect(function()
			task.spawn(fn)
		end)
	end
	action(1, "rotate-ccw", "Rejoin", function()
		window:Notify({ Title = "Rejoining", Content = "Hang on.", Duration = 3 })
		go(#I:GetPlayers() <= 1 and nil or game.JobId)
	end)
	action(2, "shuffle", "Server hop", function()
		local list = fetch("Desc")
		if not list or #list == 0 then
			return window:Notify({ Title = "No servers", Content = "Could not find another server.", Duration = 4 })
		end
		go(list[math.random(#list)].id)
	end)
	action(3, "user-minus", "Smallest server", function()
		local list = fetch("Asc")
		if not list or #list == 0 then
			return window:Notify({ Title = "No servers", Content = "Could not find another server.", Duration = 4 })
		end
		table.sort(list, function(x, y)
			return x.playing < y.playing
		end)
		go(list[1].id)
	end)
	action(4, "code", "Copy join script", function()
		if setclipboard then
			setclipboard(('game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s")'):format(game.PlaceId, game.JobId))
			window:Notify({ Title = "Copied", Content = "Paste it in your executor to join this server.", Duration = 3 })
		end
	end)

	tab:Section("Servers")
	local head = c("Frame", { Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1, LayoutOrder = tab:_nextOrder(), Parent = tab.List })
	local status = f({ Size = UDim2.new(1, -200, 1, 0), Position = UDim2.fromOffset(2, 0), Text = "Loading", TextSize = 13, FontFace = j.Regular, TextColor3 = a.Muted, Parent = head })
	local sort_btn, sort_label = self:_pill(head, "arrow-down-up", "Most players", {
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -40, 0, 0),
		Size = UDim2.fromOffset(130, 32),
		BackgroundColor3 = a.Surface2,
	})
	local refresh = self:_pill(head, "refresh-cw", "", {
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.fromOffset(32, 32),
		BackgroundColor3 = a.Surface2,
	})
	sort_btn:SetAttribute("NoDrag", true)
	refresh:SetAttribute("NoDrag", true)
	local rows = c("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = tab:_nextOrder(),
		Parent = tab.List,
	})
	c("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), Parent = rows })

	local sorts = { { "Most players", "Desc" }, { "Fewest players", "Asc" }, { "Best ping", "Desc" } }
	local sort_index = 1
	local busy = false
	local function row(order, s)
		local r = c("Frame", { Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = a.Surface2, BorderSizePixel = 0, LayoutOrder = order, Parent = rows })
		r:SetAttribute("NoDrag", true)
		g(r)
		i(r)
		local fill = (s.playing or 0) / math.max(s.maxPlayers or 1, 1)
		f({ Position = UDim2.fromOffset(14, 8), Size = UDim2.fromOffset(90, 16), Text = ("%d / %d"):format(s.playing or 0, s.maxPlayers or 0), TextSize = 14, Parent = r })
		local track = c("Frame", { Position = UDim2.fromOffset(14, 32), Size = UDim2.new(1, -220, 0, 4), BackgroundColor3 = a.Surface3, BorderSizePixel = 0, Parent = r })
		g(track, UDim.new(1, 0))
		local bar = c("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = a.Accent, BorderSizePixel = 0, Parent = track })
		g(bar, UDim.new(1, 0))
		b(bar, { Size = UDim2.fromScale(fill, 1) }, 0.4)
		local ping = s.ping and (s.ping .. " ms") or "–"
		f({
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -96, 0.5, 0),
			Size = UDim2.fromOffset(90, 16),
			Text = ping,
			TextSize = 13,
			FontFace = j.Regular,
			TextColor3 = a.Muted,
			TextXAlignment = Enum.TextXAlignment.Right,
			Parent = r,
		})
		local join = self:_pill(r, "log-in", "Join", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -8, 0.5, 0),
			Size = UDim2.fromOffset(76, 32),
		})
		join.MouseButton1Click:Connect(function()
			go(s.id)
		end)
	end
	local function load()
		if busy then
			return
		end
		busy = true
		status.Text = "Loading"
		local mode = sorts[sort_index]
		local list = fetch(mode[2]) or {}
		if sort_index == 3 then
			table.sort(list, function(x, y)
				return (x.ping or 9e9) < (y.ping or 9e9)
			end)
		end
		cache = list
		for _, child in ipairs(rows:GetChildren()) do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end
		for n, s in ipairs(list) do
			if n > 25 then
				break
			end
			row(n, s)
		end
		status.Text = #list == 0 and "No open servers found" or (#list .. " open servers")
		busy = false
	end
	sort_btn.MouseButton1Click:Connect(function()
		sort_index = sort_index % #sorts + 1
		sort_label.Text = sorts[sort_index][1]
		task.spawn(load)
	end)
	refresh.MouseButton1Click:Connect(function()
		task.spawn(load)
	end)

	local loaded = false
	task.spawn(function()
		while not self._destroyed and tab.List.Parent do
			if self.Open and self.CurrentTab == tab then
				if not loaded then
					loaded = true
					task.spawn(load)
				end
				local okp, p = pcall(function()
					return math.floor(J:GetNetworkPing() * 1e3)
				end)
				local t = math.floor(workspace.DistributedGameTime)
				live.Text = ("%d / %d players  ·  %d ms  ·  %s"):format(
					#I:GetPlayers(),
					I.MaxPlayers,
					okp and p or 0,
					t >= 3600 and ("%d:%02d:%02d"):format(t // 3600, t // 60 % 60, t % 60) or ("%d:%02d"):format(t // 60, t % 60)
				)
			end
			task.wait(1)
		end
	end)
	self.ServerTab = tab
	return tab
end
function h:_buildEsp(d)
	local tab = self:_pinTab(self:Tab({ Name = d.Name or "ESP", Desc = d.Desc, Icon = d.Icon or "scan-eye" }), 9002)
	local S = { Enabled = false, Box = true, Name = true, Distance = true, Health = true, Tracer = false, Chams = false, Outline = false, Color = Color3.fromRGB(0, 227, 255), MaxDistance = 1500 }
	self.Esp = S
	local W = 280

	-- preview panel, docked beside the window
	local panel = c("Frame", {
		Name = "EspPreview",
		Size = UDim2.fromOffset(W, 400),
		BackgroundColor3 = a.Background,
		BorderSizePixel = 0,
		Visible = false,
		Parent = self.Gui,
	})
	panel:SetAttribute("NoDrag", true)
	g(panel, UDim.new(0, 10))
	local panel_stroke = i(panel, a.Stroke)
	local panel_scale = c("UIScale", { Parent = panel })
	local panel_title = f({ Position = UDim2.fromOffset(16, 14), Size = UDim2.new(1, -32, 0, 18), Text = "Preview", TextSize = 15, Parent = panel })
	local card = c("Frame", {
		Position = UDim2.fromOffset(12, 44),
		Size = UDim2.new(1, -24, 1, -56),
		BackgroundColor3 = a.Surface,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = panel,
	})
	card:SetAttribute("NoDrag", true)
	g(card)
	local card_stroke = i(card)
	-- flat, slightly inflated copy drawn behind the avatar = outline
	local ghost_vp = c("ViewportFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Ambient = Color3.new(1, 1, 1),
		LightColor = Color3.new(0, 0, 0),
		ImageColor3 = S.Color,
		Visible = false,
		Parent = card,
	})
	ghost_vp:SetAttribute("AstrisNoTheme", true)
	local ghost_world = c("WorldModel", { Parent = ghost_vp })
	local ghost_cam = c("Camera", { FieldOfView = 36, Parent = ghost_vp })
	ghost_vp.CurrentCamera = ghost_cam
	local ghost
	local vp = c("ViewportFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Ambient = Color3.fromRGB(170, 170, 170),
		LightColor = Color3.new(1, 1, 1),
		LightDirection = Vector3.new(-0.4, -1, 0.6),
		Parent = card,
	})
	local world = c("WorldModel", { Parent = vp })
	local cam = c("Camera", { FieldOfView = 36, Parent = vp })
	vp.CurrentCamera = cam
	local layer = c("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 3, Parent = card })
	f({
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -12, 1, -8),
		Size = UDim2.fromOffset(120, 14),
		Text = "Drag to rotate",
		TextSize = 11,
		FontFace = j.Regular,
		TextColor3 = a.Muted,
		TextXAlignment = Enum.TextXAlignment.Right,
		ZIndex = 4,
		Parent = layer,
	})

	local function line(parent)
		local fr = c("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, BackgroundColor3 = S.Color, ZIndex = 3, Parent = parent })
		fr:SetAttribute("AstrisNoTheme", true)
		return fr
	end
	local function box_frame(parent)
		local fr = c("Frame", { BackgroundTransparency = 1, ZIndex = 3, Parent = parent })
		c("UIStroke", { Color = Color3.new(0, 0, 0), Thickness = 3, Transparency = 0.4, Parent = fr })
		local inner = c("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 3, Parent = fr })
		local st = c("UIStroke", { Color = S.Color, Thickness = 1.5, Parent = inner })
		fr:SetAttribute("AstrisNoTheme", true)
		inner:SetAttribute("AstrisNoTheme", true)
		return fr, st
	end
	local function tag(parent, size)
		local t = c("TextLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(200, 14),
			BackgroundTransparency = 1,
			TextColor3 = Color3.new(1, 1, 1),
			TextStrokeTransparency = 0.4,
			TextSize = size,
			FontFace = j.Medium,
			ZIndex = 4,
			Parent = parent,
		})
		t:SetAttribute("AstrisNoTheme", true)
		return t
	end
	local function hp_bar(parent)
		local bg = c("Frame", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, ZIndex = 3, Parent = parent })
		local fill = c("Frame", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, ZIndex = 4, Parent = bg })
		bg:SetAttribute("AstrisNoTheme", true)
		fill:SetAttribute("AstrisNoTheme", true)
		return bg, fill
	end
	local function hp_color(r)
		return Color3.fromRGB(255, 80, 80):Lerp(Color3.fromRGB(95, 211, 141), math.clamp(r, 0, 1))
	end

	local pv = {}
	pv.box, pv.boxStroke = box_frame(layer)
	pv.name = tag(layer, 13)
	pv.dist = tag(layer, 11)
	pv.hpBg, pv.hpFill = hp_bar(layer)
	pv.tracer = line(layer)

	local model, center, height = nil, Vector3.zero, 5
	local function build()
		if model then
			model:Destroy()
			model = nil
		end
		if ghost then
			ghost:Destroy()
			ghost = nil
		end
		local char = J.Character
		if not char then
			return
		end
		local was = char.Archivable
		char.Archivable = true
		local ok, clone = pcall(char.Clone, char)
		char.Archivable = was
		if not ok or not clone then
			return
		end
		for _, x in ipairs(clone:GetDescendants()) do
			if x:IsA("LuaSourceContainer") or x:IsA("Sound") or x:IsA("ForceField") or x:IsA("BillboardGui") or x:IsA("Highlight") or x:IsA("ParticleEmitter") then
				x:Destroy()
			elseif x:IsA("BasePart") then
				x.Anchored = true
				x.CanCollide = false
			end
		end
		local root = clone:FindFirstChild("HumanoidRootPart")
		if root then
			clone.PrimaryPart = root
		end
		clone:PivotTo(CFrame.new())
		local cf, size = clone:GetBoundingBox()
		center, height = cf.Position, size.Y
		clone.Parent = world
		model = clone
		local copy = clone:Clone()
		local grow = 0.09
		for _, x in ipairs(copy:GetDescendants()) do
			if x:IsA("Decal") or x:IsA("Texture") or x:IsA("SurfaceAppearance") or x:IsA("Clothing") or x:IsA("ShirtGraphic") then
				x:Destroy()
			elseif x:IsA("BasePart") then
				local sz = x.Size
				local cf = x.CFrame
				x.Size = sz + Vector3.new(grow, grow, grow)
				x.CFrame = cf
				x.Color = Color3.new(1, 1, 1)
				x.Material = Enum.Material.SmoothPlastic
				if x:IsA("MeshPart") then
					x.TextureID = ""
				end
				if x.Transparency < 1 and x.Name ~= "HumanoidRootPart" then
					x.Transparency = 0
				end
			elseif x:IsA("SpecialMesh") then
				x.TextureId = ""
				if x.MeshType == Enum.MeshType.FileMesh and x.Parent:IsA("BasePart") then
					local base = x.Parent.Size - Vector3.new(grow, grow, grow)
					x.Scale = x.Scale * (Vector3.one + Vector3.new(grow, grow, grow) / base)
				end
				x.VertexColor = Vector3.one
			end
		end
		copy.Parent = ghost_world
		ghost = copy
		local dist = (height * 0.88) / math.tan(math.rad(cam.FieldOfView) / 2)
		cam.CFrame = CFrame.lookAt(center + Vector3.new(0, 0, -dist), center)
		ghost_cam.CFrame = cam.CFrame
	end
	build()
	table.insert(self._connections, J.CharacterAdded:Connect(function()
		task.wait(1)
		build()
	end))

	local function project(p)
		local lp = cam.CFrame:PointToObjectSpace(p)
		local t = math.tan(math.rad(cam.FieldOfView) / 2)
		local sz = card.AbsoluteSize
		local aspect = sz.X / math.max(sz.Y, 1)
		local z = math.max(-lp.Z, 0.01)
		return 0.5 + lp.X / z / (t * aspect) * 0.5, 0.5 - lp.Y / z / t * 0.5
	end

	local yaw, spin, dragging, last = 0, 0.35, false, nil
	card.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging, last = true, input.Position
		end
	end)
	self:_listen("Changed", function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			yaw += (input.Position.X - last.X) * 0.012
			last = input.Position
		end
	end)
	self:_listen("Ended", function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	local alpha = 0
	self:_listen("Render", function(dt)
		local want = self.Open and self.CurrentTab == tab and not self._destroyed
		alpha = want and math.min(alpha + dt * 6, 1) or math.max(alpha - dt * 8, 0)
		panel.Visible = alpha > 0
		if alpha <= 0 then
			return
		end
		local root = self.Root
		local ease = alpha * alpha * (3 - 2 * alpha)
		local s = root.AbsoluteSize.X / math.max(root.Size.X.Offset, 1)
		local hgt = root.Size.Y.Offset
		panel.Size = UDim2.fromOffset(W, hgt)
		panel_scale.Scale = s * (0.94 + 0.06 * ease)
		local pos = root.AbsolutePosition - self.Gui.AbsolutePosition
		local size = root.AbsoluteSize
		local pw, ph = W * panel_scale.Scale, hgt * panel_scale.Scale
		local slide = (1 - ease) * 16
		local on_right = pos.X + size.X / 2 <= self.Gui.AbsoluteSize.X / 2 + 1
		local x = on_right and (pos.X + size.X + 12 - slide) or (pos.X - 12 - pw + slide)
		panel.Position = UDim2.fromOffset(x, pos.Y + (size.Y - ph) / 2)
		local t = 1 - ease
		panel.BackgroundTransparency, panel_stroke.Transparency, panel_title.TextTransparency = t, t, t
		card.BackgroundTransparency, card_stroke.Transparency, vp.ImageTransparency, ghost_vp.ImageTransparency = t, t, t, t
		layer.Visible = ease > 0.9
	end)

	local clock = 0
	self:_listen("Render", function(dt)
		if not self.Open or self.CurrentTab ~= tab or not model then
			return
		end
		clock += dt
		if not dragging then
			yaw += dt * spin
		end
		local spin_cf = CFrame.new(center) * CFrame.Angles(0, yaw, 0) * CFrame.new(-center)
		model:PivotTo(spin_cf)
		ghost_vp.Visible = S.Outline and ghost ~= nil
		if ghost and S.Outline then
			ghost:PivotTo(spin_cf)
			ghost_vp.ImageColor3 = S.Color
		end
		vp.ImageColor3 = S.Chams and Color3.new(1, 1, 1):Lerp(S.Color, 0.75) or Color3.new(1, 1, 1)

		local top_x, top_y = project(center + Vector3.new(0, height * 0.5, 0))
		local _, bot_y = project(center - Vector3.new(0, height * 0.5, 0))
		local sz = card.AbsoluteSize
		local h_px = (bot_y - top_y) * sz.Y
		local w = h_px * 0.55 / math.max(sz.X, 1)
		local hh = bot_y - top_y
		local px = panel.AbsoluteSize.X / W

		pv.box.Visible = S.Box
		pv.box.Position = UDim2.fromScale(top_x - w / 2, top_y)
		pv.box.Size = UDim2.fromScale(w, hh)
		pv.boxStroke.Color = S.Color

		pv.name.Visible = S.Name
		pv.name.Text = J.DisplayName
		pv.name.Position = UDim2.fromScale(top_x, top_y - 10 * px / sz.Y)

		pv.dist.Visible = S.Distance
		pv.dist.Text = ("%d studs"):format(24 + math.floor(math.sin(clock * 0.6) * 6))
		pv.dist.Position = UDim2.fromScale(top_x, bot_y + 10 * px / sz.Y)

		local hp = 0.55 + 0.45 * math.cos(clock * 0.8)
		pv.hpBg.Visible = S.Health
		pv.hpBg.Position = UDim2.fromScale(top_x - w / 2 - 6 * px / sz.X, top_y)
		pv.hpBg.Size = UDim2.new(0, 3, hh, 0)
		pv.hpFill.Size = UDim2.fromScale(1, hp)
		pv.hpFill.BackgroundColor3 = hp_color(hp)

		pv.tracer.Visible = S.Tracer
		if S.Tracer then
			local x1, y1 = 0.5 * sz.X, sz.Y
			local x2, y2 = top_x * sz.X, bot_y * sz.Y
			local len = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) / px
			pv.tracer.Position = UDim2.fromScale((x1 + x2) / 2 / sz.X, (y1 + y2) / 2 / sz.Y)
			pv.tracer.Size = UDim2.fromOffset(len, 1.5)
			pv.tracer.Rotation = math.deg(math.atan2(y2 - y1, x2 - x1))
			pv.tracer.BackgroundColor3 = S.Color
		end
	end)

	-- real ESP
	local gui = c("ScreenGui", { Name = "AstrisESP", IgnoreGuiInset = true, ResetOnSpawn = false, DisplayOrder = 998, Parent = self.Gui.Parent })
	self._espGui = gui
	local marks = {}
	local function mark(plr)
		local m = {}
		m.box, m.boxStroke = box_frame(gui)
		m.name = tag(gui, 13)
		m.dist = tag(gui, 11)
		m.hpBg, m.hpFill = hp_bar(gui)
		m.tracer = line(gui)
		m.hl = c("Highlight", { FillTransparency = 0.5, OutlineTransparency = 0, DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, Enabled = false, Parent = gui })
		marks[plr] = m
		return m
	end
	local function hide(m)
		m.box.Visible, m.name.Visible, m.dist.Visible, m.hpBg.Visible, m.tracer.Visible, m.hl.Enabled = false, false, false, false, false, false
	end
	table.insert(self._connections, I.PlayerRemoving:Connect(function(plr)
		local m = marks[plr]
		if m then
			for _, x in pairs(m) do
				x:Destroy()
			end
			marks[plr] = nil
		end
	end))
	self:_listen("Render", function()
		local camera = workspace.CurrentCamera
		if not S.Enabled or not camera then
			for _, m in pairs(marks) do
				hide(m)
			end
			return
		end
		local vs = camera.ViewportSize
		local me = J.Character and J.Character:FindFirstChild("HumanoidRootPart")
		for _, plr in ipairs(I:GetPlayers()) do
			if plr ~= J then
				local m = marks[plr] or mark(plr)
				local char = plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				local studs = root and me and (root.Position - me.Position).Magnitude or 0
				if not root or not hum or hum.Health <= 0 or studs > S.MaxDistance then
					hide(m)
				else
					local top, on = camera:WorldToViewportPoint(root.Position + Vector3.new(0, 3, 0))
					local bot = camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3.5, 0))
					m.hl.Adornee = char
					m.hl.Enabled = S.Chams or S.Outline
					m.hl.FillTransparency = S.Chams and 0.5 or 1
					m.hl.OutlineTransparency = S.Outline and 0 or 1
					m.hl.FillColor, m.hl.OutlineColor = S.Color, S.Color
					if not on then
						m.box.Visible, m.name.Visible, m.dist.Visible, m.hpBg.Visible, m.tracer.Visible = false, false, false, false, false
					else
						local hgt = math.max(bot.Y - top.Y, 4)
						local w = hgt * 0.55
						m.box.Visible = S.Box
						m.box.Position = UDim2.fromOffset(top.X - w / 2, top.Y)
						m.box.Size = UDim2.fromOffset(w, hgt)
						m.boxStroke.Color = S.Color
						m.name.Visible = S.Name
						m.name.Text = plr.DisplayName
						m.name.Position = UDim2.fromOffset(top.X, top.Y - 10)
						m.dist.Visible = S.Distance
						m.dist.Text = math.floor(studs) .. " studs"
						m.dist.Position = UDim2.fromOffset(top.X, bot.Y + 10)
						local hp = hum.Health / math.max(hum.MaxHealth, 1)
						m.hpBg.Visible = S.Health
						m.hpBg.Position = UDim2.fromOffset(top.X - w / 2 - 4, top.Y)
						m.hpBg.Size = UDim2.fromOffset(3, hgt)
						m.hpFill.Size = UDim2.fromScale(1, math.clamp(hp, 0, 1))
						m.hpFill.BackgroundColor3 = hp_color(hp)
						m.tracer.Visible = S.Tracer
						if S.Tracer then
							local x1, y1, x2, y2 = vs.X / 2, vs.Y, bot.X, bot.Y
							m.tracer.Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2)
							m.tracer.Size = UDim2.fromOffset(math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2), 1.5)
							m.tracer.Rotation = math.deg(math.atan2(y2 - y1, x2 - x1))
							m.tracer.BackgroundColor3 = S.Color
						end
					end
				end
			end
		end
	end)

	-- controls
	tab:Section("Visuals")
	tab:Toggle({ Name = "ESP", Desc = "Show everyone through walls", Flag = "AstrisEspEnabled", Default = false, Callback = function(v) S.Enabled = v end })
	tab:Toggle({ Name = "Boxes", Flag = "AstrisEspBox", Default = S.Box, Callback = function(v) S.Box = v end })
	tab:Toggle({ Name = "Names", Flag = "AstrisEspName", Default = S.Name, Callback = function(v) S.Name = v end })
	tab:Toggle({ Name = "Distance", Flag = "AstrisEspDistance", Default = S.Distance, Callback = function(v) S.Distance = v end })
	tab:Toggle({ Name = "Health bars", Flag = "AstrisEspHealth", Default = S.Health, Callback = function(v) S.Health = v end })
	tab:Toggle({ Name = "Tracers", Flag = "AstrisEspTracer", Default = S.Tracer, Callback = function(v) S.Tracer = v end })
	tab:Toggle({ Name = "Chams", Desc = "Fill players with colour", Flag = "AstrisEspChams", Default = S.Chams, Callback = function(v) S.Chams = v end })
	tab:Toggle({ Name = "Outlines", Desc = "Glow outline around players", Flag = "AstrisEspOutline", Default = S.Outline, Callback = function(v) S.Outline = v end })
	tab:Section("Style")
	tab:ColorPicker({ Name = "Colour", Flag = "AstrisEspColor", Default = S.Color, Callback = function(v) S.Color = v end })
	tab:Slider({ Name = "Max distance", Flag = "AstrisEspRange", Min = 100, Max = 5000, Step = 50, Default = S.MaxDistance, Suffix = " studs", Callback = function(v) S.MaxDistance = v end })
	self.EspTab = tab
	return tab
end
function h:_buildSettings(d)
	local tab = self:_pinTab(self:Tab({ Name = d.Name or "Settings", Desc = d.Desc, Icon = d.Icon or "settings" }), 9003)
	local window = self
	tab:Section("Interface")
	tab:ThemePicker({ Flag = "AstrisTheme" })
	tab:Keybind({
		Name = "Toggle UI",
		CurrentKeybind = self.Keybind and self.Keybind.Name or "RightControl",
		OnChanged = function(key)
			window:SetKeybind(key)
		end,
	})
	tab:ConfigManager({ Name = "Configs" })
	tab:Section("Session")
	tab:Button({
		Name = "Unload",
		Icon = "power",
		Style = "Danger",
		Callback = function()
			window:Confirm({
				Title = "Unload?",
				ConfirmText = "Unload",
				Callback = function()
					window:Destroy()
				end,
			})
		end,
	})
	self.SettingsTab = tab
	return tab
end
function h:Tab(e, v)
	e = n(e, { Title = "Name", Description = "Desc" })
	if v ~= nil and e.Icon == nil then
		e.Icon = v
	end
	local d = setmetatable({ Name = e.Name or "Tab", Window = self, _order = 0 }, k)
	local h = c(
		"TextButton",
		{
			Size = UDim2.new(1, 0, 0, 36),
			BackgroundColor3 = a.Surface3,
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			LayoutOrder = #self.Tabs + 1,
			Parent = self.TabList,
		}
	)
	g(h)
	local r = i(h, a.Stroke, 1)
	d._button = h
	local s = e.Icon ~= nil
	if s then
		local b = c(
			"ImageLabel",
			{
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 14, 0.5, 0),
				Size = UDim2.fromOffset(16, 16),
				BackgroundTransparency = 1,
				ImageColor3 = a.Muted,
				ScaleType = Enum.ScaleType.Fit,
				Parent = h,
			}
		)
		u(b, e.Icon)
		d._icon = b
	end
	d._label = f({
		Position = UDim2.fromOffset(s and 38 or 16, 0),
		Size = UDim2.new(1, -(s and 44 or 22), 1, 0),
		Text = d.Name,
		TextColor3 = a.Muted,
		Parent = h,
	})
	local p = c(
		"Frame",
		{ Name = d.Name, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, Parent = self.Content }
	)
	d._page = p
	f({ Position = UDim2.fromOffset(24, 20), Size = UDim2.new(1, -72, 0, 24), Text = d.Name, TextSize = 22, Parent = p })
	if e.Desc then
		f({
			Position = UDim2.fromOffset(24, 44),
			Size = UDim2.new(1, -72, 0, 16),
			Text = e.Desc,
			TextSize = 13,
			FontFace = j.Regular,
			TextColor3 = a.Muted,
			Parent = p,
		})
	end
	local w = e.Desc and 70 or 58
	local l = c(
		"ScrollingFrame",
		{
			Position = UDim2.fromOffset(0, w),
			Size = UDim2.new(1, 0, 1, -w),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 2,
			ScrollBarImageColor3 = a.Accent,
			ScrollBarImageTransparency = 0.5,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(),
			Parent = p,
		}
	)
	o(l, 24, 24, 2, 24)
	if m then
		l:SetAttribute("NoDrag", true)
	end
	c("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = l })
	d.List = l
	local t, q = aJ(p, e.Icon or "layout-grid", e.EmptyText or "Nothing here yet"), 0
	l.ChildAdded:Connect(function(a)
		if a:IsA("GuiObject") then
			q += 1
			t.Visible = false
		end
	end)
	l.ChildRemoved:Connect(function(a)
		if a:IsA("GuiObject") then
			q = math.max(q - 1, 0)
			t.Visible = q <= 0
		end
	end)
	t.Visible = true
	h.MouseEnter:Connect(function()
		if self.CurrentTab ~= d then
			b(h, { BackgroundTransparency = 0.6 }, 0.12)
		end
	end)
	h.MouseLeave:Connect(function()
		if self.CurrentTab ~= d then
			b(h, { BackgroundTransparency = 1 }, 0.2)
		end
	end)
	h.MouseButton1Click:Connect(function()
		self:SelectTab(d)
	end)
	d._stroke = r
	if not self._introDone then
		h.Visible = false
	end
	table.insert(self.Tabs, d)
	if #self.Tabs == 1 then
		task.defer(function()
			if not self.CurrentTab then
				self:SelectTab(d)
			end
		end)
	end
	return d
end
h.CreateTab = h.Tab
function h:Dialog(h)
	local s, t = "TextButton", "TextTransparency"
	h = n(h, { Text = "Content", Message = "Content" })
	if self._dialog then
		self._dialog.Close()
	end
	local d = 18
	local q = c(
		s,
		{
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			ZIndex = 40,
			Parent = self.Body,
		}
	)
	local e = c(
		s,
		{
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 10),
			Size = UDim2.fromOffset(300, 120),
			BackgroundColor3 = a.Background,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			ZIndex = 41,
			Parent = q,
		}
	)
	g(e, UDim.new(0, 10))
	local v = i(e, a.Stroke, 1)
	local w = c("UIScale", { Scale = 0.94, Parent = e })
	local m, u = {}, 0
	if h.Icon then
		local c, b = A(e, h.Icon, a.Accent, UDim2.new(0, d, 0, d + 9))
		b.ImageTransparency = 1
		c.ZIndex = 42
		b.ZIndex = 42
		table.insert(m, { b, "ImageTransparency", 0 })
		u = 24
	end
	local y = f({
		Position = UDim2.fromOffset(d + u, d),
		Size = UDim2.new(1, -(d * 2 + u), 0, 18),
		Text = h.Title or "Are you sure?",
		TextSize = 15,
		TextTransparency = 1,
		ZIndex = 42,
		Parent = e,
	})
	table.insert(m, { y, t, 0 })
	local p = 0
	if h.Content then
		local b = f({
			Position = UDim2.fromOffset(d, d + 24),
			Size = UDim2.new(1, -d * 2, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = h.Content,
			TextSize = 13,
			FontFace = j.Regular,
			TextColor3 = a.Muted,
			TextWrapped = true,
			TextTransparency = 1,
			TextTruncate = Enum.TextTruncate.None,
			TextYAlignment = Enum.TextYAlignment.Top,
			ZIndex = 42,
			Parent = e,
		})
		table.insert(m, { b, t, 0 })
		p = math.max(b.TextBounds.Y, 16) + 6
		b:GetPropertyChangedSignal("TextBounds"):Connect(function()
			local a = math.max(b.TextBounds.Y, 16) + 6
			if a ~= p then
				p = a
				e.Size = UDim2.fromOffset(300, d + 24 + p + 12 + 34 + d)
				local b = e:FindFirstChild("ButtonRow")
				if b then
					b.Position = UDim2.fromOffset(d, d + 24 + p + 12)
				end
			end
		end)
	end
	local x = c(
		"Frame",
		{
			Name = "ButtonRow",
			Position = UDim2.fromOffset(d, d + 24 + p + 12),
			Size = UDim2.new(1, -d * 2, 0, 34),
			BackgroundTransparency = 1,
			ZIndex = 42,
			Parent = e,
		}
	)
	c(
		"UIListLayout",
		{
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
			Parent = x,
		}
	)
	e.Size = UDim2.fromOffset(300, d + 24 + p + 12 + 34 + d)
	local k, r = {}, false
	function k.Close()
		if r then
			return
		end
		r = true
		if self._dialog == k then
			self._dialog = nil
		end
		b(q, { BackgroundTransparency = 1 }, 0.18)
		b(e, { BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 8) }, 0.18, Enum.EasingStyle.Quint)
		b(w, { Scale = 0.96 }, 0.18, Enum.EasingStyle.Quint)
		b(v, { Transparency = 1 }, 0.12)
		for c, a in ipairs(m) do
			b(a[1], { [a[2]] = 1 }, 0.12)
		end
		task.delay(0.2, function()
			q:Destroy()
		end)
	end
	for q, j in ipairs(h.Buttons or {}) do
		local e = j.Variant == "Primary"
		local d = c(
			s,
			{
				Size = UDim2.fromOffset(0, 34),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = e and a.Accent or a.Surface2,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = "",
				AutoButtonColor = false,
				ClipsDescendants = true,
				LayoutOrder = q,
				ZIndex = 43,
				Parent = x,
			}
		)
		g(d, UDim.new(0, 7))
		local h = i(d, e and a.Accent or a.Stroke, 1)
		o(d, 14, 14)
		local u = f({
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			Text = j.Title or j.Name or "OK",
			TextSize = 13,
			TextColor3 = e and a.AccentDark or a.Text,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextTransparency = 1,
			ZIndex = 44,
			Parent = d,
		})
		local n = e and 0.12 or 0
		local p = e and 0.4 or 0
		table.insert(m, { d, "BackgroundTransparency", n })
		table.insert(m, { h, "Transparency", p })
		table.insert(m, { u, t, 0 })
		d.MouseEnter:Connect(function()
			if r then
				return
			end
			if e then
				b(d, { BackgroundTransparency = 0 }, 0.12)
				b(h, { Transparency = 0 }, 0.12)
			else
				b(h, { Color = a.StrokeHover }, 0.12)
			end
		end)
		d.MouseLeave:Connect(function()
			if r then
				return
			end
			if e then
				b(d, { BackgroundTransparency = n }, 0.2)
				b(h, { Transparency = p }, 0.2)
			else
				b(h, { Color = a.Stroke }, 0.2)
			end
		end)
		d.MouseButton1Click:Connect(function()
			k.Close()
			l(j.Callback)
		end)
	end
	function k.Cancel()
		if r then
			return
		end
		k.Close()
		l(h.OnCancel)
	end
	k.Dismissable = h.CloseOnBackdrop ~= false
	if k.Dismissable then
		q.MouseButton1Click:Connect(k.Cancel)
	end
	self._dialog = k
	b(q, { BackgroundTransparency = 0.45 }, 0.25)
	b(e, { BackgroundTransparency = 0, Position = UDim2.fromScale(0.5, 0.5) }, 0.3, Enum.EasingStyle.Quint)
	b(v, { Transparency = 0 }, 0.25)
	b(w, { Scale = 1 }, 0.4, Enum.EasingStyle.Back)
	for c, a in ipairs(m) do
		b(a[1], { [a[2]] = a[3] }, 0.25)
	end
	return k
end
function h:Confirm(a)
	a = n(a, { Text = "Content", Message = "Content" })
	return self:Dialog({
		Title = a.Title or "Are you sure?",
		Content = a.Content,
		Icon = a.Icon,
		OnCancel = a.OnCancel,
		Buttons = {
			{ Title = a.CancelText or "Cancel", Callback = a.OnCancel },
			{ Title = a.ConfirmText or "Confirm", Variant = "Primary", Callback = a.Callback },
		},
	})
end
function h:_listen(e, c, a)
	local b = self._inputListeners[e]
	table.insert(b, c)
	local function d()
		for a, d in ipairs(b) do
			if d == c then
				table.remove(b, a)
				break
			end
		end
	end
	if a then
		a._listeners = a._listeners or {}
		table.insert(a._listeners, d)
	end
	return d
end
function h:_indicatorY(a)
	local b = self.TabList
	local c = self.Scale.Scale
	return (a._button.AbsolutePosition.Y - b.AbsolutePosition.Y + a._button.AbsoluteSize.Y / 2) / c
		+ b.Position.Y.Offset
end
function h:_placeIndicator(d)
	local a = self.Indicator
	local c = self:_indicatorY(d)
	if not a.Visible then
		a.Visible = true
		a.Position = UDim2.fromOffset(19, c)
		a.Size = UDim2.fromOffset(3, 0)
	end
	b(a, { Position = UDim2.fromOffset(19, c), Size = UDim2.fromOffset(3, 16) }, 0.35, Enum.EasingStyle.Back)
end
function h:SelectTab(c)
	if type(c) == "string" then
		for b, a in ipairs(self.Tabs) do
			if a.Name == c then
				c = a
				break
			end
		end
	end
	if type(c) ~= "table" or self.CurrentTab == c then
		return
	end
	local d = self.CurrentTab
	self.CurrentTab = c
	self:_settleTransition()
	local f = (self._transitionGeneration or 0) + 1
	self._transitionGeneration = f
	if d then
		b(d._button, { BackgroundTransparency = 1 }, 0.2)
		b(d._stroke, { Transparency = 1 }, 0.2)
		b(d._label, { TextColor3 = a.Muted }, 0.2)
		if d._icon then
			b(d._icon, { ImageColor3 = a.Muted }, 0.2)
		end
		local c = self._outLayer
		d._page.Parent = c
		self._outPage = d._page
		c.GroupTransparency = 0
		c.Position = UDim2.fromOffset(0, 0)
		c.Visible = true
		b(c, { GroupTransparency = 1, Position = UDim2.fromOffset(0, -10) }, 0.18)
		task.delay(0.18, function()
			if self._transitionGeneration == f then
				self:_settleOut()
			end
		end)
	end
	b(c._button, { BackgroundTransparency = 0.25 }, 0.2)
	b(c._label, { TextColor3 = a.Text }, 0.2)
	if c._icon then
		b(c._icon, { ImageColor3 = a.Accent }, 0.2)
	end
	self:_placeIndicator(c)
	local e = c._page
	e.Position = UDim2.fromOffset(0, 0)
	e.Visible = true
	e.Parent = self._inLayer
	self._inPage = e
	aL(self._inLayer)
	task.delay(0.32, function()
		if self._transitionGeneration == f then
			self:_settleIn()
		end
	end)
end
function h:_settleOut()
	local a = self._outPage
	if a then
		a.Parent = self.Content
		a.Visible = false
		self._outPage = nil
	end
	self._outLayer.Visible = false
end
function h:_settleIn()
	local a = self._inPage
	if a then
		a.Parent = self.Content
		a.Position = UDim2.fromOffset(0, 0)
		self._inPage = nil
	end
	self._inLayer.Visible = false
end
function h:_settleTransition()
	self:_settleOut()
	self:_settleIn()
end
function h:Toggle(a)
	if not self._introDone then
		return
	end
	if a == nil then
		a = not self.Open
	end
	if a == self.Open then
		return
	end
	self.Open = a
	if self._syncOpenButton then
		self:_syncOpenButton()
	end
	if a then
		self.Root.Visible = true
		b(self.Scale, { Scale = self._fitScale or 1 }, 0.4, Enum.EasingStyle.Back)
		b(self.Body, { GroupTransparency = 0 }, 0.25)
		b(self.BodyStroke, { Transparency = 0 }, 0.25)
		b(self.Shadow, { ImageTransparency = 0.6 }, 0.3)
	else
		b(self.Scale, { Scale = (self._fitScale or 1) * 0.94 }, 0.2, Enum.EasingStyle.Quint)
		b(self.Body, { GroupTransparency = 1 }, 0.16)
		b(self.BodyStroke, { Transparency = 1 }, 0.12)
		b(self.Shadow, { ImageTransparency = 1 }, 0.16)
		task.delay(0.2, function()
			if not self.Open then
				self.Root.Visible = false
			end
		end)
	end
end
function h:SetKeepOnScreen(a)
	self.KeepOnScreen = a ~= false
	if self.KeepOnScreen then
		self:_clampToScreen()
	end
end
function h:SetKeybind(a)
	a = F(a)
	if not a then
		return
	end
	self.Keybind = a
	self._keyChipLabel.Text = W(a)
end
function h:SetTitle(a)
	self._titleLabel.Text = tostring(a)
end
function h:SetSubtitle(a)
	self._subtitleLabel.Text = tostring(a)
end
function h:SetIcon(a)
	u(self._logo, a)
end
function h:Notify(d)
	local logo = e.Assets and e.Assets.Logo
	d = n(d, { Text = "Content", Message = "Content", Image = "Icon" })
	local duration = d.Duration or 4
	local kind = aB[d.Type]
	local tone = kind and a[kind] or a.Accent
	local icons = { Info = "info", Success = "circle-check", Warning = "triangle-alert", Error = "circle-x" }
	local icon = d.Icon or icons[d.Type]
	self._notifyOrder += 1

	local slot = c("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 1,
		LayoutOrder = self._notifyOrder,
		Parent = self.NotifyHolder,
	})
	local mover = c("Frame", {
		Position = UDim2.fromOffset(40, 0),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = slot,
	})
	local pop = c("UIScale", { Scale = 0.94, Parent = mover })
	local shadow = c("ImageLabel", {
		Position = UDim2.fromOffset(-22, -18),
		Size = UDim2.new(1, 44, 1, 44),
		BackgroundTransparency = 1,
		Image = v.Shadow,
		ImageColor3 = Color3.new(0, 0, 0),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = v.ShadowSlice,
		ZIndex = 0,
		Parent = mover,
	})
	local card = c("CanvasGroup", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = a.Surface,
		BorderSizePixel = 0,
		GroupTransparency = 1,
		Parent = mover,
	})
	g(card, UDim.new(0, 14))
	local stroke = i(card, a.Stroke)
	T(card)
	z(card, UDim2.fromOffset(220, 110), UDim2.new(0, 10, 0, 0), 0.9, 90)

	local body = c("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = card,
	})
	o(body, 12, 40, 12, 14)

	local tile = c("Frame", {
		Size = UDim2.fromOffset(36, 36),
		BackgroundColor3 = tone,
		BackgroundTransparency = 0.86,
		BorderSizePixel = 0,
		Parent = body,
	})
	g(tile, UDim.new(0, 10))
	i(tile, tone, 0.7)
	local glyph = c("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		ImageColor3 = icon and tone or a.Text,
		ScaleType = Enum.ScaleType.Fit,
		Parent = tile,
	})
	u(glyph, icon or logo or "bell")

	local text = c("Frame", {
		Position = UDim2.fromOffset(48, 0),
		Size = UDim2.new(1, -48, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = body,
	})
	c("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3), Parent = text })
	c("UIPadding", { PaddingTop = UDim.new(0, d.Content and 1 or 9), Parent = text })
	f({
		Size = UDim2.new(1, 0, 0, 17),
		Text = d.Title or "Notification",
		TextSize = 14,
		FontFace = j.Medium,
		LayoutOrder = 1,
		Parent = text,
	})
	if d.Content then
		f({
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = d.Content,
			TextSize = 13,
			FontFace = j.Regular,
			TextColor3 = a.Muted,
			TextWrapped = true,
			TextTruncate = Enum.TextTruncate.None,
			TextYAlignment = Enum.TextYAlignment.Top,
			LayoutOrder = 2,
			Parent = text,
		})
	end

	local close = c("ImageButton", {
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -10, 0, 10),
		Size = UDim2.fromOffset(22, 22),
		BackgroundColor3 = a.Surface3,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Parent = card,
	})
	g(close, UDim.new(0, 6))
	local close_icon = c("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(12, 12),
		BackgroundTransparency = 1,
		ImageColor3 = a.Muted,
		ImageTransparency = 0.4,
		ScaleType = Enum.ScaleType.Fit,
		Parent = close,
	})
	u(close_icon, "x")

	local track = c("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = a.Surface3,
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		Parent = card,
	})
	local bar = c("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = tone, BorderSizePixel = 0, Parent = track })

	task.defer(function()
		if slot.Parent then
			b(slot, { Size = UDim2.new(1, 0, 0, card.AbsoluteSize.Y / math.max(pop.Scale, 0.01)) }, 0.35, Enum.EasingStyle.Quint)
		end
	end)
	b(mover, { Position = UDim2.fromOffset(0, 0) }, 0.45, Enum.EasingStyle.Quint)
	b(pop, { Scale = 1 }, 0.45, Enum.EasingStyle.Back)
	b(card, { GroupTransparency = 0 }, 0.25)
	b(shadow, { ImageTransparency = 0.55 }, 0.4)

	local gone = false
	local left = duration
	local hovered = false
	local bar_tween = b(bar, { Size = UDim2.fromScale(0, 1) }, left, Enum.EasingStyle.Linear)
	local function dismiss()
		if gone then
			return
		end
		gone = true
		if bar_tween then
			bar_tween:Cancel()
		end
		for idx, fn in ipairs(self._toasts) do
			if fn == dismiss then
				table.remove(self._toasts, idx)
				break
			end
		end
		b(mover, { Position = UDim2.fromOffset(60, 0) }, 0.3, Enum.EasingStyle.Quint)
		b(pop, { Scale = 0.96 }, 0.3, Enum.EasingStyle.Quint)
		b(card, { GroupTransparency = 1 }, 0.22)
		b(stroke, { Transparency = 1 }, 0.15)
		b(shadow, { ImageTransparency = 1 }, 0.2)
		task.delay(0.2, function()
			slot.ClipsDescendants = true
			b(slot, { Size = UDim2.new(1, 0, 0, -8) }, 0.25, Enum.EasingStyle.Quint)
			task.delay(0.27, function()
				slot:Destroy()
			end)
		end)
	end
	card.MouseEnter:Connect(function()
		hovered = true
		if bar_tween then
			bar_tween:Pause()
		end
		b(close, { BackgroundTransparency = 0.6 }, 0.15)
		b(close_icon, { ImageTransparency = 0 }, 0.15)
		b(stroke, { Color = a.StrokeHover }, 0.15)
	end)
	card.MouseLeave:Connect(function()
		hovered = false
		if bar_tween then
			bar_tween:Play()
		end
		b(close, { BackgroundTransparency = 1 }, 0.2)
		b(close_icon, { ImageTransparency = 0.4 }, 0.2)
		b(stroke, { Color = a.Stroke }, 0.2)
	end)
	task.spawn(function()
		while not gone and left > 0 do
			local dt = task.wait(0.05)
			if not hovered then
				left -= dt
			end
		end
		dismiss()
	end)
	close.MouseButton1Click:Connect(dismiss)
	table.insert(self._toasts, dismiss)
	while #self._toasts > self.MaxNotifications do
		table.remove(self._toasts, 1)()
	end
	return { Dismiss = dismiss }
end
function h:Destroy()
	if self._destroyed then
		return
	end
	self._destroyed = true
	if self._espGui then
		self._espGui:Destroy()
	end
	for a, b in ipairs(e.Windows) do
		if b == self then
			table.remove(e.Windows, a)
			break
		end
	end
	for b, a in ipairs(self._connections) do
		a:Disconnect()
	end
	self._connections = {}
	for a, b in pairs(self.Flags) do
		if e.Flags[a] == b then
			e.Flags[a] = nil
		end
	end
	self.Flags = {}
	b(self.Scale, { Scale = 0.9 }, 0.2)
	b(self.Body, { GroupTransparency = 1 }, 0.2)
	b(self.BodyStroke, { Transparency = 1 }, 0.12)
	b(self.Shadow, { ImageTransparency = 1 }, 0.2)
	task.delay(0.22, function()
		self.Gui:Destroy()
	end)
end
return e
