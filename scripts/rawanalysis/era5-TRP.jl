using DrWatson
@quickactivate "PiPWV"
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("ecmwf.jl"))

init,eroot = erastartup(aID=2,dID=1,path="/n/kuangdss01/lab/ecmwf/"); adderaparams();

ecmwfana(init,eroot,modID="msfc",parID="prcp_conv",regID="TRP");
ecmwfana(init,eroot,modID="msfc",parID="prcp_ls",regID="TRP");
ecmwfana(init,eroot,modID="msfc",parID="prcp_tot",regID="TRP");
ecmwfana(init,eroot,modID="msfc",parID="tcw",regID="TRP");

ecmwfana(init,eroot,modID="mpre",parID="shum",regID="TRP");

ecmwfana(init,eroot,modID="dsfc",parID="pre_sfc",regID="TRP");
ecmwfana(init,eroot,modID="dsfc",parID="t_sfc",regID="TRP");
ecmwfana(init,eroot,modID="dsfc",parID="u_sfc",regID="TRP");
ecmwfana(init,eroot,modID="dsfc",parID="v_sfc",regID="TRP");

ecmwfana(init,eroot,modID="dpre",parID="t_air",regID="TRP");
ecmwfana(init,eroot,modID="dpre",parID="u_air",regID="TRP");
ecmwfana(init,eroot,modID="dpre",parID="v_air",regID="TRP");
