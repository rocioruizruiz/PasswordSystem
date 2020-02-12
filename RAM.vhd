-- **********************************************
-- RAM.vhd : RAM Component
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
entity RAM is
    port( CLK    : in  std_logic;                        -- Clock
          RST    : in  std_logic;                        -- Reset
          Read   : in  std_logic;                        -- Read
          Write  : in  std_logic;                        -- Write
      	  Addr   : in  std_logic_vector(0 downto 0);     -- Address (1 bits)
      	  D_in   : in  std_logic_vector(7 downto 0);     -- Data In (8 bits)
      	  D_out  : out std_logic_vector(7 downto 0)      -- Data Out (8 bits)
    );
end RAM;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of RAM is
    -- Define RAM Content
    type RAM_Array is array (0 to 0) of std_logic_vector(7 downto 0);
    signal RAM_content : RAM_Array;
begin
    -- RAM Process
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            if(RST = '1') then
                D_out <= "ZZZZZZZZ";
            else
                -- Write Data
                if (Write = '1'  and read = '0') then
                    RAM_content(conv_integer(Addr)) <= D_in;
                    D_out <= "ZZZZZZZZ";
                -- Read Data
                elsif (Read = '1' and write = '0' ) then
                    D_out <= RAM_content(conv_integer(Addr));
                else
                    D_out <= "ZZZZZZZZ";
                end if;
           end if;
        end if;
    end process;
end Behavior;
