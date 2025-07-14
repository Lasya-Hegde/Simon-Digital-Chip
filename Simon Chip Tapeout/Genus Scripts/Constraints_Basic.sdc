##############################################################################
#                            CLOCK DEFINITION                                #
##############################################################################



##### gives 0 violations post pnr






set EXTCLK "clk" ;
set_units -time 1.0ns;
set EXTCLK_PERIOD 100;
create_clock -name "$EXTCLK" -period "$EXTCLK_PERIOD" -waveform "0 [expr $EXTCLK_PERIOD/2]" [get_ports clk]

set SKEW 0.200 #Make sure to set a minimum input-delay greater than skew value
set_clock_uncertainty $SKEW [get_clocks $EXTCLK]
set SRLATENCY 0.80
set SFLATENCY 0.75
set MINRISE 0.20
set MAXRISE 0.25
set MINFALL 0.15
set MAXFALL 0.10
set_clock_transition -rise -min $MINRISE [get_clocks $EXTCLK]
set_clock_transition -rise -max $MAXRISE [get_clocks $EXTCLK]
set_clock_transition -fall -min $MINFALL [get_clocks $EXTCLK]
set_clock_transition -fall -max $MAXFALL [get_clocks $EXTCLK]
set INPUT_DELAY 0.5
set OUTPUT_DELAY 0.5
set_input_delay -min 0.25 -clock $EXTCLK [all_inputs]
set_output_delay -min 0.25 -clock $EXTCLK [all_outputs]



# Maximum fanout for non-critical nets
set MAX_FANOUT 4
set_max_fanout $MAX_FANOUT Top

set MIN_FANOUT 1
set_min_fanout $MIN_FANOUT Top

# Maximum transition time for nets
set MAX_TRANSITION 0.69
set_max_transition $MAX_TRANSITION Top

# Maximum capacitance for nets
set MAX_CAPACITANCE 0.6
set_max_capacitance $MAX_CAPACITANCE Top

set_fix_hold [get_clocks $EXTCLK]
