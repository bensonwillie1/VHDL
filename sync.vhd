----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2022 07:52:08 AM
-- Design Name: 
-- Module Name: sync - Behavioral
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

entity sync is
    Port ( clk : in STD_LOGIC;
           input, rst : in STD_LOGIC;
           output : out STD_LOGIC);
end sync;

architecture Behavioral of sync is
component d_flip_flop is
      port ( Q : out std_logic;
         clk : in std_logic;
         sync_reset : in std_logic;
         D : in std_logic );
end component;
    signal Q1, Q2, Q3: std_logic;
begin
DF1: d_flip_flop port map(D=>input, sync_reset=>rst, clk=>clk, Q=>Q1);
DF2: d_flip_flop port map(D=>Q1, sync_reset=>rst, clk=>clk, Q=>Q2);
Q3 <= not Q2;
output <= Q1 and Q3;


end Behavioral;
