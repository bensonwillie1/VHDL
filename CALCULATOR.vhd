----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2022 02:19:03 PM
-- Design Name: 
-- Module Name: CALCULATOR - Behavioral
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

entity CALCULATOR is
    Port ( User_input : in STD_LOGIC_VECTOR (7 downto 0);
           opp_code : in STD_LOGIC_VECTOR (3 downto 0);
           EX, Mclk, Mrst : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (7 downto 0);
           Address_U : in STD_LOGIC_VECTOR (3 downto 0));
end CALCULATOR;

architecture Behavioral of CALCULATOR is
component sync is
    Port ( clk : in STD_LOGIC;
           input, rst, ce : in STD_LOGIC;
           output : out std_logic);
end component;

component memory is
     Port (Data : inout std_logic_vector (7 downto 0);   
        address_m : in  std_logic_vector(3 downto 0);
        clk, read, write : in std_logic );
end component;

component CALC_STATE is
    Port ( USER_IN : in STD_LOGIC_VECTOR (7 downto 0);
           ADDR_IN : in STD_LOGIC_VECTOR (3 downto 0);
           OPP_IN : in STD_LOGIC_VECTOR (3 downto 0);
           --RESULT : in STD_LOGIC_VECTOR (7 downto 0);
           EXECUTE : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK : in std_logic;
           load, inc, store, mem_read, mem_write, ce, addr_sel, in_sel: out std_logic;
           opp_out : out STD_LOGIC_VECTOR (2 downto 0);
           address : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component calc_datapath is
        Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           mem_rd : in STD_LOGIC;
           mem_wr : in STD_LOGIC;
           operation : in STD_LOGIC_VECTOR (2 downto 0);
           inc : in STD_LOGIC;
           load : in STD_LOGIC;
           store_addr : in STD_LOGIC;
           addr_sel : in STD_LOGIC;
           addr_in : in STD_LOGIC_VECTOR (3 downto 0);
           addr_out : out STD_LOGIC_VECTOR (3 downto 0);
           data_bus : inout STD_LOGIC_VECTOR (7 downto 0);
           clk, ce : in STD_LOGIC;
           rst : in STD_LOGIC;
           display_sig : out std_logic_vector(7 downto 0));
end component;
    signal input_sel, Mrd, Mwr, Minc, Mload, Mstore, Maddr_sel, Mce, enter : std_logic;
    signal Maddr, Addr_mem :std_logic_vector(3 downto 0);
    signal Mopp :std_logic_vector(2 downto 0);
    signal Data_pass, display_signal: std_logic_vector(7 downto 0);
begin
B1: sync port map(clk=>Mclk, rst=>Mrst, input=>EX, output=>enter,ce => Mce);
C1: calc_datapath port map(input=>User_input, sel=>input_sel, mem_rd=>Mrd, mem_wr=>Mwr, operation=>Mopp, inc=>Minc, load=>Mload, store_addr=>Mstore, addr_sel=>Maddr_sel, addr_in=>Maddr, addr_out=>addr_mem, data_bus=>Data_pass, clk=>Mclk, rst=>Mrst, ce=>Mce);
C2: CALC_STATE port map(USER_IN=>user_input, ADDR_IN=>Address_U, OPP_IN=>opp_code, EXECUTE=>enter, RESET=>Mrst, CLK=>Mclk, inc=>Minc, load=>Mload, store=>Mstore, mem_read=>Mrd, mem_write=>Mwr, ce=>Mce, addr_sel=>Maddr_sel, in_sel=>input_sel, opp_out=>Mopp, address=>Maddr);
C3: Memory port map(Data=>data_pass, address_m=>Addr_mem, clk=>Mclk, read=>Mrd, write=>Mwr);
RESULT<=display_signal;
end Behavioral;
