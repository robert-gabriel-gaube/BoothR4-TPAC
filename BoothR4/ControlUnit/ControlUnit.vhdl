LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ControlUnit IS
    PORT(
        clk : IN std_logic;
        rst_b : IN std_logic;
        bgn : IN std_logic;
        q1, q0, q : IN std_logic;
        is_count_3 : IN std_logic;
        c0, c1, c2, c3, c4, c5, c6, done : OUT std_logic;
        state_out : OUT std_logic_vector(3 downto 0)
    );
END ControlUnit;

ARCHITECTURE impl OF ControlUnit IS
    CONSTANT S0 : std_logic_vector(3 downto 0) := "0000";
    CONSTANT S1 : std_logic_vector(3 downto 0) := "0001";
    CONSTANT S2 : std_logic_vector(3 downto 0) := "0010";
    CONSTANT S3 : std_logic_vector(3 downto 0) := "0011";
    CONSTANT S4 : std_logic_vector(3 downto 0) := "0100";
    CONSTANT S5 : std_logic_vector(3 downto 0) := "0101";
    CONSTANT S6 : std_logic_vector(3 downto 0) := "0110";
    CONSTANT S7 : std_logic_vector(3 downto 0) := "0111";
    CONSTANT S8 : std_logic_vector(3 downto 0) := "1000";
    CONSTANT S9 : std_logic_vector(3 downto 0) := "1001";
    CONSTANT S10 : std_logic_vector(3 downto 0) := "1010";

    SIGNAL state, state_next : std_logic_vector(3 downto 0);
    SIGNAL operation_state : std_logic_vector(3 downto 0);
    
    SIGNAL q_vector : std_logic_vector(2 downto 0);
    
BEGIN
    q_vector <= q1 & q0 & q;
    
    PROCESS(q_vector)
    BEGIN
        CASE (q_vector) IS
            WHEN "000" => operation_state <= S8;
            WHEN "111" => operation_state <= S8;
            WHEN "001" => operation_state <= S4;
            WHEN "010" => operation_state <= S4;
            WHEN "011" => operation_state <= S6;
            WHEN "100" => operation_state <= S7;
            WHEN "110" => operation_state <= S5;
            WHEN "101" => operation_state <= S5;
            WHEN OTHERS => operation_state <= S0;
        END CASE;
    END PROCESS;

    PROCESS(state, bgn, is_count_3, operation_state)
    BEGIN
        CASE state IS
            WHEN S0 =>
                IF bgn = '1' THEN
                    state_next <= S1;
                ELSE
                    state_next <= S0;
                END IF;
            WHEN S1 =>
                state_next <= S2;
            WHEN S2 =>
                state_next <= S3;
            WHEN S3 =>
                state_next <= operation_state;
            WHEN S4 | S5 | S6 | S7 | S8 =>
                state_next <= S9;
            WHEN S9 =>
                IF is_count_3 = '1' THEN
                    state_next <= S10;
                ELSE
                    state_next <= S3;
                END IF;
            WHEN S10 =>
                state_next <= S0;
            WHEN OTHERS =>
                state_next <= S0;
        END CASE;
    END PROCESS;

    c0 <= '1' WHEN state = S1 ELSE '0';
    c1 <= '1' WHEN state = S2 ELSE '0';
    c2 <= '1' WHEN (state = S4 OR state = S5 OR state = S6 OR state = S7) ELSE '0';
    c3 <= '1' WHEN (state = S6 OR state = S7) ELSE '0';
    c4 <= '1' WHEN (state = S5 OR state = S7) ELSE '0';
    c5 <= '1' WHEN state = S9 ELSE '0';
    c6 <= '1' WHEN state = S10 ELSE '0';
    done <= '1' WHEN state = S10 ELSE '0';

    state_out <= state;

    PROCESS(clk, rst_b)
    BEGIN
        IF rst_b = '0' THEN
            state <= S0;
        ELSIF rising_edge(clk) THEN
            state <= state_next;
        END IF;
    END PROCESS;

END impl;
