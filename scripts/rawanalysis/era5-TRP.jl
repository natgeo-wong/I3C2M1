using DrWatson
@quickactivate "PiPWV"
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("common.jl"))

init,eroot = erastartup(aID=2,dID=1,path="/n/kuangdss01/lab/ecmwf/"); adderaparams();

eraanalysis(init,eroot,modID="msfc",parID="prcp_conv",regID="TRP");
eraanalysis(init,eroot,modID="msfc",parID="prcp_ls",regID="TRP");
eraanalysis(init,eroot,modID="msfc",parID="prcp_tot",regID="TRP");
eraanalysis(init,eroot,modID="msfc",parID="tcw",regID="TRP");

eraanalysis(init,eroot,modID="mpre",parID="shum",regID="TRP");

eraanalysis(init,eroot,modID="dsfc",parID="pre_sfc",regID="TRP");
eraanalysis(init,eroot,modID="dsfc",parID="t_sfc",regID="TRP");
eraanalysis(init,eroot,modID="dsfc",parID="u_sfc",regID="TRP");
eraanalysis(init,eroot,modID="dsfc",parID="v_sfc",regID="TRP");

eraanalysis(init,eroot,modID="dpre",parID="t_air",regID="TRP");
eraanalysis(init,eroot,modID="dpre",parID="u_air",regID="TRP");
eraanalysis(init,eroot,modID="dpre",parID="v_air",regID="TRP");
