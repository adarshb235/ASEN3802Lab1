function [Deflection, F_reaction, F_internal] = trussDeflection(length,load,x_load, case_num)
    
for i = 1:3

    E = 69.5 * 10^6 ; %% Pa
    I = 247.49; %% cm^4

    if case_num == 1
    x = linspace(1,length,100);

    deflection1 = zeros(length) ;

    defelction1(x) = load/(E * I) * ((x^3)/12 * (length^2*x)/16 ) ;

    end

    if case_num == 2
    x = linspace(1,length,100);

    deflection2 = zeros(length) ;

    defelction2(x) = ;

    end


end