local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node

ls.add_snippets("cmake", {
    s("cmake", {
        t("cmake_minimum_required(VERSION 3.27)"),
        t({ "", "set(CMAKE_CXX_STANDARD 20)" }),
        t({ "", "set(CMAKE_CXX_STANDARD_REQUIRED ON)" }),
        t({ "", "set(CMAKE_CXX_FLAGS \"${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++20)\"" }),
        t({ "", "" }),
        -- t({ "", "set(EXECUTABLE_OUTPUT_PATH \"./debug\")" }),
        -- t({ "", "file(GLOB source_files \"${source_dir}/*.cpp\")" }),
        t({ "", "file(GLOB source_files \"./*.cpp\")" }),
        t({ "", "" }),
        t({ "", "project(hello VERSION 1.0.0)" }),
        t({ "", "" }),
        t({ "", "add_executable(hello ${source_files})" })
    })
})


ls.add_snippets("yaml", {
    s("cpp", {
        t("BasedOnStyle:  LLVM"),
        t({ "", "IndentWidth:   4" }),
        t({ "", "Language:      Cpp" }),
    })
})
