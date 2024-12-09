LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegQ IS
    PORT(
      clk, rst_b, c5, c1, a0, a1, c6: IN std_logic;
      input:  IN  std_logic_vector( 7 DOWNTO 0);
      output: OUT std_logic_vector( 7 DOWNTO 0);
      outbus: OUT std_logic_vector(16 DOWNTO 0)
    );
END RegQ;

ARCHITECTURE impl OF RegQ IS
    SIGNAL out_internal: std_logic_vector(7 DOWNTO 0);
BEGIN
    output <= out_internal;

    PROCESS(clk, rst_b, c1, c5)  
    BEGIN
        IF rst_b = '0' THEN
            out_internal <= (others => '0');
        ELSIF rising_edge(clk) THEN 
            IF c1 = '1' THEN
                out_internal <= input;
            ELSIF c5 = '1' THEN
                out_internal <= a1 & a0 & out_internal(7 DOWNTO 2);
            END IF;
        END IF;
    END PROCESS;
    
    PROCESS(c6)  
    BEGIN
        IF c6 = '1' THEN
            outbus(7 DOWNTO 0) <= out_internal; 
        ELSE
            outbus(7 DOWNTO 0) <= (others => '0'); 
        END IF;
    END PROCESS;
    
END impl;
