using DrWatson
quickactivate("/n/holylfs/LABS/kuang_lab/nwong/I3CM/")
using ClimateSatellite

user = "natgeo.wong@outlook.com";
rvec = ["TRP","ISM"]; rext = ["SEA","MLD","SMT"];
ddir = "/n/kuangdss01/lab/clisat/"

for yr = 2001 : 2019, mo = 1 : 12
    clisatdownload("gpmlate",Date(yr,mo),email=user,regions=rvec,path=ddir);
end

for yr = 2001 : 2019, mo = 1 : 12, reg in rext
    clisatsubregion("gpmlate",Date(yr,mo),region=reg,path=ddir);
end

for yr = 2001 : 2019, reg in vcat(rvec,rext)
    clisatanalysis("gpmlate",yr,varname="prcp_rate",region=reg,path=ddir);
end
