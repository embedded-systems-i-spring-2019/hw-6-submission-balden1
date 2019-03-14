----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 04:25:11 PM
-- Design Name: 
-- Module Name: EX13 - Behavioral
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

entity EX13 is
    Port ( X1, X2 : in std_logic;
           clk : in std_logic;
           Y3, Y2, Y1 : out std_logic;
           CS, RD : out std_logic);
end EX13;

architecture Behavioral of EX13 is
    type state_type is (a, b, c);
    signal CuS : state_type := a;
    signal NS : state_type := a;
begin
    sync_proc : process (clk, NS)
    begin
        if(rising_edge(clk)) then 
            CuS <= NS;
        end if;
    end process;
    
    comb_proc : process (CuS, X1, X2)
    begin
        case CuS is
            when a =>
                if (X1 = '0') then CS <= '1'; RD <= '0';
                    NS <= c;
                elsif (X1 = '1') then CS <= '0'; RD <= '1';
                    NS <= b;
                else
                    NS <= CuS;
                end if;
                    Y3 <= '0'; Y2 <= '0'; Y1 <= '1';
            when b => CS <= '1'; RD <= '1';
                NS <= c;   
                    Y3 <= '0'; Y2 <= '1'; Y1 <= '0';
            when c =>
                if ( X2 = '0') then CS <= '0'; RD <= '0';
                    NS <= a;
                elsif (X2 = '1') then CS <= '0'; RD <= '1';
                else
                    NS <= CuS;
                end if;
                    Y3 <= '1'; Y2 <= '0'; Y1 <= '0';
            when others =>
                NS <= CuS;
        end case;
   end process;
                    
end Behavioral;
