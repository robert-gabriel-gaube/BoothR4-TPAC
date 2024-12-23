LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegA IS
    PORT(
      clk, rst_b, c0, c5, c2, c6: IN std_logic;
      adder_input: IN std_logic_vector(8 DOWNTO 0);
      output: OUT std_logic_vector( 8 DOWNTO 0);
      outbus: OUT std_logic_vector(16 DOWNTO 0)
    );
END RegA;

ARCHITECTURE impl OF RegA IS
    SIGNAL out_internal: std_logic_vector(8 DOWNTO 0);
BEGIN
    output <= out_internal;

    PROCESS(clk, rst_b, c0, c5, c2, adder_input)  
    BEGIN
        IF rst_b = '0' THEN
            out_internal <= (others => '0');
        ELSIF rising_edge(clk) THEN
            IF c0 = '1' THEN
                out_internal <= (others => '0');
            ELSIF c2 = '1' THEN
                out_internal <= adder_input;
            ELSIF c5 = '1' THEN
                out_internal <= out_internal(8) & out_internal(8) & out_internal(8 DOWNTO 2);
            END IF;
        END IF;
    END PROCESS;
    
    PROCESS(c6)  
    BEGIN
        IF c6 = '1' THEN
            outbus(16 DOWNTO 8) <= out_internal; 
        ELSE
            outbus(16 DOWNTO 8) <= (others => '0'); 
        END IF;
    END PROCESS;
    
END impl;
