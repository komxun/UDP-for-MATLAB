%Check if bytes available
n = coms.NumDatagramsAvailable;
if n>0
    %Limit max datagrams per sampling time
    n_max = 100;
    if n > n_max
        n = n_max;
    end
    disp(n)

    %Iterate through datagrams
    for i=1:n
        %Read Datagram
        datagram = read(coms,1,'uint8');
       
        %Check if vicon
        if datagram.SenderAddress == "192.168.0.218"
            disp("Hello vicon!");
        else
            %Check which UAV is sending the data
            
            for j=1:objects.n_max
                % if datagram.SenderAddress==objects.ip_address(j)
                    disp("Calling process_uav_datagram...")
                    uav(j) = process_uav_datagram(datagram,uav(j),j);
                    uav
                % end
            end
        end
    end
end  

%Move vectors
move_vectors();