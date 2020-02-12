library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Selector is
    Port ( A        : in std_logic_vector(7 downto 0);
           B        : in std_logic_vector(7 downto 0);
           C        : out std_logic_vector(7 downto 0);
           CLK, RST : in std_logic
    );
end Selector;

architecture Behavioral of Selector is
begin
    process(CLK) begin
        if(rising_edge(CLK)) then
            if(RST = '1') then
                C <= "ZZZZZZZZ";
            else
                if(B = "ZZZZZZZZ")then
                    C <= A;
                else
                    C <= B;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
