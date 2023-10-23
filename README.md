# UDP-for-MATLAB
Example codes for using UDP communication in MATLAB

# Using `typecast`
- [`typecast(X, type)`](https://www.mathworks.com/help/matlab/ref/typecast.html) converts the bit patterns of `X` to the data type specified by `type` without changing the underlying data
- When you use `typecast()` to convert `int16` values to `uint8`, the negative values will be stored as _two's complement_
- When you cast the `uint8` values back to `int16`, MATLAB will correctly interpret the _two's complement_ representation and return the original negative values

For example
```matlab
x1 = int16([40, -25, 50])
x2 = typecast(x1, 'uint8')
x3 = typecast(x2, 'int16')
```

> Output
> ``` matlab
> x1 =
>     1x3 int16 row vector
>      40    -25    50
> x2 =
>     1x6 uint8 row vector
>      40     0     231     255      50      0
> x3 =
>     1x3 int16 row vector
>      40    -25    50

Notice that when you convert `int16` to `uint8` with `typecast()`, the size of the vector becomes doubled

# Converting `float` to `int`
- An easy way to convert from `float` to `int` values is to scale the values (multiply) by 10,  100, 1000, etc.
- When multiplying by the scaling factor, be cautious about the minimum-maximum range of that data type.
- For example `int16` ranges from [-32768, +32767], so the scaling factor shouldn't be 10,000 or above
- When you want to convert `int` back to `float`, divide the values by that scaling factor
  
Example:
```matlab
txData = [40.01, -25.20, 50.84]
txData_scaled = txData .* 100

x1 = int16(txData_scaled);
x2 = typecast(x1, 'uint8');
x3 = typecast(x2, 'int16');

rxData = double(x3) ./ 100
```
> Output
> ``` matlab
> txData =
>    40.0100  -25.2000   50.8400
> txData_scaled =
>       4001     -2520      5084
> rxData =
>    40.0100  -25.2000   50.8400



# Code Explain
Step 1: Check the ip-address of the wifi with `ipconfig` (Windows) or `ifconfig` (Linux)
> Window Terminal
> ```
> ipconfig
> ```
![image](https://github.com/komxun/UDP-for-MATLAB/assets/133139057/12cc798c-a440-4070-829d-65b1ff731a9c)

What does this mean?
- IPv4 Address : `172.20.10.4` is the ip-address of this computer associated with this Wi-Fi network
- The `subnet mask` and `default gateway` indicate that this network uses the `172.20.10.0/28` subnet
- This includes IP address `172.20.10.1` to `172.20.10.14`
- `172.20.10.0` and `172.20.10.15` are typically reserved

## Choosing `broadcast_address`

Now, we know that the wifi is in the domain of 172.20.10.xxx

- Use `172.20.10.255` if you want to reach ALL devices within the subnet
- Use `172.20.10.xxx` if you want to target a SPECIFIC device on the network, for example, `172.20.10.10`

https://github.com/komxun/UDP-for-MATLAB/blob/23cfb2fd73cd5e383591df0c2ab954609f0e2817/main_sender.m#L5-L7

https://github.com/komxun/UDP-for-MATLAB/blob/23cfb2fd73cd5e383591df0c2ab954609f0e2817/send_command.m#L30-L34

## Choosing `objects.ip_address`
- `objects.ip_address` in the sender code and receiver code MUST match






# Example 2


