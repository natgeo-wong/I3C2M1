using DrWatson
@quickactivate "I3C2M1"
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("common.jl"))

init,eroot = erastartup(aID=2,dID=1,path="/n/kuangdss01/lab/ecmwf/"); adderaparams();
pre = [1000,950,850,700,600,500,350,250,150,70]; t = [1980,2019];

eraanalysis(init,eroot,modID="msfc",parID="prcp_conv",regID="TRP",plvls="sfc",timeID=t);
eraanalysis(init,eroot,modID="msfc",parID="prcp_ls",regID="TRP",plvls="sfc",timeID=t);
eraanalysis(init,eroot,modID="msfc",parID="prcp_tot",regID="TRP",plvls="sfc",timeID=t);
eraanalysis(init,eroot,modID="msfc",parID="tcw",regID="TRP",plvls="sfc",timeID=t);

eraanalysis(init,eroot,modID="mpre",parID="shum",regID="TRP",plvls=pre,timeID=t);

eraanalysis(init,eroot,modID="dsfc",parID="p_sfc",regID="TRP",plvls="sfc",timeID=t);
eraanalysis(init,eroot,modID="dsfc",parID="t_sfc",regID="TRP",plvls="sfc",timeID=t);
eraanalysis(init,eroot,modID="dsfc",parID="u_sfc",regID="TRP",plvls="sfc",timeID=t);
eraanalysis(init,eroot,modID="dsfc",parID="v_sfc",regID="TRP",plvls="sfc",timeID=t);

eraanalysis(init,eroot,modID="dpre",parID="t_air",regID="TRP",plvls=pre,timeID=t);
eraanalysis(init,eroot,modID="dpre",parID="u_air",regID="TRP",plvls=pre,timeID=t);
eraanalysis(init,eroot,modID="dpre",parID="v_air",regID="TRP",plvls=pre,timeID=t);
