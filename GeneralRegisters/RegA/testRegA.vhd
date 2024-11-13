ENTITY test IS
END test;

ENTITY test_RegA IS
END test_RegA;

ARCHITECTURE tb OF test_RegA IS

    COMPONENT RegA IS
        PORT(
            clk, rst_b, c0, c5, c2, c6: IN bit;
            adder_input: IN bit_vector(8 DOWNTO 0);
            output: OUT bit_vector(8 DOWNTO 0);
            outbus: OUT bit_vector(16 DOWNTO 0)
        );
    END COMPONENT;

    CONSTANT ClockFrequency : integer := 1; -- 1 Hz for easy observation
    CONSTANT ClockPeriod    : time    := 100 ps / ClockFrequency;

    SIGNAL clk_s, rst_b_s, c0_s, c5_s, c2_s, c6_s: bit;
    SIGNAL adder_input_s: bit_vector(8 DOWNTO 0);
    SIGNAL output_s: bit_vector(8 DOWNTO 0);
    SIGNAL outbus_s: bit_vector(16 DOWNTO 0);

BEGIN

    -- Instantiate the RegA component
    regA_inst : RegA PORT MAP (
        clk         => clk_s,
        rst_b       => rst_b_s,
        c0          => c0_s,
        c5          => c5_s,
        c2          => c2_s,
        c6          => c6_s,
        adder_input => adder_input_s,
        output      => output_s,
        outbus      => outbus_s
    );

    -- Clock Generation
    clk_s <= NOT clk_s AFTER ClockPeriod / 2;

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Initial reset
        rst_b_s <= '0';
        WAIT FOR 25 ps;  -- hold reset for 25 ps
        rst_b_s <= '1';  -- Release reset

        -- Test sequence
        -- Load 0x1F into adder_input, set c0, c2, c5, and c6 as necessary
        adder_input_s <= b"000100001";
        c0_s <= '1'; c2_s <= '0'; c5_s <= '0'; c6_s <= '0';
        WAIT FOR ClockPeriod;
    
        -- Set c2_s to put the adder input in the out_internal
        c0_s <= '0'; c2_s <= '1'; c5_s <= '0'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        -- Perform a shift operation with c5 high
        c0_s <= '0'; c2_s <= '0'; c5_s <= '1'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        -- Set c6 to 1 to enable outbus output with current `out_internal` value
        c0_s <= '0'; c2_s <= '0'; c5_s <= '0'; c6_s <= '1';
        WAIT FOR ClockPeriod;

        -- Set c6 back to 0, outbus should go to zero
        c0_s <= '0'; c2_s <= '0'; c5_s <= '0'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        -- Test other values with different c0, c2, and c5 combinations
        --adder_input_s <= b"000000011";  -- New input for loading
        c0_s <= '1'; c2_s <= '0'; c5_s <= '0'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        c0_s <= '0'; c2_s <= '1'; c5_s <= '0'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        -- Test with another shift
        c0_s <= '0'; c2_s <= '0'; c5_s <= '1'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        -- Final hold state
        c0_s <= '0'; c2_s <= '0'; c5_s <= '0'; c6_s <= '0';
        WAIT FOR ClockPeriod;

        -- End simulation
        WAIT;
    END PROCESS stim_proc;

END tb;
