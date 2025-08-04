(globals
    version = 3
    io_order = clockwise
    space = 47
    total_edges = 12
)
(iopad
    ###############
    # Left Region - Clock, Reset, Control signals
    (topleft
        (inst name = "CornerCell1" cell = pfrelr offset = 0 orientation = R180 place_status = fixed)
    )
    (left
        (inst name = "POWER_VDD_L1" place_status = fixed)
        (inst name = "POWER_VSS_L1"  place_status = fixed)
	(inst name = "DUMMY0"  place_status = fixed)
	(inst name = "DUMMY1"  place_status = fixed)
        (inst name = "CLK_PAD"  place_status = fixed)
        (inst name = "RST_PAD" place_status = fixed)
        (inst name = "START_PAD" place_status = fixed)
        (inst name = "DONE_PAD"  place_status = fixed)
	(inst name = "DUMMY2"  place_status = fixed)
	(inst name = "DUMMY3" place_status = fixed)
        (inst name = "POWER_VDD_L2" place_status = fixed)
        (inst name = "POWER_VSS_L2" place_status = fixed)
    )
    ###############
    # Top Region - Input data pins
    (topright
        (inst name = "CornerCell2" cell = pfrelr offset = 0 orientation = R90 place_status = fixed)
    )
    (top
        (inst name = "POWER_VDD_T1"  place_status = fixed)
        (inst name = "POWER_VSS_T1"  place_status = fixed)
	(inst name = "DUMMY4"  place_status = fixed)
	(inst name = "DUMMY5"  place_status = fixed)
        (inst name = "INPUT_0_PAD"  place_status = fixed)
        (inst name = "INPUT_1_PAD"  place_status = fixed)
        (inst name = "INPUT_2_PAD"  place_status = fixed)
        (inst name = "INPUT_3_PAD"  place_status = fixed)
	(inst name = "DUMMY6"  place_status = fixed)
	(inst name = "DUMMY7"  place_status = fixed)
        (inst name = "POWER_VDD_T2"  place_status = fixed)
        (inst name = "POWER_VSS_T2"  place_status = fixed)
    )
    ###############
    # Right Region - Output data pins
    (bottomright
        (inst name = "CornerCell3" cell = pfrelr offset = 0 orientation = R0 place_status = fixed)
    )
    (right
        (inst name = "POWER_VDD_R1"  place_status = fixed)
        (inst name = "POWER_VSS_R1"  place_status = fixed)
	(inst name = "DUMMY8"  place_status = fixed)
	(inst name = "DUMMY9"  place_status = fixed)
        (inst name = "OUTPUT_0_PAD"  place_status = fixed)
        (inst name = "OUTPUT_1_PAD"  place_status = fixed)
        (inst name = "OUTPUT_2_PAD"  place_status = fixed)
        (inst name = "OUTPUT_3_PAD"  place_status = fixed)
	(inst name = "DUMMYa"  place_status = fixed)
	(inst name = "DUMMYb"  place_status = fixed)
        (inst name = "POWER_VDD_R2"  place_status = fixed)
        (inst name = "POWER_VSS_R2"  place_status = fixed)
    )
    ###############
    # Bottom Region - Key input pins
    (bottomleft
        (inst name = "CornerCell4" cell = pfrelr offset = 0 orientation = R270 place_status = fixed)
    )
    (bottom
        (inst name = "POWER_VDD_B1"  place_status = fixed)
        (inst name = "POWER_VSS_B1"  place_status = fixed)
        (inst name = "KEY_0_PAD"  place_status = fixed)
        (inst name = "KEY_1_PAD"  place_status = fixed)
        (inst name = "KEY_2_PAD"  place_status = fixed)
        (inst name = "KEY_3_PAD"  place_status = fixed)
        (inst name = "KEY_4_PAD"  place_status = fixed)
        (inst name = "KEY_5_PAD"  place_status = fixed)
        (inst name = "KEY_6_PAD"  place_status = fixed)
        (inst name = "KEY_7_PAD"  place_status = fixed)
        (inst name = "POWER_VDD_B2"  place_status = fixed)
        (inst name = "POWER_VSS_B2" cell = pv0i place_status = fixed)
    )
)
