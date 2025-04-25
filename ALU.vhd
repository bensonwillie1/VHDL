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

entity ALU is
    Port (A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        C : in std_logic;
        sel : in std_logic_vector(2 downto 0);
        R_out : out std_logic_vector(8 downto 0));
end ALU;

architecture Behavioral of ALU is
component add8 is
  		Port (A, B : in std_logic_vector(7 downto 0);
			C : in std_logic;
			S : out std_logic_vector(7 downto 0);
       		Cout: out std_logic );
end component;
component add8nc is
    Port (A, B : in std_logic_vector(7 downto 0);
			C : in std_logic;
			S : out std_logic_vector(7 downto 0);
       		Cout: out std_logic );
end component;
component exor is
  port ( 
    A, B: in std_logic_vector(7 downto 0);
    C : in std_logic;
    X_out : out std_logic_vector(8 downto 0)
    );
end component exor;
component HOLD is
  port ( A: in std_logic_vector(7 downto 0);
         C: in std_logic;
         A_out : out std_logic_vector(8 downto 0));
end component;
component Load is
  port ( 
    B: in std_logic_vector(7 downto 0);
    C: in std_logic;
    B_out : out std_logic_vector(8 downto 0));
end component;
component mux is
  port ( 
    A, B, C, D, E: in std_logic_vector(8 downto 0);
    Sel : in std_logic_vector(2 downto 0);
    R : out std_logic_vector(8 downto 0));
end component;
signal Ain, Bin : std_logic_vector(7 downto 0);
signal S_1, S_2 : std_logic_vector(7 downto 0);
signal SC_1, SC_2, SC_3, SC_4, SC_5, S_4, S_5, S_3 : std_logic_vector(8 downto 0);
signal sel_sig : std_logic_vector(2 downto 0);
signal Ci_sig : std_logic;
signal C0,C1,C2,C3,C4,Cin : std_logic;
--signals go here

begin 
Ain <= A;
Bin <= B;
sel_sig <= sel;
ci_sig <= c;
Cin <= C;
FA0: add8 port map (A=>Ain(7 downto 0), B=>Bin(7 downto 0), C=>Cin, Cout=>C0, S=>S_1);
FA1: add8nc port map (A=>Ain(7 downto 0), B=>Bin(7 downto 0), C=>Cin, Cout=>C1, S=>S_2);
SC_1 <= C0&S_1;
SC_2 <= C1&S_2;
FA2: exor port map (A=>Ain(7 downto 0), B=>Bin(7 downto 0), C=>C, X_out=>S_3);
FA3: HOLD port map (A=>Ain(7 downto 0), C=>C, A_out=>S_4);
FA4: load port map (B=>Bin(7 downto 0), C=>C, B_out=>S_5);
SC_3 <=S_3;
SC_4 <= S_4;
SC_5 <= S_5;
FA5: mux port map (A=>SC_1, B=>SC_2, C=>SC_3, D=>SC_4, E=>SC_5, Sel=>sel_sig, R=>R_out);

end Behavioral;
