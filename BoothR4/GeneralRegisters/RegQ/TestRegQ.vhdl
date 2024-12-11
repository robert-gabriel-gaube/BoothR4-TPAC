ENTITY test IS
END test;

ENTITY test_RegQ IS
END test_RegQ;

ARCHITECTURE tb OF test_RegQ IS

    COMPONENT RegQ IS
        PORT(
            clk, rst_b, c5, c1, a0, a1, c6: IN bit;
            input: IN bit_vector(7 DOWNTO 0);
            output: OUT bit_vector(7 DOWNTO 0);
            outbus: OUT bit_vector(16 DOWNTO 0)
        );
    END COMPONENT;

    CONSTANT ClockFrequency : integer := 1; -- 1 Hz 
    CONSTANT ClockPeriod    : time    := 100 ps / ClockFrequency;

    SIGNAL clk_s, rst_b_s, c5_s, c1_s, a0_s, a1_s, c6_s: bit;
    SIGNAL input_s: bit_vector(7 DOWNTO 0);
    SIGNAL output_s: bit_vector(7 DOWNTO 0);
    SIGNAL outbus_s: bit_vector(16 DOWNTO 0);

BEGIN
    regQ_inst : RegQ PORT MAP (
        clk         => clk_s,
        rst_b       => rst_b_s,
        c5          => c5_s,
        c1          => c1_s,
        a0          => a0_s,
        a1          => a1_s,
        c6          => c6_s,
        input       => input_s,
        output      => output_s,
        outbus      => outbus_s
    );

    clk_s <= NOT clk_s AFTER ClockPeriod / 2;

    stim_proc: PROCESS
    BEGIN
        rst_b_s <= '0';
        WAIT FOR 25 ps;
        rst_b_s <= '1';

        -- Test sequence
        -- Load '00100011' into input, set c1
        input_s <= b"00100011";
        c1_s <= '1'; c5_s <= '0'; c6_s <= '0'; a0_s <= '1'; a1_s <= '1'; -- output should be equal to input and outbus equal to 0
        WAIT FOR ClockPeriod;
    
        -- Set c5 to 1 to use a1, a0 and output shifted
        c1_s <= '0'; c5_s <= '1'; c6_s <= '0'; a0_s <= '1'; a1_s <= '1'; 
        WAIT FOR ClockPeriod;
       
        -- Set c6 to 1 to enable outbus output with current `out_internal` value
        c1_s <= '0'; c5_s <= '0'; c6_s <= '1'; a0_s <= '1'; a1_s <= '1'; -- output should be equal to input and outbus equal to output
        WAIT FOR ClockPeriod;

        -- Set c6 back to 0, outbus should go to zero
        c1_s <= '0'; c5_s <= '0'; c6_s <= '0'; a0_s <= '1'; a1_s <= '1'; -- output should be equal to input and outbus equal to 0
        WAIT FOR ClockPeriod;

        -- Test for reseting the output and outbus
        rst_b_s <= '0';c1_s <= '1'; c5_s <= '1'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        WAIT;
    END PROCESS stim_proc;

END tb;
