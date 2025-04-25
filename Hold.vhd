--HOLD

library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.NUMERIC_STD.ALL;

-- this is the entity
entity HOLD is
  port ( A: in std_logic_vector(7 downto 0);
         C: in std_logic;
         A_out : out std_logic_vector(8 downto 0));
end HOLD;

-- this is the architecture
architecture behavioral of HOLD is
 -- signal A: in std_logic_vector(7 downto 0);
 -- signal A_out: out std_logic_vector(7 downto 0);
begin
    A_out<=C&A;
end behavioral;