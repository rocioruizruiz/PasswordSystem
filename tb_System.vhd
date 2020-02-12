library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_System is
end tb_System;

architecture Behavioral of tb_System is
    component System is
        Port ( CLK, RST, W, C : in std_logic;
          DATA     : in std_logic_vector(7 downto 0);
          OK       : out std_logic
          );
    end component;
    signal CLK, RST, W, C, OK : std_logic;
    signal DATA  : std_logic_vector(7 downto 0);
begin
    MySystem: System port map(CLK=>CLK, RST=>RST, W=>W,
                              C=>C, DATA=>DATA, OK=>OK);
   process begin
        CLK <= '1'; wait for 10 ns;
        CLK <= '0'; wait for 10 ns;
    end process;
    process begin
        RST <= '0'; wait;
    end process;
    process begin
        C <= '0'; wait for 220 ns;
        C <= '1'; wait for 40 ns;
        C <= '0'; wait for 80 ns;
        C <= '1'; wait for 18 ns;
        C <= '0'; wait for 80 ns;
        C <= '1'; wait for 18 ns;
        C <= '0'; wait for 80 ns;
        C <= '1'; wait for 18 ns;
        C <= '0'; wait for 80 ns;
        C <= '1'; wait for 18 ns;
        C <= '0'; wait for 80 ns;
       
        

    end process;
    process begin
        W <= '0'; wait;
    end process;
    process begin
        DATA <= "ZZZZZZZZ"; wait for 100ns;
        DATA <= X"EE"; wait for 100 ns;
        DATA <= X"BB"; wait;
    end process; 
end Behavioral;
