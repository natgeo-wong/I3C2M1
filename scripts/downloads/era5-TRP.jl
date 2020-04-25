using DrWatson
@quickactivate "PiPWV"
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("ecmwf.jl"))

init,eroot = erastartup(aID=2,dID=1,path="/n/kuangdss01/lab/ecmwf/"); adderaparams();

ecmwfdwn(init,eroot,modID="msfc",parID="prcp_conv",regID="TRP");
ecmwfdwn(init,eroot,modID="msfc",parID="prcp_ls",regID="TRP");
ecmwfdwn(init,eroot,modID="msfc",parID="prcp_tot",regID="TRP");
ecmwfdwn(init,eroot,modID="msfc",parID="tcw",regID="TRP");

ecmwfdwn(init,eroot,modID="mpre",parID="shum",regID="TRP");

ecmwfdwn(init,eroot,modID="dsfc",parID="pre_sfc",regID="TRP");
ecmwfdwn(init,eroot,modID="dsfc",parID="t_sfc",regID="TRP");
ecmwfdwn(init,eroot,modID="dsfc",parID="u_sfc",regID="TRP");
ecmwfdwn(init,eroot,modID="dsfc",parID="v_sfc",regID="TRP");

ecmwfdwn(init,eroot,modID="dpre",parID="t_air",regID="TRP");
ecmwfdwn(init,eroot,modID="dpre",parID="u_air",regID="TRP");
ecmwfdwn(init,eroot,modID="dpre",parID="v_air",regID="TRP");
ecmwfdwn(init,eroot,modID="dpre",parID="w_air",regID="TRP");
