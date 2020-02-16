using DrWatson
quickactivate("/n/holylfs/LABS/kuang_lab/nwong/I3CM/")
using ClimateSatellite

global_logger(ConsoleLogger(stdout,Logging.Info))

rvec = ["TRP","ISM","SEA","MLD","SMT"];
ddir = "/n/kuangdss01/lab/clisat/"

for yr = 2017 : 2019, reg in rvec
    clisatanalysis("mtpw2m",yr,varname="tpw",region=reg,path=ddir);
end
