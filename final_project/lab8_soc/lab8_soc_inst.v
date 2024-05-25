	lab8_soc u0 (
		.clk_clk                (<connected-to-clk_clk>),                //             clk.clk
		.keycode_export         (<connected-to-keycode_export>),         //         keycode.export
		.otg_hpi_address_export (<connected-to-otg_hpi_address_export>), // otg_hpi_address.export
		.otg_hpi_cs_export      (<connected-to-otg_hpi_cs_export>),      //      otg_hpi_cs.export
		.otg_hpi_data_in_port   (<connected-to-otg_hpi_data_in_port>),   //    otg_hpi_data.in_port
		.otg_hpi_data_out_port  (<connected-to-otg_hpi_data_out_port>),  //                .out_port
		.otg_hpi_r_export       (<connected-to-otg_hpi_r_export>),       //       otg_hpi_r.export
		.otg_hpi_reset_export   (<connected-to-otg_hpi_reset_export>),   //   otg_hpi_reset.export
		.otg_hpi_w_export       (<connected-to-otg_hpi_w_export>),       //       otg_hpi_w.export
		.reset_reset_n          (<connected-to-reset_reset_n>),          //           reset.reset_n
		.sdram_clk_clk          (<connected-to-sdram_clk_clk>),          //       sdram_clk.clk
		.sdram_wire_addr        (<connected-to-sdram_wire_addr>),        //      sdram_wire.addr
		.sdram_wire_ba          (<connected-to-sdram_wire_ba>),          //                .ba
		.sdram_wire_cas_n       (<connected-to-sdram_wire_cas_n>),       //                .cas_n
		.sdram_wire_cke         (<connected-to-sdram_wire_cke>),         //                .cke
		.sdram_wire_cs_n        (<connected-to-sdram_wire_cs_n>),        //                .cs_n
		.sdram_wire_dq          (<connected-to-sdram_wire_dq>),          //                .dq
		.sdram_wire_dqm         (<connected-to-sdram_wire_dqm>),         //                .dqm
		.sdram_wire_ras_n       (<connected-to-sdram_wire_ras_n>),       //                .ras_n
		.sdram_wire_we_n        (<connected-to-sdram_wire_we_n>),        //                .we_n
		.audio_choose_export    (<connected-to-audio_choose_export>),    //    audio_choose.export
		.audio_show_export      (<connected-to-audio_show_export>),      //      audio_show.export
		.audio_idx_export       (<connected-to-audio_idx_export>),       //       audio_idx.export
		.keycode_2_export       (<connected-to-keycode_2_export>),       //       keycode_2.export
		.acc_wire_export        (<connected-to-acc_wire_export>),        //        acc_wire.export
		.reset_wire_export      (<connected-to-reset_wire_export>)       //      reset_wire.export
	);

