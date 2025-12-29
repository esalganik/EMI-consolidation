%% Figure 2 from Itkin et al (2025) Year-round assessment of sea ice pressure ridges by multi-frequency electromagnetic induction sounding
clear; close all; clc
c{1} = [0.0000 0.4470 0.7410]; c{2} = [0.8500 0.3250 0.0980]; c{3} = [0.9290 0.6940 0.1250]; % colors
% ridge historical data
t_guz2=['15-Jan-2020';'15-Feb-2020';'15-Mar-2020';'15-Apr-2020';'15-May-2020';'15-Jun-2020';'15-Jul-2020';'15-Aug-2020']; % Guzenko, Lyuba ridge, 2024, 1 ridge
hi_guz2 = [1.15 1.36 1.51 1.66 1.77 1.83 1.81 1.57]; % Guzenko, Lyuba ridge
hc_guz2 = [1.42 1.69 2.32 2.37 2.53 2.69 2.93 2.80]; % Guzenko, Lyuba ridge
t_guz =['13-Apr-2020';'12-Apr-2020';'28-Apr-2020';'02-Jun-2020';'13-May-2020';'15-May-2020';'23-May-2020';'07-May-2020';'30-Mar-2020';'25-Mar-2020']; % Guzenko et al., 2024
hi_guz  = [0.89 0.94 1.51 1.38 0.97 1.15 1.46 1.55 1.76 1.65]; % Guzenko et al., 2024
hc_guz  = [1.54 1.39 1.96 2.18 1.69 2.16 3.02 2.61 2.51 2.38]; % Guzenko et al., 2024
por_guz = [0.24 0.31 0.28 0.25 0.36 0.26 0.27 0.25 0.29 0.20]; % Guzenko et al., 2024, 103 ridges
t_bon =['29-Mar-2020';'14-Mar-2020';'14-Mar-2020';'14-Mar-2020';'28-Apr-2020';'28-Apr-2020';'28-Apr-2020';'29-Apr-2020';'29-Apr-2020']; % Bonath 2018
hi_bon =  [0.80 0.94 1.14 0.64 0.62 0.62 0.62 0.67 0.67]; % Bonath 2018
hc_bon =  [2.02 2.82 1.64 1.36 1.84 1.85 1.33 1.73 1.92]; % Bonath 2018
por_bon = [ .31  .22  .20  .27  .34  .31  .19  .38  .51]; % Bonath 2018, 6 ridges
t_erv=['22-May-2020';'03-Jun-2020';'24-May-2020';'31-May-2020';'10-Jun-2020';'12-Jun-2020']; % Ervik, N-ICE 2018
hi_erv =  [1.4 1.24 1.3 1.3 0.64 0.64]; % Ervik, N-ICE 2018
hc_erv =  [2.5 2.70 0.8 0.8 2.30 3.00]; % Ervik, N-ICE 2018
por_erv = [.11  .10 .25 .16  .22  .27]; % Ervik, N-ICE 2018, 4 ridges
t_hoy=['02-Mar-2020';'10-Mar-2020';'10-May-2020';'10-May-2020';'10-May-2020';'10-May-2020']; % Hoyland 2002,2007
hi_hoy =  [0.95  0.70   0.47 NaN 0.96 1.20]; % Hoyland 2002,2007
hc_hoy =  [1.19  0.91   1.05 1.5 1.40 1.90]; % Hoyland 2002,2007
por_hoy = [0.325 0.35   0.45 .36 0.10 0.30]; % Hoyland 2002,2007, 6 ridges
t_sal = ['05-Feb-2020';'26-Jul-2020']; % Salganik 2023, 1 ridge (AR)
hi_sal =  [1.17 1.07]; % Salganik 2023, AR
hc_sal =  [1.70 3.90]; % Salganik 2023, AR
por_sal = [0.29 0.15]; % Salganik 2023, AR
t_kha = ['17-Mar-2020';'06-Jun-2020';'19-Jun-2020']; % Kharitonov, 2012
hi_kha =  [1.02 1.7 1.7]; % Kharitonov, 2012
hc_kha =  [3.00 5.4 1.8]; % Kharitonov, 2012
por_keel_kha = [0.18 0.08 0.09]; % Kharitonov, 2012, 3 ridges
hk_kha =  [6.67 12.65 9.4]; % Kharitonov, 2012
por_kha = hk_kha./(hk_kha-hc_kha).*por_keel_kha; % Kharitonov, 2012
t_kha05 = '15-Apr-2020'; % Kharitonov, 2005
hi_kha05 =  0.70; % Kharitonov, 2005
hc_kha05 =  0.515; % Kharitonov, 2005
por_kha05 = 0.17; % Kharitonov, 2005, 1 ridge
hc_tru =  [2.9 1.4 3.2]; % Truskov, 1996, Sakhalin
por_keel_tru = [0.23 0.25 0.20]; % Truskov, 1996, Sakhalin
hk_tru =  [8.5 5.6 5.5]; % Truskov, 1996, Sakhalin
por_tru = hk_tru./(hk_tru-hc_tru).*por_keel_tru; % Truskov, 1996, Sakhalin, 3 ridges
hi_sum =  [hi_kha(2:3) hi_sal(2)]; % summer
hc_sum =  [hc_kha(2:3) hc_sal(2)]; % summer
por_sum = [por_kha(2:3) por_sal(2)]; % summer
t_bla = ['20-Jan-2020';'05-Mar-2020';'25-Apr-2020';'01-Jun-2020']; % Blanchet, 1998
hi_bla = [1.03 1.43 1.59 1.91]; % Blanchet, 1998
hc_bla = [1.43 2.26 2.67 3.50]; % Blanchet, 1998, 1 ridge
hi_vol = [0.49 0.40 0.42 0.69 1.02 0.99 0.79 0.92 0.43 0.52 0.61 2.21 0.77 0.36 1.07 0.41 0.72 1.08 0.94 0.61 0.75 0.58 1.13 1.13 0.38 0.52 0.61 0.91 0.61 0.87 0.46 0.49 0.46 0.91 0.68]; % Voelker et al., 1981a
hc_vol = [2.59 2.89 1.22 2.89 5.70 2.07 1.46 2.29 1.52 1.34 1.55 3.81 1.89 1.28 3.35 0.91 2.89 4.21 1.52 3.20 1.68 2.74 1.89 1.22 0.76 1.52 0.91 0.91 1.07 1.52 0.91 2.13 1.46 1.34 1.58];
t_vol = '15-Apr-2020'; for i = 1:35; t_vol(i,1:11) = t_vol(1,1:11); end

figure
font = 8; % font size for pdf export
tile = tiledlayout(1,2); tile.TileSpacing = 'compact'; tile.Padding = 'none';
nexttile
fill([datetime('01-Jan-2020') datetime('01-Mar-2020') datetime('01-Mar-2020') datetime('01-Jan-2020')],[0 0 5 5],1,'FaceColor',c{1},'EdgeColor','none'); alpha(.1); hold on
fill([datetime('01-Mar-2020') datetime('01-Aug-2020') datetime('01-Aug-2020') datetime('01-Mar-2020')],[0 0 5 5],1,'FaceColor',c{3},'EdgeColor','none'); alpha(.1);
p = text(datetime('31-Jan-2020'),(5-0.4)*6/50,'Winter'); set(p,'Color',c{1},'HorizontalAlignment','center','FontSize',8);
p = text(datetime('31-Jan-2020'),(5-0.6)*6/50,'consolidation'); set(p,'Color',c{1},'HorizontalAlignment','center','FontSize',8);
p = text(datetime('15-May-2020'),(5-0.4)*6/50,'Spring and summer'); set(p,'Color',c{3},'HorizontalAlignment','center','FontSize',8);
p = text(datetime('15-May-2020'),(5-0.6)*6/50,'consolidation'); set(p,'Color',c{3},'HorizontalAlignment','center','FontSize',8);

C = linspecer(13); msz = 3.5;
xx = [datenum(t_hoy); datenum(t_kha(1,:)); datenum(t_bon); datenum(t_erv(1:4,:)); datenum(t_sal(1,:)); datenum(t_guz)];
yy = [por_hoy por_kha(1) por_bon por_erv(1:4) por_sal(1) por_guz];
[x,ind] = sort(xx); y = yy(ind); [p,S] = polyfit(x,y,1); [y_fit,delta] = polyval(p,x,S);
plot(datetime(x,'ConvertFrom','datenum'),y_fit,':','color',[.7 .7 .7],'LineWidth',3.0); hold on
h = plot(datetime(t_hoy),por_hoy,'>','LineWidth',0.5,'color',C(3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_kha05),por_kha05,'o','LineWidth',0.5,'color',C(4,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_kha(1,:)),por_kha(1),'pentagram','LineWidth',0.5,'color',C(5,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_bon),por_bon,'v','LineWidth',0.5,'color',C(6+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_erv(1:4,:)),por_erv(1:4),'^','LineWidth',0.5,'color',C(7+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_sal(1,:)),por_sal(1),'diamond','LineWidth',0.5,'color',C(8+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_guz),por_guz,'s','LineWidth',0.5,'color',C(9+2,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_kha(2:3,:)),por_kha(2:3),'pentagram','LineWidth',0.5,'color',C(5,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_erv(5:6,:)),por_erv(5:6),'^','LineWidth',0.5,'color',C(7+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_sal(2,:)),por_sal(2),'diamond','LineWidth',0.5,'color',C(8+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
fill([datetime(x,'ConvertFrom','datenum'); flipud(datetime(x,'ConvertFrom','datenum'))],[y_fit-delta; flipud(y_fit+delta)],1,'FaceColor',[.6 .6 .6],'EdgeColor','none'); alpha(.1);
mdl = fitlm(x',y'); % plot(mdl)
p = text(datetime('10-Jan-2020'),0.09,sprintf('R^2 = %.2f',mdl.Rsquared.Ordinary)); set(p,'Color','k','HorizontalAlignment','left','FontSize',font);
p = text(datetime('10-Jan-2020'),0.06,sprintf('p-value = %.2f',mdl.Coefficients{2,4})); set(p,'Color','k','HorizontalAlignment','left','FontSize',font);
p = text(datetime('10-Jan-2020'),0.03,sprintf('Porosity = %.2f ± %.2f',mean(yy),std(yy))); set(p,'Color','k','HorizontalAlignment','left','FontSize',font);
set(gca,'FontSize',font,'FontWeight','normal');
hYLabel = ylabel('Rubble porosity'); set([hYLabel gca],'FontSize',font,'FontWeight','normal');
ax = gca; ax.XTick = datetime(['01-Jan-2020';'01-Feb-2020';'01-Mar-2020';'01-Apr-2020';'01-May-2020';'01-Jun-2020';'01-Jul-2020';'01-Aug-2020']); datetick('x','mmm','keepticks'); xtickangle(0); % time
ylim([0 0.6]);

nexttile
msz = 3.5;
fill([datetime('01-Jan-2020') datetime('01-Mar-2020') datetime('01-Mar-2020') datetime('01-Jan-2020')],[0 0 5 5],1,'FaceColor',c{1},'EdgeColor','none'); alpha(.1); hold on
fill([datetime('01-Mar-2020') datetime('01-Aug-2020') datetime('01-Aug-2020') datetime('01-Mar-2020')],[0 0 5 5],1,'FaceColor',c{3},'EdgeColor','none'); alpha(.1);

p = text(datetime('31-Jan-2020'),5-0.4,'Winter'); set(p,'Color',c{1},'HorizontalAlignment','center','FontSize',8);
p = text(datetime('31-Jan-2020'),5-0.6,'consolidation'); set(p,'Color',c{1},'HorizontalAlignment','center','FontSize',8);
p = text(datetime('15-May-2020'),5-0.4,'Spring and summer'); set(p,'Color',c{3},'HorizontalAlignment','center','FontSize',8);
p = text(datetime('15-May-2020'),5-0.6,'consolidation'); set(p,'Color',c{3},'HorizontalAlignment','center','FontSize',8);

xx = [datenum(t_vol(1,:)); datenum(t_hoy([1:3 5:6],:)); datenum(t_bla(:,:)); datenum(t_kha05(:,:)); datenum(t_kha(1,:)); datenum(t_bon); datenum(t_erv(1:4,:)); datenum(t_sal(1,:)); datenum(t_guz); datenum(t_guz2(1:5,:))];
yy = [mean(hc_vol./hi_vol) hc_hoy([1:3 5:6])./hi_hoy([1:3 5:6]) hc_bla./hi_bla hc_kha05./hi_kha05 hc_kha(1)./hi_kha(1) hc_bon./hi_bon hc_erv(1:4)./hi_erv(1:4) hc_sal(1)./hi_sal(1) hc_guz./hi_guz hc_guz2(1:5)./hi_guz2(1:5)];
[x,ind] = sort(xx); y = yy(ind); [p,S] = polyfit(x,y,1); [y_fit,delta] = polyval(p,x,S);
fill([datetime(x,'ConvertFrom','datenum'); flipud(datetime(x,'ConvertFrom','datenum'))],[y_fit-delta; flipud(y_fit+delta)],1,'FaceColor',[.6 .6 .6],'EdgeColor','none'); alpha(.1); hold on
mdl = fitlm(x',y');
plot(datetime(x,'ConvertFrom','datenum'),y_fit,':','color',[.7 .7 .7],'LineWidth',3.0);

h = plot(datetime(t_vol(1,:)),mean(hc_vol./hi_vol),'o','LineWidth',0.5,'color',C(1,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color')); hold on
h = plot(datetime(t_bla),hc_bla./hi_bla,'<','LineWidth',0.5,'color',C(2,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_hoy),hc_hoy./hi_hoy,'>','LineWidth',0.5,'color',C(3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_kha05),hc_kha05./hi_kha05,'o','LineWidth',0.5,'color',C(4,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_kha),hc_kha./hi_kha,'pentagram','LineWidth',0.5,'color',C(5,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_bon),hc_bon./hi_bon,'v','LineWidth',0.5,'color',C(6+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_erv),hc_erv./hi_erv,'^','LineWidth',0.5,'color',C(7+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_sal),hc_sal./hi_sal,'diamond','LineWidth',0.5,'color',C(8+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_guz),hc_guz./hi_guz,'s','LineWidth',0.5,'color',C(9+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));
h = plot(datetime(t_guz2),hc_guz2./hi_guz2,'o','LineWidth',0.5,'color',C(10+3,:)); h.MarkerSize = msz; set(h,'markerfacecolor',get(h,'color'));

p = text(datetime('10-Jan-2020'),0.09*5/0.6,sprintf('R^2 = %.2f',mdl.Rsquared.Ordinary)); set(p,'Color','k','HorizontalAlignment','left','FontSize',font);
p = text(datetime('10-Jan-2020'),0.06*5/0.6,sprintf('p-value = %.2f',mdl.Coefficients{2,4})); set(p,'Color','k','HorizontalAlignment','left','FontSize',font);
p = text(datetime('10-Jan-2020'),0.03*5/0.6,sprintf('CL / LI = %.1f ± %.1f',mean(yy),std(yy))); set(p,'Color','k','HorizontalAlignment','left','FontSize',font);

ylim([0 5]);
hYLabel = ylabel('CL / LI thickness'); set([hYLabel gca],'FontSize',8,'FontWeight','normal');
leg = legend('','','','','Voelker et al., 1981','Blanchet, 1998','Høyland, 2002,2007','Kharitonov, 2005','Kharitonov, 2012','Bonath et al., 2018','Ervik et al., 2018','Salganik et al., 2023','Guzenko et al., 2022','Guzenko et al., 2024','box','off');
set(leg,'FontSize',6,'Location','eastoutside'); leg.ItemTokenSize = [30*0.05,18*0.05];
ax = gca; ax.XTick = datetime(['01-Jan-2020';'01-Feb-2020';'01-Mar-2020';'01-Apr-2020';'01-May-2020';'01-Jun-2020';'01-Jul-2020';'01-Aug-2020']); datetick('x','mmm','keepticks'); xtickangle(0); % time

annotation('textbox',[0.00 .51 0.02 .51],'String','(a)','EdgeColor','none','HorizontalAlignment','center','FontSize',8);
annotation('textbox',[0.29 .51 0.29 .51],'String','(b)','EdgeColor','none','HorizontalAlignment','center','FontSize',8);
