using DrWatson
@quickactivate "I3CM"

using ClimateSatellite
using NCDatasets

greg = "SEA"
include(srcdir("etopo.jl")); lsseg,areawgt = etoporeg(greg); idarray = unique(lsseg);
nID = length(idarray); table = zeros(Int32,nID,2)

for iID = 1 : nID
    table[iID,1] = idarray[iID];
    table[iID,2] = sum(lsseg .== idarray[iID]);
end

table = table[table[:,2].>24,:];

info = Dict(); clisatinfo!(info,"gpmimerg");
fola = clisatanafol(info,greg)
fnc  = joinpath(fola,clisatananame(info,Date(2001),greg)); ds = Dataset(fnca);
prcpyr = ds["domain_yearly_mean_hourly"].var[:];

function testextract(IDArray::Array{<:Real,2},data::Array{<:Real,3})

    nID = size(IDArray,1); dataout = zeros(Int16,nID,48)

    for ihr = 1 : 48; datahr = @view data[:,:,ihr]
        for iID = 1 : nID; dataID = @view datahr[lsseg .== table[iID,1]];
            dataout[iID,ihr] = mean(dataID);
        end
    end

end

out = testextract(table,prcpyr);
