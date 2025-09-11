clear;
clc;
close all;

centerData = readmatrix("Case 1 - load in center"); % read in data for centered load
offCenterData = readmatrix("Case_b1.txt"); % read in data for off centered load at unknown location
symmData = readmatrix("Case_l1"); % read in data for 2 symmetrical loads

centerLoad = centerData(:,1); % sort each column for centered data
centerLVDT = centerData(:,6);
centerF0 = centerData(:,2);
centerF1 = centerData(:,3);
centerF2 = centerData(:,4);
centerF3D = centerData(:,5);

offCenterLoad = offCenterData(:,1); % sort each column for unknown loc data
offCenterLVDT = offCenterData(:,6);
offCenterF0 = offCenterData(:,2);
offCenterF1 = offCenterData(:,3);
offCenterF2 = offCenterData(:,4);
offCenterF3D = offCenterData(:,5);

symmLoad = symmData(:,1); % sort each column for symmetric loading data
symmLVDT = symmData(:,6);
symmF0 = symmData(:,2);
symmF1 = symmData(:,3);
symmF2 = symmData(:,4);
symmF3D = symmData(:,5);


graph(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLoad, symmLVDT, symmF0, symmF1, symmF2, symmF3D)


function [] = graph(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLoad, symmLVDT, symmF0, symmF1, symmF2, symmF3D)
    
    maxIndexCenters = 1;
    temp1 = 0;
    for x = 1:length(centerLoad)
        if temp1<centerLoad(x)
            temp1 = centerLoad(x);
            maxIndexCenters = x; % Store the index of the maximum center load
        end
    end

    maxIndexSymm = 1;
    temp2 = 0;
    for x = 1:length(symmLoad)
        if temp2<symmLoad(x)
            temp2 = symmLoad(x);
            maxIndexSymm = x; % Store the index of the maximum center load
        end
    end
    [fitCenterLDVTcoeff, fitCenterLDVTstruct] = polyfit(centerLoad(1:maxIndexCenters), centerLVDT(1:maxIndexCenters), 1);
    fitCenterLVDT  = polyval(fitCenterLDVTcoeff, centerLoad(1:maxIndexCenters));
    [fitCenterF0coeff, fitCenterF0struct] = polyfit(centerLoad(1:maxIndexCenters), centerF0(1:maxIndexCenters), 1);
    fitCenterF0 = polyval(fitCenterF0coeff, centerLoad(1:maxIndexCenters));
    [fitCenterF1coeff, fitCenterF1struct] = polyfit(centerLoad(1:maxIndexCenters), centerF1(1:maxIndexCenters), 1);
    fitCenterF1 = polyval(fitCenterF1coeff, centerLoad(1:maxIndexCenters));
    [fitCenterF2coeff, fitCenterF2struct] = polyfit(centerLoad(1:maxIndexCenters), centerF2(1:maxIndexCenters), 1);
    fitCenterF2 = polyval(fitCenterF2coeff, centerLoad(1:maxIndexCenters));
    [fitCenterF3Dcoeff, fitCenterF3Dstruct] = polyfit(centerLoad(1:maxIndexCenters), centerF3D(1:maxIndexCenters), 1);
    fitCenterF3D = polyval(fitCenterF3Dcoeff, centerLoad(1:maxIndexCenters));

    [fitOffCenterLVDTcoeff, fitOffCenterLVDTstruct] = polyfit(offCenterLoad(1:maxIndexCenters), offCenterLVDT(1:maxIndexCenters), 1);
    fitOffCenterLVDT = polyval(fitOffCenterLVDTcoeff, offCenterLoad(1:maxIndexCenters));
    [fitOffCenterF0coeff, fitOffCenterF0struct] = polyfit(offCenterLoad(1:maxIndexCenters), offCenterF0(1:maxIndexCenters), 1);
    fitOffCenterF0 = polyval(fitOffCenterF0coeff, offCenterLoad(1:maxIndexCenters));
    [fitOffCenterF1coeff, fitOffCenterF1struct] = polyfit(offCenterLoad(1:maxIndexCenters), offCenterF1(1:maxIndexCenters), 1);
    fitOffCenterF1 = polyval(fitOffCenterF1coeff, offCenterLoad(1:maxIndexCenters));
    [fitOffCenterF2coeff, fitOffCenterF2struct] = polyfit(offCenterLoad(1:maxIndexCenters), offCenterF2(1:maxIndexCenters), 1);
    fitOffCenterF2 = polyval(fitOffCenterF2coeff, offCenterLoad(1:maxIndexCenters));
    [fitOffCenterF3Dcoeff, fitOffCenterF3Dstruct] = polyfit(offCenterLoad(1:maxIndexCenters), offCenterF3D(1:maxIndexCenters), 1);
    fitOffCenterF3D = polyval(fitOffCenterF3Dcoeff, offCenterLoad(1:maxIndexCenters));

    [fitSymmLVDTcoeff, fitSymmLVDTstruct] = polyfit(symmLoad(1:maxIndexSymm), symmLVDT(1:maxIndexSymm), 1);
    fitSymmLVDT = polyval(fitSymmLVDTcoeff, symmLoad(1:maxIndexSymm));
    [fitSymmF0coeff, fitSymmF0struct] = polyfit(symmLoad(1:maxIndexSymm), symmF0(1:maxIndexSymm), 1);
    fitSymmF0 = polyval(fitSymmF0coeff, symmLoad(1:maxIndexSymm));
    [fitSymmF1coeff, fitSymmF1struct] = polyfit(symmLoad(1:maxIndexSymm), symmF1(1:maxIndexSymm), 1);
    fitSymmF1 = polyval(fitSymmF1coeff, symmLoad(1:maxIndexSymm));
    [fitSymmF2coeff, fitSymmF2struct] = polyfit(symmLoad(1:maxIndexSymm), symmF2(1:maxIndexSymm), 1);
    fitSymmF2 = polyval(fitSymmF2coeff, symmLoad(1:maxIndexSymm));
    [fitSymmF3Dcoeff, fitSymmF3Dstruct] = polyfit(symmLoad(1:maxIndexSymm), symmF3D(1:maxIndexSymm), 1);
    fitSymmF3D = polyval(fitSymmF3Dcoeff, symmLoad(1:maxIndexSymm));

    %{
    mu_values = struct();
    mu_values.CenterLDVT = muCenterLDVT;
    mu_values.CenterF0 = muCenterF0;
    mu_values.CenterF1 = muCenterF1;
    mu_values.CenterF2 = muCenterF2;
    mu_values.CenterF3D = muCenterF3D;
    mu_values.OffCenterLDVT = muOffCenterLVDT;
    mu_values.OffCenterF0 = muOffCenterF0;
    mu_values.OffCenterF1 = muOffCenterF1;
    mu_values.OffCenterF2 = muOffCenterF2;
    mu_values.OffCenterF3D = muOffCenterF3D;
    mu_values.SymmLDVT = muSymmLVDT;
    mu_values.SymmF0 = muSymmF0;
    mu_values.SymmF1 = muSymmF1;
    mu_values.SymmF2 = muSymmF2;
    mu_values.SymmF3D = muSymmF3D;
    %}

    R_squared_values = struct();
    R_squared_values.CenterLDVT = fitCenterLDVTstruct.rsquared;
    R_squared_values.CenterF0 = fitCenterF0struct.rsquared;
    R_squared_values.CenterF1 = fitCenterF1struct.rsquared;
    R_squared_values.CenterF2 = fitCenterF2struct.rsquared;
    R_squared_values.CenterF3D = fitCenterF3Dstruct.rsquared;
    R_squared_values.OffCenterLDVT = fitOffCenterLVDTstruct.rsquared;
    R_squared_values.OffCenterF0 = fitOffCenterF0struct.rsquared;
    R_squared_values.OffCenterF1 = fitOffCenterF1struct.rsquared;
    R_squared_values.OffCenterF2 = fitOffCenterF2struct.rsquared;
    R_squared_values.OffCenterF3D = fitOffCenterF3Dstruct.rsquared;
    R_squared_values.SymmLDVT = fitSymmLVDTstruct.rsquared;
    R_squared_values.SymmF0 = fitSymmF0struct.rsquared;
    R_squared_values.SymmF1 = fitSymmF1struct.rsquared;
    R_squared_values.SymmF2 = fitSymmF2struct.rsquared;
    R_squared_values.SymmF3D = fitSymmF3Dstruct.rsquared;

    R_squared_values

    
    figure(100);
    hold on;
    title('Linear Displacements (LDVT) vs Loading Force')
    plot(centerLoad, centerLVDT, 'ro');
    plot(centerLoad(1:maxIndexCenters), fitCenterLVDT, 'r')
    plot(offCenterLoad, offCenterLVDT, 'cdiamond');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterLVDT, 'c');
    plot(symmLoad, symmLVDT, 'ysquare');
    plot(symmLoad(1:maxIndexSymm), fitSymmLVDT, 'y')
    xlabel('Loading Force (lbf)')
    ylabel('Deflection (in)')
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(200);
    hold on;
    title('F0 Force vs Loading Force')
    plot(centerLoad, centerF0, 'ro');
    plot(offCenterLoad, offCenterF0, 'cdiamond');
    plot(symmLoad, symmF0, 'ysquare');
    plot(centerLoad(1:maxIndexCenters), fitCenterF0, 'r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF0, 'c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF0, 'y');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(300);
    hold on;
    title('F1 Force vs Loading Force');
    plot(centerLoad, centerF1, 'ro');
    plot(offCenterLoad, offCenterF1, 'cdiamond');
    plot(symmLoad, symmF1, 'ysquare');
    plot(centerLoad(1:maxIndexCenters), fitCenterF1, 'r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF1, 'c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF1, 'y');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(400);
    hold on;
    title('F2 Force vs Loading Force')
    plot(centerLoad, centerF2, 'ro');
    plot(offCenterLoad, offCenterF2, 'cdiamond');
    plot(symmLoad, symmF2, 'ysquare');
    plot(centerLoad(1:maxIndexCenters), fitCenterF2, 'r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF2, 'c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF2, 'y');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(500);
    hold on;
    title('F3D Force vs Loading Force')
    plot(centerLoad, centerF3D, 'ro');
    plot(offCenterLoad, offCenterF3D, 'cdiamond');
    plot(symmLoad, symmF3D, 'ysquare');
    plot(centerLoad(1:maxIndexCenters), fitCenterF3D, 'r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF3D, 'c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF3D, 'y');   
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(600);
    hold on
    title('All Measured Forces vs Loading Force');
    plot(centerLoad, centerF0, 'ro', offCenterLoad, offCenterF0, 'co', symmLoad, symmF0, 'yo');
    plot(centerLoad, centerF1, 'r+', offCenterLoad, offCenterF1, 'c+', symmLoad, symmF1, 'y+');
    plot(centerLoad, centerF2, 'rdiamond', offCenterLoad, offCenterF2, 'cdiamond', symmLoad, symmF2, 'ydiamond');
    plot(centerLoad, centerF3D, 'rsquare', offCenterLoad, offCenterF3D, 'csquare', symmLoad, symmF3D, 'ysquare');
    plot(centerLoad(1:maxIndexCenters), fitCenterF0, 'r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF0, 'c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF0, 'y');
    plot(centerLoad(1:maxIndexCenters), fitCenterF1, '-.r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF1, '-.c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF1, '-.y');
    plot(centerLoad(1:maxIndexCenters), fitCenterF2, '--r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF2, '--c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF2, '--y');
    plot(centerLoad(1:maxIndexCenters), fitCenterF3D, ':r');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF3D, ':c');
    plot(symmLoad(1:maxIndexSymm), fitSymmF3D, ':y');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load F0', 'Case 2: Off Centered Load F0', 'Case 3: 2 Symmetric Loads F0', ...
           'Case 1: Centered Load F1', 'Case 2: Off Centered Load F1', 'Case 3: 2 Symmetric Loads F1', ...
           'Case 1: Centered Load F2', 'Case 2: Off Centered Load F2', 'Case 3: 2 Symmetric Loads F2', ...
           'Case 1: Centered Load F3D', 'Case 2: Off Centered Load F3D', 'Case 3: 2 Symmetric Loads F3D', ...
           'Case 1: Centered Load F0 Best Fit', 'Case 2: Off Centered Load F0 Best Fit', 'Case 3: Symmetric Load F0 Best Fit', ...
           'Case 1: Centered Load F1 Best Fit', 'Case 2: Off Centered Load F1 Best Fit', 'Case 3: Symmetric Load F1 Best Fit', ...
           'Case 1: Centered Load F2 Best Fit', 'Case 2: Off Centered Load F2 Best Fit', 'Case 3: Symmetric Load F2 Best Fit', ...
           'Case 1: Centered Load F3D Best Fit', 'Case 2: Off Centered Load F3D Best Fit', 'Case 3: Symmetric Load F3D Best Fit');
    hold off;

    %{

    figure(101);
    hold on;
    plot(-1*centerLVDT)
    plot(-1*offCenterLVDT)
    xticks(1:10:length(centerLoad));
    xticklabels(centerLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Deflection (in)');
    title('Linear Displacement (LVDT) vs Loading Force (Time Visualization Case 1 and 2)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load');
    hold off;


    figure(201)
    hold on;
    plot(centerF0);
    plot(offCenterF0);
    xticks(1:10:length(centerLoad));
    xticklabels(centerLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    title('F0 vs Loading Force (Time Visualization Case 1 and 2)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load');
    hold off;

    figure(301)
    hold on;
    plot(centerF1);
    plot(offCenterF1);
    xticks(1:10:length(centerLoad));
    xticklabels(centerLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    title('F1 vs Loading Force (Time Visualization Case 1 and 2)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load');
    hold off;

    
    figure(401)
    hold on;
    plot(centerF2);
    plot(offCenterF2);
    xticks(1:10:length(centerLoad));
    xticklabels(centerLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    title('F2 vs Loading Force (Time Visualization Case 1 and 2)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load');
    hold off; 

    figure(501)
    hold on;
    plot(centerF3D);
    plot(offCenterF3D);
    xticks(1:10:length(centerLoad));
    xticklabels(centerLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    title('F3D vs Loading Force (Time Visualization Case 1 and 2)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load');
    hold off;

    figure(601);
    hold on;
    title('All Measured Forces vs Loading Force (Time Visualization)');
    plot(centerF0, 'o-');
    plot(offCenterF0, 's-');
    plot(centerF1, 'r-');
    plot(offCenterF1, 'g-');
    plot(centerF2, 'm-');
    plot(offCenterF2, 'c-');
    plot(centerF3D, 'y-');
    plot(offCenterF3D, 'd--');
    xticks(1:10:length(centerLoad));
    xticklabels(centerLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load F0', 'Case 2: Off Centered Load F0', ...
           'Case 1: Centered Load F1', 'Case 2: Off Centered Load F1',  ...
           'Case 1: Centered Load F2', 'Case 2: Off Centered Load F2', ...
           'Case 1: Centered Load F3D', 'Case 2: Off Centered Load F3D');
    hold off;

    figure(102);
    hold on;
    plot(-1*symmLVDT);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Deflection (in)');
    title('Linear Displacement (LVDT) vs Loading Force')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(202);
    hold on;
    plot(symmF0);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F0 (lbf)');
    title('F0 vs Loading Force')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(302);
    hold on;
    plot(symmF1);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F1 (lbf)');
    title('F1 vs Loading Force')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(402);
    hold on;
    plot(symmF2);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F2 (lbf)');
    title('F2 vs Loading Force')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(502);
    hold on;
    plot(symmF3D);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F3D (lbf)');
    title('F3D vs Loading Force')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(602);
    hold on;
    plot(symmF0);
    plot(symmF1);
    plot(symmF2);
    plot(symmF3D);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    title('Case 3 Forces vs Loading Force (Time Visualization)')
    legend('Case 3: 2 Symmetric Loads F0', 'Case 3: 2 Symmetric Loads F1', 'Case 3: 2 Symmetric Loads F2', 'Case 3: 2 Symmetric Loads F3D');
    hold off;

    %}

end

