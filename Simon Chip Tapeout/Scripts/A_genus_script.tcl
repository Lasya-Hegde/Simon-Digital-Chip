read_libs /home/vlsilab/Desktop/Chandu/Simon_0/tsl18cio150_max.lib /home/vlsilab/Desktop/Chandu/Simon_0/tsl18fs120_scl_ss.lib 
read_hdl encrypt.v key_gen.v simon_newer.v Top.v input_taker_5.v output_giver.v
elaborate

read_sdc /home/vlsilab/Desktop/Chandu/Simon_0/cons.sdc 
syn_generic
syn_map
syn_opt 

report_area > area.rpt
report_timing > timing.rpt
report_power > power.rpt
write_hdl > NEW_netlist.v
write_sdc > constraints_out.sdc
