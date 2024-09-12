-- VHDL Entity my_project_lib.project.symbol
--
-- Created:
--          by - Owner.UNKNOWN (DESKTOP-BED4071)
--          at - 20:06:56 01/11/2023
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2007.1 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY project IS
   PORT( 
      clk      : IN     std_logic;
      rst      : IN     std_logic;
      change   : OUT    integer RANGE 50 DOWNTO 0 := 0;
      chosen   : OUT    integer RANGE 50 DOWNTO 0;
      y        : OUT    std_logic;
      money    : INOUT  integer RANGE 50 DOWNTO 0;
      moneyTmp : INOUT  integer RANGE 50 DOWNTO 0;
      msg      : INOUT  string ( 11 DOWNTO 1 );
      price    : INOUT  integer RANGE 50 DOWNTO 1;
      sel      : INOUT  integer RANGE 3 DOWNTO 0;
      stcash   : INOUT  integer RANGE 50 DOWNTO 0 := 50;
      stock1   : INOUT  integer RANGE 50 DOWNTO 0 := 50;
      stock2   : INOUT  integer RANGE 50 DOWNTO 0 := 50;
      stock3   : INOUT  integer RANGE 50 DOWNTO 0 := 50;
      zero     : INOUT  integer RANGE 50 DOWNTO 0 := 0
   );

-- Declarations

END project ;

--
-- VHDL Architecture my_project_lib.project.fsm
--
-- Created:
--          by - Owner.UNKNOWN (DESKTOP-BED4071)
--          at - 20:06:56 01/11/2023
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2007.1 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
 
ARCHITECTURE fsm OF project IS

   TYPE STATE_TYPE IS (
      Start,
      X1,
      X2,
      X5,
      process_1,
      process_2,
      process_3,
      s0,
      s1,
      s2
   );
 
   -- Declare current and next state signals
   SIGNAL current_state : STATE_TYPE;
   SIGNAL next_state : STATE_TYPE;

   -- Declare any pre-registered internal signals
   SIGNAL money_cld : integer RANGE 50 DOWNTO 0;
   SIGNAL moneyTmp_cld : integer RANGE 50 DOWNTO 0;
   SIGNAL stock1_cld : integer RANGE 50 DOWNTO 0;
   SIGNAL stock2_cld : integer RANGE 50 DOWNTO 0;
   SIGNAL stock3_cld : integer RANGE 50 DOWNTO 0;

BEGIN

   -----------------------------------------------------------------
   clocked_proc : PROCESS ( 
      clk,
      rst
   )
   -----------------------------------------------------------------
   BEGIN
      IF (rst = '0') THEN
         current_state <= Start;
      ELSIF (clk'EVENT AND clk = '1') THEN
         current_state <= next_state;

         -- Combined Actions
         CASE current_state IS
            WHEN process_1 => 
               IF (money_cld  > price) THEN 
                  stock1_cld <= stock1_cld - 1;
               ELSIF (money_cld = price) THEN 
                  stock1_cld <= stock1_cld - 1;
               ELSIF (money_cld < price) THEN 
                  moneyTmp_cld <= money_cld;
                  money_cld <= 0 ;
               END IF;
            WHEN process_2 => 
               IF (money_cld > price) THEN 
                  stock2_cld <= stock2_cld - 1;
               ELSIF (money_cld = price) THEN 
                  stock2_cld <= stock2_cld - 1;
               ELSIF (money_cld < price) THEN 
                  moneyTmp_cld <= money_cld;
                  money_cld <= 0;
               END IF;
            WHEN process_3 => 
               IF (money_cld > price) THEN 
                  stock3_cld <= stock3_cld - 1;
               ELSIF (money_cld = price) THEN 
                  stock3_cld <= stock3_cld - 1;
               ELSIF (money_cld < price) THEN 
                  moneyTmp_cld <= money_cld;
                  money_cld <=zero;
               END IF;
            WHEN s0 => 
               IF (moneyTmp_cld >=  price) THEN 
                  money_cld <= moneyTmp_cld ;
               ELSIF (moneyTmp_cld < price) THEN 
                  moneyTmp_cld <= moneyTmp_cld + money_cld ;
               END IF;
            WHEN s1 => 
               IF (moneyTmp_cld >=  price) THEN 
                  money_cld <= moneyTmp_cld ;
               ELSIF (moneyTmp_cld < price) THEN 
                  moneyTmp_cld <= moneyTmp_cld + money_cld ;
               END IF;
            WHEN s2 => 
               IF (moneyTmp_cld < price) THEN 
                  moneyTmp_cld <= moneyTmp_cld + money_cld ;
               ELSIF (moneyTmp_cld >=  price) THEN 
                  money_cld <= moneyTmp_cld ;
               END IF;
            WHEN OTHERS =>
               NULL;
         END CASE;
      END IF;
   END PROCESS clocked_proc;
 
   -----------------------------------------------------------------
   nextstate_proc : PROCESS ( 
      current_state,
      moneyTmp_cld,
      money_cld,
      price,
      sel,
      stock1_cld,
      stock2_cld,
      stock3_cld
   )
   -----------------------------------------------------------------
   BEGIN
      CASE current_state IS
         WHEN Start => 
            IF (sel = 1) THEN 
               next_state <= X1;
            ELSIF (sel = 2) THEN 
               next_state <= X2;
            ELSIF (sel = 3) THEN 
               next_state <= X5;
            ELSE
               next_state <= Start;
            END IF;
         WHEN X1 => 
            IF (stock1_cld = 0) THEN 
               next_state <= Start;
            ELSIF (stock1_cld > 0) THEN 
               next_state <= process_1;
            ELSE
               next_state <= X1;
            END IF;
         WHEN X2 => 
            IF (stock2_cld > 0) THEN 
               next_state <= process_2;
            ELSIF (stock2_cld = 0) THEN 
               next_state <= Start;
            ELSE
               next_state <= X2;
            END IF;
         WHEN X5 => 
            IF (stock3_cld = 0) THEN 
               next_state <= Start;
            ELSIF (stock3_cld >0) THEN 
               next_state <= process_3;
            ELSE
               next_state <= X5;
            END IF;
         WHEN process_1 => 
            IF (money_cld  > price) THEN 
               next_state <= Start;
            ELSIF (money_cld = price) THEN 
               next_state <= Start;
            ELSIF (money_cld < price) THEN 
               next_state <= s2;
            ELSE
               next_state <= process_1;
            END IF;
         WHEN process_2 => 
            IF (money_cld > price) THEN 
               next_state <= Start;
            ELSIF (money_cld = price) THEN 
               next_state <= Start;
            ELSIF (money_cld < price) THEN 
               next_state <= s1;
            ELSE
               next_state <= process_2;
            END IF;
         WHEN process_3 => 
            IF (money_cld > price) THEN 
               next_state <= Start;
            ELSIF (money_cld = price) THEN 
               next_state <= Start;
            ELSIF (money_cld < price) THEN 
               next_state <= s0;
            ELSE
               next_state <= process_3;
            END IF;
         WHEN s0 => 
            IF (moneyTmp_cld >=  price) THEN 
               next_state <= process_3;
            ELSIF (moneyTmp_cld < price) THEN 
               next_state <= s0;
            ELSE
               next_state <= s0;
            END IF;
         WHEN s1 => 
            IF (moneyTmp_cld >=  price) THEN 
               next_state <= process_2;
            ELSIF (moneyTmp_cld < price) THEN 
               next_state <= s1;
            ELSE
               next_state <= s1;
            END IF;
         WHEN s2 => 
            IF (moneyTmp_cld < price) THEN 
               next_state <= s2;
            ELSIF (moneyTmp_cld >=  price) THEN 
               next_state <= process_1;
            ELSE
               next_state <= s2;
            END IF;
         WHEN OTHERS =>
            next_state <= Start;
      END CASE;
   END PROCESS nextstate_proc;
 
   -----------------------------------------------------------------
   output_proc : PROCESS ( 
      current_state,
      money_cld,
      price,
      sel,
      stcash,
      stock1_cld,
      stock2_cld,
      stock3_cld
   )
   -----------------------------------------------------------------
   BEGIN

      -- Combined Actions
      CASE current_state IS
         WHEN Start => 
            IF (sel = 1) THEN 
               y <='0';
               msg <= "select item";
            ELSIF (sel = 2) THEN 
               y <='0';
               msg <= "select item";
            ELSIF (sel = 3) THEN 
               y <='0';
               msg <= "select item";
            END IF;
         WHEN X1 => 
            IF (stock1_cld = 0) THEN 
               msg <= "no stock   ";
            ELSIF (stock1_cld > 0) THEN 
               msg <= "enter 1 EGP";
               price <= 1;
            END IF;
         WHEN X2 => 
            IF (stock2_cld > 0) THEN 
               msg <= "enter 2 EGP";
               price <= 2;
            ELSIF (stock2_cld = 0) THEN 
               msg <= "no stock   ";
            END IF;
         WHEN X5 => 
            IF (stock3_cld = 0) THEN 
               msg <= "no stock   ";
            ELSIF (stock3_cld >0) THEN 
               msg <= "enter 5 EGP";
               price <= 5;
            END IF;
         WHEN process_1 => 
            IF (money_cld  > price) THEN 
               change <= money_cld- price ;
               chosen <= sel ;
               y <= '1';
               msg <= "thank you  " ;
               stcash <= stcash - ( money_cld-  price);
            ELSIF (money_cld = price) THEN 
               change <= 0;
               chosen <= sel ;
               y <= '1';
               msg <= "thank you  " ;
            END IF;
         WHEN process_2 => 
            IF (money_cld > price) THEN 
               change <= money_cld- price ;
               chosen <= sel ;
               y <= '1';
               msg <= "thank you  " ;
               stcash <= stcash - ( money_cld-  price);
            ELSIF (money_cld = price) THEN 
               change <= 0;
               chosen <= sel ;
               y <= '1';
               msg <= "thank you  " ;
            END IF;
         WHEN process_3 => 
            IF (money_cld > price) THEN 
               change <= money_cld- price ;
               chosen <= sel ;
               y <= '1';
               msg <= "thank you  " ;
               stcash <= stcash - ( money_cld-  price);
            ELSIF (money_cld = price) THEN 
               change <= 0;
               chosen <= sel ;
               y <= '1';
               msg <= "thank you  " ;
            END IF;
         WHEN OTHERS =>
            NULL;
      END CASE;
   END PROCESS output_proc;
 
   -- Concurrent Statements
   -- Clocked output assignments
   money <= money_cld;
   moneyTmp <= moneyTmp_cld;
   stock1 <= stock1_cld;
   stock2 <= stock2_cld;
   stock3 <= stock3_cld;
END fsm;
