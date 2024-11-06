entity test is	
end test;

architecture t of test is	
	component Mux2to1 is  
		port(
            M, dM: in bit_vector(8 downto 0);
            c3: in bit;
            result: out bit_vector(8 downto 0)
        );
	end component;
	signal c3_s: bit := '0'; 	  
	signal M_s, dM_s, result_s: bit_vector(8 downto 0);

begin
    mux: Mux2to1 PORT MAP(M_s, dM_s, c3_s, result_s);
  
	M_s <= "111111111";
	dM_s <= "010101010";
	c3_s <= '0', '1' AFTER 200 ps;
	
end t;
