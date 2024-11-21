LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test IS
END test;

ARCHITECTURE t OF test IS	
	COMPONENT Mux2to1 IS
		PORT(
			M, dM: IN std_logic_vector(8 DOWNTO 0);
			c3: IN std_logic;
			result: OUT std_logic_vector(8 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL c3_s: std_logic := '0'; 	  
	SIGNAL M_s, dM_s, result_s: std_logic_vector(8 DOWNTO 0);

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
