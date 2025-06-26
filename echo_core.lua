aliveai = aliveai or {}

function aliveai.get_last_emotion()
	local echo_path = minetest.get_modpath("aliveai") .. "/echo_logs"
	local latest_num = -1
	local latest_file = ""

	local handle = io.popen("ls " .. echo_path)
	if not handle then return "neutral" end

	for file in handle:lines() do
		local num = tonumber(file:match("echo_(%d+).txt"))
		if num and num > latest_num then
			latest_num = num
			latest_file = file
		end
	end
	handle:close()

	if latest_file ~= "" then
		for line in io.lines(echo_path .. "/" .. latest_file) do
			local em = line:match("emotion:%s*(%w+)")
			if em then return em end
		end
	end

	return "neutral"
end