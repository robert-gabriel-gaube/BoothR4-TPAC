ENTITY test IS
END test;

ARCHITECTURE t OF test IS
    component RegM is 
        PORT(
            clk, rst_b, c0: in bit;
            input: in bit_vector(7 downto 0);
            output: out bit_vector(7 downto 0)
        );
    end component;

    constant ClockFrequency : integer := 1; -- 1 Hz
    constant ClockPeriod    : time    := 100 ps / ClockFrequency;

    signal clk_s, rst_b_s, c0_s: bit;
    signal input_s, output_s: bit_vector(7 downto 0);

BEGIN

    reg: RegM PORT MAP(clk_s, rst_b_s, c0_s, input_s, output_s);

    -- Testing plan:
    --      from 0 to 25 ps the value of output should be 0                                         (check)
    --      on the next rising edge of clk_s the value loaded should be 0x1F,   because c0_s is 1   (check)
    --      on the next rising edge of clk_s the value loaded should be 0x1E,   because c0_s is 1   (check)
    --      on the next rising edge of clk_s the value should remain 0x1E,      because c0_s is 0   (check)
    --      on the next rising edge of clk_s the value should remain 0x1E,      because c0_s is 0   (check)
    --      on the next rising edge of clk_s the value loaded should be 0x1B,   because c0_s is 1   (check)
    --      on the next rising edge of clk_s the value loaded should be 0x1A,   because c0_s is 1   (check)

    clk_s <= NOT clk_s AFTER ClockPeriod / 2;

    input_s <=  x"1F", 
                x"1E" AFTER ClockPeriod, 
                x"1D" AFTER 2 * ClockPeriod, 
                x"1C" AFTER 3 * ClockPeriod,
                x"1B" AFTER 4 * ClockPeriod,
                x"1A" AFTER 5 * ClockPeriod;

    c0_s <= '1', 
            '0' AFTER 2 * ClockPeriod,
            '1' AFTER 4 * ClockPeriod;

    rst_b_s <=  '0', 
                '1' AFTER 25 ps;

END t;
