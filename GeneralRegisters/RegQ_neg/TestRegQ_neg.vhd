ENTITY test IS
END test;

ENTITY test_RegQ_neg IS
END test_RegQ_neg;

ARCHITECTURE tb OF test_RegQ_neg IS

    COMPONENT RegQ_neg IS
        PORT(
            clk, rst_b, c0, c5, q1: IN bit;
            output: OUT bit
        );
    END COMPONENT;

    CONSTANT ClockFrequency : integer := 1; -- 1 Hz 
    CONSTANT ClockPeriod    : time    := 100 ps / ClockFrequency;

    SIGNAL clk_s, rst_b_s, c0_s, c5_s, q1_s: bit;
    SIGNAL output_s: bit;

BEGIN
    regQ_neq_inst : RegQ_neg PORT MAP (
        clk         => clk_s,
        rst_b       => rst_b_s,
        c0          => c0_s,
        c5          => c5_s,
        q1          => q1_s,
        output      => output_s
    );

    -- Clock Generation
    clk_s <= NOT clk_s AFTER ClockPeriod / 2;

    stim_proc: PROCESS
    BEGIN
        -- Initial reset
        rst_b_s <= '0';
        WAIT FOR 25 ps;  -- hold reset for 25 ps
        rst_b_s <= '1';  -- Release reset

        -- Test sequence
        -- Load '1' into q1, set c0, c5 as necessary
        c0_s <= '1'; c5_s <= '0'; q1_s <= '1'; -- output should be equal to 0
        WAIT FOR ClockPeriod;
    
        -- Load '1' into q1, set c0, c5 as necessary
        c0_s <= '0'; c5_s <= '1'; q1_s <= '1'; -- output should be equal to q1
        WAIT FOR ClockPeriod;

        -- Load '1' into q1, set c0, c5 as necessary
        c0_s <= '1'; c5_s <= '1'; q1_s <= '1'; -- output should be equal to 0
        WAIT FOR ClockPeriod;
        
        -- Load '1' into q1, set c0, c5 as necessary
        c0_s <= '0'; c5_s <= '1'; q1_s <= '1'; -- output should be equal to q1
        WAIT FOR ClockPeriod;
                
        -- Test for reseting the output
        rst_b_s <= '0';c0_s <= '1'; c5_s <= '1';
        WAIT FOR ClockPeriod;

        WAIT;
    END PROCESS stim_proc;

END tb;
