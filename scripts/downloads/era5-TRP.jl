using DrWatson
@quickactivate "PiPWV"
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))

init,eroot = erastartup(aID=2,dID=1,path="/n/kuangdss01/lab/ecmwf/"); adderaparams();

eradownload(init,eroot,modID="msfc",parID="prcp_conv",regID="TRP");
eradownload(init,eroot,modID="msfc",parID="prcp_ls",regID="TRP");
eradownload(init,eroot,modID="msfc",parID="prcp_tot",regID="TRP");
eradownload(init,eroot,modID="msfc",parID="tcw",regID="TRP");

eradownload(init,eroot,modID="mpre",parID="shum",regID="TRP");

eradownload(init,eroot,modID="dsfc",parID="p_sfc",regID="TRP");
eradownload(init,eroot,modID="dsfc",parID="t_sfc",regID="TRP");
eradownload(init,eroot,modID="dsfc",parID="u_sfc",regID="TRP");
eradownload(init,eroot,modID="dsfc",parID="v_sfc",regID="TRP");

eradownload(init,eroot,modID="dpre",parID="t_air",regID="TRP");
eradownload(init,eroot,modID="dpre",parID="u_air",regID="TRP");
eradownload(init,eroot,modID="dpre",parID="v_air",regID="TRP");
eradownload(init,eroot,modID="dpre",parID="w_air",regID="TRP");
