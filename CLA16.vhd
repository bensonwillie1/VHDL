----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 07:59:38 AM
-- Design Name: 
-- Module Name: CLA16 - Behavioral
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

entity CLA16 is
       Port (A, B : in std_logic_vector(15 downto 0);
          Ci : in std_logic;
          S : out std_logic_vector(15 downto 0);
          Co : out std_logic);
end CLA16;

architecture Behavioral of CLA16 is

component CarryLookaheadAdder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end component;
    
    signal intermediateCarry : std_logic_vector(2 downto 0);  -- To hold the carry out of each 4-bit block
    signal PG, GG : std_logic_vector(3 downto 0);  -- Propagate and Generate signals for each block
begin
    CLA0: CarryLookaheadAdder 
        port map (A => A(3 downto 0), B => B(3 downto 0), Cin => Ci, Sum => S(3 downto 0), Cout => intermediateCarry(0));

    -- Second 4-bit CLA
    CLA1: CarryLookaheadAdder
        port map (A => A(7 downto 4), B => B(7 downto 4), Cin => intermediateCarry(0), Sum => S(7 downto 4), Cout => intermediateCarry(1));

    -- Third 4-bit CLA
    CLA2: CarryLookaheadAdder
        port map (A => A(11 downto 8), B => B(11 downto 8), Cin => intermediateCarry(1), Sum => S(11 downto 8), Cout => intermediateCarry(2));

    -- Fourth 4-bit CLA (MSBs)
    CLA3: CarryLookaheadAdder
        port map (A => A(15 downto 12), B => B(15 downto 12), Cin => intermediateCarry(2), Sum => S(15 downto 12), Cout => Co);
end Behavioral;