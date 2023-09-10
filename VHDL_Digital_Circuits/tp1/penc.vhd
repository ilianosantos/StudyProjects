LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity PEnc is
port (
		I : in std_logic_vector(3 downto 0);
		O : out std_logic_vector(1 downto 0);
		V : OUT std_logic
);
end PEnc;

architecture PENC of PEnc is
begin
		O(0) <= I(3) or (I(1) and not I(2));
		O(1) <= I(3) or I(2);
		 V <= I(0) or I(1) or I(2) or I(3);
end PENC;			