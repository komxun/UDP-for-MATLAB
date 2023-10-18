function uav = process_uav_datagram(datagram,uav,focus)
    %Check if standard message
    datagram.Data
    n = length(datagram.Data);
    if n>10 && all(datagram.Data(1:3)=='STR')
        disp("header is STR!")
        %Index
        ind = 4;
        
        %Make data uint8
        datagram.Data = uint8(datagram.Data);
        
        %Cast all data as integers
%         len = (length(datagram.Data)-8)/2;
%         data = typecast(datagram.Data(ind : ind + len*2 - 1),'int16');
        data = typecast(datagram.Data(ind:end-3), 'int16');
%         data_double = typecast(uint8(datagram.Data(ind: end-3)), 'int16')
%         data = datagram.Data(ind: end-3);
%         data_double = double(data)
        
        %Scalers
        % scalers = ones(len,1);
        % scalers(1:6,1) = [100*ones(6,1)];
        % data_double(1:6) = data_double(1:6)./scalers(1:6)';
        % 
        data_double = double(data)./10;
        %Timestamp
        
        %Arrange
        [uav.xyz, data_double] = split_data(data_double,3);        
        [uav.xyz_vel, data_double] = split_data(data_double,3);
        % [uav.xyz_acc, data_double] = split_data(data_double,3);
        % [uav.quat, data_double] = split_data(data_double,4);
        % [uav.rpy, data_double] = split_data(data_double,3);
        % [uav.pqr, data_double] = split_data(data_double,3);
        % [uav.rpy_refs, data_double] = split_data(data_double,3);
        % [uav.rate_refs, data_double] = split_data(data_double,3);
        % [uav.LMNZ, data_double] = split_data(data_double,4);
        % [uav.receiver, data_double] = split_data(data_double,8);
        
    else        
        disp("Message(" + focus + "):" + char(datagram.Data(1:end-1)));
    end
end