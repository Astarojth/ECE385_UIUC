//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3,HEX4, HEX5, HEX6, HEX7,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
											
											


               // output SRAM_UB_N,SRAM_LB_N,SRAM_CE_N,SRAM_OE_N,SRAM_WE_N,
               // output logic [19:0] SRAM_ADDR,
               // inout wire [15:0] SRAM_DQ
                    );
    
    logic Reset_h, Clk, Run_h;
    logic [7:0] keycode, keycode_2;
    logic [9:0] DrawX, DrawY;
	logic is_ball, key_R, key_T;
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
		Run_h <= ~(KEY[1]);
    end
    
    logic [1:0]  hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;

    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     lab8_soc nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
							 .audio_choose_export(audio_1),
							 .audio_show_export(audio),
							 .audio_idx_export(add[7:0]),
                             .keycode_export(keycode),  
							 .keycode_2_export(keycode_2),
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );
    
	 /*------------------------GAME-----------------------*/
	logic [9:0] boss_bullet_X_Addr, boss_bullet_Y_Addr,MapEnd_X_Addr, MapEnd_Y_Addr,Ball_Y_Pos_Block,
                MapEnd_X_Pos,MapEnd_Y_Pos, Ball_X_Pos, Ball_Y_Pos,Ball_Y_Motion_in,Ball_Y_Motion,Ball_X_Motion;
    logic [9:0] boss_X_Addr, boss_Y_Addr,Ball_X_Init, Ball_Y_Init, bullet_X_Init, bullet_Y_Init,StayY;
	logic [3:0] state_audio,counter,jump_count, jump_reset,jump_count_time,state_index;
	logic is_MapEnd, is_bar, is_boss_bullet, is_boss, update_flag, Ending, rtc_clk,in_air,
          top,death_in,sec_clk,death,actual_shoot,actual_jump,blocked,win,is_bullet,direct,bullet,delay_clk,bullet_0,bullet_1,bullet_2,bullet_3;
    logic [8:0] boss_counter;
    logic [9:0] Block_X_Pos [0:16], Block_Y_Pos [0:16], Block_X_size [0:16], Block_Y_size [0:16];
    logic [1:0] shoot_counter;
	logic [7:0] add;
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(.*,.Reset(Reset_h));
	 
    zuofu ball_instance(.*,.Reset(Reset_h),.frame_clk(VGA_VS));
    
    color_mapper color_instance(.*);
    
	 RTC rtc(.*);
	 sec_clk sec(.*);
    MAP maps(.*);

    boss fpga(.*,.Reset(Reset_h),.frame_clk(VGA_VS));

	 bullet_gen bull_0(.*,.frame_clk(VGA_VS));
	 
    //------------------------ Display keycode on hex display for debug----------------------------//
    HexDriver hex_inst_0 (4'b0, HEX0);
    HexDriver hex_inst_1 (4'b0, HEX1);
	 HexDriver hex_inst_2 (4'b0, HEX2);
    HexDriver hex_inst_3 (4'b0, HEX3);
	 
    HexDriver hex_inst_4 ({3'b0,freq}, HEX4);
    HexDriver hex_inst_5 (4'b0, HEX5);
	 HexDriver hex_inst_6 (4'b0, HEX6);
    HexDriver hex_inst_7 (4'b0, HEX7);

	
endmodule

