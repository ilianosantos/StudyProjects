LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is
port (
A : in std_logic;
B : in std_logic;
CYi : in std_logic;
R : out std_logic;
CyOut: out std_logic
);
end fulladder;

architecture fulladder of fulladder is
begin
R <= (A xor B) xor CYi;
CyOut <= ((A xor B) and CYi) or (A and B);
end fulladder;