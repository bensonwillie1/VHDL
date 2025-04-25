
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity garagecontroller is
    Port (motor_up, motor_down : out std_logic;
          curr_state : out std_logic_vector(3 downto 0); 
          sensor, button, clk, rst : in std_logic;
          up, down : in std_logic);
end garagecontroller;

architecture Behavioral of garagecontroller is
    type STATE_TYPE is (RU, RD, GU, GD);
    signal CS, NS: STATE_TYPE;
begin
process(clk, rst)
begin
    if rst = '1' then
        NS <= RU;    
    elsif rising_edge(clk) then
        case NS is
            when RU =>
            curr_state <= "0001";
            motor_up <= '0';
            motor_down <= '0';
            if button = '1' and sensor = '0' and down = '1' then
                NS <= GU;
            elsif button = '0' then
                NS <= RU;
            elsif button = '1' and down = '0' and up = '0' then
                NS <= GU;
            else
                NS <= RU;
            end if;
            
            when RD =>
            curr_state <= "0010";
            motor_up <= '0';
            motor_down <= '0';
            if button = '1' and sensor = '0' and up = '1' then
                NS <= GD;
            elsif button = '0' then
                NS <= RD;
            elsif button = '1' and down = '0' and up = '0' then
                NS <= GD;
            else 
                NS <= RD;
            end if;
            
            when GU =>
            curr_state <= "0100";
            motor_up <= '1';
            motor_down <= '0';
            if button = '1' or  up = '1' then
                NS <= RD;
            elsif button = '0' and sensor = '0' then
                NS <= GU;
            elsif sensor = '1' then
                NS <= GU;
            else
                NS <= GU;
            end if;
            
            when GD =>
            curr_state <= "1000";
            motor_down <= '1';
            motor_up <= '0';
            if button = '1' or down = '1' then
                NS <= RU;
            elsif button = '0' and sensor = '0' then
                NS <= GD;
            elsif sensor = '1' then
                NS <= GU;
            else          
                NS <= GU;
            end if;          
        end case;
     end if;


end process;

end Behavioral;
