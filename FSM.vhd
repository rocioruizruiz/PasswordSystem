library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity FSM is
    port( CLK, RST, CHECK, WRITE : in  std_logic;
          OK: in std_logic;
          BOMB : out std_logic;
          DATA: in std_logic_vector(7 downto 0);
          DATA_IN: out std_logic_vector(7 downto 0);
          R_ROM, R_RAM, W_RAM : out std_logic
    );
end FSM;

architecture Structural of FSM is
    -- Define FSM States
    type state_type is (S0, S1, S2, S3, S4, S5);
    signal currentState, nextState : state_type;   
    signal top : integer := 0;
    -- Define intern signals
    
begin
        -- State Change Process
    process(CLK, RST)
    begin
        if (rising_edge(CLK)) then
            if (RST = '1') then
                currentState <= S0;
            else
                currentState <= nextState;
            end if;
        end if;
    end process;

    -- FSM Process
    process(currentState,CHECK, WRITE, OK)
    begin
        case currentState is
            -- Transfer Data Content from ROM to RAM 
            when S0 =>

                R_ROM <= '1'; W_RAM <= '1'; R_RAM <= '0';
                BOMB <= '0';
                DATA_IN <= "ZZZZZZZZ";
                top <= top + 1;
                if(top < 2)then
                    nextState <= S0;
                else
                    nextState <= S1;
                    top <= 0;
                end if;
            when S1 =>
            if(OK = '1') then
                nextState <= S5;
            else
                if(CHECK = '1' and WRITE = '0') then
                    R_RAM <= '1'; W_RAM <= '0'; R_ROM <= '0';
                    DATA_IN <= DATA;
                    if(OK = '1') then
                        nextState <= S5;
                    else
                        nextState <= S2;
                    end if;
                elsif(WRITE = '1' and CHECK = '0') then
                    R_RAM <= '0'; W_RAM <= '1'; R_ROM <= '0';
                    nextState <= S1;
                else
                    nextState <= S1;
                end if;
            end if;    
            when S2 =>
                if(OK = '1') then
                        nextState <= S5;
                else
                    if(WRITE = '0') then  
                        if(CHECK = '1' )then
                            R_RAM <= '1'; W_RAM <= '0'; R_ROM <= '0';
                            DATA_IN <= DATA;
                            if(OK = '1') then
                                nextState <= S5;
                            else
                                nextState <= S3;
                            end if;
                        end if;
                    end if;
                end if;
            when S3 =>
            if(OK = '1') then
                        nextState <= S5;
            else
                if(WRITE = '0') then  
                    if(CHECK = '1' )then
                        R_RAM <= '1'; W_RAM <= '0'; R_ROM <= '0';
                        DATA_IN <= DATA;
                        if(OK = '1') then
                            nextState <= S5;
                        else
                            nextState <= S4;
                        end if;
                    end if;
                end if;
            end if;
            when S4 =>
            if(OK = '1') then
                        nextState <= S5;
            else
                if(WRITE = '0') then  
                    if(CHECK = '1' )then
                        R_RAM <= '1'; W_RAM <= '0'; R_ROM <= '0';
                        DATA_IN <= DATA;
                        nextState <= S5;
                    end if;
                end if;
            end if;
            when S5 =>
            -- Check
                BOMB <= '1';
                report "Sanity check : OK = " & std_logic'image(OK);
                R_RAM <= '0'; W_RAM <= '0'; R_ROM <= '0';
                DATA_IN <= "ZZZZZZZZ";
                nextState <= S5;
            when others =>
                nextState <= S0;
        end case;
     end process;
end Structural;
