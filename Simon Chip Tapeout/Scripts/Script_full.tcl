#floorPlan -coreMarginsBy io -site CoreSite -r 0.995833333333 0.002544 40 40 40 40
#floorPlan -site CoreSite -r 0.98755186722 0.002544 40.64 40.64 40.32 40.32
addIoFiller -cell pfeed10000 -prefix FILLER -side n
addIoFiller -cell pfeed10000 -prefix FILLER -side s
addIoFiller -cell pfeed10000 -prefix FILLER -side w
addIoFiller -cell pfeed10000 -prefix FILLER -side e
addIoFiller -cell pfeed01000 -prefix FILLER -side e
addIoFiller -cell pfeed01000 -prefix FILLER -side n
addIoFiller -cell pfeed01000 -prefix FILLER -side s
addIoFiller -cell pfeed01000 -prefix FILLER -side w
globalNetConnect VDD -type pgpin -pin VDD -override -verbose -netlistOverride
globalNetConnect VSS -type pgpin -pin VSS -override -verbose -netlistOverride
globalNetConnect VSSO -type pgpin -pin VSSO -override -verbose -netlistOverride
globalNetConnect VDDO -type pgpin -pin VDDO -override -verbose -netlistOverride
addRing -skip_via_on_wire_shape Noshape -exclude_selected 1 -skip_via_on_pin Standardcell -center 1 -stacked_via_top_layer TOP_M -type core_rings -jog_distance 0.56 -threshold 0.56 -nets {VDD VSS} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right TOP_M left TOP_M} -width 6 -spacing 6 -offset 2
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M1 TOP_M } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1 TOP_M } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1 TOP_M }
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit TOP_M -max_same_layer_jog_length 0.88 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 40 -skip_via_on_pin Standardcell -stacked_via_top_layer TOP_M -padcore_ring_top_layer_limit TOP_M -spacing 0.46 -xleft_offset 10 -merge_stripes_value 0.56 -layer TOP_M -block_ring_bottom_layer_limit M3 -width 2 -nets {VDD VSS} -stacked_via_bottom_layer M1saveDesign 
addIoFiller -cell pfeed00010 -prefix FILLER -side e
addIoFiller -cell pfeed00010 -prefix FILLER -side n
addIoFiller -cell pfeed00010 -prefix FILLER -side s
addIoFiller -cell pfeed00010 -prefix FILLER -side w
saveDesign C2S0099_re_power_v3.enc
setPlaceMode -fp false
place_design -noPrePlaceOpt
setOptMode -fixCap true -fixTran true -fixFanoutLoad false

optDesign -preCTS
saveDesign C2S0099_re_place_v3.enc
set_ccopt_property target_skew 0.5
set_ccopt_property target_max_trans 0.5
ccopt_design

optDesign -postCTS
timeDesign -postCTS -hold

setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeWithSiDriven 1
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail


setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -routeAntennaCellName {}
setUsefulSkewMode -maxSkew false -noBoundary false -useCells {dl04d1 bufbd7 buffd2 dl03d1 bufbdf buffda dl02d2 dl03d4 dl04d2 dl02d1 dl01d4 buffd3 bufbda bufbdk buffd4 dl04d4 dl02d4 bufbd4 dl01d2 bufbd3 bufbd1 dl01d1 buffd7 bufbd2 buffd1 dl03d2 inv0d2 invbda inv0da invbdk inv0d1 inv0d7 invbd4 invbd2 inv0d0 invbd7 invbdf inv0d4} -maxAllowedDelay 1
setNanoRouteMode -quiet -routeAntennaCellName adiode
setNanoRouteMode -quiet -routeTdrEffort 5
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail -viaOpt -wireOpt

### Post Route Anlysis.......0.0
setAnalysisMode -analysisType onChipVariation
timeDesign -postRoute
## optional when there is any violation....
 optDesign -postRoute -hold

timeDesign -postRoute 
report_timing
setAnalysisMode -checkType hold
report_timing 
report_power
report_constraint -all_violators
report_ccopt_skew_groups

### Metal Fill..
addFiller -cell feedth9 -prefix FILLER -doDRC
addFiller -cell feedth3 -prefix FILLER -doDRC
addFiller -cell feedth -prefix FILLER -doDRC

###Verify Geometry
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }

###Verify DRC
get_verify_drc_mode -disable_rules -quiet
get_verify_drc_mode -quiet -area
get_verify_drc_mode -quiet -layer_range
get_verify_drc_mode -check_implant -quiet
get_verify_drc_mode -check_implant_across_rows -quiet
get_verify_drc_mode -check_ndr_spacing -quiet
get_verify_drc_mode -check_only -quiet
get_verify_drc_mode -check_same_via_cell -quiet
get_verify_drc_mode -exclude_pg_net -quiet
get_verify_drc_mode -ignore_trial_route -quiet
get_verify_drc_mode -max_wrong_way_halo -quiet
get_verify_drc_mode -use_min_spacing_on_block_obs -quiet
get_verify_drc_mode -limit -quiet
set_verify_drc_mode -disable_rules {} -check_implant true -check_implant_across_rows false -check_ndr_spacing false -check_same_via_cell false -exclude_pg_net false -ignore_trial_route false -report test.drc.rpt -limit 1000
verify_drc
set_verify_drc_mode -area {0 0 0 0}

###Verify Connectivity
verifyConnectivity -type all -error 1000 -warning 50

saveNetlist C2S0099_netlist.v

saveDesign C2S0099_final_v4.enc

streamOut C2S0099_21052025_v3.gds -mapFile /home/vlsilab/Desktop/SHAANVI/gds2_fe_4l.map -libName DesignLib -merge {/home/install/SCL180/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/4M1IL/gds/scl18fs120.gds /home/install/SCL180/SCLPDK_V3.0_KIT/scl180/iopad/cio150/4M1L/gds/tsl18cio150_4lm.gds } -uniquifyCellNames -units 1000 -mode ALL



streamOut Layout_22.gds -mapFile /home/vlsilab/Desktop/OLD/Simon_Digital_Chip_Share/gds2_fe_4l.map -libName DesignLib -merge {/home/vlsilab/Desktop/OLD/Simon_Digital_Chip_Share/scl180/stdcell/fs120/4M1IL/gds/scl18fs120.gds /home/vlsilab/Desktop/OLD/Simon_Digital_Chip_Share/scl180/iopad/cio150/4M1L/gds/tsl18cio150_4lm.gds } -uniquifyCellNames -units 1000 -mode ALL


saveNetlist -includePowerGround ./Routing/simon_postRoute_withPG.v
saveNetlist ./Routing/simon_postRoute_withoutPG.v
write_sdc ./Routing/simon_postRoute.sdc
write_sdf -version 2.1 -edges noedge -recrem split -setuphold merge_when_paired ./
Routing/simon_postRoute_with_pad_delay.sdf
rcOut -spef ./Routing/simon_postRoute.spef


