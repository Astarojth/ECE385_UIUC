module Win (
    input [9:0] DrawX, DrawY,
    input logic win,
    input [9:0] Ball_X_Pos, Ball_Y_Pos,
    output logic is_win,
    output [9:0] win_X_Addr, win_Y_Addr
);

parameter [9:0] Win_X_Size = 178;
parameter [9:0] Win_Y_Size = 30;

// 定义屏幕中央位置
parameter [9:0] Center_X = (640 - Win_X_Size) / 2;
parameter [9:0] Center_Y = (480 - Win_Y_Size) / 2;

assign win_X_Addr = DrawX - Center_X;
assign win_Y_Addr = DrawY - Center_Y;

always_comb
begin
    if ((win_X_Addr >= 0) && (win_X_Addr < Win_X_Size) && 
        (win_Y_Addr >= 0) && (win_Y_Addr < Win_Y_Size) && win == 1'b1) 
    begin
        is_win = 1'b1;
    end
    else 
    begin
        is_win = 1'b0;
    end
end

endmodule