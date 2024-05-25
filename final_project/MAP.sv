module MAP(
    input Reset_h,                    //   or background (computed in ball.sv)
    key_R,
    Clk,
    Ending,  
    key_T,
	 input [8:0] boss_counter,
    input [9:0] DrawX,DrawY,          

        output logic is_MapEnd,update_flag,win,
        output logic [3:0] state_index,
        output [9:0] Ball_X_Init,
                     Ball_Y_Init ,
                     bullet_X_Init,
                     bullet_Y_Init,
                     MapEnd_X_Pos,
                     MapEnd_Y_Pos,
                     MapEnd_X_Addr, MapEnd_Y_Addr,
        output [9:0] Block_X_Pos [0:16],
                     Block_Y_Pos [0:16],
                     Block_X_size [0:16],
                     Block_Y_size [0:16]
                    

);


    //logic update_flag;

    logic [9:0] Block_X_Pos_0 [0:16];
    logic [9:0] Block_Y_Pos_0 [0:16];
    logic [9:0] Block_X_size_0 [0:16];
    logic [9:0] Block_Y_size_0 [0:16];

    logic [9:0] Block_X_Pos_1 [0:16];
    logic [9:0] Block_Y_Pos_1 [0:16];
    logic [9:0] Block_X_size_1 [0:16];
    logic [9:0] Block_Y_size_1 [0:16];

    logic [9:0] Block_X_Pos_2 [0:16];
    logic [9:0] Block_Y_Pos_2 [0:16];
    logic [9:0] Block_X_size_2 [0:16];
    logic [9:0] Block_Y_size_2 [0:16];

    logic [9:0] Block_X_Pos_3 [0:16];
    logic [9:0] Block_Y_Pos_3 [0:16];
    logic [9:0] Block_X_size_3 [0:16];
    logic [9:0] Block_Y_size_3 [0:16];

    logic [9:0] Ball_X_Init_array[0:3];
    logic [9:0] Ball_Y_Init_array[0:3];  
    logic [9:0] bullet_X_Init_array[0:3]; 
    logic [9:0] bullet_Y_Init_array[0:3];

    logic [9:0] MapEnd_X_Pos_array [0:4];
    logic [9:0] MapEnd_Y_Pos_array [0:4];

    
    enum logic [2:0] {  idle, idle_ready, map1, map1_ready, map2, map2_ready,winning,win_ready}  State, Next_state;

    always_ff @ (posedge Clk)
    begin
        if (Reset_h||key_T)
        begin
		State <= idle;
        end
        else
        begin
	        State <= Next_state;
        end
    end

    always_comb
	begin 
        //     state_index = 4'd0;
            update_flag = 0;
	    Next_state = State;
            Ball_X_Init =  Ball_X_Init_array [0];
            Ball_Y_Init =  Ball_Y_Init_array [0];
            bullet_X_Init = bullet_X_Init_array [0];
            bullet_Y_Init = bullet_Y_Init_array [0];
            MapEnd_X_Pos = MapEnd_X_Pos_array [0];
            MapEnd_Y_Pos = MapEnd_Y_Pos_array [0];
            state_index = 4'd0;
            win = 0;
            unique case (State)
		idle : 
		        if (Ending == 0) 
			Next_state = idle_ready  ;   
		idle_ready : 
		        if (Ending) 
			Next_state = map1   ;                      
		map1 : 
			if(Ending == 0)
			Next_state = map1_ready;
                map1_ready : 
			if(Ending)
			Next_state = map2;
                map2 : 
			if(Ending == 0)
			Next_state = map2_ready;
                map2_ready : 
			if(Ending)
			Next_state = winning;
                winning :
                        Next_state = win_ready;
                win_ready:
                        Next_state = win_ready;
                default:;
		endcase
		case (State)
			idle: 
				begin
                                        Ball_X_Init =  Ball_X_Init_array [0];
                                        Ball_Y_Init =  Ball_Y_Init_array [0];
                                        bullet_X_Init = bullet_X_Init_array [0];
                                        bullet_Y_Init = bullet_Y_Init_array [0];
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [0];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [0];
                                        Block_X_Pos = Block_X_Pos_0 ;
                                        Block_Y_Pos = Block_Y_Pos_0 ;
                                        Block_X_size = Block_X_size_0;
                                        Block_Y_size = Block_Y_size_0;
                                        state_index = 4'd0;
                                        update_flag = 1;
				end
			idle_ready: 
				begin
                                        Ball_X_Init =  Ball_X_Init_array [0];
                                        Ball_Y_Init =  Ball_Y_Init_array [0];
                                        bullet_X_Init = bullet_X_Init_array [0];
                                        bullet_Y_Init = bullet_Y_Init_array [0];
                                        Block_X_Pos = Block_X_Pos_0 ;
                                        Block_Y_Pos = Block_Y_Pos_0 ;
                                        Block_X_size = Block_X_size_0;
                                        Block_Y_size = Block_Y_size_0;
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [0];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [0];
                                        state_index = 4'd0;
                                        update_flag = 0;
				end
			map1 : 
				begin
                                        Ball_X_Init =  Ball_X_Init_array [1];
                                        Ball_Y_Init =  Ball_Y_Init_array [1];
                                        bullet_X_Init = bullet_X_Init_array [1];
                                        bullet_Y_Init = bullet_Y_Init_array [1];
                                        Block_X_Pos = Block_X_Pos_1 ;
                                        Block_Y_Pos = Block_Y_Pos_1 ;
                                        Block_X_size = Block_X_size_1;
                                        Block_Y_size = Block_Y_size_1;
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [1];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [1];
                                        state_index = 4'd1;
                                        update_flag = 1;
                                end
        		map1_ready : 
				begin
                                        Ball_X_Init =  Ball_X_Init_array [1];
                                        Ball_Y_Init =  Ball_Y_Init_array [1];
                                        bullet_X_Init = bullet_X_Init_array [1];
                                        bullet_Y_Init = bullet_Y_Init_array [1];
                                        Block_X_Pos = Block_X_Pos_1 ;
                                        Block_Y_Pos = Block_Y_Pos_1 ;
                                        Block_X_size = Block_X_size_1;
                                        Block_Y_size = Block_Y_size_1;
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [1];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [1];
                                        state_index = 4'd1;
                                        update_flag = 0;
                                end
			map2 : 
				begin
                                        Ball_X_Init =  Ball_X_Init_array [2];
                                        Ball_Y_Init =  Ball_Y_Init_array [2];
                                        bullet_X_Init = bullet_X_Init_array [2];
                                        bullet_Y_Init = bullet_Y_Init_array [2];
                                        Block_X_Pos = Block_X_Pos_2 ;
                                        Block_Y_Pos = Block_Y_Pos_2 ;
                                        Block_X_size = Block_X_size_2;
                                        Block_Y_size = Block_Y_size_2;
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [2];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [2];
                                        state_index = 4'd2;
                                        update_flag = 1;
                                end
        		map2_ready : 
				begin
                                        Ball_X_Init =  Ball_X_Init_array [2];
                                        Ball_Y_Init =  Ball_Y_Init_array [2];
                                        bullet_X_Init = bullet_X_Init_array [2];
                                        bullet_Y_Init = bullet_Y_Init_array [2];
                                        Block_X_Pos = Block_X_Pos_2 ;
                                        Block_Y_Pos = Block_Y_Pos_2 ;
                                        Block_X_size = Block_X_size_2;
                                        Block_Y_size = Block_Y_size_2;
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [2];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [2];
                                        state_index = 4'd2;
                                        update_flag = 0;
                                end
                        winning:
                                begin
                                        Ball_X_Init =  Ball_X_Init_array [3];
                                        Ball_Y_Init =  Ball_Y_Init_array [3];
                                        bullet_X_Init = bullet_X_Init_array [3];
                                        bullet_Y_Init = bullet_Y_Init_array [3];
                                        Block_X_Pos = Block_X_Pos_3 ;
                                        Block_Y_Pos = Block_Y_Pos_3 ;
                                        Block_X_size = Block_X_size_3;
                                        Block_Y_size = Block_Y_size_3;
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [3];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [3];
                                        state_index = 4'd3;
                                        update_flag = 1;
                                        win = 1;
                                end
                        win_ready:
                                begin
                                        Ball_X_Init =  Ball_X_Init_array [3];
                                        Ball_Y_Init =  Ball_Y_Init_array [3];
                                        bullet_X_Init = bullet_X_Init_array [3];
                                        bullet_Y_Init = bullet_Y_Init_array [3];
                                        Block_X_Pos = Block_X_Pos_3 ;
                                        Block_Y_Pos = Block_Y_Pos_3 ;
                                        Block_X_size = Block_X_size_3;
                                        Block_Y_size = Block_Y_size_3;
                                        MapEnd_X_Pos = MapEnd_X_Pos_array [3];
                                        MapEnd_Y_Pos = MapEnd_Y_Pos_array [3];
                                        state_index = 4'd3;
                                        update_flag = 0;
                                        win =1;
                                end
                endcase
        end 


    always_comb
    begin

    end
    always_comb
    begin
/*------------------------Map End----------------------------*/
//修改传送门位置
       MapEnd_X_Pos_array [0] = 10'd620;
       MapEnd_Y_Pos_array [0]= 10'd310;
       MapEnd_X_Pos_array [1] = 340;
       MapEnd_Y_Pos_array [1]= 440;
       MapEnd_X_Pos_array [2] = 40;
       MapEnd_Y_Pos_array [2]= 420;
       MapEnd_X_Pos_array [3] = 10'd330;
       MapEnd_Y_Pos_array [3]= 10'd450;

/*------------------------Ball&Bullet----------------------------*/
//修改出生点
        Ball_X_Init_array [0] = 10'd15;
        Ball_Y_Init_array [0] = 10'd250; 
        bullet_X_Init_array [0] = 10'd15;
        bullet_Y_Init_array [0] = 10'd250; 

        Ball_X_Init_array [1] = 610;
        Ball_Y_Init_array [1] = 10; 
        bullet_X_Init_array [1] = 610;
        bullet_Y_Init_array [1] = 10; 

        Ball_X_Init_array [2] = 340;
        Ball_Y_Init_array [2] = 10; 
        bullet_X_Init_array [2] = 340;
        bullet_Y_Init_array [2] = 10; 

        Ball_X_Init_array [3] = 40;
        Ball_Y_Init_array [3] = 100;
        bullet_X_Init_array [3] = 40;
        bullet_Y_Init_array [3] = 100; 

/* ---------------------------------block0----------------------------*/
        Block_X_Pos_0 [0] = 0;
        Block_Y_Pos_0 [0] = 360;
        Block_X_size_0 [0] = 620;
        Block_Y_size_0 [0] = 100;
        Block_X_Pos_0 [1] = 0;
        Block_Y_Pos_0 [1] = 460;
        Block_X_size_0 [1] = 40;
        Block_Y_size_0 [1] = 20;



/* ---------------------------------block1----------------------------*/
         Block_X_Pos_1 [1] = 0;
			Block_Y_Pos_1 [1] = 0;
			Block_X_size_1 [1] = 40;
			Block_Y_size_1 [1] = 480;
			Block_X_Pos_1 [2] = 600;
			Block_Y_Pos_1 [2] = 80;
			Block_X_size_1 [2] = 40;
			Block_Y_size_1 [2] = 20;
			Block_X_Pos_1 [3] = 620;
			Block_Y_Pos_1 [3] = 100;
			Block_X_size_1 [3] = 40;
			Block_Y_size_1 [3] = 380;
			Block_X_Pos_1 [4] = 0;
			Block_Y_Pos_1 [4] = 80;
			Block_X_size_1 [4] = 120;
			Block_Y_size_1 [4] = 40;
			Block_X_Pos_1 [5] = 280;
			Block_Y_Pos_1 [5] = 80;
			Block_X_size_1 [5] = 280;
			Block_Y_size_1 [5] = 40;
			Block_X_Pos_1 [6] = 0;
			Block_Y_Pos_1 [6] = 440;
			Block_X_size_1 [6] = 300;
			Block_Y_size_1 [6] = 100;
			Block_X_Pos_1 [7] = 300;
			Block_Y_Pos_1 [7] = 200;
			Block_X_size_1 [7] = 40;
			Block_Y_size_1 [7] = 280;
			Block_X_Pos_1 [8] = 80;
			Block_Y_Pos_1 [8] = 350;
			Block_X_size_1 [8] = 100;
			Block_Y_size_1 [8] = 20;
			Block_X_Pos_1 [9] = 340;
			Block_Y_Pos_1 [9] = 200;
			Block_X_size_1 [9] = 100;
			Block_Y_size_1 [9] = 20;
			Block_X_Pos_1 [10] = 360;
			Block_Y_Pos_1 [10] = 440;
			Block_X_size_1 [10] = 300;
			Block_Y_size_1 [10] = 80;
			Block_X_Pos_1 [11] = 200;
			Block_Y_Pos_1 [11] = 400;
			Block_X_size_1 [11] = 80;
			Block_Y_size_1 [11] = 20;
			Block_X_Pos_1 [12] = 240;
			Block_Y_Pos_1 [12] = 240;
			Block_X_size_1 [12] = 40;
			Block_Y_size_1 [12] = 40;
			Block_X_Pos_1 [13] = 160;
			Block_Y_Pos_1 [13] = 300;
			Block_X_size_1 [13] = 60;
			Block_Y_size_1 [13] = 20;
			Block_X_Pos_1 [14] = 440;
			Block_Y_Pos_1 [14] = 300;
			Block_X_size_1 [14] = 40;
			Block_Y_size_1 [14] = 20;


/* ---------------------------------block2----------------------------*/
Block_X_Pos_2 [1] = 0;
Block_Y_Pos_2 [1] = 0;
Block_X_size_2 [1] = 40;
Block_Y_size_2 [1] = 480;
Block_X_Pos_2 [2] = 600;
Block_Y_Pos_2 [2] = 0;
Block_X_size_2 [2] = 40;
Block_Y_size_2 [2] = 480;
Block_X_Pos_2 [3] = 0;
Block_Y_Pos_2 [3] = 0;
Block_X_size_2 [3] = 340;
Block_Y_size_2 [3] = 40;
Block_X_Pos_2 [4] = 380;
Block_Y_Pos_2 [4] = 0;
Block_X_size_2 [4] = 260;
Block_Y_size_2 [4] = 40;
Block_X_Pos_2 [5] = 0;
Block_Y_Pos_2 [5] = 440;
Block_X_size_2 [5] = 40;
Block_Y_size_2 [5] = 40;
Block_X_Pos_2 [6] = 60;
Block_Y_Pos_2 [6] = 440;
Block_X_size_2 [6] = 580;
Block_Y_size_2 [6] = 40;
Block_X_Pos_2 [7] = 0;
Block_Y_Pos_2 [7] = 100;
Block_X_size_2 [7] = 440;
Block_Y_size_2 [7] = 20;
Block_X_Pos_2 [8] = 100;
Block_Y_Pos_2 [8] = 160;
Block_X_size_2 [8] = 400;
Block_Y_size_2 [8] = 20;
Block_X_Pos_2 [9] = 0;
Block_Y_Pos_2 [9] = 220;
Block_X_size_2 [9] = 380;
Block_Y_size_2 [9] = 20;
Block_X_Pos_2 [10] = 80;
Block_Y_Pos_2 [10] = 280;
Block_X_size_2 [10] = 380;
Block_Y_size_2 [10] = 20;
Block_X_Pos_2 [11] = 0;
Block_Y_Pos_2 [11] = 340;
Block_X_size_2 [11] = 420;
Block_Y_size_2 [11] = 20;
Block_X_Pos_2 [12] = 140;
Block_Y_Pos_2 [12] = 400;
Block_X_size_2 [12] = 340;
Block_Y_size_2 [12] = 20;
/* ---------------------------------block3----------------------------*/
Block_X_Pos_3 [1] = 0;
Block_Y_Pos_3 [1] = 0;
Block_X_size_3 [1] = 40;
Block_Y_size_3 [1] = 480;
Block_X_Pos_3 [2] = 60;
Block_Y_Pos_3 [2] = 0;
Block_X_size_3 [2] = 580;
Block_Y_size_3 [2] = 40;
Block_X_Pos_3 [3] = 600;
Block_Y_Pos_3 [3] = 0;
Block_X_size_3 [3] = 40;
Block_Y_size_3 [3] = 480;
Block_X_Pos_3 [4] = 380;
Block_Y_Pos_3 [4] = 0;
Block_X_size_3 [4] = 260;
Block_Y_size_3 [4] = 40;
Block_X_Pos_3 [5] = 0;
Block_Y_Pos_3 [5] = 440;
Block_X_size_3 [5] = 40;
Block_Y_size_3 [5] = 40;
Block_X_Pos_3 [6] = 0;
Block_Y_Pos_3 [6] = 400;
Block_X_size_3 [6] = 640;
Block_Y_size_3 [6] = 100;

    end

    assign MapEnd_X_Addr = DrawX - MapEnd_X_Pos;
    assign MapEnd_Y_Addr = DrawY - MapEnd_Y_Pos;
    parameter MapEnd_X_Size = 17;
    parameter MapEnd_Y_Size = 24;

    always_comb
    begin
        if (state_index != 3 && (state_index != 2 || !(boss_counter <200)) &&(MapEnd_X_Addr>=0 && MapEnd_X_Addr<MapEnd_X_Size) 
             &&(MapEnd_Y_Addr>=0 && MapEnd_Y_Addr<MapEnd_Y_Size) )
            is_MapEnd = 1;
        else 
            is_MapEnd = 0;
    end

endmodule

