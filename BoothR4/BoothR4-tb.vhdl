LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test IS
END test;

ARCHITECTURE t OF test IS
    COMPONENT boothR4 IS
        PORT (
            bgn    : IN std_logic;
            clk    : IN std_logic;
            rst_b  : IN std_logic;
            inbus  : IN std_logic_vector(7 DOWNTO 0);
            done   : OUT std_logic;
            outbus : OUT std_logic_vector(16 DOWNTO 0);
            state  : OUT std_logic_vector( 3 DOWNTO 0)
        );
	END COMPONENT;

    CONSTANT ClockFrequency : integer := 1; -- 1 Hz
    CONSTANT ClockPeriod    : time    := 100 ps / ClockFrequency;

	SIGNAL bgn_s, clk_s, rst_b_s: std_logic := '0';
    SIGNAL done_s: std_logic;
	SIGNAL inbus_s : std_logic_vector( 7 DOWNTO 0);
    SIGNAL outbus_s: std_logic_vector(16 DOWNTO 0);
    SIGNAL state_s : std_logic_vector( 3 DOWNTO 0);

BEGIN
    booth: boothR4 PORT MAP(bgn_s, clk_s, rst_b_s, inbus_s, done_s, outbus_s, state_s);

    clk_s <= NOT clk_s AFTER ClockPeriod / 2;

    bgn_s   <= '1';
    rst_b_s <= '1' AFTER 25 ps,
               '0' AFTER 1500 ps, '1' AFTER 1525 ps,
               '0' AFTER 3000 ps, '1' AFTER 3025 ps,
               '0' AFTER 4500 ps, '1' AFTER 4525 ps;

    inbus_s  <= X"38", X"2D" AFTER 200 ps,
                X"02" AFTER 1500 ps, X"04" AFTER 1700 ps,
                X"8F" AFTER 3000 ps, X"04" AFTER 3200 ps,
                X"8F" AFTER 4500 ps, X"A9" AFTER 4700 ps;


END t;
