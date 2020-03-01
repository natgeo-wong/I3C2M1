using DrWatson
quickactivate("/n/holylfs/LABS/kuang_lab/nwong/I3CM/")
using ClimateSatellite

global_logger(ConsoleLogger(stdout,Logging.Info))

rvec = ["TRP","ISM","SEA","MLD","SMT"];
ddir = "/n/kuangdss01/lab/clisat/"

for yr = 2001 : 2019, reg in rvec
    clisatanalysis("gpmlate",yr,varname="prcp_rate",region=reg,path=ddir);
end
