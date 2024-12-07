LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RegM IS
    PORT(
        clk, rst_b, c0: IN std_logic;
        input:  IN  std_logic_vector(7 DOWNTO 0);
        output: OUT std_logic_vector(7 DOWNTO 0)
    );
END RegM;

ARCHITECTURE impl OF RegM IS
BEGIN
    PROCESS(clk, rst_b)
    BEGIN
        IF rst_b = '0' THEN
            output <= x"00";
        ELSIF rising_edge(clk) and c0 = '1' THEN 
            output <= input;
        END IF;
    END PROCESS;
END;
