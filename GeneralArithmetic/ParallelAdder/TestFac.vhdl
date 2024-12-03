LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test IS
END test;

ARCHITECTURE t OF test IS	
	COMPONENT Fac IS
		PORT(
			a, b, cin: IN std_logic;
			output, cout: OUT std_logic
		);
	END COMPONENT;
	SIGNAL a_s, b_s, cin_s, output_s, cout_s: std_logic;

BEGIN
    proc: Fac PORT MAP(a_s, b_s, cin_s, output_s, cout_s);
	  -- Testing the full adder cell
	  stim_proc: PROCESS
    BEGIN
        -- Test 1: a = 1, b = 0, cin = 0 => output = '1', cout = '0'
        a_s <= '1';
        b_s <= '0';
        cin_s <= '0';
        WAIT FOR 10 ns;

        -- Test 2: a = 1, b = 1, cin = 1 => output = '1', cout = '1'
        a_s <= '1';
        b_s <= '1';
        cin_s <= '1';
        WAIT FOR 10 ns;
        
        -- Test 3: a = 1, b = 1, cin = 0 => output = '0', cout = '1'
        a_s <= '1';
        b_s <= '1';
        cin_s <= '0';
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;
END t;
