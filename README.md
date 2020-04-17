# <div align="center">I3C2M1: Investigating the Impact of Islands on Convection, Climate and Models</div>

This repository contains the code for my current project, which aims to investigate the impact of islands on convection, climate and models.

**Created/Mantained By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)

> The Maritime Continent is the largest island archipelago in the world and spans five major countries in the region: Malaysia, Indonesia, Singapore, Philippines and Papua New Guinea. It holds a critical role in the global climate for a multitude of reasons: (1) it is globally one of the most important sources of convective release of latent heat and therefore plays a critical role in the global moisture flux; (2) it is geographically unique in its distribution of land and sea, neither fully oceanic nor truly continental, and this results in a strong diurnal cycle of precipitation that modulates and is modulated by larger-scale climate phenomena such as the monsoon and the Madden-Julian Oscillation (MJO); (3) it is located within the Indo-Pacific warmpool, one of the major drivers of convection in the region.
>
> Many questions remain about the role of the Maritime Continent in global climate. But the questions that I am interested in ultimately boil down to one simple question: How do islands impact with the atmospheric circulation? In order to tackle these problems, I aim to use TRMM and GPM satellite-based rainfall data from the Precipitation Measurement Mission, satellite-derived (e.g. MIMIC-TPW2m) and GNSS-derived (e.g. SuGAr) precipitable water products, ERA5 and ERA-Interim reanalysis products, and a hierarchy of climate models ranging from idealized models to fully-coupled GCMs.

## Current Status

**Preliminary Data Handling**
* [x] Downloaded ECWMF Reanalysis Datasets
* [x] Downloaded GPM Precipitation Datasets
* [ ] Analysis of all datasets and retrieve basic climatological statistics

## Project Setup

### 1) Required Julia Dependencies

The entire codebase is written in Julia.  If the data files are downloaded, you should be able to produce my results in their entirety.  The following are a list of Julia packages that were used in this project:
* `GeoRegions.jl`
* `ClimateSatellite.jl`, `ClimateERA.jl`
* `Images.jl`, `ImageSegmentation.jl`
* `NCDatasets.jl`

In order to reproduce the results, first you have to clone the repository, and instantiate the project environment in the Julia REPL in order to install the required packages:
```
git clone https://github.com/natgeo-wong/I3C2M1.git
] activate .
instantiate
```

### 2) Downloading Required Data Files
* **ETOPO GRD Files**: Download the **ETOPO1 Bedrock** file `ETOPO1_Bed_g_gmt4.grd.gz` from `https://www.ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/bedrock/grid_registered/netcdf/`, and save as `data/raw/ETOPO1.grd`
* **GPM IMERG/NRT-LATE Files**: Modify the `ddir` variable in the download/rawanalysis scripts found in `scripts/download` and `scripts/rawanalysis` and save to whereever is relevant.  Use `ClimateSatellite.jl` to determine/point to your data folder.
* **ERA5**: Modify the `ddir` variable in the download/rawanalysis scripts found in `scripts/download` and `scripts/rawanalysis` and save to whereever is relevant.  Use `ClimateERA.jl` to determine/point to your data folder.

_**NB**: It is not advised to point the `ddir` into I3C2M1 unless you have a lot of space available.  Most of my analysis of the relevant satellite and reanalysis data was done on the Harvard cluster Odyssey/Cannon._

### 3) Preliminary Data Analysis
* **Data Downloads**: See `scripts/download` to download available relevant satellite and ECMWF reanalysis data.  Uses `ClimateSatellite.jl` and `ClimateERA.jl`
* **Preliminary Analysis**: See `scripts/analysis` for preliminary analysis of downloaded satellite and reanalysis data.  Uses `ClimateSatellite.jl` and `ClimateERA.jl`
* **Land/Sea Mask**: See `src/etopo.jl` to extract and identify individual landmasses.  Uses `Images.jl` and `ImageSegmentation.jl` to identify islands based on ETOPO bathymetry data.  Uses `GeoRegions.jl` to extract regional data.

## **Other Acknowledgements**
> Project Repository Template generated using [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl) created by George Datseris.
