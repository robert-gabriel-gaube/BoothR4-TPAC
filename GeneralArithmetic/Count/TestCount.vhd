LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test IS
END test;

ARCHITECTURE t OF test IS
    COMPONENT Count IS 
        PORT(
            clk, rst_b, c0, c5: IN std_logic;
            output: OUT std_logic_vector(1 DOWNTO 0)
        );
    END COMPONENT;

    CONSTANT ClockFrequency : integer := 1; -- 1 Hz
    CONSTANT ClockPeriod    : time    := 100 ps / ClockFrequency;

    SIGNAL clk_s, rst_b_s, c0_s, c5_s: std_logic:= '0';
    SIGNAL output_s: std_logic_vector(1 DOWNTO 0);

BEGIN

    cnt: Count PORT MAP(clk_s, rst_b_s, c0_s, c5_s, output_s);

    -- Testing plan:
    --      from 0 to 25 ps the value of output should be 0
    --      on the next rising edge of clk output should be 0,  because c0 is 1 (check)
    --      on the next rising edge of clk output should be 0,  because c0 is 1 (check)
    --      on the next rising edge of clk output should be 1,  because c5 is 1 (check)
    --      on the next rising edge of clk output should be 2,  because c5 is 1 (check)
    --      on the next rising edge of clk output should be 3,  because c5 is 1 (check)
    --      on the next rising edge of clk output should be 0,  because c5 is 1 (check)
    --      on the next rising edge of clk output should be 1,  because c5 is 1 (check)
    --      on the next rising edge of clk output should be 0,  because c0 is 1 (check)

    clk_s <= NOT clk_s AFTER ClockPeriod / 2;

    c5_s <= '0',
            '1' AFTER 2 * ClockPeriod,
            '0' AFTER 7 * ClockPeriod;

    c0_s <= '1', 
            '0' AFTER 2 * ClockPeriod,
            '1' AFTER 7 * ClockPeriod;

    rst_b_s <=  '0', 
                '1' AFTER 25 ps;
END t;