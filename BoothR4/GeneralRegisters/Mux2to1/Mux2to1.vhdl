LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Mux2to1 IS
	PORT(
        M, dM: IN std_logic_vector(8 DOWNTO 0);
        c3:    IN std_logic;
        output: OUT std_logic_vector(8 DOWNTO 0)
    );
END Mux2to1;

ARCHITECTURE impl OF Mux2to1 IS
BEGIN
    PROCESS(M, dM, c3)
    BEGIN
        IF c3 = '0' THEN 
            output <= M;
        ELSE 
            output <= dM;
        END IF;
    END PROCESS;
END;
