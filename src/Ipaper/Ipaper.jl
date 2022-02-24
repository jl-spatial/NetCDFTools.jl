module Ipaper

using Dates

include("cmd.jl")
include("dates.jl")
include("file_operation.jl")
include("macro.jl")
include("par.jl")
include("stringr.jl")
include("tools.jl")


export path_mnt, is_wsl, is_windows, is_linux

end
