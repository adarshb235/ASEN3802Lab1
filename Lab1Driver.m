clear;
clc;
close all;

centerData = readmatrix("Case 1 - load in center"); % read in data for centered load
offCenterData = readmatrix("Case_b1.txt"); % read in data for off centered load at unknown location
symmData = readmatrix("Case_l1"); % read in data for 2 symmetrical loads

centerLoad = centerData(:,1); % sort each column for centered data
centerLVDT = centerData(:,2);
centerF0 = centerData(:,3);
centerF1 = centerData(:,4);
centerF2 = centerData(:,5);
centerF3D = centerData(:,6);

offCenterLoad = offCenterData(:,1); % sort each column for unknown loc data
offCenterLVDT = offCenterData(:,2);
offCenterF0 = offCenterData(:,3);
offCenterF1 = offCenterData(:,4);
offCenterF2 = offCenterData(:,5);
offCenterF3D = offCenterData(:,6);

symmLoad = symmData(:,1); % sort each column for symmetric loading data
symmLVDT = symmData(:,2);
symmF0 = symmData(:,3);
symmF1 = symmData(:,4);
symmF2 = symmData(:,5);
symmF3D = symmData(:,6);

graph(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLVDT, symmF0, symmF1, symmF2, symmF3D)


function [] = graph(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLoad, symmLVDT, symmF0, symmF1, symmF2, symmF3D)

    
    figure;
    hold on;
    title("Linear Displacements (LDVT) vs Loading")
    plot(centerLoad, centerLVDT);
    plot(offCenterLoad, offCenterLVDT);
    plot(symmLoad, symmLVDT);
    xlabel('Loading Force (lbf)')
    ylabel('Deflection (in)')
    legend('Case 1: Centered Load', 'Case 2: Off Centered Load', 'Case 3: 2 Symmetric Loads')

end

