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
    
    fitCenterLDVTcoeff = polyfit(centerLoad, centerLVDT, 1);
    fitCenterLVDT = polyval(fitCenterLDVTcoeff, centerLoad);
    fitCenterF0coeff = polyfit(centerLoad, centerF0, 1);
    fitCenterF0 = polyval(fitCenterF0coeff, centerLoad);
    fitCenterF1coeff = polyfit(centerLoad, centerF1, 1);
    fitCenterF1 = polyval(fitCenterF1coeff, centerLoad);
    fitCenterF2coeff = polyfit(centerLoad, centerF2, 1);
    fitCenterF2 = polyval(fitCenterF2coeff, centerLoad);
    fitCenterF3Dcoeff = polyfit(centerLoad, centerF3D, 1);
    fitCenterF3D = polyval(fitCenterF3Dcoeff, centerLoad);

    fitOffCenterLVDTcoeff = polyfit(offCenterLoad, offCenterLVDT, 1);
    fitOffCenterLVDT = polyval(fitOffCenterLVDTcoeff, offCenterLoad);
    fitOffCenterF0coeff = polyfit(offCenterLoad, offCenterF0, 1);
    fitOffCenterF0 = polyval(fitOffCenterF0coeff, offCenterLoad);
    fitOffCenterF1coeff = polyfit(offCenterLoad, offCenterF1, 1);
    fitOffCenterF1 = polyval(fitOffCenterF1coeff, offCenterLoad);
    fitOffCenterF2coeff = polyfit(offCenterLoad, offCenterF2, 1);
    fitOffCenterF2 = polyval(fitOffCenterF2coeff, offCenterLoad);
    fitOffCenterF3Dcoeff = polyfit(offCenterLoad, offCenterF3D, 1);
    fitOffCenterF3D = polyval(fitOffCenterF3Dcoeff, offCenterLoad);

    fitSymmLVDTcoeff = polyfit(symmLoad, symmLVDT, 1);
    fitSymmLVDT = polyval(fitSymmLVDTcoeff, symmLoad);
    fitSymmF0coeff = polyfit(symmLoad, symmF0, 1);
    fitSymmF0 = polyval(fitSymmF0coeff, symmLoad);
    fitSymmF1coeff = polyfit(symmLoad, symmF1, 1);
    fitSymmF1 = polyval(fitSymmF1coeff, symmLoad);
    fitSymmF2coeff = polyfit(symmLoad, symmF2, 1);
    fitSymmF2 = polyval(fitSymmF2coeff, symmLoad);
    fitSymmF3Dcoeff = polyfit(symmLoad, symmF3D, 1);
    fitSymmF3D = polyval(fitSymmF3Dcoeff, symmLoad);

    
    figure(100);
    hold on;
    title("Linear Displacements (LDVT) vs Loading Force")
    plot(centerLoad, centerLVDT, 'ro');
    plot(centerLoad, fitCenterLVDT, 'r')
    plot(offCenterLoad, offCenterLVDT, 'cdiamond');
    plot(offCenterLoad, fitOffCenterLVDT, 'c');
    plot(symmLoad, symmLVDT, 'ysquare');
    plot(symmLoad, fitSymmLVDT, 'y')
    xlabel('Loading Force (lbf)')
    ylabel('Deflection (in)')
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(200);
    hold on;
    title('F0 Force vs Loading Force')
    plot(centerLoad, centerF0, 'ro');
    plot(offCenterLoad, offCenterF0, 'cdiamond');
    plot(symmLoad, symmF0, 'ysquare');
    plot(centerLoad, fitCenterF0, 'r');
    plot(offCenterLoad, fitOffCenterF0, 'c');
    plot(symmLoad, fitSymmF0, 'y');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(300);
    hold on;
    title('F1 Force vs Loading Force');
    plot(centerLoad, centerF1, 'ro');
    plot(offCenterLoad, offCenterF1, 'cdiamond');
    plot(symmLoad, symmF1, 'ysquare');
    plot(centerLoad, fitCenterF1, 'r');
    plot(offCenterLoad, fitOffCenterF1, 'c');
    plot(symmLoad, fitSymmF1, 'y');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(400);
    hold on;
    title('F2 Force vs Loading Force')
    plot(centerLoad, centerF2, 'ro');
    plot(offCenterLoad, offCenterF2, 'cdiamond');
    plot(symmLoad, symmF2, 'ysquare');
    plot(centerLoad, fitCenterF2, 'r');
    plot(offCenterLoad, fitOffCenterF2, 'c');
    plot(symmLoad, fitSymmF2, 'y');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads', 'Case 1 Best Fit', 'Case 2 Best Fit', 'Case 3 Best Fit');

    figure(500);
    hold on;
    title('F3D Force vs Loading Force')
    plot(centerLoad, centerF3D, 'ro');
    plot(offCenterLoad, offCenterF3D, 'cdiamond');
    plot(symmLoad, symmF3D, 'ysquare');
    plot(centerLoad, fitCenterF3D, 'r');
    plot(offCenterLoad, fitOffCenterF3D, 'c');
    plot(symmLoad, fitSymmF3D, 'y');   
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
    plot(centerLoad, fitCenterF0, 'r');
    plot(offCenterLoad, fitOffCenterF0, 'c');
    plot(symmLoad, fitSymmF0, 'y');
    plot(centerLoad, fitCenterF1, '-.r');
    plot(offCenterLoad, fitOffCenterF1, '-.c');
    plot(symmLoad, fitSymmF1, '-.y');
    plot(centerLoad, fitCenterF2, '--r');
    plot(offCenterLoad, fitOffCenterF2, '--c');
    plot(symmLoad, fitSymmF2, '--y');
    plot(centerLoad, fitCenterF3D, ':r');
    plot(offCenterLoad, fitOffCenterF3D, ':c');
    plot(symmLoad, fitSymmF3D, ':y');
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
    hold on
    title('All Measured Forces vs Loading Force (Time Visualization)');
    plot(centerLoad, centerF0, 'o-', offCenterLoad, offCenterF0, 's-');
    plot(centerLoad, centerF1, 'r-', offCenterLoad, offCenterF1, 'g-');
    plot(centerLoad, centerF2, 'm-', offCenterLoad, offCenterF2, 'c-');
    plot(centerLoad, centerF3D, 'y-', offCenterLoad, offCenterF3D, 'd--');
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
    title('F3D vs Loading Force')
    legend('Case 3: 2 Symmetric Loads F0', 'Case 3: 2 Symmetric Loads F1', 'Case 3: 2 Symmetric Loads F2', 'Case 3: 2 Symmetric Loads F3D');
    hold off;

end

