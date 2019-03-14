----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 02:02:11 AM
-- Design Name: 
-- Module Name: EX4 - Behavioral
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

entity EX4 is
    Port ( X1, X2 : in std_logic;
           clk, INIT : in std_logic;
           Z1, Z2 : out std_logic);
end EX4;

architecture Behavioral of EX4 is
    type state_type is (a, b, c);
    signal CS : state_type := a;
    signal NS : state_type := a;
begin

    sync_proc : process ( clk, NS, INIT )
    begin
        if (INIT = '1') then CS <=a;
        elsif (rising_edge(clk)) then CS <= NS;
        end if;
    end process;
    
    comb_proc : process ( CS, X1, X2 )
    begin
        case CS is
            when a => Z1 <= '0';
                if (X1 = '0') then Z2 <= '0'; 
                    NS <= c;
                elsif (X1 = '1') then Z2 <= '1';
                    NS <= b;
                else
                    NS <= a;
                end if;
            when b => Z1 <= '1';
                if (X2 = '1') then Z2 <= '0';
                    NS <= a;
                elsif (X2 = '0') then Z2 <= '1';
                    NS <= c;
                else
                    NS <= b;
                end if;
            when c => Z1 <= '1';
                if (X1 = '0') then Z2 <= '1';
                    NS <=a;
                elsif (X1 = '1') then Z2 <= '1';
                    NS <= b;
                else
                    NS <= c;
                end if;
            when others => NS <= CS;
        end case;
     end process;
end Behavioral;
