library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity roll is
port(clk: in std_logic;
partout:out std_logic_vector(6 downto 0);
catout: out std_logic_vector(7 downto 0));
end roll;
architecture a of roll is
signal part:    std_logic_vector(6 downto 0);
signal cat:     std_logic_vector(7 downto 0);
signal number:  std_logic_vector(7 downto 0);
signal tempclk: std_logic;--a clk(div 1)
signal move:    std_logic;--a clk(div 2)
begin

p1:process(clk)		
variable count:integer range 0 to 50000:=0;
begin
if(clk'event and clk='1')then
	if(count=50000)then
		count:=0;
		tempclk<= not tempclk;
	else
		count:=count+1;
	end if;
end if;
end process p1;

p2:process(tempclk) 		
begin
if (tempclk'event and tempclk='1') then
	case cat is
	when"01111111"=>cat<="10111111";
	when"10111111"=>cat<="11011111";
	when"11011111"=>cat<="11101111";
	when"11101111"=>cat<="11110111";
	when"11110111"=>cat<="11111011";
	when"11111011"=>cat<="11111101";
	when"11111101"=>cat<="11111110";
	when others =>cat<="01111111";
	end case;
end if;
catout<=cat;
end process p2;

p3:process(clk)		
variable count:integer range 0 to 25000000:=0;
begin
if (clk'event and clk='1') then
	if (count=25000000) then
		count:=0;
		move<=not move;
	else
		count:=count+1;
	end if;
end if;
end process p3;

p4:process(tempclk,move)	--计数器
variable judge1:integer range 0 to 1:=0;-- 1 when "move" come 
variable judge2:integer range 0 to 1:=0;
begin
if (move'event and move='1') then
    judge1:=1;
end if;
if (tempclk='1') then
	if (judge1=0) then --when move donnot come
		judge2:=0;
		case number is
		when"01111111"=>number<="10111111";
		when"10111111"=>number<="11011111";
		when"11011111"=>number<="11101111";
		when"11101111"=>number<="11110111";
		when"11110111"=>number<="11111011";
		when"11111011"=>number<="11111101";
		when"11111101"=>number<="11111110";
		when others =>number<="01111111";
		end case;
	else
		judge2:=1;
		case number is
		when"01111111"=>number<="11011111";
		when"10111111"=>number<="11101111";
		when"11011111"=>number<="11110111";
		when"11101111"=>number<="11111011";
		when"11110111"=>number<="11111101";
		when"11111011"=>number<="11111110";
		when"11111101"=>number<="01111111";
		when others =>number<="10111111";
		end case;
	end if;
end if;
if (judge2=1) then
	judge1:=0;
end if;
end process p4;

p5:process(number)	--数码管译码器
begin
case number is
when"01111111"=>part<="1111110";
when"10111111"=>part<="0110000";
when"11011111"=>part<="1101101";
when"11101111"=>part<="1111001";
when"11110111"=>part<="0110011";
when"11111011"=>part<="1011011";
when"11111101"=>part<="1011111";
when"11111110"=>part<="1110000";
when others =>part<="1111110";
end case;
end process p5;
partout<=part;
end a;