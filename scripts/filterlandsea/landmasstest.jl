using DrWatson
@quickactivate "I3CM"

using Dates
using ClimateSatellite
using NCDatasets

greg = "SEA"
include(srcdir("etopo.jl"));
lsseg,areawgt,lon,lat = etoporeg(greg); idarray = unique(lsseg);
nID = length(idarray); table = zeros(Int32,nID,2);
elon = repeat(lon,outer=[1,length(lat)]);
elat = repeat(lat,outer=[1,length(lon)])'; elat = convert(Array,elat);

for iID = 1 : nID
    table[iID,1] = idarray[iID];
    table[iID,2] = sum(lsseg .== idarray[iID]);
end

#table = table[table[:,2].>4,:];

info = Dict{Any,Any}("root"=>clisatroot("gpmimerg")); clisatinfo!(info,"gpmimerg");
fola = clisatanafol(info,greg)
fnca = joinpath(fola,clisatananame(info,"prcp_rate",Date(2001),greg)); ds = Dataset(fnca);
scle = ds["domain_yearly_mean_diurnalvariance"].attrib["scale_factor"];
oset = ds["domain_yearly_mean_diurnalvariance"].attrib["add_offset"];
glon = ds["longitude"][:]*1.0; glat = ds["latitude"][:]*1.0;
close(ds);

prcp = zeros(length(glon),length(glat),18)

for ii = 1 : 18
    global fnca = joinpath(fola,clisatananame(info,"prcp_rate",Date(2000+ii),greg));
    ds = Dataset(fnca); prcp[:,:,ii] = ds["domain_yearly_mean_diurnalvariance"].var[:];
    close(ds);
end

prcp = dropdims(mean(prcp,dims=3),dims=3);

function testextracthourly(
    IDArray::Array{<:Real,2}, data::Array{<:Real,3},
    glon::Vector{<:Real}, glat::Vector{<:Real},
    elon::Array{<:Real,2}, elat::Array{<:Real,2}
)

    nID = size(IDArray,1); dataout = zeros(48,nID-1)

    for iID = 2 : nID; @info "$(Dates.now()) - $iID"

        ilon = @view elon[lsseg.==table[iID,1]];
        ilat = @view elat[lsseg.==table[iID,1]];
        ind  = landmassind(ilon,ilat,glon,glat);
        nind = length(ind); tmp = zeros(Int16,nind);

        for ihr = 1 : 48; datahr = @view data[:,:,ihr]
            for iind = 1 : nind; tmp[iind] = datahr[ind[iind]...] end;
            dataID = mean(tmp); dataout[ihr,iID-1] = mean(dataID);
        end

    end

    return dataout

end

function testextractdiurnalvariance(
    IDArray::Array{<:Real,2}, data::Array{<:Real,2},
    glon::Vector{<:Real}, glat::Vector{<:Real},
    elon::Array{<:Real,2}, elat::Array{<:Real,2}
)

    nID = size(IDArray,1); dataout = zeros(nID-1)

    for iID = 2 : nID; @info "$(Dates.now()) - $iID"

        ilon = @view elon[lsseg.==table[iID,1]];
        ilat = @view elat[lsseg.==table[iID,1]];
        ind  = landmassind(ilon,ilat,glon,glat);
        nind = length(ind); tmp = zeros(nind);

        for iind = 1 : nind; tmp[iind] = data[ind[iind]...] end;
        dataID = mean(tmp); dataout[iID-1] = mean(dataID);

    end

    return dataout

end

function landmassind(
    ilon,ilat,
    glon::Vector{<:Real},glat::Vector{<:Real}
)

    ncoord = length(ilon); gcoord = Vector{Vector}(undef,ncoord)
    for icoord = 1 : ncoord;
        gcoord[icoord] = regionpoint(ilon[icoord],ilat[icoord],glon,glat)
    end
    return gcoord

end

out = testextractdiurnalvariance(table,prcp,glon,glat,elon,elat) .* scle .+ oset;
out = out.*3600; isize = log10.(table[2:end,2]); ivec = convert(Array,0.5:0.05:6);
bin01 = zeros(length(ivec));
bin05 = zeros(length(ivec)); bin10 = zeros(length(ivec));
bin20 = zeros(length(ivec)); bin50 = zeros(length(ivec));
jj = 0;

for ii in ivec; global jj = jj + 1;
    ind = (isize .< ii+0.5) .& (isize .> ii-0.5);
    if (ind != []) .& (sum(ind)>1);  bin01[jj] = mean(out[ind]); else bin01[jj] = NaN end
    if (ind != []) .& (sum(ind)>5);  bin05[jj] = mean(out[ind]); else bin05[jj] = NaN end
    if (ind != []) .& (sum(ind)>10); bin10[jj] = mean(out[ind]); else bin10[jj] = NaN end
    if (ind != []) .& (sum(ind)>20); bin20[jj] = mean(out[ind]); else bin20[jj] = NaN end
    if (ind != []) .& (sum(ind)>50); bin50[jj] = mean(out[ind]); else bin50[jj] = NaN end
end

close(); figure(figsize=(6,5),dpi=200)
scatter(ivec,bin01,s=2);
scatter(ivec,bin05,s=2); scatter(ivec,bin10,s=2);
scatter(ivec,bin20,s=2); scatter(ivec,bin50,s=2);
xlim(0.5,6); grid("on"); gcf()
