LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY ControlUnitLib;
USE ControlUnitLib.ALL;

LIBRARY GeneralArithmeticLib;
USE GeneralArithmeticLib.ALL;

LIBRARY GeneralRegistersLib;
USE GeneralRegistersLib.ALL;

ENTITY boothr4 IS
    PORT (
        bgn    : IN std_logic;
        clk    : IN std_logic;
        rst_b  : IN std_logic;
        inbus  : IN std_logic_vector(7 DOWNTO 0);
        done   : OUT std_logic;
        outbus : OUT std_logic_vector(16 DOWNTO 0)
    );
END boothr4;

ARCHITECTURE impl OF boothr4 IS
    SIGNAL reg_m, reg_q : std_logic_vector(7 DOWNTO 0);
    SIGNAL reg_a, adder_output, mux_out : std_logic_vector(8 DOWNTO 0);
    SIGNAL cnt : std_logic_vector(1 DOWNTO 0);
    SIGNAL c0, c1, c2, c3, c4, c5, c6 : std_logic;
    SIGNAL q, is_count_3_signal : std_logic;
    signal reg_m_extended : std_logic_vector(8 DOWNTO 0);
    signal double_reg_m   : std_logic_vector(8 DOWNTO 0);
    signal c4_extended    : std_logic_vector(8 DOWNTO 0);
    signal negative_m     : std_logic_vector(8 DOWNTO 0);
    
BEGIN
    is_count_3_signal <= cnt(0) AND cnt(1);
    reg_m_extended    <= reg_m(7) & reg_m;
    double_reg_m      <= reg_m    & '0';
    c4_extended       <= (OTHERS => c4);
    negative_m        <= mux_out XOR c4_extended;

    inst7: ENTITY ControlUnitLib.ControlUnit
        PORT MAP (
            clk         => clk,
            rst_b       => rst_b,
            bgn         => bgn,
            q1          => reg_q(1),
            q0          => reg_q(0),
            q           => q,
            is_count_3  => is_count_3_signal,
            c0          => c0,
            c1          => c1,
            c2          => c2,
            c3          => c3,
            c4          => c4,
            c5          => c5,
            c6          => c6,
            done        => done
        );

    inst0: ENTITY GeneralRegistersLib.RegM
        PORT MAP (
            clk     => clk,
            rst_b   => rst_b,
            c0      => c0,
            input   => inbus,
            output  => reg_m
        );

    inst1: ENTITY GeneralRegistersLib.RegQ
        PORT MAP (
            clk     => clk,
            rst_b   => rst_b,
            c1      => c1,
            c5      => c5,
            c6      => c6,
            a0      => reg_a(0),
            a1      => reg_a(1),
            input   => inbus,
            output  => reg_q,
            outbus  => outbus
        );

    inst2: ENTITY GeneralRegistersLib.RegA
        PORT MAP (
            clk           => clk,
            rst_b         => rst_b,
            c0            => c0,
            c2            => c2,
            c5            => c5,
            c6            => c6,
            adder_input   => adder_output,
            output        => reg_a,
            outbus        => outbus
        );

    inst3: ENTITY GeneralRegistersLib.RegQ_neg
        PORT MAP (
            clk     => clk,
            rst_b   => rst_b,
            c0      => c0,
            c5      => c5,
            q1      => reg_q(1),
            output  => q
        );

    inst4: ENTITY GeneralRegistersLib.Mux2to1
        PORT MAP (
            c3      => c3,
            M       => reg_m_extended,
            dM      => double_reg_m,
            output  => mux_out
        );

    inst6: ENTITY GeneralArithmeticLib.ParallelAdder
        PORT MAP (
            cin      => c4,
            a        => reg_a,
            b        => negative_m,
            out_add  => adder_output
        );
END impl;
