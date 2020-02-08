using DrWatson
quickactivate("/n/holylfs/LABS/kuang_lab/nwong/I3CM/")
using ClimateSatellite

user = "natgeo.wong@outlook.com";
rvec = ["TRP"];
ddir = "/n/kuangdss01/lab/clisat/"

for yr = 2001 : 2018, mo = 1 : 12
    clisatdownload("gpmimerg",Date(yr,mo),email=user,regions=rvec,path=ddir);
end

for yr = 2001 : 2018, reg in rvec
    clisatanalysis("gpmimerg",yr,varname="prcp_rate",region=reg,path=ddir);
end
