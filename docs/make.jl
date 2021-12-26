using Libfive
using Documenter

DocMeta.setdocmeta!(Libfive, :DocTestSetup, :(using Libfive); recursive=true)

makedocs(;
    modules=[Libfive],
    authors="Steve Kelly <kd2cca@gmail.com> and contributors",
    repo="https://github.com/sjkelly/Libfive.jl/blob/{commit}{path}#{line}",
    sitename="Libfive.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://sjkelly.github.io/Libfive.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/sjkelly/Libfive.jl",
)
