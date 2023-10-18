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



# Example 1

# Example 2
