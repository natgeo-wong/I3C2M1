using DrWatson
@quickactivate "I3C2M1"
using ClimateSatellite

global_logger(ConsoleLogger(stdout,Logging.Info))

user = "natgeo.wong@outlook.com";
rvec = ["TRP","ISM"]; rext = ["SEA","MLD","SMT"];
ddir = "/n/kuangdss01/lab/clisat/"

for yr = 2008 : 2018, mo = 1 : 12
    clisatdownload("gpmimerg",Date(yr,mo),email=user,regions=rvec,path=ddir);
end

for yr = 2001 : 2018, mo = 1 : 12, reg in rext
    clisatsubregion("gpmimerg",Date(yr,mo),region=reg,path=ddir);
end
