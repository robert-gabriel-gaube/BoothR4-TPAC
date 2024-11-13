ENTITY RegM IS
    PORT(
        clk, rst_b, c0: IN bit;
        input: IN bit_vector(7 DOWNTO 0);
        output: OUT bit_vector(7 DOWNTO 0)
    );
END RegM;

ARCHITECTURE impl OF RegM IS
BEGIN
    PROCESS(clk, rst_b) -- rising edge of clk and falling edge of rst_b
    BEGIN
        IF rst_b = '0' THEN
            output <= x"00";
        ELSIF clk = '1' and c0 = '1' THEN 
            output <= input;
        END IF;
    END PROCESS;
END;
