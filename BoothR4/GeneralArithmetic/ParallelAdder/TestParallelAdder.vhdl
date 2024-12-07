LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TestParallelAdder IS
END TestParallelAdder;

ARCHITECTURE tb OF TestParallelAdder IS
    COMPONENT ParallelAdder IS
        PORT(
            cin : IN std_logic; 
            a, b : IN std_logic_vector(8 downto 0);
            out_add : OUT std_logic_vector(8 downto 0) 
        );
    END COMPONENT;

    SIGNAL cin_s : std_logic;
    SIGNAL a_s, b_s : std_logic_vector(8 downto 0);
    SIGNAL out_add_s : std_logic_vector(8 downto 0);

BEGIN
    adder: ParallelAdder PORT MAP(
        cin => cin_s,
        a => a_s,
        b => b_s,
        out_add => out_add_s
    );

    proc: PROCESS
    BEGIN
        -- Test 1: a = "000000001", b = "000000010", cin = '0'
        a_s <= "000000001";
        b_s <= "000000010";
        cin_s <= '0';
        WAIT FOR 10 ns;

        -- Test 2: a = "111111111", b = "000000001", cin = '1'
        a_s <= "111111111";
        b_s <= "000000001";
        cin_s <= '1';
        WAIT FOR 10 ns;

        -- Test 3: a = "101010101", b = "010101010", cin = '0'
        a_s <= "101010101";
        b_s <= "010101010";
        cin_s <= '0';
        WAIT FOR 10 ns;

        -- Test 4: a = "000000000", b = "000000000", cin = '1'
        a_s <= "000000000";
        b_s <= "000000000";
        cin_s <= '1';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END tb;
