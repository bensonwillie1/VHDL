----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 07:52:04 AM
-- Design Name: 
-- Module Name: CarryLookaheadAdder - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CarryLookaheadAdder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end CarryLookaheadAdder;

architecture Behavioral of CarryLookaheadAdder is

signal G, P, C: STD_LOGIC_VECTOR (3 downto 0);

begin

 -- Generate and Propagate for each bit
    G <= A and B;
    P <= A or B;

    -- Calculate carries
    C(0) <= Cin;
    C(1) <= G(0) or (P(0) and C(0));
    C(2) <= G(1) or (P(1) and C(1));
    C(3) <= G(2) or (P(2) and C(2));
    Cout <= G(3) or (P(3) and C(3));

    -- Calculate sum
    Sum <= A xor B xor C;


end Behavioral;
