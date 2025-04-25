library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity I2C is
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
end I2C;

architecture Behavioral of I2C is

type states is (idle, strt_con, adrs0, adrs1, ackp0, ackp1, wr0, wr1, rd0, rd1, acko0, acko1, acki0, acki1, noack0, noack1, stp_con);  
signal i2c_state: states;

signal sd_int: std_logic;
signal rw_mux: bit;
signal bit_count: integer;  
signal count_down: integer;
signal rd_flg: std_logic;

constant ndx_count: integer := 8;
constant full_samp: integer := 16;
constant clk_rate: integer := 1000;
constant half_clk_rate: integer := 500;

begin
pull: pullup port map( O => sd_i2c);
sd_i2c <= 'Z' when rw_mux = '1' else sd_int;
rdy <= '1' when (i2c_state = acko1 AND rd_flg = '1') OR i2c_state = noack1 else '0';
process(clk)
begin
    if rising_edge (clk) then
   
        if i2c_state = ackp0 or i2c_state = ackp1 or i2c_state = rd0 or i2c_state = rd1 then
            rw_mux <= '1';
        else
            rw_mux <= '0';
        end if;
       
    end if;
end process;


process(clk,rst)
begin

    if rst = '1' then
        i2c_state <= idle;
        i2c_clk <= '1';
        sd_int <= '1';
--        rdy <= '0';
    elsif rising_edge (clk) then
   
        case i2c_state is
---------------------------------------------------------------------------        
            when idle =>
                i2c_clk <= '1';
                sd_int <= '1'  ;
--                rdy <= '0';    
                if strt = '1' then
                    i2c_state <= strt_con;
                    count_down <= half_clk_rate;
                else
                    i2c_state <= idle;
                end if;
---------------------------------------------------------------------------                        
            when strt_con =>
                i2c_clk <= '1';  
                sd_int <= '0';
                if count_down = 0 then
               
                    i2c_state <= adrs0;
                    bit_count <= ndx_count - 1;
                    count_down <= clk_rate;
                else
                    count_down <= count_down - 1;
                    i2c_state <= strt_con;
                end if;
               
---------------------------------------------------------------------------        
            when adrs0 =>
                i2c_clk <= '0';
                sd_int <= adrs_in(bit_count);  
               
                if count_down = 0 then                  
                    count_down <= clk_rate;
                    i2c_state <= adrs1;         
                else
                    count_down <= count_down - 1;
                    i2c_state <= adrs0;
                end if;
                       
---------------------------------------------------------------------------        
            when adrs1 =>
                i2c_clk <= '1';
                         
                if count_down = 0 then
               
                    count_down <= clk_rate;  
                   
                    if bit_count = 0 then
                      i2c_state <= ackp0  ;                        
                    else
                        bit_count <= bit_count - 1 ;
                        i2c_state <= adrs0;
                    end if;
                   
--                    i2c_state <= adrs0;              
                else
                    count_down <= count_down - 1;
                    i2c_state <= adrs1;
                end if;            
---------------------------------------------------------------------------        
            when ackp0 =>                            
                i2c_clk <= '0';                      
                if count_down = 0 then
                    count_down <= clk_rate;
                    i2c_state <= ackp1;
                else
                    count_down <= count_down - 1;
                    i2c_state <= ackp0;
                end if;
 ---------------------------------------------------------------------------        
            when ackp1 =>
                i2c_clk <= '1';                
                if count_down = 0 then
                    count_down <= clk_rate;
                    bit_count <= full_samp - 1;
                   
                    if adrs_in(0) = '1' then
                        i2c_state <= rd0;
                        rd_flg <= '0';
                    elsif adrs_in(0) = '0' then
                        i2c_state <= rd0;           -- change to write when ready to implement
                        rd_flg <= '0';
                    end if;
                else
                    count_down <= count_down - 1;
                    i2c_state <= ackp1;
                end if;
 ---------------------------------------------------------------------------         
            when rd0 =>
                i2c_clk <= '0';
                pdata_out(bit_count) <= sd_i2c;
                 
                if count_down = 0 then
                    count_down <= clk_rate;
                    i2c_state <= rd1;
                else
                    count_down <= count_down - 1;
                    i2c_state <= rd0;
                end if;
                                 
 ---------------------------------------------------------------------------        
            when rd1 =>
                i2c_clk <= '1';
                                 
                if count_down = 0 then
                    count_down <= clk_rate;
                    --i2c_state <= acko0;
                    if bit_count = 8 then
                        i2c_state <= acko0;
                        bit_count <= bit_count - 1;
                    elsif bit_count = 0 then

                          if more_samp = '1' then
                                i2c_state <= acko0;
                                rd_flg <= '1';
                            elsif more_samp = '0' then
                                i2c_state <= noack0;
                            end if;
                             
                    else    
                        i2c_state <= rd0;
                        bit_count <= bit_count - 1;
                    end if;
                else
                    count_down <= count_down - 1;
                    i2c_state <= rd1;
                end if;  
 ---------------------------------------------------------------------------        
            when acko0 =>
                i2c_clk <= '0';
                sd_int <= '0';
               
                if count_down = 0 then
                    count_down <= clk_rate;
                    i2c_state <= acko1;
                   
--                    if bit_count = 0 then
--                        rd_flg <= '1';
--                    end if;
                   
                else
                    count_down <= count_down - 1;
                    i2c_state <= acko0;
                end if;
  ---------------------------------------------------------------------------        
            when acko1 =>
                i2c_clk <= '1';
                sd_int <= '0';  
                if count_down = 0 then
                    count_down <= clk_rate;
                   
                    if bit_count = 0 then
                        rd_flg <= '0';
                        bit_count <= full_samp - 1;
                    else
                        rd_flg <= '0';
                    end if;                  
                    i2c_state <= rd0;
                   
                else
                    count_down <= count_down - 1;
                    i2c_state <= acko1;
                end if;
  ---------------------------------------------------------------------------        
            when noack0 =>
                i2c_clk <= '0';
                sd_int <= '1';                      
                if count_down = 0 then
                    count_down <= clk_rate;
                    i2c_state <= noack1;
                else
                    count_down <= count_down - 1;
                    i2c_state <= noack0;
                end if;                                              
  ---------------------------------------------------------------------------      
            when noack1 =>
                i2c_clk <= '1';                
                sd_int <= '1';                      
                if count_down = 0 then
--                    count_down <= clk_rate;
                    i2c_state <= stp_con;
                    sd_int <= '0';
                else
                    count_down <= count_down - 1;
                    i2c_state <= noack1;
                end if;
   ---------------------------------------------------------------------------      
            when stp_con =>
                i2c_clk <= '1';
                sd_int <= '1';
                 if count_down = 0 then         -- might not need to count down
                    i2c_state <= idle;
                 else
                    count_down <= count_down - 1;
                    i2c_state <= stp_con;
                 end if;
--------------------------------------------------------------------------------
              when others =>
                i2c_state <= idle;  
                                                                   
        end case;
    end if;
end process;
end Behavioral;

