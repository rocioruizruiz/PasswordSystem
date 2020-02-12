-- **********************************************
-- ROM.vhd : ROM Component
--
-- Prof. Luis A. Aranda
--
-- Universidad Nebrija
-- Curso 2019/2020
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;                        -- Contains 'conv_integer' Function

-- **********************************************
-- ENTITY
-- **********************************************
entity ROM is
    port( CLK, RST   : in  std_logic;                        -- Clock
          Read  : in  std_logic;                        -- Read
      	  Addr  : in  std_logic_vector(0 downto 0);     -- Address (1 bit)
      	  D_out : out std_logic_vector(7 downto 0)      -- Data Out (8 bits)
    );
end ROM;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of ROM is
    -- Define ROM Content
    type ROM_Array is array (0 to 0) of std_logic_vector(7 downto 0);
    constant ROM_content : ROM_Array := (
        0 => X"EE",                        -- ROM Content at location OH
        others => X"00"
    );
begin
    -- ROM Process
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            if(RST = '1') then
                D_out <= "ZZZZZZZZ";
            else
            -- Read Data
                if (Read = '1') then
                    D_out <= ROM_content(conv_integer(Addr));
                else
                    D_out <= "ZZZZZZZZ";
                end if;
            end if;
        end if;
    end process;
end Behavior;
