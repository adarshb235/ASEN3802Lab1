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

[R_squared, normR] = graph(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLoad, symmLVDT, symmF0, symmF1, symmF2, symmF3D);

[v_model_case2, predicted_a_case2] = case2Estimate(offCenterLoad, offCenterLVDT, offCenterF2, offCenterF3D); % 

[v_model_case3, predicted_a_case3] = case3estimate(symmLoad, symmF3D, symmLVDT); % m

predictions.case2A = predicted_a_case2; % sort into struct
predictions.case3A = predicted_a_case3;


P = struct2table(predictions);
writetable(P, "Predictions.csv");

%auxiliaryGraphs(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLoad, symmLVDT, symmF0, symmF1, symmF2, symmF3D)
%saveFigures();

[matlabPred] = part3Model(centerLoad, centerLVDT);

function [R_squared_values, normR_values] = graph(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLoad, symmLVDT, symmF0, symmF1, symmF2, symmF3D)
    
    maxIndexCenters = 1; % sort indices to find index of max 
    temp1 = 0;
    for x = 1:length(centerLoad)
        if temp1<centerLoad(x)
            temp1 = centerLoad(x);
            maxIndexCenters = x; % Store the index of the maximum center load
        end
    end
    maxIndexCenters = maxIndexCenters + 9; % adjust to include additional 9 points on max load

    maxIndexSymm = 1; % sort to find index of max value
    temp2 = 0;
    for x = 1:length(symmLoad)
        if temp2<symmLoad(x)
            temp2 = symmLoad(x);
            maxIndexSymm = x; % Store the index of the maximum center load
        end
    end
    maxIndexSymm = maxIndexSymm + 9; % adjust to include additional 9 points on max load

    [fitCenterLDVTcoeff, fitCenterLDVTstruct] = polyfit(centerLoad(1:maxIndexCenters), centerLVDT(1:maxIndexCenters), 1); % all of the best fit lines and calcs for each force and LVDT
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

    R_squared_values.CenterLDVT = fitCenterLDVTstruct.rsquared; % sort R squared into struct
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

    normR_values.CenterLDVT = fitCenterLDVTstruct.normr; % sort norm of the residuals into a struct 
    normR_values.CenterF0 = fitCenterF0struct.normr;
    normR_values.CenterF1 = fitCenterF1struct.normr;
    normR_values.CenterF2 = fitCenterF2struct.normr;
    normR_values.CenterF3D = fitCenterF3Dstruct.normr;
    normR_values.OffCenterLDVT = fitOffCenterLVDTstruct.normr;
    normR_values.OffCenterF0 = fitOffCenterF0struct.normr;
    normR_values.OffCenterF1 = fitOffCenterF1struct.normr;
    normR_values.OffCenterF2 = fitOffCenterF2struct.normr;
    normR_values.OffCenterF3D = fitOffCenterF3Dstruct.normr;
    normR_values.SymmLDVT = fitSymmLVDTstruct.normr;
    normR_values.SymmF0 = fitSymmF0struct.normr;
    normR_values.SymmF1 = fitSymmF1struct.normr;
    normR_values.SymmF2 = fitSymmF2struct.normr;
    normR_values.SymmF3D = fitSymmF3Dstruct.normr;
    
    figure(100); % plots 
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
    legend('Case 1: Centered Load', 'Case 1 Best Fit', 'Case 2: Off Centered Load', 'Case 2 Best Fit', 'Case 3: 2 Symmetric Loads', 'Case 3 Best Fit');
    hold off;
        
    figure(103)
    hold on;
    title('Linear Displacements (LDVT) vs Loading Force')
    plot(centerLoad, centerLVDT, 'ro');
    plot(centerLoad(1:maxIndexCenters), fitCenterLVDT(1:maxIndexCenters), 'r')
    xlabel('Loading Force (lbf)')
    ylabel('Deflection (in)')
    legend('Case 1: Centered Load', 'Case 1 Best Fit')
    hold off;


    figure(104)
    hold on;
    title('Linear Displacements (LDVT) vs Loading Force')
    plot(offCenterLoad, offCenterLVDT, 'cdiamond');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterLVDT(1:maxIndexCenters), 'c');
    xlabel('Loading Force (lbf)')
    ylabel('Deflection (in)')
    legend('Case 2: Off Centered Load', 'Case 2 Best Fit')
    hold off;

    figure(105)
    hold on;
    title('Linear Displacements (LDVT) vs Loading Force')
    plot(symmLoad, symmLVDT, 'ysquare');
    plot(symmLoad(1:maxIndexSymm), fitSymmLVDT(1:maxIndexSymm), 'y');
    xlabel('Loading Force (lbf)')
    ylabel('Deflection (in)')
    legend('Case 3: 2 Symmetric Loads', 'Case 3 Best Fit')
    hold off;

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
    hold off;

    figure(203)
    hold on;
    title('F0 Force vs Loading Force')
    plot(centerLoad, centerF0, 'ro');
    plot(centerLoad(1:maxIndexCenters), fitCenterF0(1:maxIndexCenters), 'r')
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 1: Centered Load', 'Case 1 Best Fit')
    hold off;

    figure(204)
    hold on;
    title('F0 Force vs Loading Force')
    plot(offCenterLoad, offCenterF0, 'cdiamond');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF0(1:maxIndexCenters), 'c');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 2: Off Centered Load', 'Case 2 Best Fit')
    hold off;

    figure(205)
    hold on;
    title('F0 Force vs Loading Force')
    plot(symmLoad, symmF0, 'ysquare');
    plot(symmLoad(1:maxIndexSymm), fitSymmF0(1:maxIndexSymm), 'y');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 3: 2 Symmetric Loads', 'Case 3 Best Fit')
    hold off;

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
    hold off;

    figure(303)
    hold on;
    title('F1 Force vs Loading Force')
    plot(centerLoad, centerF1, 'ro');
    plot(centerLoad(1:maxIndexCenters), fitCenterF1(1:maxIndexCenters), 'r')
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 1: Centered Load', 'Case 1 Best Fit')
    hold off;

    figure(304)
    hold on;
    title('F1 Force vs Loading Force')
    plot(offCenterLoad, offCenterF1, 'cdiamond');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF1(1:maxIndexCenters), 'c');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 2: Off Centered Load', 'Case 2 Best Fit')
    hold off;

    figure(305)
    hold on;
    title('F1 Force vs Loading Force')
    plot(symmLoad, symmF1, 'ysquare');
    plot(symmLoad(1:maxIndexSymm), fitSymmF1(1:maxIndexSymm), 'y');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 3: 2 Symmetric Loads', 'Case 3 Best Fit')
    hold off;

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
    hold off;

    figure(403)
    hold on;
    title('F2 Force vs Loading Force')
    plot(centerLoad, centerF2, 'ro');
    plot(centerLoad(1:maxIndexCenters), fitCenterF2(1:maxIndexCenters), 'r')
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 1: Centered Load', 'Case 1 Best Fit')
    hold off;

    figure(404)
    hold on;
    title('F2 Force vs Loading Force')
    plot(offCenterLoad, offCenterF2, 'cdiamond');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF2(1:maxIndexCenters), 'c');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 2: Off Centered Load', 'Case 2 Best Fit')
    hold off;

    figure(405)
    hold on;
    title('F2 Force vs Loading Force')
    plot(symmLoad, symmF2, 'ysquare');
    plot(symmLoad(1:maxIndexSymm), fitSymmF2(1:maxIndexSymm), 'y');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 3: 2 Symmetric Loads', 'Case 3 Best Fit')
    hold off;

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
    hold off;

    figure(503)
    hold on;
    title('F3D Force vs Loading Force')
    plot(centerLoad, centerF3D, 'ro');
    plot(centerLoad(1:maxIndexCenters), fitCenterF3D(1:maxIndexCenters), 'r')
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 1: Centered Load', 'Case 1 Best Fit')
    hold off;

    figure(504)
    hold on;
    title('F3D Force vs Loading Force')
    plot(offCenterLoad, offCenterF3D, 'cdiamond');
    plot(offCenterLoad(1:maxIndexCenters), fitOffCenterF3D(1:maxIndexCenters), 'c');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 2: Off Centered Load', 'Case 2 Best Fit')
    hold off;

    figure(505)
    hold on;
    title('F3D Force vs Loading Force')
    plot(symmLoad, symmF3D, 'ysquare');
    plot(symmLoad(1:maxIndexSymm), fitSymmF3D(1:maxIndexSymm), 'y');
    xlabel('Loading Force (lbf)')
    ylabel('Force (lbf)')
    legend('Case 3: 2 Symmetric Loads', 'Case 3 Best Fit')
    hold off;

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
    
    R = struct2table(R_squared_values);
    N = struct2table(normR_values);

    writetable(R, "R_Squared.csv");
    writetable(N, "NormR.csv");

end

function [v_model, predicted_a] = case2Estimate(offCenterLoad, offCenterLVDT, offCenterF2, offCenterF3D)

    L = 157.48; % in
    E = 10^7; % psi
    I = 5.9457; % in^4
    x = L/2;

    maxIndexCenters = 1; % sort indices to find index of max 
    temp1 = 0;
    for d = 11:length(offCenterLoad) % 11 chosen to throw out 0 values and avoid division by 0
        if temp1<offCenterLoad(d)
            temp1 = offCenterLoad(d);
            maxIndexCenters = d; % Store the index of the maximum center load
        end
    end
    maxIndexCenters = maxIndexCenters + 9;

    a = zeros(maxIndexCenters, 1); % calculate a for each index
    for i = 11:(length(a) + 10)
        a(i - 10) = L .* offCenterF2(i) ./ offCenterLoad(i);
    end 

    predicted_a = sum(a)./length(a); % average a value
    predicted_a = predicted_a ./ 39.37; % convert to m
    predicted_a = (round(predicted_a * 4)/4); % round to consider that it may only be on the joints
    
    pred_a = predicted_a .* 39.37; % convert back to in for consistency
    B = L - pred_a;
    if (pred_a < L/2)
        v_model = (offCenterLoad(11:maxIndexCenters) .* pred_a .* (L- x)) ./ (6 * E * I * L) .* (2 .* L .* x - x^2 - pred_a^2);
    elseif (pred_a > L/2)
        v_model = offCenterLoad(11:maxIndexCenters) .* pred_a  ./ (48 * E * I) .* (4 * pred_a.^2 - 3 * L.^2);
    end
    
    blank = zeros(10, 1); % model 0 deflection for 0 lbf loading then add
    v_model = [blank; v_model];
    v_exp = offCenterLVDT((1:length(v_model)));
    
    figure(700); % plot
    hold on;
    plot(offCenterLoad(1:length(v_model)), v_model);
    plot(offCenterLoad(1:length(v_model)), v_exp);
    ylabel("Deflection (in)");
    xlabel("Loading Force (lbf)");
    title("Case 2: Deflection vs Loading Force");
    legend("Modeled Deflection", "Experimental Deflection")
    hold off;

    A = pi * ((3/16)^2 - (1/8)^2);
    M = offCenterLoad(1:length(v_model)) .* pred_a ./ 2;
    f3d_model = A .* M .* 4.9212598 ./ I;
    f3d_exp = offCenterF3D(1:length(v_model));

    figure(800)
    hold on;
    plot(offCenterLoad(1:length(v_model)), f3d_model);
    plot(offCenterLoad(1:length(v_model)), f3d_exp - f3d_exp(1));
    ylabel("Force (lbf)");
    xlabel("Loading Force (lbf)");
    title("Case 2: Internal Force @ Midspan vs Loading Force");
    legend("Modeled Force", "Experimental Force")    
    hold off;



end

function [v_model, predicted_a] = case3estimate(symmLoad, symmF3D, symmLVDT)
    
    L = 157.48; % in
    E = 10^7; % psi
    I = 5.9457; % in^4
    x = L/2; % in
    v = symmLVDT;

    maxIndexSymm = 1; % sort indices to find index of max 
    temp2 = 0;
    for c = 1:length(symmLoad) % 
        if temp2<symmLoad(c)
            temp2 = symmLoad(c);
            maxIndexSymm = c; % Store the index of the maximum center load
        end
    end
    maxIndexSymm = maxIndexSymm + 9;
    
    a_find = zeros(maxIndexSymm - 10, 1);
    for i = 11:(length(a_find) + 10) % select 11 to throw out 0 values (consistency)
        f = @(a) (symmLoad(i) .* a .* (3 .* L .*x - 3 .* x .^2 - a .^ 2) ./ (12 * E * I)) - v(i);
        a_start = 0;
        a_find(i - 10) = fzero(f, a_start);
    end

    pre_round_predicted_a = sum(a_find)./length(a_find); % get average
    pre_round_predicted_a = pre_round_predicted_a ./ 39.37; % convert to m
    predicted_a = (round(pre_round_predicted_a * 4)/4);

    rounded_a = predicted_a .* 39.37; 
    
    v_model = zeros(maxIndexSymm - 10, 1);
    for i = 11:(length(v_model) + 10) % select 11 to throw out 0 values (consistency)
        f = @(v) (symmLoad(i) .* rounded_a .* (3 .* L .*x - 3 .* x .^2 - rounded_a .^ 2) ./ (12 * E * I)) - v;
        v_start = 0;
        v_model(i - 10) = fzero(f, v_start);
    end


    blank = zeros(10, 1); % model 0 deflection for 0 lbf loading then add
    v_model = [blank; v_model];
    v_exp = symmLVDT(1:length(v_model)); % in


    figure(701);
    hold on;
    plot(symmLoad(1:length(v_model)), v_model);
    plot(symmLoad(1:length(v_model)), v_exp);
    ylabel("Deflection (in)");
    xlabel("Loading Force (lbf)");
    title("Case 3: Deflection vs Loading Force");
    legend("Modeled Deflection", "Experimental Deflection")
    hold off;

    A = pi * ((3/16)^2 - (1/8)^2);
    M = (symmLoad(1:length(v_model)) ./ 2) .* rounded_a;
    f3d_model = A .* M .* 4.9212598 ./ I;
    f3d_exp = symmF3D(1:length(v_model));


    figure(801)
    hold on;
    plot(symmLoad(1:length(v_model)), f3d_model);
    plot(symmLoad(1:length(v_model)), f3d_exp - f3d_exp(1));
    ylabel("Force (lbf)");
    xlabel("Loading Force (lbf)");
    title("Case 3: Internal Force @ Midspan vs Loading Force");
    legend("Modeled Force", "Experimental Force")    
    hold off;
    

end


function [] = auxiliaryGraphs(centerLoad, centerLVDT, centerF0, centerF1, centerF2, centerF3D, offCenterLoad, offCenterLVDT, offCenterF0, offCenterF1, offCenterF2, offCenterF3D, symmLoad, symmLVDT, symmF0, symmF1, symmF2, symmF3D)

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
    title('Linear Displacement (LVDT) vs Loading Force (Time Visualization)')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(202);
    hold on;
    plot(symmF0);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F0 (lbf)');
    title('F0 vs Loading Force (Time Visualization)')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(302);
    hold on;
    plot(symmF1);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F1 (lbf)');
    title('F1 vs Loading Force (Time Visualization)')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(402);
    hold on;
    plot(symmF2);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F2 (lbf)');
    title('F2 vs Loading Force (Time Visualization)')
    legend('Case 3: 2 Symmetric Loads');
    hold off;

    figure(502);
    hold on;
    plot(symmF3D);
    xticks(1:10:length(symmLoad));
    xticklabels(symmLoad(1:10:end));
    xlabel('Loading Force (lbf)');
    ylabel('F3D (lbf)');
    title('F3D vs Loading Force (Time Visualization)')
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

end

function saveFigures()
    % Get a list of all open figure handles
    figHandles = findall(0, 'Type', 'figure');

    % Loop through each figure and save it
    for i = 1:length(figHandles)
        figure(figHandles(i)); % Make the current figure active
        filename_pdf = sprintf('figure_%d.pdf', i); % Define filename for PDF

        % Save as PDF
        exportgraphics(gcf, filename_pdf);
    end
end

function [matlabPred] = part3Model(centerLoad, centerLVDT)

    % using metric for this to match ANSYS work

    P = 222.4;
    L = 4;
    M = P * L / 4;
    E = 69 * 10^9;
    I = 5.9457 * 4.16231426 * 10^-7;
    sig = M .* 0.125 ./ I;
    A = 0.00064516 * pi * ((3/16)^2 - (1/8)^2);
    F_3D = sig * A;

    v = P * L.^3 ./ (48 * E * I);

    matlabPred = struct();
    matlabPred.deflection = v;
    matlabPred.internalFroce = F_3D;


end
