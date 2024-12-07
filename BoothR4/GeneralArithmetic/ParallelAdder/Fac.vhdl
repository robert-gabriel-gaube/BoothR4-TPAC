LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Fac IS
	PORT(
        a, b, cin: IN std_logic;
        output, cout: OUT std_logic
    );
END Fac;

ARCHITECTURE impl OF Fac IS
BEGIN
    PROCESS(a, b, cin)
    BEGIN
        output <= (a xor b) xor cin;
        cout <= (a and b) xor ((a xor b) and cin);
    END PROCESS;
END;
