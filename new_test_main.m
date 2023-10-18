clc, clear, close all

%Figure handlers
h=figure(1);
h.WindowState='maximized';
pause(1);

% Open UDP port
port_in = 51001;
coms = udpport("datagram", "IPV4", "LocalPort", port_in);

objects.ip_address = ["127.0.0.0"];

objects.names = "Computer A";
objects.n_max=size(objects.names,1);

% Initialize message structure
uav_base.xyz = zeros(1,3);
uav_base.xyz_vel = zeros(1,3);
uav_bas.xyz_acc = zeros(1,3);
% uav_base.receiver = zeros(1,8);

uav(1:objects.n_max) = uav_base;

%% Prepare graphs

%Initialize Vectors
N = 200;
XYZ = zeros(N,3);
XYZ_VEL = zeros(N,3);
time = zeros(N,1);

subplot(6,1,1:4)
%Prepare 3D Figure
h3d = plot3(uav(1).xyz(:,1),uav(1).xyz(:,2),uav(1).xyz(:,3));
grid on, hold on
set(h3d,'Marker','.','MarkerSize',25,'LineStyle','none')
% axis([0,15,0,20,0,4])
axis equal
xlim([0 200])
ylim([-100, 100])
zlim([0, 100])

subplot(6,1,5)
h1 = plot(time,XYZ);
title('XYZ');
xlabel('Time (s)');
ylabel('Signals (Pulse Width)');
% ylim([-20,20]);

subplot(6,1,6)
h2 = plot(time,XYZ_VEL);
title('XVZ-VEL');
xlabel('Time (s)');
ylabel('Velocity (m)');
% ylim([-100,100]);
% axis([0,10,-180,180]);

%% Main Loop
%Set figure handler
set(h,'KeyPressFcn',@detect_keypress);

%Start timer
t_ini=tic;
tic
period=1/60;
target=1;
run = 1;

trajSaver = [0 0 0];
while run == 1
    %Run loop at desired period
    if(toc>period)
        %Restart timer
        tic;
        
        %Get current time since start of program
        t = toc(t_ini);
        time = [time(2:end);t];
        
        %Read
        read_data();
        
        %Process Keyboard
        process_keyboard();
        
        %Plot 3D      
        set(h3d,'XData',uav(target).xyz(:,1),...
        'YData',uav(target).xyz(:,2)',...
        'ZData',uav(target).xyz(:,3));
        subplot(6,1,1:4)
        plot3(trajSaver(:,1), trajSaver(:,2), trajSaver(:,3), 'k-', 'LineWidth', 1.2);
        
        %Plot 2D
        for i=1:3    
            set(h1(i),'XData',time,'YData',XYZ(:,i), 'LineWidth', 1.2);
        end
        
        for i=1:3    
            set(h2(i),'XData',time,'YData',XYZ_VEL(:,i), 'LineWidth', 1.2);
        end
        
        %Refresh graph

        drawnow;
        trajSaver = [trajSaver; uav(target).xyz];
%         hold off

    end
end
close all

%Function to detect keyboard presses
function detect_keypress(src,event)
global key_pressed key
   key_pressed=1;
   key=event.Key;
%    disp(key)
end
