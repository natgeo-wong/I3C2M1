using DrWatson
@quickactivate I3CM
using ClimateSatellite

global_logger(ConsoleLogger(stderr,Logging.Info))

user = "natgeo.wong@outlook.com";
rvec = ["TRP"];
ddir = "/n/kuangdss01/user/nwong/clisat/"

for yr = 2001 : 2019, mo = 1 : 12
    clisatdownload("mtpw2m",Date(yr,mo),email=user,regions=rvec,path=ddir);
end

for yr = 2001 : 2019, reg in rvec
    clisatanalysis("mtpw2m",yr,varname="tpw",region=reg,path=ddir);
end
