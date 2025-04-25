----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2022 09:50:23 AM
-- Design Name: 
-- Module Name: big door - Behavioral
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity big_door is
  Port (button, clk, rst, inci, sensor_1 : in std_logic;
        position : out std_logic_vector(9 downto 0);
        current_state : out std_logic_vector(3 downto 0));
        --err : out std_logic 
        
end big_door;

architecture Behavioral of big_door is
component garage_door is
 Port (motor_up, motor_down, clk : in std_logic;
        sensor_up, sensor_down, err : out std_logic;
         position_out : out integer);
end component;
component garagecontroller is
    Port (motor_up, motor_down : out std_logic; 
          curr_state : out std_logic_vector(3 downto 0);
          sensor, button, up, down, clk, rst : in std_logic);
end component;
component Clock is
  Port (clk, rst : in std_logic := '0';
        inc : in std_logic; 
        clk_out : out std_logic );
end component;
component sync is
    Port ( clk : in STD_LOGIC;
           input, rst : in STD_LOGIC;
           output : out STD_LOGIC);
end component;
component Encoder is
  Port (pos : in integer;
  out_out : out std_logic_vector(9 downto 0) );
end component;
    signal btn, master_clk, tr_sensor, motor_d, motor_u, s_d, s_u : std_logic;
    signal pos_sig : integer;
    --signal final_output : std_logic_vector(9 downto 0);
    signal error : std_logic;
begin
    CTR: garagecontroller port map(motor_up=>motor_u, motor_down=>motor_d, sensor=>sensor_1, button=>btn, up=>s_u, down=>s_d ,rst=>rst, clk=>clk, curr_state=>current_state);
    GD: garage_door port map( motor_up=> motor_u, motor_down=>motor_d, clk=>master_clk, sensor_up=>s_u, sensor_down=>s_d, err=>error, position_out=>pos_sig); 
    sy: sync port map(clk=>clk, input=>button, rst=>rst, output=>btn);
    MC: Clock port map(clk=>clk, rst=>rst, inc=>inci, clk_out => master_clk);  
    EN: Encoder port map( pos=>pos_sig, out_out=>position);
    --err <= error ;
end Behavioral;
