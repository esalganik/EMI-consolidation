
# Sea ice pressure ridge consolidation

MATLAB scripts accompanying:

**Itkin et al. (2025).** *Year-round assessment of sea ice pressure ridges by multi-frequency electromagnetic induction sounding.*  
https://doi.org/10.5194/egusphere-2025-6081

## MATLAB scripts

The repository contains scripts to reproduce two figures:

1. **Fig2.m** — Historical observations of sea ice pressure ridge rubble porosity and the ratio of consolidated-layer to level-ice thickness. The compiled literature data are included directly in the script.
2. **Fig11.m** — Thermodynamic modeling of consolidated-layer evolution for selected profiles of Alli's Ridge and Fort Ridge during MOSAiC, compared with electromagnetic induction measurements and ice mass balance buoy observations.

Both scripts export PNG figures at 300 dpi.

## Repository structure

```text
├── Fig2.m
├── Fig11.m
├── linspecer.m
├── README.md
└── data/
    ├── PS_meteo.mat
    ├── T66.mat
    ├── T60.mat
    ├── T61.mat
    ├── DTC26.mat
    ├── DTC_data.mat
    ├── Coring_AR.mat
    └── ridge_model_input_EM/
        ├── ridgeA1_*.csv
        ├── ridgeA2_*.csv
        ├── ridgeA3_*.csv
        ├── ridgeFR1_*.csv
        └── ridgeFR2_*.csv
```

## Usage

Run `Fig2.m` or `Fig11.m` in MATLAB. The scripts save `Fig2.png` and `Fig11.png` in the repository directory.

`Fig2.m` uses the [linspecer](https://www.mathworks.com/matlabcentral/fileexchange/42673-beautiful-and-distinguishable-line-colors-colormap) colormap by Jonathan C. Lansey and requires the Statistics and Machine Learning Toolbox.

`Fig11.m` loads MAT files from `data/` and CSV files from `data/ridge_model_input_EM/`. All paths are relative to the script location.

## Datasets

The scripts use the following published datasets and model inputs:

- Ridge thermodynamic model: https://doi.org/10.1016/j.coldregions.2020.103194
- Temperature measurements from 2020T60 buoy: https://doi.org/10.1594/PANGAEA.924269
- Temperature measurements from 2020T61 buoy: https://doi.org/10.1594/PANGAEA.926580
- Temperature measurements from DTC24 buoy: https://doi.org/10.1594/PANGAEA.960609
- Temperature measurements from DTC25 buoy: https://doi.org/10.1594/PANGAEA.960620
- Temperature measurements from DTC26 buoy: https://doi.org/10.1594/PANGAEA.951780
- Snow thickness from Magnaprobe transect observations: https://doi.org/10.1594/PANGAEA.937781
- Ice thickness from GEM-2 transect observations: https://doi.org/10.1594/PANGAEA.943666
- Alli's Ridge coring measurements of ice density and salinity: https://doi.org/10.1594/PANGAEA.953865
- Fort Ridge coring measurements of ice salinity: https://doi.org/10.1594/PANGAEA.962542
- Core oceanographic parameters: https://doi.org/10.18739/A21J9790B
- Alli's Ridge drilling data: https://doi.org/10.1594/PANGAEA.950192
- Fort Ridge drilling data: https://doi.org/10.1594/PANGAEA.960347
- Snow thermal conductivity estimates from computed tomography: https://doi.org/10.5194/tc-17-5417-2023

The two investigated ridges are described in:

- **Alli's Ridge:** https://doi.org/10.1525/elementa.2023.00008
- **Fort Ridge**, MOSAiC Central Observatory: https://doi.org/10.1525/elementa.2021.000046

Additional literature sources used for the historical compilation in Fig. 2 are documented in `Fig2.m`.
