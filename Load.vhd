--Load

library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.NUMERIC_STD.ALL;

-- this is the entity
entity Load is
  port ( 
    B: in std_logic_vector(7 downto 0);
    C: in std_logic;
    B_out : out std_logic_vector(8 downto 0));
end Load;

-- this is the architecture
architecture behavioral of Load is
   --signal B : in std_logic_vector(7 downto 0);
   --signal B_out : out std_logic_vector(7 downto 0);
begin
    B_out<=C&B;
end behavioral;