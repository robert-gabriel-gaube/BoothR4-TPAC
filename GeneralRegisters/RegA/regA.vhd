ENTITY RegA IS
    PORT(
      clk, rst_b, c0, c5, c2, c6: IN bit;
      adder_input: IN bit_vector(8 DOWNTO 0);
      output: OUT bit_vector(8 DOWNTO 0);
      outbus: OUT bit_vector(16 DOWNTO 0)
    );
END RegA;

ARCHITECTURE impl OF RegA IS
    SIGNAL out_internal: bit_vector(8 downto 0);  -- internal signal to hold out_result data
BEGIN
    -- Drive the output port
    output <= out_internal;

    PROCESS(clk, rst_b, c0, c5, c2, adder_input)  
    BEGIN
        IF rst_b = '0' THEN
            out_internal <= (others => '0');
        ELSIF clk'event and clk = '1' THEN  -- Detect rising edge
            IF c0 = '1' THEN
                out_internal <= (others => '0');
            ELSIF c2 = '1' THEN
                out_internal <= adder_input;
            ELSIF c5 = '1' THEN
                out_internal <= out_internal(8) & out_internal(8) & out_internal(8 DOWNTO 2);
            END IF;
        END IF;
    END PROCESS;
    
    PROCESS(c6)  -- Sensitivity list includes all signals read in the process
    BEGIN
        IF c6 = '1' THEN
            -- Convert out_internal (bit_vector) to std_logic_vector and assign 'Z'
            outbus(16 DOWNTO 8) <= out_internal; 
        ELSE
            outbus <= (others => '0');  -- Set all bits of outbus to high-impedance 'Z'
        END IF;
    END PROCESS;
    
END impl;