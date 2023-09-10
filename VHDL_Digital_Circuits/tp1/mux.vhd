LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
port (
		I0, I1 : in std_logic_vector(1 downto 0);
		S: in std_logic;
		O1, O0 : out std_logic
);
end mux2;

architecture mux of mux2 is
begin
		O0 <= (I0(0) and not S) or (I1(0) and S);
		O1 <= (I0(1) and not S) or (I1(1) and S);
END mux;