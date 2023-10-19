clc, clear, close all
load("leader_trajectory.mat")

%Open udp port
port = 51002;
coms = udpport("datagram","IPV4","LocalPort",port);
broadcast_address = "127.0.0.255";

% ogData = [40, -25, 50.2, 12.3, 2 0]

% procData = ogData*10;
% procData2 = procData/10;
procTraj = lead_traj.*10;
for j = 1:length(lead_traj)
    
    %Add paths
    command.header = 'STR';
%     command.msg_id = uint8(2);
%     command.msg_type = uint8(0);

    command.array = int16([procTraj(:,j)' 0 0 0]);
%     command.array = int16(procData);

    command.terminator='END';
    send_command(command,coms);
    disp('Data sent!');

end



%Load objects list
objects.ip_address = ["127.0.0.0"];

objects.names = "Computer A";
objects.n_max = size(objects.names,1);