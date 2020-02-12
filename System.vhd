library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System is
    Port ( CLK, RST, W, C : in std_logic;
          DATA     : in std_logic_vector(7 downto 0);
          OK       : out std_logic;
          BOMB     : out std_logic
          );
end System;

architecture Structural of System is
-- Define components
    component FSM is
        port( CLK, RST, CHECK, WRITE : in  std_logic;
              OK: in std_logic;
              BOMB: out std_logic;
              DATA: in std_logic_vector(7 downto 0);
              DATA_IN: out std_logic_vector(7 downto 0);
              R_ROM, R_RAM, W_RAM : out std_logic
        );
    end component;
        component MemSys is
            port( CLK, RST, R_ROM, R_RAM, W_RAM : in  std_logic;
              DATA_IN: in std_logic_vector(7 downto 0);
              OK: out std_logic
        );
    end component;
     -- Define signals
     signal CHECK_OUT, R_ROM, R_RAM, W_RAM, OK_AUX : std_logic;
     signal DATA_IN : std_logic_vector(7 downto 0); 
begin
   MyMemSys : MemSys port map(CLK=>CLK, RST=>RST,
                              R_ROM => R_ROM, R_RAM=>R_RAM, W_RAM=>W_RAM,
                              DATA_IN=>DATA_IN, OK=>OK_AUX
                              );
   MyFSM   : FSM    port map(CLK=>CLK, RST=>RST, CHECK=>C,
                              WRITE=>W, OK=>OK_AUX, BOMB=>BOMB, DATA=>DATA, 
                              DATA_IN => DATA_IN,
                              R_ROM => R_ROM, R_RAM=>R_RAM, W_RAM=>W_RAM);
   
   OK <= OK_AUX;
end Structural;
