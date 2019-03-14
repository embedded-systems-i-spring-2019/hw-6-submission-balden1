----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2019 11:14:36 PM
-- Design Name: 
-- Module Name: EX2 - Behavioral
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

entity EX2 is
    Port ( X1, X2 : in std_logic;
           clk : in std_logic;
           Y1, Y0 : out std_logic;
           Z : out std_logic);
end EX2;

architecture Behavioral of EX2 is
    type state_type is (a, b, c);  -- Three states: state a, state b, state c
    signal CS, NS : state_type;  --CS = Current-State, NS = Next-State
begin
    sync_proc : process (clk, NS)  -- Synchronous process which transitions NS to CS on rising edge of clk.
    begin                          -- This synchronous process functions just like a DFF where NS, and CS = D, Q.
        if (rising_edge(clk)) then
            CS <= NS;
        end if;
    end process;
    
    comb_proc : process ( CS, X1, X2)
    begin 
        case CS is
            when a => Y1 <= '1'; Y0 <= '0';
                if (X1 = '0') then Z <= '0';
                    NS <= a;
                elsif (X1 = '1') then Z <= '0';
                    NS <= c;
                else
                    NS <= a;
                end if;
            when b => Y1 <= '1'; Y0 <= '1'; 
                if (X2 = '1') then Z <= '0';
                    NS <= b;
                elsif (X2 = '0') then Z <= '1';
                    NS <= a;
                else 
                    NS <= b;
                end if;
            when c => Y1 <= '0'; Y0 <= '1';
                if (X2 = '0') then Z <= '1';
                    NS <= a;
                elsif (X2 = '1') then Z <= '0';
                    NS <= b;
                else
                    NS <= c;
                end if;
            when others =>
                NS <= CS;
        end case;
    end process;    
end Behavioral;
