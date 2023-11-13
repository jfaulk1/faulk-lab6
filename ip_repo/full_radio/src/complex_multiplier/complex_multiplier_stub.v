// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Sat Nov 11 14:28:10 2023
// Host        : DESKTOP-37UOHH9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/JHU/SoC/Lab6/radio_periph_lab/ip_repo/full_radio/src/complex_multiplier/complex_multiplier_stub.v
// Design      : complex_multiplier
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "cmpy_v6_0_21,Vivado 2022.1" *)
module complex_multiplier(aclk, s_axis_a_tvalid, s_axis_a_tdata, 
  s_axis_b_tvalid, s_axis_b_tdata, m_axis_dout_tvalid, m_axis_dout_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_a_tvalid,s_axis_a_tdata[15:0],s_axis_b_tvalid,s_axis_b_tdata[31:0],m_axis_dout_tvalid,m_axis_dout_tdata[31:0]" */;
  input aclk;
  input s_axis_a_tvalid;
  input [15:0]s_axis_a_tdata;
  input s_axis_b_tvalid;
  input [31:0]s_axis_b_tdata;
  output m_axis_dout_tvalid;
  output [31:0]m_axis_dout_tdata;
endmodule
