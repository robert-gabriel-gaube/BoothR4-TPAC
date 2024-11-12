ENTITY RegM IS
    PORT(
        clk, rst_b, c0: in bit;
        input: in bit_vector(7 downto 0);
        output: out bit_vector(7 downto 0)
    );
END RegM;

ARCHITECTURE impl OF RegM IS
BEGIN
    PROCESS(clk, rst_b)
    BEGIN
        IF rst_b = '0' THEN
            output <= x"00";
        ELSE 
            IF clk = '1' THEN
                IF c0 = '1' THEN
                    output <= input;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END;