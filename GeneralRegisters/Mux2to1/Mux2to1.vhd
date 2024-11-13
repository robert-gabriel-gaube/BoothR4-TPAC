ENTITY Mux2to1 IS
	port(
        M, dM: IN bit_vector(8 DOWNTO 0);
        c3: IN bit;
        result: OUT bit_vector(8 DOWNTO 0)
    );
END Mux2to1;

ARCHITECTURE impl OF Mux2to1 IS
BEGIN
    PROCESS(M, dM, c3)
    BEGIN
        IF c3 = '0' THEN 
            result <= M;
        ELSE 
            result <= dM;
        END IF;
    END PROCESS;
END;
