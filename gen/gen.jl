#! /usr/bin/env julia

using Pkg

using libfive_jll

using Clang.Generators

include_dir = joinpath(libfive_jll.artifact_dir, "include") |> normpath
clang_dir = joinpath(include_dir, "clang-c")

options = load_options(joinpath(@__DIR__, "generator.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()
push!(args, "-I$include_dir")

headers = [joinpath(include_dir, "libfive.h")]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(clang_dir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)