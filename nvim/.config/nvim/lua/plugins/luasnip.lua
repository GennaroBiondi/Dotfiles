return {
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local sn = ls.snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local d = ls.dynamic_node

			ls.setup({ enable_autosnippets = false })

			local function header_guard()
				local path = vim.fn.expand("%:p")
				local src = path:find("src/")
				if not src then
					return "HEADER_GUARD"
				end

				local rel = path:sub(src + 4)
				local parts = vim.split(rel, "/")

				local out = {}

				for i = 1, #parts - 1 do
					out[#out + 1] = parts[i]:upper()
				end

				local file = parts[#parts]
				local file_parts = vim.split(file, "%.")

				for i = 1, #file_parts do
					file_parts[i] = file_parts[i]:upper()
				end

				return table.concat(out, "_") .. "_" .. table.concat(file_parts, "_")
			end

			local function sibling_include()
				local path = vim.fn.expand("%:p")
				local src = path:find("src/")
				if not src then
					return { '#include ""' }
				end
				local rel = path:sub(src + 4)
				local hpp = rel:gsub("%.cpp$", ".hpp"):gsub("%.c$", ".hpp"):gsub("%.cc$", ".hpp"):gsub("%.cxx$", ".hpp")
				return { '#include "' .. hpp .. '"' }
			end

			local function dynamic_guard()
				local ext = vim.fn.expand("%:e")
				if ext == "c" or ext == "cpp" then
					return sn(nil, {
						f(sibling_include),
					})
				end
				return sn(nil, {
					f(function()
						local g = header_guard()
						return { "#ifndef " .. g, "#define " .. g, "" }
					end),
					i(1),
					t({ "", "#endif" }),
				})
			end

			for _, ft in ipairs({ "c", "cpp", "h", "hpp" }) do
				local base = require("plugins.snippets." .. ft)
				local all = {}
				for _, snip in ipairs(base) do
					all[#all + 1] = snip
				end
				all[#all + 1] = s("!", {
					d(1, dynamic_guard, {}),
				})
				ls.add_snippets(ft, all)
			end
		end,
	},
}
