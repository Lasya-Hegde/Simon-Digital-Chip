read_libs /home/vlsilab/Desktop/Chandu/Simon_0/scl180/iopad/cio150/4M1L/liberty/tsl18cio150_max.lib /home/vlsilab/Desktop/Chandu/Simon_0/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib 
read_hdl /home/vlsilab/Desktop/Chandu/Simon_0/synth/inpu_files/Top.v /home/vlsilab/Desktop/Chandu/Simon_0/synth/inpu_files/simon_newer.v /home/vlsilab/Desktop/Chandu/Simon_0/synth/inpu_files/input_taker_5.v /home/vlsilab/Desktop/Chandu/Simon_0/synth/inpu_files/output_giver.v /home/vlsilab/Desktop/Chandu/Simon_0/synth/inpu_files/key_gen.v /home/vlsilab/Desktop/Chandu/Simon_0/synth/inpu_files/encrypt.v
elaborate

read_sdc /home/vlsilab/Desktop/Chandu/Simon_0/synth/inpu_files/cons.sdc
syn_generic
syn_map
syn_opt 

report_area > /home/vlsilab/Desktop/Chandu/Simon_0/synth/output_files/area.rpt
report_timing > /home/vlsilab/Desktop/Chandu/Simon_0/synth/output_files/timing.rpt
report_power > /home/vlsilab/Desktop/Chandu/Simon_0/synth/output_files/power.rpt
write_hdl > /home/vlsilab/Desktop/Chandu/Simon_0/synth/output_files/NEW_netlist.v
write_sdc > /home/vlsilab/Desktop/Chandu/Simon_0/synth/output_files/constraints_out.sdc
