----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2022 11:15:11 AM
-- Design Name: 
-- Module Name: Memory - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
--use UNISIM.VComponents.all;

entity Memory is
  Port (Data : inout std_logic_vector (7 downto 0):="ZZZZZZZZ";   
        address_m : in  std_logic_vector(3 downto 0);
        clk, read, write : in std_logic );
end Memory;


    
architecture Behavioral of Memory is
    type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);   
    signal RAM:ram_type;
  
begin


process (clk)
begin
  if rising_edge(clk) then
    if write = '1' then
      ram(TO_INTEGER(signed(address_m)))<= data;
    end if;
  end if;
end process;
data <= ram(TO_INTEGER(signed(address_m))) when read = '1' else "ZZZZZZZZ";
end Behavioral;
