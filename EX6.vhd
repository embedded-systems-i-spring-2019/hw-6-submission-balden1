----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 02:22:38 AM
-- Design Name: 
-- Module Name: EX6 - Behavioral
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

entity EX6 is
    Port ( X : in std_logic;
           Z2 : out std_logic;
           clk : in std_logic;
           Z1 : out std_logic;
           State : out std_logic_vector (1 downto 0));
end EX6;

architecture Behavioral of EX6 is
    type state_type is (A, B, C, D);
    signal CS, NS : state_type;
begin

    with CS select                -- Output State, either A, B, C, or D.
        State <= "00" when A,
                 "01" when B,
                 "10" when C,
                 "11" when D,
                 "00" when others;
              
    with CS select                -- Output corresponding Z1 value for each state
        Z1 <= '1' when A,
              '0' when B,
              '1' when C,
              '0' when D,
              '0' when others;
              
    sync_proc : process (clk, NS)  --synchronous process
    begin 
        if (rising_edge(clk)) then 
            CS <= NS;
        end if;
    end process;
    
    comb_proc : process (CS, X)  --combo process
    begin 
        case CS is 
            when A => 
                if (X = '1') then Z2 <='0';
                    NS <= A;
                elsif (X = '0') then Z2 <= '0';
                    NS <= C;
                end if;
            when B =>
                if (X = '1') then Z2 <= '0';
                    NS <= B;
                elsif (X = '0') then Z2 <= '0';
                    NS <= D;
                end if;
            when C =>
                if (X = '1') then Z2 <= '0';
                    NS <= A;
                elsif (X = '0') then Z2 <= '0';
                    NS <= B;
                end if;
            when D =>
                if (X = '1') then Z2 <= '0';
                    NS <= B;
                elsif (X = '0') then Z2 <= '1';
                    NS <= A;
                end if;
            when others => NS <= CS;
        end case;
     end process;   
        
                     
end Behavioral;
