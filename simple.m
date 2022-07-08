%% Исходные данные
clc, clear, close all
G = 398600.4418 * 1e9;   %Earth`s gravitation field const, m^3/sec^2
j20 = 1082625.75 * 1e-9;        %koefficient pri vtoroi zonalnoi garmoniki
ae = 6378136.0;    % ekvatorialnii radius zemli, m
w = 7.2921151467 * 1e-5;   %uglovaya skorost vrasheniya zemli
ae2 = ae^2;
w2 = w^2;
J20_G_ae2 = 1.5 * j20 * G * ae2; %3/2*J20*G*ae^2
step_size = 10;
dt = 12300 - 11700; % ti - tb
steps = round(dt/step_size);
% steps = 12300 - round(dt/86400)*86400;
xyz = [7003.008789e3, -12206.626953e3, 21280.765625e3 ];
v_xyz = [0.7835417e3, 2.8042530e3, 1.3525150e3];
a_xyz = [0,1.7e-9, -5.41e-9];
test_point = struct ('xyz', xyz, 'v_xyz', v_xyz, 'a_xyz', a_xyz);
Rteor = sqrt(test_point.xyz(1)*test_point.xyz(1)+test_point.xyz(2)*test_point.xyz(2)+test_point.xyz(3)*test_point.xyz(3));

for step = 0:1:(steps-1)
    test_point = struct(StepMove(test_point, step_size));
%     fprintf("\nStep = %d\n", step);
%     test_point.xyz
end
Rpract = sqrt(test_point.xyz(1)*test_point.xyz(1)+test_point.xyz(2)*test_point.xyz(2)+test_point.xyz(3)*test_point.xyz(3));
respoint = struct ('x',{7523.174853e3},'y',{-10506.962176e3}, 'z',{21999.239866e3}, ...
                    'vx',{0.95012609e3}, 'vy',{2.85568710e3},'vz',{1.04068137e3},'ax',{0},'ay',{0},'az',{0});resPoint = struct2array(respoint);
ResPoint.xyz = resPoint(1:3);ResPoint.v_xyz = resPoint(4:6);ResPoint.a_xyz = resPoint(7:9);

error = mmin(ResPoint,test_point);
Error = sqrt(error.xyz(1)*error.xyz(1)+error.xyz(2)*error.xyz(2)+error.xyz(3)*error.xyz(3));

fprintf('\nError r = %d',Error);disp(' meters');fprintf("\nerror x = %d\n",error.xyz(1));fprintf("\nerror y = %d\n",error.xyz(2));fprintf("\nerror z = %d\n",error.xyz(3));fprintf("\nerror vx = %d\n",error.v_xyz(1));fprintf("\nerror vy = %d\n",error.v_xyz(2));fprintf("\nerror vz = %d\n",error.v_xyz(3));fprintf("\nerror ax = %d\n",error.a_xyz(1));fprintf("\nerror ay = %d\n",error.a_xyz(2));fprintf("\nerror az = %d\n",error.a_xyz(3));
