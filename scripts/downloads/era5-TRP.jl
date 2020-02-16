using DrWatson
quickactivate("/n/holylfs/LABS/kuang_lab/nwong/I3CM/")
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))


## Dry Surface
init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(1,1,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(1,2,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(1,3,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(1,5,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)


## Dry Pressure Levels
init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(2,1,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(2,2,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(2,3,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(2,4,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)


## Moist Surface
init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(3,1,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(3,2,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(3,3,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)

init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(3,5,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)


## Moist Pressure Levels
init,eroot = erastartup(1,1,"/n/kuangdss01/lab/ecmwf/");
emod,epar,ereg,etime = erainitialize(4,2,2,0,init);
eradownload(emod,epar,ereg,etime,eroot)
