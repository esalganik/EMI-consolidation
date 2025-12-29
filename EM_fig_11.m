%% Figure 11 from Itkin et al (2025) Year-round assessment of sea ice pressure ridges by multi-frequency electromagnetic induction sounding
electromagnetic induction sounding
clc; clear; close all

ks  = 0.26; % thermal conductivity of snow on ridges frpm snow pits, Macfalane et al.
Hia = 21; % air-snow heat transfer coefficient for the average wind speed
Li  = 333400; % latent heat of fresh ice
por = 0.29; % average ridge macroporosity from drilling

c = {[0.0000 0.4470 0.7410], ...
     [0.8500 0.3250 0.0980], ...
     [0.9290 0.6940 0.1250], ...
     [0.4940 0.1840 0.5560]};

basePath = "C:\Users\evsalg001\Documents\MATLAB\datasets\ridge_model_input_EM\";

load('PS_meteo.mat',"Tw_mss","Ta_T66")
load('T66.mat',"t_T66"); t_T66 = t_T66(1:1097);
load('Coring_AR.mat',"Lsi","k_si_bulk_int","rho_bulk_int")

cfgTags    = {'ridgeA1','ridgeA2','ridgeA3','ridgeFR1','ridgeFR2'};
ylim_values = {[0.5 5.5],[0.5 5.5],[0.5 5.5],[0.5 4.0],[0.5 4.0]};

cfg = cell(1,numel(cfgTags));
for k = 1:numel(cfgTags)
    fb = read_emi(basePath + cfgTags{k} + "_cc_freeboard.csv", true);
    t_EMI_start = fb.t(1);
    [~, t0_idx] = min(abs(datenum(t_T66) - datenum(t_EMI_start)));
    
    cfg{k} = struct('name',cfgTags{k}(6:end),...
                    'tag',cfgTags{k},...
                    't0', t0_idx,...
                    'ylim', ylim_values{k});
end

figure
tl = tiledlayout(1,numel(cfg));
tl.TileSpacing = 'compact';
tl.Padding = 'none';

handlesTile1 = [];

for k = 1:numel(cfg)
    nexttile
    out = run_ridge_case(cfg{k},basePath,t_T66,Tw_mss,Ta_T66,...
                         Lsi,k_si_bulk_int,rho_bulk_int,ks,Hia,Li,por);
    h = plot_ridge_case(out,c,cfg{k},k);
    if k == 1
        handlesTile1 = h;
    end
end

letters = {'(a)','(b)','(c)','(d)','(e)'};
xpos = [0.005,0.14,0.27,0.40,0.535];
for k = 1:numel(letters)
    annotation('textbox',[xpos(k) .51 xpos(k)+0.01 .51],'String',letters{k},...
               'FontSize',7,'EdgeColor','none','HorizontalAlignment','center');
end

ax3 = tl.Children(end-2);
legLabels = {'EMI mean ± std','Simulated','IMB'};
leg = legend(ax3, handlesTile1, legLabels, ...
             'Box','off', 'NumColumns',3, 'FontSize',7, 'Location','southoutside');
leg.ItemTokenSize = [30*0.66,18*0.66];

tileNames = cell(1,numel(cfg));
EMI_thicknessChange = zeros(1,numel(cfg));
Model_thicknessChange = zeros(1,numel(cfg));
Diff_thicknessChange = zeros(1,numel(cfg));
IMB_thicknessChange = nan(1,numel(cfg));

for k = 1:numel(cfg)
    fb = read_emi(basePath + cfg{k}.tag + "_cc_freeboard.csv", true);
    cl = read_emi(basePath + cfg{k}.tag + "_cc_consolidatedlayer.csv");
    
    EMI_thicknessChange(k) = mean((cl.data(end,:) - fb.data(end,:)) - ...
                                  (cl.data(1,:) - fb.data(1,:)));
    
    out = run_ridge_case(cfg{k},basePath,t_T66,Tw_mss,Ta_T66,...
                         Lsi,k_si_bulk_int,rho_bulk_int,ks,Hia,Li,por);
    
    t_last_EMI = datenum(fb.t(end));
    dsi_interp = interp1(datenum(out.t_sim), out.dsi_avg, t_last_EMI, 'linear');
    Model_thicknessChange(k) = dsi_interp - out.dsi_avg(1);
    Diff_thicknessChange(k)  = Model_thicknessChange(k) - EMI_thicknessChange(k);
    
    IMB_diffs = [];

    if k == 1
        load('T61.mat','t_T61')
        hc_T = -[104 106 118 130 132 134 142 144 149 156 166 167 172 181 187 ...
                 205 217 222 227 251 273 306 329 352 376 384 392]/100;
        n = min(numel(t_T61),numel(hc_T));
        t_T61 = t_T61(1:n); hc_T = hc_T(1:n);
        [~,idx_last] = min(abs(datenum(t_T61)-t_last_EMI));
        IMB_diffs = [IMB_diffs; hc_T(idx_last) - hc_T(1)];

        load('DTC26.mat','t_DTC26')
        hc_DTC = -[210 210 210 210 214 222 224 238 238 242 238 256 242 ...
                   238 224 214]/100;
        n = min(numel(t_DTC26),numel(hc_DTC));
        t_DTC26 = t_DTC26(1:n); hc_DTC = hc_DTC(1:n);
        [~,idx_last] = min(abs(datenum(t_DTC26)-t_last_EMI));
        IMB_diffs = [IMB_diffs; hc_DTC(idx_last) - hc_DTC(1)];
    end

    if k == 4
        load('T60.mat','t_T60')
        hc_T = -[147 147 177 200 214 233 256 280 319 323 354 374 ...
                 412 429 448 450 450 450 450]/100;
        n = min(numel(t_T60),numel(hc_T));
        t_T60 = t_T60(1:n); hc_T = hc_T(1:n);
        [~,idx_last] = min(abs(datenum(t_T60)-t_last_EMI));
        IMB_diffs = [IMB_diffs; hc_T(idx_last) - hc_T(1) - 0.5];

        load('DTC_data.mat','t_DTC','hi_DTC')
        t_dtc25 = datetime(t_DTC{11},'ConvertFrom','datenum');
        [~,idx_last] = min(abs(datenum(t_dtc25)-t_last_EMI));
        IMB_diffs = [IMB_diffs; -hi_DTC{11}(idx_last) + hi_DTC{11}(1)];

        t_dtc24 = datetime(t_DTC{12},'ConvertFrom','datenum');
        [~,idx_last] = min(abs(datenum(t_dtc24)-t_last_EMI));
        IMB_diffs = [IMB_diffs; -hi_DTC{12}(idx_last) + hi_DTC{12}(1)];
    end

    if ~isempty(IMB_diffs)
        IMB_thicknessChange(k) = mean(-IMB_diffs);
    end

    tileNames{k} = cfg{k}.name;
end

T = table(tileNames',round(EMI_thicknessChange,2)',...
          round(Model_thicknessChange,2)',...
          round(IMB_thicknessChange,2)',...
          round(Diff_thicknessChange,2)',...
          'VariableNames',{'Tile','EMI ThicknessChange (m)',...
                           'Model ThicknessChange (m)',...
                           'IMB ThicknessChange (m)','Difference (m)'});
disp(T)

% --- Functions ---
function out = run_ridge_case(cfg,basePath,t_T66,Tw,Ta,Lsi,ki_all,rhoi_all,ks,Hia,Li,por)

    fb = read_emi(basePath + cfg.tag + "_cc_freeboard.csv", true);
    cl = read_emi(basePath + cfg.tag + "_cc_consolidatedlayer.csv");
    sn = read_emi(basePath + cfg.tag + "_cc_snow.csv");

    % --- Start simulation exactly at first EMI time ---
    t_EMI_start = fb.t(1);
    [~, t0_idx] = min(abs(datenum(t_T66) - datenum(t_EMI_start)));
    t_sim  = t_T66(t0_idx:end);
    Tw_sim = Tw(t0_idx:end);
    Ta_sim = Ta(t0_idx:end);

    x  = cl.x;
    t  = cl.t;
    cl = cl.data;
    fb = fb.data;
    sn = sn.data;

    % --- Interpolate auxiliary inputs to t_sim ---
    t_aux = linspace(datenum(t_T66(1)),datenum(t_T66(end)),numel(Lsi));
    Lsi_i = interp1(t_aux,Lsi,datenum(t_sim),'linear','extrap');
    ki_i  = interp1(t_aux,ki_all,datenum(t_sim),'linear','extrap');
    rhoi_i= interp1(t_aux,rhoi_all,datenum(t_sim),'linear','extrap');

    hs = zeros(numel(t_sim),numel(x));
    for i = 1:numel(x)
        hs(:,i) = interp1([datenum(t); datenum(t_sim(end))],...
                          [sn(:,i); 0],datenum(t_sim),'linear');
    end

    td = datenum(t_sim) - datenum(t_sim(1));
    t_sec = td * 86400;
    dt = diff(t_sec);

    dc_em = zeros(numel(t_sim),numel(x));
    for j = 1:numel(x)
        dc = zeros(1,numel(t_sec));
        dc(1) = cl(1,j);
        for i = 1:numel(dt)
            R1 = 1/Hia;
            R2 = hs(i,j)/ks;
            R3 = dc(i)/ki_i(i);
            Tsi = (Ta_sim(i)-Tw_sim(i))*R3/(R1+R2+R3) + Tw_sim(i);
            dc(i+1) = dc(i) - ki_i(i)/rhoi_i(i)/(Li*por) * (Tsi-Tw_sim(i))/dc(i)*dt(i);
        end
        dc_em(:,j) = dc(:) - fb(j);
    end

    dc_em_si = dc_em .* (Li./Lsi_i - Li/Lsi_i(1) + 1);

    out.t         = t;
    out.t_sim     = t_sim;
    out.di_em_avg = mean(cl - fb(1,:),2);
    out.di_em_std = std(cl,[],2);
    out.dsi_avg   = mean(dc_em_si,2);
    out.dsi_std   = std(dc_em_si,[],2);
    out.name      = cfg.name;
end

function hOut = plot_ridge_case(o,c,cfg,scan_id)
    % Shaded area (simulated ± std)
    p = fill([o.t_sim; flipud(o.t_sim)],...
             [o.dsi_avg+o.dsi_std; flipud(o.dsi_avg-o.dsi_std)],...
             1,'FaceColor',c{1},'EdgeColor','none');
    set(p,'FaceAlpha',0.1)
    p.Annotation.LegendInformation.IconDisplayStyle = 'off';
    hold on

    % Observed EM
    h1 = errorbar(o.t,o.di_em_avg,o.di_em_std,'o','Color',c{4},...
                  'MarkerFaceColor',c{4},'MarkerSize',3,'LineWidth',0.75);

    % Simulated mean
    h3 = plot(o.t_sim,o.dsi_avg,'Color',c{1});

    % IMB/T61/DTC
    h_IMB = [];
    if scan_id == 1
        load('T61.mat',"t_T61")
        load('DTC26.mat',"t_DTC26")
        t_hc = [1 9 50 100 140 150 175 200 225 250 275 290 300 310 315 325 330 340 350 375 400 425 450 475 525 550 689];
        hc_T = -[104 106 118 130 132 134 142 144 149 156 166 167 172 181 187 205 217 222 227 251 273 306 329 352 376 384 392]/100;
        hc_T_int = interp1(datenum(t_T61(t_hc)),hc_T,datenum(t_T61),'linear');
        t_hc_DTC = [1 15 30 60 160 200 240 300 330 375 440 500 550 600 630 656];
        hc_DTC = -[210 210 210 210 214 222 224 238 238 242 238 256 242 238 224 214]/100;
        hc_DTC_int = interp1(datenum(t_DTC26(t_hc_DTC)),hc_DTC,datenum(t_DTC26),'linear','extrap');
        h1_IMB = plot(t_T61,-hc_T_int,'--','LineWidth',0.5,'Color',c{3});
        plot(t_DTC26(4:end),-hc_DTC_int(4:end),'-','LineWidth',0.5,'Color',c{3});
        text(o.t(1)+30,1.0,'T61','Color',c{3},'HorizontalAlignment','left','FontSize',7)
        text(o.t(1)+30,1.9,'DTC26','Color',c{3},'HorizontalAlignment','left','FontSize',7)
        h_IMB = h1_IMB;
    end

    if scan_id == 4
        load('DTC_data.mat',"t_DTC","fb_DTC","hs_DTC","hi_DTC")
        load('T60.mat',"t_T60")
        t_hc = [1 9 50 100 150 200 250 275 285 290 310 315 325 350 375 395 405 410 420];
        hc_T = -[147 147 177 200 214 233 256 280 319 323 354 374 412 429 448 450 450 450 450]/100;
        hc_T_int = interp1(datenum(t_T60(t_hc)),hc_T,datenum(t_T60),'linear');
        plot(datetime(t_DTC{12},'ConvertFrom','datenum'),-hi_DTC{12},'-','LineWidth',0.5,'Color',c{3})
        plot(t_T60,-hc_T_int-0.5,'-.','LineWidth',0.5,'Color',c{3})
        plot(datetime(t_DTC{11},'ConvertFrom','datenum'),-hi_DTC{11},'--','LineWidth',0.5,'Color',c{3})
        text(o.t(1)+80,1.35,'DTC25','Color',c{3},'HorizontalAlignment','right','FontSize',7)
        text(o.t(1)+35,2.45,'DTC24','Color',c{3},'HorizontalAlignment','right','FontSize',7)
        text(o.t(1)+75,3.35,'T60','Color',c{3},'HorizontalAlignment','right','FontSize',7)
    end

    ylim(cfg.ylim); 
    yticks(cfg.ylim(1):0.5:cfg.ylim(2));   % <- fixed spacing of 0.5 m
    set(gca,'YDir','reverse','FontSize',8); 
    box on

    if scan_id == 1
        ylabel('Consolidated layer thickness (m)','FontSize',8)
    end

    if scan_id == 4 || scan_id == 5
        xlim([datetime('01-Jan-2020') datetime('01-Apr-2020')])
    else
        xlim([datetime('01-Jan-2020') datetime('01-Aug-2020')])
    end
    datetick('x','mmm','keeplimits')
    xtickangle(0)

    title(cfg.name,'FontSize',8,'FontWeight','normal')

    hOut = [h1,h3,h_IMB];
end

function out = read_emi(fname,isVector)
if nargin < 2; isVector = false; end
A = table2array(readtable(fname));
out.x = A(1,2:end);
out.t = datetime(num2str(A(2:end,1)),'InputFormat','yyyyMMdd');
if isVector
    out.data = A(2,2:end);
else
    out.data = A(2:end,2:end);
end
end