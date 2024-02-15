local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

ls.config.set_config {
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
}

ls.add_snippets("all", {
s("todo", { t("// TODO(sqd): ") }),
s("note", { t("// NOTE(sqd): ") }),
s("important", { t("// IMPORTANT(sqd): ") }),
s("warn", { t("// WARNING(sqd): ") }),
s("perf", { t("// PERFORMANCE(sqd): ") }),
s("fmt", { t("// clang-format ") }),
})

require("luasnip/loaders/from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well
