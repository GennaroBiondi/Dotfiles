return {
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			local rep = require("luasnip.extras").rep

			ls.setup({ enable_autosnippets = false })
			ls.cleanup()
			local c_snippets = {
				s("fori", {
					t("for (std::size_t i = 0; i < "),
					i(1),
					t({ "; ++i) {", "\t" }),
					i(2),
					t({ "", "}" }),
				}),
				s("fort", {
					t("for ("),
					i(1),
					t(" : "),
					i(2),
					t({ ") {", "\t" }),
					i(3),
					t({ "", "}" }),
				}),
				s("!", {
					t("#ifndef "),
					i(1),
					t({ "", "#define " }),
					rep(1),
					t({ "", "", "" }),
					i(2),
					t({ "", "", "#endif" }),
				}),
			}

			for _, ft in ipairs({ "c", "h", "cpp", "hpp" }) do
				ls.add_snippets(ft, c_snippets)
			end
		end,
	},
}
