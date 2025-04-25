library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity I2C_master_ctrl is
  Port (clk: in std_logic;
        rst: in std_logic;
        start: in std_logic;
        more_samp: in std_logic;
        sd_i2c: inout std_logic;
        i2c_clk: out std_logic;
        pdata_ctrl: out std_logic_vector(5 downto 0)) ;
end I2C_master_ctrl;

architecture Behavioral of I2C_master_ctrl is

component  I2C is
  Port (clk: in std_logic;
        rst: in std_logic;
        strt: in std_logic;
        more_samp: in std_logic;
        adrs_in: in std_logic_vector(7 downto 0);
        config_in: in std_logic_vector (7 downto 0);
        pdata_out: out std_logic_vector(15 downto 0);
        rdy: out std_logic;
        i2c_clk: out std_logic;
        sd_i2c: inout std_logic );
end component ;

signal adrs: std_logic_vector(7 downto 0);
signal config: std_logic_vector(7 downto 0);
signal pdata_o: std_logic_vector(15 downto 0);
signal ready: std_logic;
signal pdata_ctrl_int: std_logic_vector(15 downto 0);
signal clk_inv: std_logic;

begin

clk_inv <= NOT clk;

i2c_mod: I2C port map( clk=>clk,
                        rst=>rst,
                        strt => start,
                        more_samp => more_samp,
                        adrs_in => adrs,
                        config_in => config,
                        pdata_out => pdata_o,
                        rdy => ready,
                        i2c_clk => i2c_clk,
                        sd_i2c => sd_i2c);

pdata_ctrl <= pdata_ctrl_int(11 downto 6);

adrs <= "01010001";


process(clk)
begin
    if falling_edge(clk) then
        if ready = '1' then
            pdata_ctrl_int <= pdata_o;
        else
            pdata_ctrl_int <= pdata_ctrl_int;
        end if;
    end if;
end process;          




end Behavioral;