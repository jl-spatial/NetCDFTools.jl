NCdata = Union{NCDataset, NCDatasets.MFDataset}
NCfiles = Union{Vector{<:AbstractString}, AbstractString}

# nc_open = NCDataset
"""
    nc_open is same as NCDataset

@seealso [NCDatasets.NCDataset()]
"""
# nc_open = NCDataset

function nc_open(f::NCfiles, args...; kwargs...)
    NCDataset(path_mnt.(f), args...; kwargs...)
end

function nc_open(f::Function, args...; kwargs...)
    ds = nc_open(args...; kwargs...)
    try
        f(ds)
    finally
        @debug "closing netCDF NCDataset $(ds.ncid) $(NCDatasets.path(ds))"
        close(ds)
    end
end

nc_close(ds::NCdata) = close(ds)


function nc_bands(ds::NCdata)
    # v_id = NCDatasets.nc_inq_varids(ds.ncid)
    # vars = NCDatasets.nc_inq_varname.(ds.ncid, v_id)
    vars = keys(ds)
    dims = ["lon", "lat", "time"]
    setdiff(vars, [dims; dims .* "_bnds"; "height"])
end

function nc_bands(file::NCfiles)
    nc_open(file) do ds
        nc_bands(ds)
    end
end

function nc_info(ds::NCdata)
    # vars = nc_bands(ds)[1]
    println(ds)
end

function nc_info(file::NCfiles)
    println(basename(file))
    nc_open(file) do ds
        nc_info(ds)
    end
end

ncinfo = nc_info
