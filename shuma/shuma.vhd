LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY division IS
		PORT (
			clk : IN STD_LOGIC;
			clear : IN STD_LOGIC;
			clk_out : OUT STD_LOGIC
		);
		END division;
	
ARCHITECTURE a OF division IS
		SIGNAL tmp : INTEGER RANGE 0 TO 4;
		SIGNAL clktmp : STD_LOGIC;
		BEGIN 
			PROCESS(clear,clk)
			BEGIN
			IF clear = '1' THEN
				tmp <= 0;
			ELSIF clk'event AND clk = '1' THEN
				IF tmp = 4 THEN
					tmp <= 0; clktmp <= NOT clktmp;
			ELSE
				tmp <= tmp + 1;
			END IF;
		END IF;
		END PROCESS;
		clk_out <= clktmp;
END a;
		



		
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter IS
	PORT (
		clk,clear : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
	);
	END counter;
	
ARCHITECTURE a OF counter IS
	SIGNAL q_temp : STD_LOGIC_VECTOR (3 DOWNTO 0);
	BEGIN
		PROCESS(clk)
		BEGIN
		IF clear = '1' THEN 
				q_temp<="0000";
			ELSIF(clk'event AND clk = '1')THEN
			IF q_temp="1001" THEN
			    q_temp<="0000";
			ELSE
				q_temp<=q_temp+1;
			END IF;
		END IF;
		END PROCESS;
	q<=q_temp;	
END a;












LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY shuma IS
	PORT(
		clkin : IN STD_LOGIC;
		reset: IN STD_LOGIC;
		reset1: IN STD_LOGIC;
		clkout : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		cat: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	END shuma;
ARCHITECTURE a OF shuma IS
	SIGNAL temp1 : STD_LOGIC;
	SIGNAL temp2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT division 
	PORT
	(
		clk : IN STD_LOGIC;
		clear : IN STD_LOGIC;
		clk_out : OUT STD_LOGIC
	);
	END COMPONENT;
COMPONENT counter
	PORT
	(
		clk,clear : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
	);
	END COMPONENT;	
BEGIN
	u1 : division PORT MAP(clk =>clkin,clear =>reset,clk_out =>temp1);
	u2 : counter PORT MAP(clk =>temp1,clear =>reset1,q =>temp2);
	PROCESS (temp2)
		BEGIN 
			CASE temp2 IS
			WHEN"0000" => clkout <="1111110";   --0
			WHEN"0001" => clkout <="0110000";   --1
			WHEN"0010" => clkout <="1101101";   --2
			WHEN"0011" => clkout <="1111001";   --3
			WHEN"0100" => clkout <="0110011";   --4
			WHEN"0101" => clkout <="1011011";   --5
			WHEN"0110" => clkout <="1011111";   --6
			WHEN"0111" => clkout <="1110000";   --7
			WHEN"1000" => clkout <="1111111";   --8
			WHEN"1001" => clkout <="1111011";   --9
			WHEN OTHERS => clkout <="0110011"; 
		END CASE;
	END PROCESS;
	cat <= "11111110";
END;
