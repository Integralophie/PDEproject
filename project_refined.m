function virus_model
% Define system parameters
beta = 1/8;            % Recover rate
gamma_no_ctrl = 0.1;           % Infection rate  
gamma_ctrl = 0.02;          %infection rate after people wearing masks

%can change wrt time, gets smaller because of people wearing masks
%adding in a new group of people: isolated, move out of population 
%rnot: how many people can one person infect, the recipical tells how much
%of the population has ro be infected to reach herd immunity
%immigration flow into the city
d = beta*0.1;               % death rate
lambda = 100           % Incoming population
lambda_infected = 0.01   %percentage of infected incoming population

% Define state variables: 
%  z1 = S, z2 = I, z3 = R, z4 = death, z5 = isolated 

% Initial state for no control
z1_0 = 10e4;  	
z2_0 = 1;    					
z3_0 = 0;
z4_0 = 0;


% put IC's into a single variable 
Z_0 = [z1_0, z2_0, z3_0,z4_0];

% Define simulation parameters
T_span = [0 200];  % time range for simulation with specified time step


options = odeset('Events', @event_stop);
[t, zout] = ode45(@virus_no_ctrl, T_span, Z_0);
[tctrl,zoutctrl] = ode45(@virus_ctrl,T_span,Z_0);
t(end)  %show end time

% Plots

figure  
plot(zout(:,1),'r');
hold on;
plot(zout(:,2),'b');
hold on;
plot(zout(:,3),'g');
hold on;
plot(zout(:,4).'.');
hold off;
legend('S','I','R','death');
title('Virus Outbreak without Control')
ylabel('number of population')
xlabel('t')

figure  
plot(zoutctrl(:,1),'r');
hold on;
plot(zoutctrl(:,2),'b');
hold on;
plot(zoutctrl(:,3),'g');
hold on;
plot(zoutctrl(:,4).'.');
hold off;
legend('S','I','R','death');
title('Virus Outbreak with Control')
ylabel('number of population')
xlabel('t')




% print time values
time_end = t(end)      				% simulation time when stopped by events


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function: equations of motion in first order form
function dzdt = virus_no_ctrl(T,Z)

dz1dt = lambda * (1-lambda_infected) - gamma_no_ctrl * Z(1) ; 
dz2dt = lambda_infected * lambda + gamma_no_ctrl *Z(1) - beta * Z(2) - d * Z(2);
dz3dt = beta * Z(2);
dz4dt = d*Z(2);
dzdt = [dz1dt;dz2dt;dz3dt;dz4dt];
%
end

function dzdt = virus_ctrl(T,Z)
dz1dt =  - gamma_ctrl * Z(1) ; 
dz2dt = gamma_ctrl *Z(1) - beta * Z(2) - d * Z(2);
dz3dt = beta * Z(2);
dz4dt = d*Z(2);
dzdt = [dz1dt;dz2dt;dz3dt;dz4dt]; 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end





