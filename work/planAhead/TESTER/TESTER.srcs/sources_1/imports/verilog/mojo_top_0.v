/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    output reg [23:0] io_led,
    input [4:0] io_button,
    input p1_button,
    input p2_button,
    input start_button
  );
  
  
  
  reg rst;
  
  wire [16-1:0] M_alu_out;
  reg [16-1:0] M_alu_a;
  reg [16-1:0] M_alu_b;
  reg [6-1:0] M_alu_alufn;
  alu_1 alu (
    .a(M_alu_a),
    .b(M_alu_b),
    .alufn(M_alu_alufn),
    .out(M_alu_out)
  );
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_2 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  localparam MENU_state = 3'd0;
  localparam P1_state = 3'd1;
  localparam P2_state = 3'd2;
  localparam P1_LOSE_state = 3'd3;
  localparam P2_LOSE_state = 3'd4;
  localparam LOSE_state = 3'd5;
  
  reg [2:0] M_state_d, M_state_q = MENU_state;
  reg [15:0] M_ball_pos_d, M_ball_pos_q = 1'h0;
  reg [23:0] M_ball_speed_d, M_ball_speed_q = 1'h0;
  reg [15:0] M_lives_p1_d, M_lives_p1_q = 1'h0;
  reg [15:0] M_lives_p2_d, M_lives_p2_q = 1'h0;
  reg [23:0] M_speeds_d, M_speeds_q = 1'h0;
  reg [1:0] M_speed_counter_d, M_speed_counter_q = 1'h0;
  wire [1-1:0] M_button_p1_press;
  reg [1-1:0] M_button_p1_button;
  button_3 button_p1 (
    .clk(clk),
    .rst(rst),
    .button(M_button_p1_button),
    .press(M_button_p1_press)
  );
  wire [1-1:0] M_button_p2_press;
  reg [1-1:0] M_button_p2_button;
  button_3 button_p2 (
    .clk(clk),
    .rst(rst),
    .button(M_button_p2_button),
    .press(M_button_p2_press)
  );
  wire [1-1:0] M_button_start_press;
  reg [1-1:0] M_button_start_button;
  button_3 button_start (
    .clk(clk),
    .rst(rst),
    .button(M_button_start_button),
    .press(M_button_start_press)
  );
  
  always @* begin
    M_state_d = M_state_q;
    M_speeds_d = M_speeds_q;
    M_speed_counter_d = M_speed_counter_q;
    M_ball_speed_d = M_ball_speed_q;
    M_lives_p1_d = M_lives_p1_q;
    M_lives_p2_d = M_lives_p2_q;
    M_ball_pos_d = M_ball_pos_q;
    
    led = M_speed_counter_q;
    M_alu_a = 1'h0;
    M_alu_b = 1'h1;
    M_alu_alufn = 1'h0;
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    io_led[0+7-:8] = M_ball_pos_q[0+7-:8];
    io_led[8+7-:8] = M_ball_pos_q[8+7-:8];
    io_led[16+7-:8] = 1'h0;
    io_led[16+5+2-:3] = M_lives_p1_q[13+2-:3];
    io_led[16+0+2-:3] = M_lives_p2_q[0+2-:3];
    M_button_p1_button = io_button[3+0-:1];
    M_button_p2_button = io_button[4+0-:1];
    M_button_start_button = io_button[1+0-:1];
    if (M_speed_counter_q == 2'h3) begin
      M_speed_counter_d = 2'h0;
      if (M_speeds_q == 24'h800000) begin
        M_speeds_d = 24'h408000;
      end else begin
        if (M_speeds_q == 24'h408000) begin
          M_speeds_d = 24'h308000;
        end else begin
          if (M_speeds_q == 24'h308000) begin
            M_speeds_d = 24'h300800;
          end else begin
            M_speeds_d = 24'h1f0000;
          end
        end
      end
    end
    
    case (M_state_q)
      MENU_state: begin
        led = 8'haa;
        M_ball_pos_d = 18'h00001;
        M_lives_p1_d = 16'he000;
        M_lives_p2_d = 16'h0007;
        M_speeds_d = 24'h800000;
        M_speed_counter_d = 1'h0;
        if (M_button_start_press) begin
          M_state_d = P1_state;
        end
      end
      P1_state: begin
        if (!M_ball_pos_q[0+15-:16]) begin
          M_lives_p1_d = M_lives_p1_q << 1'h1;
          M_state_d = P1_LOSE_state;
        end
        if (M_button_p1_press) begin
          if (M_ball_pos_q[15+0-:1] | M_ball_pos_q[14+0-:1]) begin
            M_speed_counter_d = M_speed_counter_q + 1'h1;
            M_state_d = P2_state;
          end else begin
            M_lives_p1_d = M_lives_p1_q << 1'h1;
            M_state_d = P1_LOSE_state;
          end
        end
      end
      P2_state: begin
        if (!M_ball_pos_q) begin
          M_lives_p2_d = M_lives_p2_q >> 1'h1;
          M_state_d = P2_LOSE_state;
        end
        if (M_button_p2_press) begin
          if (M_ball_pos_q[0+0-:1] | M_ball_pos_q[1+0-:1]) begin
            M_speed_counter_d = M_speed_counter_q + 1'h1;
            M_state_d = P1_state;
          end else begin
            M_lives_p2_d = M_lives_p2_q >> 1'h1;
            M_state_d = P2_LOSE_state;
          end
        end
      end
      P1_LOSE_state: begin
        M_alu_a = M_lives_p1_q;
        M_alu_b = 1'h0;
        M_alu_alufn = 6'h33;
        if (M_alu_out) begin
          M_state_d = LOSE_state;
        end else begin
          M_ball_pos_d = 16'h8000;
          if (M_button_p1_press) begin
            M_state_d = P2_state;
          end
        end
      end
      P2_LOSE_state: begin
        M_alu_a = M_lives_p2_q;
        M_alu_b = 1'h0;
        M_alu_alufn = 6'h33;
        if (M_alu_out) begin
          M_state_d = LOSE_state;
        end else begin
          M_ball_pos_d = 16'h0001;
          if (M_button_p2_press) begin
            M_state_d = P1_state;
          end
        end
      end
      LOSE_state: begin
        io_led[16+3+1-:2] = 2'h3;
        M_alu_a = M_lives_p1_q[13+2-:3];
        M_alu_b = 1'h0;
        M_alu_alufn = 6'h33;
        if (M_alu_out) begin
          io_led[0+7-:8] = 8'hff;
          io_led[8+7-:8] = 1'h0;
        end else begin
          io_led[0+7-:8] = 1'h0;
          io_led[8+7-:8] = 8'hff;
        end
        if (M_button_start_press) begin
          M_state_d = MENU_state;
        end else begin
          M_state_d = LOSE_state;
        end
      end
    endcase
    M_ball_speed_d = M_ball_speed_q + 1'h1;
    if (M_ball_speed_q[0+23-:24] >= M_speeds_q[0+23-:24]) begin
      M_ball_speed_d[0+23-:24] = 1'h0;
      
      case (M_state_q)
        P1_state: begin
          M_alu_a = M_ball_pos_q;
          M_alu_b = 1'h1;
          M_alu_alufn = 6'h20;
          M_ball_pos_d = M_alu_out;
        end
        P2_state: begin
          M_alu_a = M_ball_pos_q;
          M_alu_b = 1'h1;
          M_alu_alufn = 6'h21;
          M_ball_pos_d = M_alu_out;
        end
      endcase
    end
    if (M_speeds_q <= 24'h408000) begin
      io_led[0+5+2-:3] = 1'h0;
      io_led[8+0+2-:3] = 1'h0;
    end
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_ball_pos_q <= 1'h0;
      M_ball_speed_q <= 1'h0;
      M_lives_p1_q <= 1'h0;
      M_lives_p2_q <= 1'h0;
      M_speeds_q <= 1'h0;
      M_speed_counter_q <= 1'h0;
      M_state_q <= 1'h0;
    end else begin
      M_ball_pos_q <= M_ball_pos_d;
      M_ball_speed_q <= M_ball_speed_d;
      M_lives_p1_q <= M_lives_p1_d;
      M_lives_p2_q <= M_lives_p2_d;
      M_speeds_q <= M_speeds_d;
      M_speed_counter_q <= M_speed_counter_d;
      M_state_q <= M_state_d;
    end
  end
  
endmodule