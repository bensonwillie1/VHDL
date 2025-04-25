--mux

library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.NUMERIC_STD.ALL;

-- this is the entity
entity mux is
  port ( 
    A, B, C, D, E: in std_logic_vector(8 downto 0);
    Sel : in std_logic_vector(2 downto 0);
    R : out std_logic_vector(8 downto 0));
end entity mux;

-- this is the architecture
architecture behavioral of mux is
    
begin
    R <= A when Sel = "000" else
        B when Sel = "001" else
        C when Sel = "010" else
        D when Sel = "011" else
        E when Sel = "100" else
        "XXXXXXXXX";
    


end architecture behavioral;