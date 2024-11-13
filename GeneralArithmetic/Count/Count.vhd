LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Count IS
    PORT(
        clk, rst_b, c0, c5: IN std_logic;
        output: OUT std_logic_vector(1 DOWNTO 0)
    );
END Count;

ARCHITECTURE impl OF Count IS
    SIGNAL count: unsigned(1 DOWNTO 0);
BEGIN
    PROCESS(clk, rst_b) 
    BEGIN
        IF rst_b = '0' THEN
            count <= "00";
        ELSIF rising_edge(clk) THEN
            IF c0 = '1' THEN
                count <= "00";
            ELSIF c5 = '1' THEN 
                count <= count + 1;
            END IF;
        END IF;
    END PROCESS;

    output <= std_logic_vector(count);

END impl;
