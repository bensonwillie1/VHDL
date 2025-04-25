--Full_ adder

library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.NUMERIC_STD.ALL;

-- this is the entity
entity full_adder is
  port ( 
    A, B, C : in std_logic;
    S, Cout : out std_logic);
end entity full_adder;

-- this is the architecture
architecture behavioral of full_adder is
begin
  S <= (A AND NOT(b) AND NOT(C)) OR (NOT(A) AND NOT(B) AND C) OR (A AND B AND C) OR (NOT(A) AND B AND NOT(C));
  Cout <= (B AND C) OR (A AND C) OR (B AND A);
end architecture behavioral;