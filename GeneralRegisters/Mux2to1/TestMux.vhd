ENTITY test IS
END test;

ARCHITECTURE t OF test IS	
	COMPONENT Mux2to1 IS
		PORT(
            M, dM: IN bit_vector(8 DOWNTO 0);
            c3: IN bit;
            result: OUT bit_vector(8 DOWNTO 0)
        );
	END COMPONENT;
	SIGNAL c3_s: bit := '0'; 	  
	SIGNAL M_s, dM_s, result_s: bit_vector(8 DOWNTO 0);

BEGIN
    mux: Mux2to1 PORT MAP(M_s, dM_s, c3_s, result_s);
	
	-- Testing plan:
	-- 		In the first 200ps the output should be 0x1FF 	 	because c3_s is 0 	(check)
	--		After the first 200ps the output should be 0x155	because c3_s is 1	(check)

	M_s  <= "111111111";
	dM_s <= "101010101";

	c3_s <=	'0', 
			'1' AFTER 200 ps;
	
END t;
