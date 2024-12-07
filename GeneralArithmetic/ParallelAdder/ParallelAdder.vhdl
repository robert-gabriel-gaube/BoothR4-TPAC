LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ParallelAdder IS
    PORT(
        cin : IN std_logic; 
        a, b : IN std_logic_vector(8 downto 0); 
        out_add : OUT std_logic_vector(8 downto 0)
    );
END ParallelAdder;

ARCHITECTURE impl OF ParallelAdder IS
    SIGNAL c : std_logic_vector(8 downto 0);
    SIGNAL out_s : std_logic_vector(8 downto 0);
BEGIN
    fac0: ENTITY work.Fac PORT MAP(
        a => a(0), 
        b => b(0), 
        cin => cin, 
        output => out_s(0), 
        cout => c(0)
    );

    fac1: ENTITY work.Fac PORT MAP(
        a => a(1), 
        b => b(1), 
        cin => c(0), 
        output => out_s(1), 
        cout => c(1)
    );

    fac2: ENTITY work.Fac PORT MAP(
        a => a(2), 
        b => b(2), 
        cin => c(1), 
        output => out_s(2), 
        cout => c(2)
    );

    fac3: ENTITY work.Fac PORT MAP(
        a => a(3), 
        b => b(3), 
        cin => c(2), 
        output => out_s(3), 
        cout => c(3)
    );

    fac4: ENTITY work.Fac PORT MAP(
        a => a(4), 
        b => b(4), 
        cin => c(3), 
        output => out_s(4), 
        cout => c(4)
    );

    fac5: ENTITY work.Fac PORT MAP(
        a => a(5), 
        b => b(5), 
        cin => c(4), 
        output => out_s(5), 
        cout => c(5)
    );

    fac6: ENTITY work.Fac PORT MAP(
        a => a(6), 
        b => b(6), 
        cin => c(5), 
        output => out_s(6), 
        cout => c(6)
    );

    fac7: ENTITY work.Fac PORT MAP(
        a => a(7), 
        b => b(7), 
        cin => c(6), 
        output => out_s(7), 
        cout => c(7)
    );

    fac8: ENTITY work.Fac PORT MAP(
        a => a(8), 
        b => b(8), 
        cin => c(7), 
        output => out_s(8), 
        cout => c(8)
    );

    out_add <= out_s;

END impl;
