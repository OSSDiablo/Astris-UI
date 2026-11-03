# one-time pass: turn the formatted Airflow source into Astris UI
import re, sys
from pathlib import Path
p = Path(__file__).resolve().parent.parent / "src" / "AstrisUI.luau"
s = p.read_text()

def sub(old, new, count=1):
    global s
    n = s.count(old)
    if n != count:
        sys.exit(f"expected {count}x {old!r}, found {n}")
    s = s.replace(old, new)

s = s.replace('[AirFlow]', '[Astris]')
sub('"AirFlowFonts"', '"AstrisUI/fonts"')
sub('"AirflowNoTheme"', '"AstrisNoTheme"', 2)
sub('"AirflowUI"', '"AstrisUI"')
sub('k.Title or "Airflow"', 'k.Title or "Astris Hub"', 2)
sub('e.LoadingTitle or e.Title or "Airflow"', 'e.LoadingTitle or e.Title or "Astris Hub"')

# palette: neutral ink + Astris green, every theme shares the ink base
start = s.index("e.Themes = {")
end = s.index("e.Theme = table.clone(e.Themes.Default)")
def ink(accent, dark, glow, hover):
    return f"""x({{
		Background = d(12, 13, 13),
		Surface = d(17, 18, 18),
		Surface2 = d(22, 24, 23),
		Surface3 = d(38, 41, 40),
		Stroke = d(31, 34, 33),
		StrokeHover = d({hover}),
		Accent = d({accent}),
		AccentDark = d({dark}),
		Text = d(238, 240, 239),
		Muted = d(136, 143, 140),
		Glow = d({glow}),
	}})"""
themes = {
    "Default": ("62, 196, 130", "5, 24, 14", "150, 232, 190", "60, 104, 82"),
    "Mono": ("232, 234, 233", "14, 15, 15", "220, 222, 221", "84, 88, 86"),
    "Midnight": ("107, 184, 255", "6, 18, 32", "190, 220, 255", "58, 86, 116"),
    "Moss": ("150, 214, 110", "14, 26, 8", "206, 236, 186", "80, 104, 64"),
    "Ember": ("255, 178, 26", "30, 18, 0", "255, 220, 160", "116, 88, 40"),
    "Rose": ("255, 120, 150", "32, 8, 14", "255, 200, 214", "116, 64, 78"),
}
body = "e.Themes = {\n" + "".join(f"\t{k} = {ink(*v)},\n" for k, v in themes.items()) + "}\n"
s = s[:start] + body + s[end:]
sub('local ap = { Warning = d(240, 176, 108), Success = d(150, 220, 170), Error = d(240, 120, 120) }',
    'local ap = { Warning = d(244, 184, 96), Success = d(95, 211, 141), Error = d(255, 107, 107) }')

# logo: bake the Astris mark, write it once, load with getcustomasset; lucide triangle as fallback
sub('''e.Assets =
	{ Shadow = "rbxassetid://6014261993", Glow = "rbxassetid://8992230677", Logo = "rbxassetid://103859712365480" }''',
'''e.Assets = { Shadow = "rbxassetid://6014261993", Glow = "rbxassetid://8992230677", Logo = "triangle" }
do
	local LOGO = "@@LOGO@@"
	pcall(function()
		if not (writefile and getcustomasset) then
			return
		end
		local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		local map = {}
		for i = 1, 64 do
			map[chars:byte(i)] = i - 1
		end
		local out = table.create(#LOGO // 4)
		for i = 1, #LOGO, 4 do
			local a, b, c, d = LOGO:byte(i, i + 3)
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
		local path = "AstrisUI/logo_@@LOGOVER@@.png"
		if not (isfile and isfile(path)) then
			writefile(path, table.concat(out))
		end
		e.Assets.Logo = getcustomasset(path)
	end)
end''')

# the mark is white, so tint it with Text instead of Accent
for title in ('Size = UDim2.fromOffset(30, 28),\n\t\t\tBackgroundTransparency = 1,\n\t\t\tImage = "",\n\t\t\tImageColor3 = a.Accent,',):
    sub(title, title.replace("a.Accent", "a.Text"))
sub('''			Rotation = -14,
			BackgroundTransparency = 1,
			ImageColor3 = a.Accent,''', '''			Rotation = -14,
			BackgroundTransparency = 1,
			ImageColor3 = a.Text,''')
sub('''			Size = UDim2.fromOffset(20, 20),
			BackgroundTransparency = 1,
			ImageColor3 = a.Accent,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 31,''', '''			Size = UDim2.fromOffset(20, 20),
			BackgroundTransparency = 1,
			ImageColor3 = a.Text,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 31,''')
p.write_text(s)
print("ok")
