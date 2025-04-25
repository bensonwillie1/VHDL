--XOR

library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.NUMERIC_STD.ALL;

-- this is the entity
entity exor is
  port ( 
    A, B: in std_logic_vector(7 downto 0);
    C : in std_logic;
    X_out : out std_logic_vector(8 downto 0)
    );
end entity exor;

-- this is the architecture
architecture behavioral of exor is
    
begin
    X_out <= C&(A XOR B);
end behavioral;