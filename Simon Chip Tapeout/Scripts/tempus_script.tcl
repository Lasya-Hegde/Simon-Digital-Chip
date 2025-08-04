read_lib /home/vlsilab/Desktop/Chandu/Simon_0/tsl18cio150_max.lib /home/vlsilab/Desktop/Chandu/Simon_0/tsl18fs120_scl_ss.lib
read_verilog NEW_netlist.v 
set_top_module Top
read_sdc /home/vlsilab/Desktop/Chandu/Simon_0/cons.sdc  

set_delay_cal_mode -siAware true
set_si_mode -enable_delay true
set_si_mode -enable_glitch_report true
set_si_mode -enable_glitch_propagation true

update_timing -full 
report_timing
report_slack
report_clocks
report_analysis_coverage
