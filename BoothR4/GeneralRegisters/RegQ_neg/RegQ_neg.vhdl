LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegQ_neg IS
    PORT(
      clk, rst_b, c0, c5, q1: IN std_logic;
      output: OUT std_logic
    );
END RegQ_neg;

ARCHITECTURE impl OF RegQ_neg IS
    SIGNAL out_internal: std_logic;  -- internal signal to hold output data
BEGIN
    output <= out_internal;

    PROCESS(clk, rst_b, c0, c5)  
    BEGIN
        IF rst_b = '0' THEN
            out_internal <= '0';
        ELSIF clk'event and clk = '1' THEN  -- Detect rising edge
            IF c0 = '1' THEN
                out_internal <= '0';
            ELSIF c5 = '1' THEN
                out_internal <= q1;
            END IF;
        END IF;
    END PROCESS;
END impl;
