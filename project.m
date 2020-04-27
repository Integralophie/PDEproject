function projectile
% Define system parameters
beta = 1/8;            % Recover rate
gamma = 0.1;           % Infection rate


% Define state variables: 
%  z1 = S, z2 = I, z3 = R. 

% Initial state
z1_0 = 10e3;  	
z2_0 = 1;    					
z3_0 = 0;

% put IC's into a single variable 
Z_0 = [z1_0, z2_0, z3_0];

% Define simulation parameters
 T_span = [0 100];  % time range for simulation with specified time step


options = odeset('Events', @event_stop);
[t, zout] = ode45(@projectile_fun, T_span, Z_0, options);

t(end)  %show end time





% Plots

figure  % trajectory path in x-y space
plot(zout(:,1),'r');
hold on;
plot(zout(:,2),'b');
hold on;
plot(zout(:,3),'g');
hold off;
legend('S','I','R');
title('Trajectory in Space')
ylabel('number of population')
xlabel('t')




% print time values
time_end = t(end)      				% simulation time when stopped by events
horizontal_distance = zout(end,1) 	% horizontal distance (zout(1) = x, when stimulation stopped)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function: equations of motion in first order form
function dzdt = projectile_fun(T,Z)

dz1dt = -beta * Z(1); 
dz2dt = beta * Z(1) - gamma * Z(2);
dz3dt = gamma * Z(2);

%
dzdt = [dz1dt;dz2dt;dz3dt];
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [eventvalue,stopthecalc,eventdirection] = event_stop(T,Z)
     
 % stop when Z(3)= z3= y = 0 (mass hits the ground in y-dir)
        eventvalue      =  Z(3)-10e3;    %  �Events� are detected when eventvalue=0
        stopthecalc     =  1;       %  Stop if event occurs
        eventdirection  = -1;       %  Detect only events with dydt<0
end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end





