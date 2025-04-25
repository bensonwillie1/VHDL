----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2022 12:44:17 PM
-- Design Name: 
-- Module Name: CALC_STATE - Behavioral
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

entity CALC_STATE is
    Port ( USER_IN : in STD_LOGIC_VECTOR (7 downto 0);
           ADDR_IN : in STD_LOGIC_VECTOR (3 downto 0);
           OPP_IN : in STD_LOGIC_VECTOR (3 downto 0);
           --RESULT : in STD_LOGIC_VECTOR (7 downto 0);
           EXECUTE : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK : in std_logic;
           load, inc, store, mem_read, mem_write, ce, addr_sel, in_sel : out std_logic;
           opp_out : out STD_LOGIC_VECTOR (2 downto 0);
           address : out STD_LOGIC_VECTOR (3 downto 0));
           
end CALC_STATE;

architecture Behavioral of CALC_STATE is
    type STATE_TYPE is (IDLE, LOAD_MEM, SAVE_MEM, A_MEM, S_MEM, M_MEM, LOAD_USER, A_USER, S_USER, M_USER);
    signal NS: STATE_TYPE;
    
begin
process(CLK, RESET)
begin
    ce<= '1';
    if RESET = '1' then
        NS <= IDLE;
    elsif falling_edge(clk) then
        case NS is
            when IDLE => 
                if EXECUTE = '1' and OPP_IN = "0001" then
                    NS <= LOAD_MEM;
                elsif EXECUTE = '1' and OPP_IN = "0010" then
                    NS <= SAVE_MEM;
                elsif EXECUTE = '1' and OPP_IN = "0011" then
                    NS <= A_MEM;
                elsif EXECUTE = '1' and OPP_IN = "0100" then
                    NS <= S_MEM;
                elsif EXECUTE = '1' and OPP_IN = "0101" then
                    NS <= M_MEM;
                elsif EXECUTE = '1' and OPP_IN = "1000" then
                    NS <= LOAD_USER;
                elsif EXECUTE = '1' and OPP_IN = "1011" then
                    NS <= A_USER;
                elsif EXECUTE = '1' and OPP_IN = "1100" then
                    NS <= S_USER;
                elsif EXECUTE = '1' and OPP_IN = "0101" then
                    NS <= M_USER;
                end if;  
            When LOAD_MEM =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '1';
                mem_read <= '1';
                mem_write <= '0';
                opp_out <= "011";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '1';
                NS <= IDLE; 
                
            When SAVE_MEM =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '1';
                mem_read <= '0';
                mem_write <= '1';
                opp_out <= "011";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '0';
                NS <= IDLE; 
                
            WHEN A_MEM =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '0';
                mem_read <= '1';
                mem_write <= '0';
                opp_out <= "000";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '1';
                NS <= IDLE; 
                
            when S_MEM =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '0';
                mem_read <= '1';
                mem_write <= '0';
                opp_out <= "001";
                ce <= '1';
                addr_sel <= '1';
                in_sel <= '1';
                NS <= IDLE; 
                
            when M_MEM =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '0';
                mem_read <= '1';
                mem_write <= '0';
                opp_out <= "010";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '1';
                NS <= IDLE; 
                
            when LOAD_USER =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '1';
                mem_read <= '0';
                mem_write <= '0';
                opp_out <= "011";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '0';
                NS <= IDLE; 
                
            when A_USER =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '1';
                mem_read <= '1';
                mem_write <= '0';
                opp_out <= "000";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '0';
                NS <= IDLE; 
                
            WHEN S_USER =>  
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '1';
                mem_read <= '1';
                mem_write <= '0';
                opp_out <= "001";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '0';
                NS <= IDLE; 
                
            when M_USER =>
                address <= ADDR_IN;
                load <= '1';
                inc <=  '1';
                store <= '1';
                mem_read <= '1';
                mem_write <= '0';
                opp_out <= "010";
                ce <= '1';
                addr_sel <= '0';
                in_sel <= '0';
                NS <= IDLE; 
                
        end case;
    end if;
end process;    
end Behavioral;
