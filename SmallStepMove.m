function [output1] = SmallStepMove(in,step)
    G = 398600.4418 * 1e9;   %Earth`s gravitation field const, m^3/sec^2
    step_size = 10;dt = 12300 - 11700;steps = round(dt/step_size);
    
    xyz = [7003.008789e3, -12206.626953e3, 21280.765625e3 ];
    v_xyz = [0.7835417e3, 2.8042530e3, 1.3525150e3];
    a_xyz = [0,1.7e-9, -5.41e-9];
    test_point = struct ('xyz', xyz, 'v_xyz', v_xyz, 'a_xyz', a_xyz);
    Rteor = sqrt(test_point.xyz(1)*test_point.xyz(1)+test_point.xyz(2)*test_point.xyz(2)+test_point.xyz(3)*test_point.xyz(3));
 
    R = sqrt(in.xyz(1)*in.xyz(1)+in.xyz(2)*in.xyz(2)+in.xyz(3)*in.xyz(3));
 
    j20 = 1082625.75 * 1e-9;        %koefficient pri vtoroi zonalnoi garmoniki
    ae = 6378136.0;    % ekvatorialnii radius zemli, m
    w = 7.2921151467 * 1e-5;   %uglovaya skorost vrasheniya zemli
    ae2 = ae^2;
    J20_G_ae2 = 1.5 * j20 * G * ae2; %3/2*J20*G*ae^2
    w2 = w^2;
    r  = R;
    r2 = r^2;
    r3 = r * r2;
    r5 = r2 * r3;
    mur3 = G / r3;
    jmar = J20_G_ae2 / r5;  %3/2*J20*G*ae^2/(length of r * r^4)
%     zr2 = (5.0 * I.(3)^2)/r2;
    zr2 = (5.0 * in.xyz(3)^2) / r2;     %5z^2-r^2
    
    out.x = step * in.v_xyz(1);
    out.y = step * in.v_xyz(2);
    out.z = step * in.v_xyz(3);
    out.vx = step * (-mur3 * in.xyz(1) - jmar * in.xyz(1) * (1 - zr2) + w2 * in.xyz(1) + 2 * w * in.v_xyz(2) + in.a_xyz(1));
    out.vy = step * (-mur3 * in.xyz(2) - jmar * in.xyz(2) * (1 - zr2) + w2 * in.xyz(2) - 2 * w * in.v_xyz(1) + in.a_xyz(2));
    out.vz = step * (-mur3 * in.xyz(3) - jmar * in.xyz(3) * (3 - zr2) + in.a_xyz(3));
    out.ax = 0;
    out.ay = 0;
    out.az = 0;
%         for i = 1:1:steps - 1
%         R = sqrt(out.x*out.x+out.y*out.y+out.z*out.z);
%         T.r(i) = R;
%         i = i+1;
%         output1 = T;
%         end
    output1 = out;
end

