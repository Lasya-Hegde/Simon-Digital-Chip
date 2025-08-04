(globals
    version = 3
    io_order = clockwise
    space = 50
    place_status = fixed
)
(iopad
    ###############
    # Left Region - Clock, Reset, Control signals
    (topleft
        (inst name = "CornerCell1" cell = pfrelr offset = 0 orientation = R180 place_status = fixed)
    )
    (left
        (inst name = "pvdi_VDD_CORE_1")
        (inst name = "pv0i_VSS_CORE_1")
        (inst name = "CLK_3DPAD")
	(inst name = "CLK_3CPAD")
	(inst name = "RST_PAD")
	(inst name = "START_PAD")
	(inst name = "DONE_PAD")
	(inst name = "TXT_DONE_PAD")
	(inst name = "TEST_PAD1")
	(inst name = "TEST_PAD2")
	(inst name = "pvda_VDDO_CORE_1")
        (inst name = "pv0a_VSSO_CORE_1")

    )
    ###############
    # Top Region - Input data pins
    (topright
        (inst name = "CornerCell2" cell = pfrelr offset = 0 orientation = R90 place_status = fixed)
    )
    (top
        (inst name = "pvdi_VDD_CORE_2")
        (inst name = "pv0i_VSS_CORE_2")
        (inst name = "INPUT_0_PAD")
        (inst name = "INPUT_1_PAD")
        (inst name = "INPUT_2_PAD")
        (inst name = "INPUT_3_PAD")	
	(inst name = "TEST_PAD3")
	(inst name = "TEST_PAD4")
	(inst name = "TEST_PAD5")
	(inst name = "TEST_PAD6")
	(inst name = "pvda_VDDO_CORE_2")
        (inst name = "pv0a_VSSO_CORE_2")

    )
    ###############
    # Right Region - Output data pins
    (bottomright
        (inst name = "CornerCell3" cell = pfrelr offset = 0 orientation = R0 place_status = fixed)
    )
    (right
 	(inst name = "pvdi_VDD_CORE_3")
        (inst name = "pv0i_VSS_CORE_3")
        (inst name = "OUTPUT_0_PAD")
	(inst name = "OUTPUT_1_PAD")
	(inst name = "OUTPUT_2_PAD")
	(inst name = "OUTPUT_3_PAD")
        (inst name = "TXT_OUTPUT_0_PAD")
	(inst name = "TXT_OUTPUT_1_PAD")
	(inst name = "TXT_OUTPUT_2_PAD")
	(inst name = "TXT_OUTPUT_3_PAD")
	(inst name = "pvda_VDDO_CORE_3")
        (inst name = "pv0a_VSSO_CORE_3")
    )
    ###############
    # Bottom Region - Key input pins
    (bottomleft
        (inst name = "CornerCell4" cell = pfrelr offset = 0 orientation = R270 place_status = fixed)
    )
    (bottom
        (inst name = "pvdi_VDD_CORE_4")
        (inst name = "pv0i_VSS_CORE_4")
        (inst name = "KEY_0_PAD")
	(inst name = "KEY_1_PAD")
	(inst name = "KEY_2_PAD")
	(inst name = "KEY_3_PAD")
	(inst name = "KEY_4_PAD")
	(inst name = "KEY_5_PAD")
	(inst name = "KEY_6_PAD")
	(inst name = "KEY_7_PAD")
	(inst name = "pvda_VDDO_CORE_4")
        (inst name = "pv0a_VSSO_CORE_4")
    )
)
