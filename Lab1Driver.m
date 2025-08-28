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

    
    figure;
    hold on;
    title("Linear Displacements (LDVT) vs Loading Force")
    plot(centerLoad, centerLVDT);
    plot(offCenterLoad, offCenterLVDT);
    plot(symmLoad, symmLVDT);
    xlabel('Loading Force (lbf)')
    ylabel('Deflection (in)')
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads');

    figure(2);
    hold on;
    title('F0 Force vs Loading Force')
    plot(centerLoad, centerF0);
    plot(offCenterLoad, offCenterF0);
    plot(symmLoad, symmF0);
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads');

    figure(3);
    hold on;
    title('F1 Force vs Loading Force');
    plot(centerLoad, centerF1);
    plot(offCenterLoad, offCenterF1);
    plot(symmLoad, symmF1);
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads');

    figure(4);
    hold on;
    title('F2 Force vs Loading Force')
    plot(centerLoad, centerF2);
    plot(offCenterLoad, offCenterF2);
    plot(symmLoad, symmF2);
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads');

    figure(5);
    hold on;
    title('F3D Force vs Loading Force')
    plot(centerLoad, centerF3D);
    plot(offCenterLoad, offCenterF3D);
    plot(symmLoad, symmF3D);
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads');

    figure(6);
    hold on
    title('All Measured Forces vs Loading Force');
    plot(centerLoad, centerF0, 'o-', offCenterLoad, offCenterF0, 's-', symmLoad, symmF0, 'd-');
    plot(centerLoad, centerF1, 'r-', offCenterLoad, offCenterF1, 'g-', symmLoad, symmF1, 'p-');
    plot(centerLoad, centerF2, 'm-', offCenterLoad, offCenterF2, 'c-', symmLoad, symmF2, 'x-');
    plot(centerLoad, centerF3D, 'y-', offCenterLoad, offCenterF3D, 'd--', symmLoad, symmF3D, 'b--');
    xlabel('Loading Force (lbf)');
    ylabel('Force (lbf)');
    legend('Case 1: Centered Load F0', 'Case 2: Off Centered Load F0', 'Case 3: 2 Symmetric Loads F0', ...
           'Case 1: Centered Load F1', 'Case 2: Off Centered Load F1', 'Case 3: 2 Symmetric Loads F1', ...
           'Case 1: Centered Load F2', 'Case 2: Off Centered Load F2', 'Case 3: 2 Symmetric Loads F2', ...
           'Case 1: Centered Load F3D', 'Case 2: Off Centered Load F3D', 'Case 3: 2 Symmetric Loads F3D');
    hold off;

end

