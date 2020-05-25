using GeoDatasets
using Dates
using NCDatasets
using GeoRegions

function checklsm(;res::AbstractString="l",min::Real=5)

    fnc = datadir("data/raw/lsm_$(grid)min_$(resolution).nc")
    if !isfile(fnc); getlsm(res=res,min=min) end; ds = Dataset(fnc);
    lsm = ds["landmask"][:]*1; lon = ds["longitude"].var[:]; lat = ds["latitude"].var[:];

    return lon,lat,lsm

end
