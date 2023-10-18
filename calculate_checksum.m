function chksm=calculate_checksum(data)
    sum1=uint16(0);
    sum2=uint16(0);
    N=length(data);
    data=uint16(data);
    for i=1:N        
        sum1=mod((sum1+data(i)),255);
        sum2=mod((sum2+sum1),255);
    end
    chksm=uint16(sum1+sum2*256);
end