LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TestControlUnit IS
END TestControlUnit;

ARCHITECTURE tb OF TestControlUnit IS
    COMPONENT ControlUnit IS
        PORT(
            clk : IN std_logic;
            rst_b : IN std_logic;
            bgn : IN std_logic;
            q1, q0, q : IN std_logic;
            is_count_3 : IN std_logic;
            c0, c1, c2, c3, c4, c5, c6, done : OUT std_logic;
            state_out : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;

    SIGNAL clk_s : std_logic := '0';
    SIGNAL rst_b_s : std_logic := '1';
    SIGNAL bgn_s : std_logic := '0';
    SIGNAL q1_s, q0_s, q_s : std_logic := '0';
    SIGNAL is_count_3_s : std_logic := '0';
    SIGNAL c0_s, c1_s, c2_s, c3_s, c4_s, c5_s, c6_s, done_s : std_logic;
    SIGNAL state_s : std_logic_vector(3 downto 0);

    CONSTANT clk_period : time := 100 ps;

BEGIN
    cu: ControlUnit
        PORT MAP(
            clk => clk_s,
            rst_b => rst_b_s,
            bgn => bgn_s,
            q1 => q1_s,
            q0 => q0_s,
            q => q_s,
            is_count_3 => is_count_3_s,
            c0 => c0_s,
            c1 => c1_s,
            c2 => c2_s,
            c3 => c3_s,
            c4 => c4_s,
            c5 => c5_s,
            c6 => c6_s,
            done => done_s,
            state_out => state_s
        );

    clk_process: PROCESS
    BEGIN
        WHILE TRUE LOOP
            clk_s <= '0';
            WAIT FOR clk_period / 2;
            clk_s <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS;

    test: PROCESS
    BEGIN
        -- Test 1: Reset activ
        -- Rezultate a?teptate: FSM �n S0. Toate ie?irile = '0'.
        rst_b_s <= '0';
        WAIT FOR clk_period;
        rst_b_s <= '1';
        WAIT FOR clk_period;

        -- Test 2: Activare cu bgn
        -- Rezultate a?teptate:
        -- �n S1: c0 = '1', c1-c6 = '0', done = '0'.
        -- �n S2: c1 = '1', restul '0'.
        bgn_s <= '1';
        WAIT FOR clk_period;

        -- Test 3: Tranzi?ie �n S3
        -- Rezultate a?teptate: FSM �n S3, toate ie?irile = '0'.
        WAIT FOR clk_period;

        -- Test 4: Tranzi?ie �n S4
        -- Rezultate a?teptate: FSM �n S4, c2 = '1', restul '0'.
        q1_s <= '0';
        q0_s <= '0';
        q_s <= '1';
        WAIT FOR clk_period;

        -- Test 5: Tranzi?ie �n S5
        -- Rezultate a?teptate: FSM �n S5, c2 = '1', c4 = '1', restul '0'.
        q1_s <= '1';
        q0_s <= '1';
        q_s <= '0';
        WAIT FOR 2 * clk_period;

        -- Test 6: Tranzi?ie �n S6
        -- Rezultate a?teptate: FSM �n S6, c2 = '1', c3 = '1', restul '0'.
        q1_s <= '0';
        q0_s <= '1';
        q_s <= '1';
        WAIT FOR clk_period;

        -- Test 7: Tranzi?ie �n S7
        -- Rezultate a?teptate: FSM �n S7, c2 = '1', c3 = '1', c4 = '1', restul '0'.
        q1_s <= '1';
        q0_s <= '0';
        q_s <= '0';
        WAIT FOR clk_period;

        -- Test 8: Tranzi?ie �n S8
        -- Rezultate a?teptate: FSM �n S8, toate ie?irile = '0'.
        q1_s <= '0';
        q0_s <= '0';
        q_s <= '0';
        WAIT FOR clk_period;

        -- Test 9: Tranzi?ie �n S9
        -- Rezultate a?teptate: FSM �n S9, c5 = '1', restul '0'.
        WAIT FOR clk_period;

        -- Test 10: Tranzi?ie la S10
        -- Rezultate a?teptate: FSM �n S10, c6 = '1', done = '1', restul '0'.
        is_count_3_s <= '1';
        WAIT FOR clk_period;

        -- Test 11: Revenire la S0
        -- Rezultate a?teptate: FSM �n S0, toate ie?irile = '0'.
        bgn_s <= '0';
        is_count_3_s <= '0';
        WAIT FOR clk_period;

        -- �ncheierea simul?rii
        WAIT;
    END PROCESS;

END tb;
