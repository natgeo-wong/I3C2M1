using ClimateSatellite

global_logger(ConsoleLogger(stderr,Logging.Info))

user = "natgeo.wong@outlook.com";
rvec = ["TRP","SEA","SGP"];
ddir = "/n/kuangdss01/user/nwong/clisat/"

for yr = 2001 : 2019, mo = 1 : 12
    clisatdownload("gpmlate",Date(yr,mo),email=user,regions=rvec,path=ddir);
end

for yr = 2001 : 2019, reg in rvec
    clisatanalysis("gpmlate",yr,varname="prcp_rate",region=reg,path=ddir);
end
