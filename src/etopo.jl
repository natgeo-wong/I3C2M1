using Dates
using NCDatasets
using ImageSegmentation
using GeoRegions

function findetopo()
    fetopo = datadir("raw/ETOPO1.grd")
    if !isfile(fetopo); error("$(Dates.now()) - Please download the ETOPO1 file.") end
end

function etopoinit()
    findetopo();
    fetopo = datadir("raw/ETOPO1.grd")
    fsegnc = datadir("etopo/etopo-GLB.nc")
    detopo = datadir("etopo/")
    if !isdir(detopo); mkpath(detopo) end
    if !isfile(fsegnc); etoposeg(fetopo,fsegnc) end
    return fetopo,fsegnc
end

function etopoweights(lon::Vector{<:Real},lat::Vector{<:Real})

    nlon = length(lon); nlat = length(lat); wgt = ones(nlon,nlat)
    for ilat = 1 : nlat, ilon = 1 : nlon; wgt[ilon,ilat] = wgt[ilon,ilat] * lat[ilat] end
    return wgt

end

function etoposeg(fetopo::AbstractString,fsegnc::AbstractString)

    eds = Dataset(fetopo,"r"); lon = eds["x"][:]*1.0; lat = eds["y"][:]*1.0;
    oro = eds["z"][:]*1; oro[oro.<0] .= 0; oro[oro.>0] .= 1;
    seg = fast_scanning(oro); lab = labels_map(seg); wgt = etopoweights(lon,lat)
    close(eds);

    sds = Dataset(fsegnc,"c");
    nlon,nlat = size(lab); sds.dim["longitude"] = nlon; sds.dim["latitude"] = nlat;
    att_lon = Dict("units"=>"degrees_east","long_name"=>"longitude");
    att_lat = Dict("units"=>"degrees_north","long_name"=>"latitude");
    att_lab = Dict("long_name"=>"land_segment_labels");
    att_wgt = Dict("long_name"=>"area_weighted_by_latitude");

    defVar(sds,"longitude",lon,("longitude",),attrib=att_lon)
    defVar(sds,"latitude",lat,("latitude",),attrib=att_lat)
    defVar(sds,"landsegments",lab,("longitude","latitude"),attrib=att_lab)
    defVar(sds,"weightedarea",wgt,("longitude","latitude"),attrib=att_wgt)

    close(sds);

end

function etoporegextract(gregID::AbstractString,fregnc::AbstractString)

    fetopo,fsegnc = etopoinit(); eds = Dataset(fsegnc,"r");
    lon = eds["longitude"][:]*1.0; lat = eds["latitude"][:]*1.0;
    rlon,rlat,rinfo = gregiongridvec(gregID,lon,lat); iWE,iNS = rinfo["IDvec"];
    lab = eds["landsegments"][iWE,iNS]; nlon = length(rlon); nlat = length(rlat);
    wgt = etopoweights(rlon,rlat)

    rds = Dataset(fregnc,"c");
    nlon,nlat = size(lab); rds.dim["longitude"] = nlon; rds.dim["latitude"] = nlat;
    att_lon = Dict("units"=>"degrees_east","long_name"=>"longitude");
    att_lat = Dict("units"=>"degrees_north","long_name"=>"latitude");
    att_lab = Dict("long_name"=>"land_segment_labels");
    att_wgt = Dict("long_name"=>"area_weighted_by_latitude");

    defVar(rds,"longitude",rlon,("longitude",),attrib=att_lon)
    defVar(rds,"latitude",rlat,("latitude",),attrib=att_lat)
    defVar(rds,"landsegments",lab,("longitude","latitude"),attrib=att_lab)
    defVar(rds,"weightedarea",wgt,("longitude","latitude"),attrib=att_wgt)

    close(rds)

end

function etoporeg(gregID::AbstractString)
    fregnc = joinpath(@__DIR__,"../data/etopo/etopo-$(gregID).nc")
    if !isfile(fregnc); etoporegextract(gregID,fregnc) end
    rds = Dataset(fregnc,"r");
    return rds["landsegments"][:]*1,rds["weightedarea"][:]*1.0,
           rds["longitude"][:]*1,rds["latitude"][:]*1
end
