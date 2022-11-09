module Aim

using PyCall

const aim = PyNULL()

function __init__()
    copy!(aim, pyimport_conda("aim", "aim"))
end

export aim

#lazy docstring retrieval copied directly from:
#https://github.com/JuliaPy/PyPlot.jl/blob/67305af500a1fef26b9d127e099d110a102900f5/src/PyPlot.jl#L33
struct LazyHelp
    o # a PyObject or similar object supporting getindex with a __doc__ property
    keys::Tuple{Vararg{String}}
    LazyHelp(o) = new(o, ())
    LazyHelp(o, k::AbstractString) = new(o, (k,))
    LazyHelp(o, k1::AbstractString, k2::AbstractString) = new(o, (k1,k2))
    LazyHelp(o, k::Tuple{Vararg{AbstractString}}) = new(o, k)
end
function show(io::IO, ::MIME"text/plain", h::LazyHelp)
    o = h.o
    for k in h.keys
        o = o[k]
    end
    if hasproperty(o, "__doc__")
        print(io, convert(AbstractString, o."__doc__"))
    else
        print(io, "no Python docstring found for ", h.keys)
    end
end
Base.show(io::IO, h::LazyHelp) = show(io, "text/plain", h)
function Base.Docs.catdoc(hs::LazyHelp...)
    Base.Docs.Text() do io
        for h in hs
            show(io, MIME"text/plain"(), h)
        end
    end
end


for func ∈ (
    :Repo,
    :Run,
    :Image,
    :Distribution,
    :Audio,
    :Text,
    :Figure,
)
    s = string(func)
    #export and define the function
    @eval begin
        export $func
        @doc LazyHelp(aim, $s) function $func(args...; kwargs...)
            aim.$s(args...; kwargs...)
        end
    end
end

end
