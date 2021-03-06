LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY gundong IS
PORT(
clk_in: IN STD_LOGIC;
seg_out: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
cat: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END gundong;

ARCHITECTURE segment_r_arch OF gundong IS
BEGIN
PROCESS(clk_in)
VARIABLE status: INTEGER RANGE 0 TO 7 := 0;
VARIABLE flag: STD_LOGIC := '0';
VARIABLE cnt: INTEGER RANGE 0 TO 4999 := 0;
VARIABLE seg_0: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000"; --1
VARIABLE seg_1: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1011111"; --6
VARIABLE seg_2: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000"; --1
VARIABLE seg_3: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1101101"; --2
VARIABLE seg_4: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1011011"; --5
VARIABLE seg_5: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000001"; ---
VARIABLE seg_6: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111110"; --0
VARIABLE seg_7: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000"; --1
VARIABLE seg_temp: STD_LOGIC_VECTOR(6 DOWNTO 0); --temp
BEGIN
IF clk_in'EVENT AND clk_in = '1' THEN
IF flag = '1' THEN
flag := NOT flag;
seg_temp := seg_0;
seg_0 := seg_1;
seg_1 := seg_2;
seg_2 := seg_3;
seg_3 := seg_4;
seg_4 := seg_5;
seg_5 := seg_6;
seg_6 := seg_7;
seg_7 := seg_temp;
END IF;
CASE status IS
WHEN 0 => cat <= "01111111"; seg_out <= seg_0;
WHEN 1 => cat <= "10111111"; seg_out <= seg_1;
WHEN 2 => cat <= "11011111"; seg_out <= seg_2;
WHEN 3 => cat <= "11101111"; seg_out <= seg_3;
WHEN 4 => cat <= "11110111"; seg_out <= seg_4;
WHEN 5 => cat <= "11111011"; seg_out <= seg_5;
WHEN 6 => cat <= "11111101"; seg_out <= seg_6;
WHEN 7 => cat <= "11111110"; seg_out <= seg_7;
WHEN OTHERS => cat <= "11111111"; seg_out <= "0000000";
END CASE;
IF status = 7 THEN
status := 0;
cnt := cnt + 1;
ELSE
status := status + 1;
END IF;
IF cnt = 141 THEN --"cnt = 1" for simulation, "cnt = 4999" for upload
flag := NOT flag;
cnt := 0;
END IF;
END IF;
END PROCESS;
END segment_r_arch;