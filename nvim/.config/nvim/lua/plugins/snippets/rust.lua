local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s("!derive", {
		t("#[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]"),
	}),
}
