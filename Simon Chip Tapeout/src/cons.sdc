###############  SDC CONSTRAINTS   ############


##### PARAMETERS #####
set_units -time 1.0ns;
set_units -capacitance  1.0pF;

set CLOCK_PERIOD 100;
set CLOCK_NAME   clk; 

#set SKEW_setup  [expr $CLOCK_PERIOD*0.025];
#set SKEW_hold   [expr $CLOCK_PERIOD*0.025];
set SKEW_setup  0.01;
set SKEW_hold   0.01;
set MINRISE     [expr $CLOCK_PERIOD*0.125];
set MAXRISE     [expr $CLOCK_PERIOD*0.2];
set MINFALL     [expr $CLOCK_PERIOD*0.125];
set MAXFALL     [expr $CLOCK_PERIOD*0.2];



#set MIN_PORT 1;
#set MAX_PORT 2.5;
set MIN_PORT 0.1;
set MAX_PORT 0.2;

####### CLOCK CONSTRAINTS #########
create_clock -name "$CLOCK_NAME" -period "$CLOCK_PERIOD" -waveform "0 [expr $CLOCK_PERIOD/2]"  [get_ports clk_pad]

##  Write clock source latency
#set_clock_latency   -source   -max   1.25   -late    [get_clocks  clk]
#set_clock_latency   -source   -min   0.75   -late    [get_clocks  clk]
#set_clock_latency   -source   -max   1.0    -early   [get_clocks  clk]
#set_clock_latency   -source   -min   1.25   -early   [get_clocks  clk]

set_clock_latency   -source   -max   0.20   -late    [get_clocks  clk]
set_clock_latency   -source   -min   0.15   -late    [get_clocks  clk]
set_clock_latency   -source   -max   0.20   -early   [get_clocks  clk]
set_clock_latency   -source   -min   0.15   -early   [get_clocks  clk]

# Write clock transition
set_clock_transition   -rise   -min   $MINRISE   [get_clocks  clk]
set_clock_transition   -rise   -max   $MAXRISE   [get_clocks  clk]
set_clock_transition   -fall   -min   $MINRISE   [get_clocks  clk]
set_clock_transition   -fall   -max   $MAXRISE   [get_clocks  clk]

# Input transition 
set_input_transition	-max	$MAX_PORT 	[remove_from_collection [all_inputs] [get_ports clk_pad]] 
set_input_transition	-min	$MIN_PORT 	[remove_from_collection [all_inputs] [get_ports clk_pad]]
 
set_input_transition	-max	$MAX_PORT 	[get_ports	reset_pad]
set_input_transition	-max	$MAX_PORT 	[get_ports	start_pad]
set_input_transition	-min	$MIN_PORT 	[get_ports	reset_pad]
set_input_transition	-min	$MIN_PORT 	[get_ports	start_pad] 

# Write clock uncertainty
set_clock_uncertainty -setup $SKEW_setup  [get_clocks  clk]
set_clock_uncertainty -hold  $SKEW_hold   [get_clocks  clk]


#input port delay
#set_input_delay  -add_delay -clock clk -max 7.75 [remove_from_collection [all_inputs] [get_ports clk_pad]]
#set_input_delay  -add_delay -clock clk -min 2.25 [remove_from_collection [all_inputs] [get_ports clk_pad]]
set_input_delay  -add_delay -clock clk -max 0.4 [remove_from_collection [all_inputs] [get_ports clk_pad]]
set_input_delay  -add_delay -clock clk -min 0.3 [remove_from_collection [all_inputs] [get_ports clk_pad]]

#Output port delay
#set_output_delay -clock clk -max 3.931 [all_outputs] -add_delay
#set_output_delay -clock clk -min 2.628 [all_outputs] -add_delay

set_output_delay -clock clk -max 0.4 [all_outputs] -add_delay
set_output_delay -clock clk -min 0.3 [all_outputs] -add_delay


#######   LOAD SPECIFIACATIONS   ########
set_load	5	[all_outputs]


########## FALSE PATHS ###########
#####its like you are specifying asynchronous inputs to be handled properly######
set_false_path  -from   [get_ports reset_pad]         -to     [all_registers] 
set_false_path  -from   [get_ports start_pad]         -to     [all_registers]



##########  GROUP PATHS  #########
group_path -name   I2R   -from   [all_inputs]      -to   [all_registers]
group_path -name   R2O   -from   [all_registers]   -to   [all_outputs]
group_path -name   R2R   -from   [all_registers]   -to   [all_registers]
group_path -name   I2O   -from   [all_inputs]      -to   [all_outputs]
