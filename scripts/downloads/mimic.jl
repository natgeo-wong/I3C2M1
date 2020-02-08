using DrWatson
quickactivate("/n/holylfs/LABS/kuang_lab/nwong/I3CM/")
using ClimateSatellite

user = "natgeo.wong@outlook.com";
rvec = ["TRP"];
ddir = "/n/kuangdss01/lab/clisat/"

for yr = 2001 : 2019, mo = 1 : 12
    clisatdownload("mtpw2m",Date(yr,mo),email=user,regions=rvec,path=ddir);
end

for yr = 2001 : 2019, reg in rvec
    clisatanalysis("mtpw2m",yr,varname="tpw",region=reg,path=ddir);
end
