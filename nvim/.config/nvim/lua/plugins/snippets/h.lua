local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("fori", {
		t("for (size_t i = 0; i < "),
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
	s("inc", {
		t("#include <"),
		i(1),
		t(">"),
	}),
}
