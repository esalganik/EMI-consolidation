%% Figure 2: Historical ridge porosity and consolidation
% Itkin et al. (2025), DOI: https://doi.org/10.5194/egusphere-2025-6081
%
% (a) Unconsolidated rubble macroporosity.
% (b) Consolidated-layer to level-ice thickness ratio (CL/LI).
% Dates are shown by month/day in reference year 2020.
% Thicknesses are in metres; porosity is dimensionless.
% Linear regressions use finite observations before 1 June.

clear; close all; clc

%% 1. Source observations

% Voelker et al. (1981a)
% Source: Strub-Klein and Sudom (2012), Appendix A.1.
% DOI: https://doi.org/10.1016/j.coldregions.2012.05.014
% 35 paired level-ice and consolidated-layer thicknesses; April reference date.
hi_vol = [0.49 0.40 0.42 0.69 1.02 0.99 0.79 0.92 0.43 0.52 ...
    0.61 2.21 0.77 0.36 1.07 0.41 0.72 1.08 0.94 0.61 ...
    0.75 0.58 1.13 1.13 0.38 0.52 0.61 0.91 0.61 0.87 ...
    0.46 0.49 0.46 0.91 0.68];

hc_vol = [2.59 2.89 1.22 2.89 5.70 2.07 1.46 2.29 1.52 1.34 ...
    1.55 3.81 1.89 1.28 3.35 0.91 2.89 4.21 1.52 3.20 ...
    1.68 2.74 1.89 1.22 0.76 1.52 0.91 0.91 1.07 1.52 ...
    0.91 2.13 1.46 1.34 1.58];

t_vol = repmat('15-Apr-2020',35,1);

% Blanchet (1998)
% Four consolidated-layer and level-ice thickness pairs.
t_bla = ['20-Jan-2020';'05-Mar-2020';'25-Apr-2020';'01-Jun-2020'];

hi_bla = [1.03 1.43 1.59 1.91];

hc_bla = [1.43 2.26 2.67 3.50];

% Høyland (2002)
% Consolidation of first-year sea ice ridges (JGR), DOI: https://doi.org/10.1029/2000JC000526
% Simulations of the consolidation process (CRST), Table 2,
% DOI: https://doi.org/10.1016/S0165-232X(02)00002-2
% Svartodden (1998) and Camp Morton (1999); initial thicknesses.
t_hoy02 = ['02-Mar-2020';'10-Mar-2020'];

hi_hoy02 = [0.95 0.70];

hc_hoy02 = [1.19 0.91];

por_hoy02 = [0.325 0.35];  % 0.325 in CRST; 0.33 rounded in JGR.

% Kharitonov (2005)
% POAC 2005, Pechora Sea, April 1999.
% Regional bulk porosity (0.17) is not used as rubble porosity.
% Refrozen-layer thickness = midpoint of 0.53-0.56 m.
t_kha05 = '15-Apr-2020';

hi_kha05 = 0.70;

hc_kha05 = 0.545;

por_kha05 = NaN;

% Høyland (2007)
% DOI: https://doi.org/10.1016/j.coldregions.2007.01.006
% Appendix A, Tables 1-2: four Hopen ridge surveys (2002-2005).
% Approximate date for May surveys: 10 May.
t_hoy07 = ['10-May-2020';'10-May-2020';'10-May-2020';'10-May-2020'];

hi_hoy07 = [NaN 0.96 NaN 0.48];

hc_hoy07 = [1.90 NaN NaN 1.05];

por_hoy07 = [0.30 0.10 0.36 0.45];

% Kharitonov (2012)
% DOI: https://doi.org/10.1016/j.coldregions.2012.05.018
% Table 1: three NP-38 ridge profiles (2011).
% Rubble porosity derived from whole-keel porosity assuming zero CL macroporosity.
t_kha = ['08-Apr-2020';'24-May-2020';'04-Jun-2020'];

hi_kha = [1.02 1.70 1.70];

hc_kha = [3.00 5.40 1.80];

por_keel_kha = [0.18 0.08 0.09];

hk_kha = [6.67 12.65 9.40];

por_kha = hk_kha./(hk_kha-hc_kha).*por_keel_kha;

% Bonath et al. (2018)
% DOI: https://doi.org/10.1016/j.coldregions.2018.08.011
% Tables 1, 3, 4: ridge profiles measured in 2011-2013.
% Two R1-2013 profiles have no rubble-porosity values.
% Same ridge campaigns reported in Sand et al. (2015).
t_bon = ['29-Mar-2020'; ...
         '14-Mar-2020';'14-Mar-2020';'14-Mar-2020'; ...
         '27-Apr-2020';'27-Apr-2020'; ...
         '28-Apr-2020';'28-Apr-2020';'28-Apr-2020'; ...
         '29-Apr-2020';'29-Apr-2020'];

hi_bon  = [0.80 0.94 0.94 1.14 0.64 0.64 0.62 0.62 0.62 0.67 0.67];

hc_bon  = [2.02 2.82 1.84 1.64 1.36 0.97 1.84 1.85 1.33 1.73 1.92];

por_bon = [0.31 0.22 0.20 0.27 NaN NaN 0.34 0.31 0.19 0.38 0.51];

% Ervik et al. (2018)
% DOI: https://doi.org/10.1016/j.coldregions.2018.03.024
% Table 2: six drilling observations of four N-ICE2015 ridges.
% No level-ice denominator is used for CL/LI in this compilation.
t_erv = ['22-May-2020';'03-Jun-2020';'24-May-2020'; ...
         '31-May-2020';'10-Jun-2020';'12-Jun-2020'];

hi_erv  = [NaN NaN NaN NaN NaN NaN];

hc_erv  = [2.50 2.70 0.80 0.80 2.30 3.00];

por_erv = [0.11 0.10 0.25 0.16 0.22 0.27];

% Salganik et al. (2023)
% DOI: https://doi.org/10.1525/elementa.2023.00008
% Alli Ridge, MOSAiC, February and July 2020.
t_sal = ['05-Feb-2020';'26-Jul-2020'];

hi_sal = [1.17 1.07];

hc_sal = [1.70 3.90];

por_sal = [0.29 0.15];

% Guzenko et al. (2025)
% DOI: https://doi.org/10.17736/ijope.2025.jc943
% Table 2: monthly level ice (Hi) and CL bottom-boundary depth (CLb), January-August 2023.
% Table 3: rubble porosity (PU), May, July and August 2023; fully consolidated August rubble has no PU value.
t_guz2 = ['15-Jan-2020';'15-Feb-2020';'15-Mar-2020';'15-Apr-2020'; ...
          '15-May-2020';'15-Jun-2020';'15-Jul-2020';'15-Aug-2020'];

hi_guz2 = [1.16 1.36 1.51 1.66 1.77 1.83 1.81 1.57]; % Hi, Table 2

hc_guz2 = [1.42 1.69 2.32 2.37 2.53 2.69 2.93 2.80]; % CLb, Table 2

t_guz2_por = ['05-May-2020';'03-Jul-2020';'02-Aug-2020'; ...
              '05-May-2020';'03-Jul-2020';'02-Aug-2020'; ...
              '05-May-2020';'03-Jul-2020';'02-Aug-2020'];

por_guz2 = [0.020 0.022 NaN 0.121 0.302 NaN 0.111 0.066 NaN];

% Guzenko et al. (2026)
% DOI: https://doi.org/10.1016/j.joes.2026.03.004
% Table 3: nine ridge-group averages and one stamukha-group average (2014-2017).
t_guz = ['13-Apr-2020';'12-Apr-2020';'28-Apr-2020';'02-Jun-2020'; ...
         '13-May-2020';'15-May-2020';'23-May-2020';'07-May-2020'; ...
         '30-Mar-2020';'25-Mar-2020'];

hi_guz  = [0.89 0.94 1.51 1.38 0.97 1.15 1.46 1.55 1.76 1.65];

hc_guz  = [1.54 1.39 1.96 2.18 1.69 2.16 3.02 2.61 2.51 2.38];

por_guz = [0.24 0.31 0.28 0.25 0.36 0.26 0.27 0.25 0.29 0.20];

%% 2. Figure settings
c{1} = [0.0000 0.4470 0.7410];
c{2} = [0.8500 0.3250 0.0980];
c{3} = [0.9290 0.6940 0.1250];

fig = figure('Units','inches','Position',[1 1 7 3],'Color','w');

font = 8;

% Chronological source colors: 11 studies selected from linspecer(31).
Cpool = linspecer(31,'sequential');
brightness = 0.2126*Cpool(:,1) + 0.7152*Cpool(:,2) + 0.0722*Cpool(:,3);
Cpool = Cpool(brightness <= 0.70,:);
if size(Cpool,1) < 11
    Cpool = linspecer(31,'sequential');
end
C = Cpool(round(linspace(1,size(Cpool,1),11)),:);

msz = 4;

tile = tiledlayout(1,2); tile.TileSpacing = 'compact'; tile.Padding = 'none';

%% 3. Panel (a): rubble porosity
nexttile

fill([datetime('01-Jan-2020') datetime('01-Mar-2020') datetime('01-Mar-2020') datetime('01-Jan-2020')],[0 0 5 5],1,'FaceColor',c{1},'EdgeColor','none'); alpha(.1); hold on

fill([datetime('01-Mar-2020') datetime('01-Aug-2020') datetime('01-Aug-2020') datetime('01-Mar-2020')],[0 0 5 5],1,'FaceColor',c{3},'EdgeColor','none'); alpha(.1);

% Consolidation labels

text(0.14,0.94,'Winter', ...
    'Units','normalized','Color',c{1}, ...
    'HorizontalAlignment','center','FontSize',8);

text(0.14,0.90,'consolidation', ...
    'Units','normalized','Color',c{1}, ...
    'HorizontalAlignment','center','FontSize',8);

text(0.64,0.94,'Spring and summer', ...
    'Units','normalized','Color',c{3}, ...
    'HorizontalAlignment','center','FontSize',8);

text(0.64,0.90,'consolidation', ...
    'Units','normalized','Color',c{3}, ...
    'HorizontalAlignment','center','FontSize',8);

xx_all = [datenum(t_hoy02); datenum(t_hoy07); datenum(t_kha); ...
          datenum(t_bon); datenum(t_erv); datenum(t_sal); ...
          datenum(t_guz); datenum(t_guz2_por)];

yy_all = [por_hoy02 por_hoy07 por_kha por_bon por_erv ...
          por_sal por_guz por_guz2];

use_fit = (xx_all < datenum('01-Jun-2020')) & isfinite(yy_all(:));

xx = xx_all(use_fit); yy = yy_all(use_fit);

[x,ind] = sort(xx); y = yy(ind); [p,S] = polyfit(x,y,1); [y_fit,delta] = polyval(p,x,S);

plot(datetime(x,'ConvertFrom','datenum'),y_fit,':','color',[.7 .7 .7],'LineWidth',3.0); hold on


h = plot(datetime(t_hoy02),por_hoy02,'>','LineWidth',0.5,'color',C(3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_hoy07),por_hoy07,'>','LineWidth',0.5,'color',C(5,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_kha05),por_kha05,'o','LineWidth',0.5,'color',C(4,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_kha),por_kha,'pentagram','LineWidth',0.5,'color',C(6,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_bon),por_bon,'v','LineWidth',0.5,'color',C(7,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_erv),por_erv,'^','LineWidth',0.5,'color',C(8,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_sal),por_sal,'diamond','LineWidth',0.5,'color',C(9,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_guz2_por),por_guz2,'o','LineWidth',0.5,'color',C(10,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

h = plot(datetime(t_guz),por_guz,'s','LineWidth',0.5,'color',C(11,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

fill([datetime(x,'ConvertFrom','datenum'); flipud(datetime(x,'ConvertFrom','datenum'))],[y_fit-delta; flipud(y_fit+delta)],1,'FaceColor',[.6 .6 .6],'EdgeColor','none'); alpha(.1);

mdl = fitlm(x(:),y(:));

text(0.04,0.15,sprintf('R^2 = %.2f',mdl.Rsquared.Ordinary), ...
    'Units','normalized','FontSize',font);

text(0.04,0.10,sprintf('p-value = %.2f',mdl.Coefficients{2,4}), ...
    'Units','normalized','FontSize',font);

text(0.04,0.05,sprintf('Porosity = %.2f ± %.2f',mean(yy),std(yy)), ...
    'Units','normalized','FontSize',font);

set(gca,'FontSize',font,'FontWeight','normal');

hYLabel = ylabel('Rubble porosity'); set([hYLabel gca],'FontSize',font,'FontWeight','normal');

ax = gca; ax.XTick = datetime(['01-Jan-2020';'01-Feb-2020';'01-Mar-2020';'01-Apr-2020';'01-May-2020';'01-Jun-2020';'01-Jul-2020';'01-Aug-2020']); datetick('x','mmm','keepticks'); xtickangle(0); % time

ylim([0 0.6]);

%% 4. Panel (b): CL/LI thickness
nexttile

fill([datetime('01-Jan-2020') datetime('01-Mar-2020') datetime('01-Mar-2020') datetime('01-Jan-2020')],[0 0 5 5],1,'FaceColor',c{1},'EdgeColor','none'); alpha(.1); hold on

fill([datetime('01-Mar-2020') datetime('01-Aug-2020') datetime('01-Aug-2020') datetime('01-Mar-2020')],[0 0 5 5],1,'FaceColor',c{3},'EdgeColor','none'); alpha(.1);

% Consolidation labels

text(0.14,0.94,'Winter', ...
    'Units','normalized','Color',c{1}, ...
    'HorizontalAlignment','center','FontSize',8);

text(0.14,0.90,'consolidation', ...
    'Units','normalized','Color',c{1}, ...
    'HorizontalAlignment','center','FontSize',8);

text(0.64,0.94,'Spring and summer', ...
    'Units','normalized','Color',c{3}, ...
    'HorizontalAlignment','center','FontSize',8);

text(0.64,0.90,'consolidation', ...
    'Units','normalized','Color',c{3}, ...
    'HorizontalAlignment','center','FontSize',8);

xx_all = [datenum(t_vol(1,:)); datenum(t_bla); datenum(t_hoy02); ...
          datenum(t_kha05); datenum(t_hoy07); datenum(t_kha); ...
          datenum(t_bon); datenum(t_erv); datenum(t_sal); ...
          datenum(t_guz2); datenum(t_guz)];

yy_all = [mean(hc_vol./hi_vol) hc_bla./hi_bla ...
          hc_hoy02./hi_hoy02 hc_kha05./hi_kha05 hc_hoy07./hi_hoy07 ...
          hc_kha./hi_kha hc_bon./hi_bon hc_erv./hi_erv ...
          hc_sal./hi_sal hc_guz2./hi_guz2 hc_guz./hi_guz];

use_fit = (xx_all < datenum('01-Jun-2020')) & isfinite(yy_all(:));

xx = xx_all(use_fit); yy = yy_all(use_fit);

[x,ind] = sort(xx); y = yy(ind); [p,S] = polyfit(x,y,1); [y_fit,delta] = polyval(p,x,S);

fill([datetime(x,'ConvertFrom','datenum'); flipud(datetime(x,'ConvertFrom','datenum'))],[y_fit-delta; flipud(y_fit+delta)],1,'FaceColor',[.6 .6 .6],'EdgeColor','none'); alpha(.1); hold on

mdl = fitlm(x(:),y(:));

plot(datetime(x,'ConvertFrom','datenum'),y_fit,':','color',[.7 .7 .7],'LineWidth',3.0);

hVol = plot(datetime(t_vol(1,:)),mean(hc_vol./hi_vol),'o','LineWidth',0.5,'color',C(1,:)); hVol.MarkerSize = msz; set(hVol,'markerfacecolor',get(hVol,'color')); hold on

hBla = plot(datetime(t_bla),hc_bla./hi_bla,'<','LineWidth',0.5,'color',C(2,:)); hBla.MarkerSize = msz; set(hBla,'markerfacecolor',get(hBla,'color'));

hHoy02 = plot(datetime(t_hoy02),hc_hoy02./hi_hoy02,'>','LineWidth',0.5,'color',C(3,:)); hHoy02.MarkerSize = msz; set(hHoy02,'markerfacecolor',get(hHoy02,'color'));

hKha05 = plot(datetime(t_kha05),hc_kha05./hi_kha05,'o','LineWidth',0.5,'color',C(4,:)); hKha05.MarkerSize = msz; set(hKha05,'markerfacecolor',get(hKha05,'color'));

hHoy07 = plot(datetime(t_hoy07),hc_hoy07./hi_hoy07,'>','LineWidth',0.5,'color',C(5,:)); hHoy07.MarkerSize = msz; set(hHoy07,'markerfacecolor',get(hHoy07,'color'));

hKha12 = plot(datetime(t_kha),hc_kha./hi_kha,'pentagram','LineWidth',0.5,'color',C(6,:)); hKha12.MarkerSize = msz; set(hKha12,'markerfacecolor',get(hKha12,'color'));

hBon = plot(datetime(t_bon),hc_bon./hi_bon,'v','LineWidth',0.5,'color',C(7,:)); hBon.MarkerSize = msz; set(hBon,'markerfacecolor',get(hBon,'color'));

% Legend handle for Ervik (panel a only).

hErv = plot(datetime(t_erv),hc_erv./hi_erv,'^','LineWidth',0.5,'color',C(8,:)); hErv.MarkerSize = msz; set(hErv,'markerfacecolor',get(hErv,'color'));

hSal = plot(datetime(t_sal),hc_sal./hi_sal,'diamond','LineWidth',0.5,'color',C(9,:)); hSal.MarkerSize = msz; set(hSal,'markerfacecolor',get(hSal,'color'));

hGuz25 = plot(datetime(t_guz2),hc_guz2./hi_guz2,'o','LineWidth',0.5,'color',C(10,:)); hGuz25.MarkerSize = msz; set(hGuz25,'markerfacecolor',get(hGuz25,'color'));

hGuz26 = plot(datetime(t_guz),hc_guz./hi_guz,'s','LineWidth',0.5,'color',C(11,:)); hGuz26.MarkerSize = msz; set(hGuz26,'markerfacecolor',get(hGuz26,'color'));

text(0.04,0.15,sprintf('R^2 = %.2f',mdl.Rsquared.Ordinary), ...
    'Units','normalized','FontSize',font);

text(0.04,0.10,sprintf('p-value = %.2f',mdl.Coefficients{2,4}), ...
    'Units','normalized','FontSize',font);

text(0.04,0.05,sprintf('CL / LI = %.1f ± %.1f',mean(yy),std(yy)), ...
    'Units','normalized','FontSize',font);

ylim([0 4]);

hYLabel = ylabel('CL / LI thickness'); set([hYLabel gca],'FontSize',8,'FontWeight','normal');

leg = legend([hVol hBla hHoy02 hKha05 hHoy07 hKha12 hBon hErv hSal hGuz25 hGuz26], ...
    {'Voelker et al., 1981','Blanchet, 1998','Høyland, 2002', ...
     'Kharitonov, 2005','Høyland, 2007','Kharitonov, 2012', ...
     'Bonath et al., 2018','Ervik et al., 2018','Salganik et al., 2023', ...
     'Guzenko et al., 2025','Guzenko et al., 2026'},'box','off');

set(leg,'FontSize',6,'Location','eastoutside'); leg.ItemTokenSize = [30*0.05,18*0.05];

ax = gca; ax.XTick = datetime(['01-Jan-2020';'01-Feb-2020';'01-Mar-2020';'01-Apr-2020';'01-May-2020';'01-Jun-2020';'01-Jul-2020';'01-Aug-2020']); datetick('x','mmm','keepticks'); xtickangle(0); % time

annotation('textbox',[0.00 .51 0.02 .51],'String','(a)','EdgeColor','none','HorizontalAlignment','center','FontSize',8);

annotation('textbox',[0.29 .51 0.29 .51],'String','(b)','EdgeColor','none','HorizontalAlignment','center','FontSize',8);

%% 5. Export (7 x 3 inches, 300 dpi)

set(fig,'PaperUnits','inches', ...
    'PaperSize',[7 3], ...
    'PaperPosition',[0 0 7 3], ...
    'PaperPositionMode','manual');

scriptDir = fileparts(mfilename('fullpath'));

if isempty(scriptDir), scriptDir = pwd; end

pngFile = fullfile(scriptDir,'Fig2.png');

drawnow;

print(fig,pngFile,'-dpng','-r300');

fprintf('Saved 7 x 3 inch figure at 300 dpi (2100 x 900 px):\n%s\n',pngFile);