global key_pressed key
if key_pressed==1
    key_pressed=0;
    %Password protection
    if enable_keys<3
        enable_keys=3;
    else
        for i=1:1
            switch(key)
                case 'a'
                    arm();
                    break;
                case 'escape'
                    disarm();
                    break;
                case '1'
                    target=1;
                    break;
                case '2'
                    target=2;
                    break;
                case '3'
                    target=3;
                    break;
                case '4'
                    target=4;
                    break;
                case '5'
                    target=5;
                    break;
                case '6'
                    target=6;
                    break;
                case '7'
                    target=7;
                    break;
                case '8'
                    target=8;
                    break;                    
                case '9'
                    target=9;
                    break;                
                case 'space'
                    run=0;
                    break;
                otherwise
                    enable_keys=0;                
                    disp("Keys disabled!");
                    break;
            end
        end
        
    end
end