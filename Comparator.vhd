library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Comparator is
    Port ( A, B : in std_logic_vector(7 downto 0);
          C : out std_logic;
          CLK, RST : in std_logic
    );
end Comparator;

architecture Behavioral of Comparator is

begin
    process(CLK) begin
        if(rising_edge(CLK)) then
            if(RST = '1') then
                C <= '0';
            else
                if(A = B) then
                    if (A = "ZZZZZZZZ" or B = "ZZZZZZZZ") then
                        C <= '0';
                    else
                        C <= '1';
                    end if;
                else
                    C <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
