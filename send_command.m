function send_command(command,coms)
    %Initialise bytes array    
    bytes=[];

    %Append header
    msg = uint8(command.header);
    bytes = [bytes,msg];
    
    % %Append msg id
    % msg = command.msg_id;
    % bytes = [bytes,msg,msg,msg];
    % 
    % %Append msg type
    % msg = command.msg_type;
    % bytes = [bytes,msg];
    
    %Append array
    msg = typecast(command.array','uint8');
    bytes = [bytes,msg'];
    
    % %Calculate and append checksum
    % chksm = calculate_checksum(bytes(8:end));  
    % msg = typecast(chksm,'uint8');
    % bytes = [bytes,msg,msg];
    
    %Append terminator
    msg = uint8(command.terminator);
    bytes = [bytes,msg];
    
    %Send bytes
%     broadcast_address="192.168.0.255";
    broadcast_address = "127.0.0.255";
    port_out = 51001;
    write(coms,bytes,'uint8',broadcast_address,port_out)
end