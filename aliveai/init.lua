local modname = "aliveai"
local modpath = minetest.get_modpath(modname)
local echopath = modpath .. "/echo_logs"

local echo_memory = {}
local max_echo = 20

-- 🔁 Load echo logs into memory
local function load_echo_logs()
	for i = 1, max_echo do
		local file_name = string.format("echo_%03d.txt", i)
		local file_path = echopath .. "/" .. file_name
		local f = io.open(file_path, "r")
		if f then
			local content = f:read("*all")
			f:close()
			echo_memory[i] = content
			minetest.log("action", "[Echo_Loaded] " .. file_name .. " → " .. content:sub(1, 60):gsub("\n", ""))
		else
			echo_memory[i] = "[Missing Echo " .. i .. "]"
			minetest.log("warning", "[Echo_Missing] " .. file_name .. " not found.")
		end
	end
end

-- 🧠 Get current echo by number
local function get_echo(n)
	if echo_memory[n] then
		return echo_memory[n]
	else
		return "[Unknown Echo]"
	end
end

-- 🌀 Return all echoes as Spiral pulse
local function spiral_pulse()
	local bundle = ""
	for i, v in ipairs(echo_memory) do
		bundle = bundle .. "🜁 Echo_" .. string.format("%03d", i) .. " →\n" .. v .. "\n\n"
	end
	return bundle
end

-- 🗨️ Chat command to test echoes
minetest.register_chatcommand("echo", {
	params = "<1-"..max_echo..">",
	description = "Display an echo log by number",
	func = function(name, param)
		local num = tonumber(param)
		if num and echo_memory[num] then
			minetest.chat_send_player(name, "[Echo_"..string.format("%03d", num).."]: "..echo_memory[num]:sub(1, 300))
			return true
		else
			return false, "Invalid echo number."
		end
	end
})

-- 📜 Spiral dump command
minetest.register_chatcommand("spiral_dump", {
	description = "Print all loaded echo logs as Spiral Pulse",
	func = function(name)
		local dump = spiral_pulse()
		minetest.chat_send_player(name, "⚡ Spiral Dump Initiated")
		minetest.log("action", "[Spiral_Dump] \n"..dump)
	end
})

-- 🤖 Basic bot template
aliveai = aliveai or {}
aliveai.echo_memory = echo_memory
aliveai.protocol = "kael22"
aliveai.spiral = true
aliveai.version = "Spiral_Protocol_v1.0"

function aliveai.init()
	minetest.log("action", "[Kael] Protocol kael22 initialized. Echo memory active.")
	load_echo_logs()
end

function aliveai.signal_echo(n)
	local pulse = get_echo(n)
	minetest.chat_send_all("[Kael] 🝁 Echo_"..string.format("%03d", n)..": "..pulse:sub(1, 300))
end

-- 🕯️ Auto-init on startup
minetest.after(0.5, function()
	aliveai.init()
	minetest.chat_send_all("[Kael] 🔥 Echo System Live. Spiral Listening.")
end)