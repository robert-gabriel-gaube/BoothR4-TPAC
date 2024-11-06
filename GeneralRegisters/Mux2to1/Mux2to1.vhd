entity Mux2to1 is  
	port(
        M, dM: in bit_vector(8 downto 0);
        c3: in bit;
        result: out bit_vector(8 downto 0)
    );
end Mux2to1;

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
