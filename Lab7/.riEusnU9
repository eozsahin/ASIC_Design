
module lab7_out_ctrl ( clk, n_rst, d_plus, d_minus, bus_mode, tx_value );
  input [1:0] bus_mode;
  input clk, n_rst, tx_value;
  output d_plus, d_minus;
  wire   n9, n10, n3, n4, n5, n6, n7, n8, n11, n12;

  DFFSR d_minus_reg_reg ( .D(n10), .CLK(clk), .R(n_rst), .S(1'b1), .Q(d_minus)
         );
  DFFSR d_plus_reg_reg ( .D(n9), .CLK(clk), .R(1'b1), .S(n_rst), .Q(d_plus) );
  INVX2 U5 ( .A(tx_value), .Y(n3) );
  MUX2X1 U6 ( .B(d_minus), .A(n3), .S(n5), .Y(n4) );
  INVX2 U7 ( .A(bus_mode[0]), .Y(n7) );
  NOR2X1 U8 ( .A(n7), .B(n4), .Y(n10) );
  INVX2 U9 ( .A(bus_mode[1]), .Y(n5) );
  NAND2X1 U10 ( .A(bus_mode[0]), .B(n5), .Y(n11) );
  INVX2 U11 ( .A(d_plus), .Y(n6) );
  OAI21X1 U12 ( .A(n7), .B(n6), .C(bus_mode[1]), .Y(n8) );
  OAI21X1 U13 ( .A(tx_value), .B(n11), .C(n8), .Y(n12) );
  INVX2 U14 ( .A(n12), .Y(n9) );
endmodule


module lab7_encoder ( clk, n_rst, tx_bit, shift_enable, tx_value );
  input clk, n_rst, tx_bit, shift_enable;
  output tx_value;
  wire   last_bit, n4, n1, n2;

  DFFSR last_bit_reg ( .D(n4), .CLK(clk), .R(1'b1), .S(n_rst), .Q(last_bit) );
  XOR2X1 U2 ( .A(tx_bit), .B(n2), .Y(tx_value) );
  INVX1 U3 ( .A(tx_bit), .Y(n1) );
  INVX2 U4 ( .A(last_bit), .Y(n2) );
  MUX2X1 U5 ( .B(n2), .A(n1), .S(shift_enable), .Y(n4) );
endmodule


module lab7_tx_sr_1 ( clk, n_rst, shift_enable, tx_enable, tx_data, load_data, 
        tx_out );
  input [7:0] tx_data;
  input clk, n_rst, shift_enable, tx_enable, load_data;
  output tx_out;
  wire   n29, n30, n31, n32, n33, n34, n35, n36, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49;
  wire   [7:1] curr_val;

  DFFSR \curr_val_reg[7]  ( .D(n30), .CLK(clk), .R(n15), .S(1'b1), .Q(
        curr_val[7]) );
  DFFSR \curr_val_reg[6]  ( .D(n31), .CLK(clk), .R(n15), .S(1'b1), .Q(
        curr_val[6]) );
  DFFSR \curr_val_reg[5]  ( .D(n32), .CLK(clk), .R(n15), .S(1'b1), .Q(
        curr_val[5]) );
  DFFSR \curr_val_reg[4]  ( .D(n33), .CLK(clk), .R(n15), .S(1'b1), .Q(
        curr_val[4]) );
  DFFSR \curr_val_reg[3]  ( .D(n34), .CLK(clk), .R(n15), .S(1'b1), .Q(
        curr_val[3]) );
  DFFSR \curr_val_reg[2]  ( .D(n35), .CLK(clk), .R(n15), .S(1'b1), .Q(
        curr_val[2]) );
  DFFSR \curr_val_reg[1]  ( .D(n36), .CLK(clk), .R(n15), .S(1'b1), .Q(
        curr_val[1]) );
  DFFSR \curr_val_reg[0]  ( .D(n29), .CLK(clk), .R(n15), .S(1'b1), .Q(tx_out)
         );
  INVX1 U11 ( .A(load_data), .Y(n9) );
  INVX1 U12 ( .A(load_data), .Y(n17) );
  AND2X2 U13 ( .A(n9), .B(n18), .Y(n13) );
  AND2X1 U14 ( .A(tx_enable), .B(shift_enable), .Y(n10) );
  AND2X2 U15 ( .A(n10), .B(n17), .Y(n11) );
  INVX1 U16 ( .A(n11), .Y(n20) );
  AND2X2 U17 ( .A(n9), .B(n18), .Y(n12) );
  INVX2 U18 ( .A(n16), .Y(n15) );
  INVX2 U19 ( .A(n_rst), .Y(n16) );
  BUFX2 U20 ( .A(load_data), .Y(n14) );
  NAND2X1 U21 ( .A(shift_enable), .B(tx_enable), .Y(n18) );
  MUX2X1 U22 ( .B(tx_data[7]), .A(curr_val[7]), .S(n13), .Y(n19) );
  NAND2X1 U23 ( .A(n20), .B(n19), .Y(n30) );
  NAND2X1 U24 ( .A(curr_val[7]), .B(n11), .Y(n23) );
  NAND2X1 U25 ( .A(n12), .B(curr_val[6]), .Y(n22) );
  NAND2X1 U26 ( .A(tx_data[6]), .B(n14), .Y(n21) );
  NAND3X1 U27 ( .A(n21), .B(n23), .C(n22), .Y(n31) );
  NAND2X1 U28 ( .A(curr_val[6]), .B(n11), .Y(n26) );
  NAND2X1 U29 ( .A(n12), .B(curr_val[5]), .Y(n25) );
  NAND2X1 U30 ( .A(tx_data[5]), .B(n14), .Y(n24) );
  NAND3X1 U31 ( .A(n24), .B(n26), .C(n25), .Y(n32) );
  NAND2X1 U32 ( .A(curr_val[5]), .B(n11), .Y(n37) );
  NAND2X1 U33 ( .A(n12), .B(curr_val[4]), .Y(n28) );
  NAND2X1 U34 ( .A(tx_data[4]), .B(n14), .Y(n27) );
  NAND3X1 U35 ( .A(n27), .B(n37), .C(n28), .Y(n33) );
  NAND2X1 U36 ( .A(curr_val[4]), .B(n11), .Y(n40) );
  NAND2X1 U37 ( .A(n12), .B(curr_val[3]), .Y(n39) );
  NAND2X1 U38 ( .A(tx_data[3]), .B(n14), .Y(n38) );
  NAND3X1 U39 ( .A(n38), .B(n40), .C(n39), .Y(n34) );
  NAND2X1 U40 ( .A(curr_val[3]), .B(n11), .Y(n43) );
  NAND2X1 U41 ( .A(n12), .B(curr_val[2]), .Y(n42) );
  NAND2X1 U42 ( .A(tx_data[2]), .B(n14), .Y(n41) );
  NAND3X1 U43 ( .A(n41), .B(n43), .C(n42), .Y(n35) );
  NAND2X1 U44 ( .A(curr_val[2]), .B(n11), .Y(n46) );
  NAND2X1 U45 ( .A(n12), .B(curr_val[1]), .Y(n45) );
  NAND2X1 U46 ( .A(tx_data[1]), .B(n14), .Y(n44) );
  NAND3X1 U47 ( .A(n44), .B(n46), .C(n45), .Y(n36) );
  NAND2X1 U48 ( .A(curr_val[1]), .B(n11), .Y(n49) );
  NAND2X1 U49 ( .A(n12), .B(tx_out), .Y(n48) );
  NAND2X1 U50 ( .A(tx_data[0]), .B(n14), .Y(n47) );
  NAND3X1 U51 ( .A(n47), .B(n49), .C(n48), .Y(n29) );
endmodule


module fiforam ( wclk, wenable, waddr, raddr, wdata, rdata );
  input [2:0] waddr;
  input [2:0] raddr;
  input [7:0] wdata;
  output [7:0] rdata;
  input wclk, wenable;
  wire   \fiforeg[0][7] , \fiforeg[0][6] , \fiforeg[0][5] , \fiforeg[0][4] ,
         \fiforeg[0][3] , \fiforeg[0][2] , \fiforeg[0][1] , \fiforeg[0][0] ,
         \fiforeg[1][7] , \fiforeg[1][6] , \fiforeg[1][5] , \fiforeg[1][4] ,
         \fiforeg[1][3] , \fiforeg[1][2] , \fiforeg[1][1] , \fiforeg[1][0] ,
         \fiforeg[2][7] , \fiforeg[2][6] , \fiforeg[2][5] , \fiforeg[2][4] ,
         \fiforeg[2][3] , \fiforeg[2][2] , \fiforeg[2][1] , \fiforeg[2][0] ,
         \fiforeg[3][7] , \fiforeg[3][6] , \fiforeg[3][5] , \fiforeg[3][4] ,
         \fiforeg[3][3] , \fiforeg[3][2] , \fiforeg[3][1] , \fiforeg[3][0] ,
         \fiforeg[4][7] , \fiforeg[4][6] , \fiforeg[4][5] , \fiforeg[4][4] ,
         \fiforeg[4][3] , \fiforeg[4][2] , \fiforeg[4][1] , \fiforeg[4][0] ,
         \fiforeg[5][7] , \fiforeg[5][6] , \fiforeg[5][5] , \fiforeg[5][4] ,
         \fiforeg[5][3] , \fiforeg[5][2] , \fiforeg[5][1] , \fiforeg[5][0] ,
         \fiforeg[6][7] , \fiforeg[6][6] , \fiforeg[6][5] , \fiforeg[6][4] ,
         \fiforeg[6][3] , \fiforeg[6][2] , \fiforeg[6][1] , \fiforeg[6][0] ,
         \fiforeg[7][7] , \fiforeg[7][6] , \fiforeg[7][5] , \fiforeg[7][4] ,
         \fiforeg[7][3] , \fiforeg[7][2] , \fiforeg[7][1] , \fiforeg[7][0] ,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n276,
         n277, n278, n279, n280, n281, n282, n283, n284, n285, n286, n287,
         n288, n289, n290, n291, n292, n293, n294;

  DFFPOSX1 \fiforeg_reg[7][7]  ( .D(n212), .CLK(wclk), .Q(\fiforeg[7][7] ) );
  DFFPOSX1 \fiforeg_reg[6][7]  ( .D(n213), .CLK(wclk), .Q(\fiforeg[6][7] ) );
  DFFPOSX1 \fiforeg_reg[5][7]  ( .D(n214), .CLK(wclk), .Q(\fiforeg[5][7] ) );
  DFFPOSX1 \fiforeg_reg[4][7]  ( .D(n215), .CLK(wclk), .Q(\fiforeg[4][7] ) );
  DFFPOSX1 \fiforeg_reg[3][7]  ( .D(n216), .CLK(wclk), .Q(\fiforeg[3][7] ) );
  DFFPOSX1 \fiforeg_reg[2][7]  ( .D(n217), .CLK(wclk), .Q(\fiforeg[2][7] ) );
  DFFPOSX1 \fiforeg_reg[1][7]  ( .D(n218), .CLK(wclk), .Q(\fiforeg[1][7] ) );
  DFFPOSX1 \fiforeg_reg[0][7]  ( .D(n219), .CLK(wclk), .Q(\fiforeg[0][7] ) );
  DFFPOSX1 \fiforeg_reg[7][6]  ( .D(n220), .CLK(wclk), .Q(\fiforeg[7][6] ) );
  DFFPOSX1 \fiforeg_reg[6][6]  ( .D(n221), .CLK(wclk), .Q(\fiforeg[6][6] ) );
  DFFPOSX1 \fiforeg_reg[5][6]  ( .D(n222), .CLK(wclk), .Q(\fiforeg[5][6] ) );
  DFFPOSX1 \fiforeg_reg[4][6]  ( .D(n223), .CLK(wclk), .Q(\fiforeg[4][6] ) );
  DFFPOSX1 \fiforeg_reg[3][6]  ( .D(n224), .CLK(wclk), .Q(\fiforeg[3][6] ) );
  DFFPOSX1 \fiforeg_reg[2][6]  ( .D(n225), .CLK(wclk), .Q(\fiforeg[2][6] ) );
  DFFPOSX1 \fiforeg_reg[1][6]  ( .D(n226), .CLK(wclk), .Q(\fiforeg[1][6] ) );
  DFFPOSX1 \fiforeg_reg[0][6]  ( .D(n227), .CLK(wclk), .Q(\fiforeg[0][6] ) );
  DFFPOSX1 \fiforeg_reg[7][5]  ( .D(n228), .CLK(wclk), .Q(\fiforeg[7][5] ) );
  DFFPOSX1 \fiforeg_reg[6][5]  ( .D(n229), .CLK(wclk), .Q(\fiforeg[6][5] ) );
  DFFPOSX1 \fiforeg_reg[5][5]  ( .D(n230), .CLK(wclk), .Q(\fiforeg[5][5] ) );
  DFFPOSX1 \fiforeg_reg[4][5]  ( .D(n231), .CLK(wclk), .Q(\fiforeg[4][5] ) );
  DFFPOSX1 \fiforeg_reg[3][5]  ( .D(n232), .CLK(wclk), .Q(\fiforeg[3][5] ) );
  DFFPOSX1 \fiforeg_reg[2][5]  ( .D(n233), .CLK(wclk), .Q(\fiforeg[2][5] ) );
  DFFPOSX1 \fiforeg_reg[1][5]  ( .D(n234), .CLK(wclk), .Q(\fiforeg[1][5] ) );
  DFFPOSX1 \fiforeg_reg[0][5]  ( .D(n235), .CLK(wclk), .Q(\fiforeg[0][5] ) );
  DFFPOSX1 \fiforeg_reg[7][4]  ( .D(n236), .CLK(wclk), .Q(\fiforeg[7][4] ) );
  DFFPOSX1 \fiforeg_reg[6][4]  ( .D(n237), .CLK(wclk), .Q(\fiforeg[6][4] ) );
  DFFPOSX1 \fiforeg_reg[5][4]  ( .D(n238), .CLK(wclk), .Q(\fiforeg[5][4] ) );
  DFFPOSX1 \fiforeg_reg[4][4]  ( .D(n239), .CLK(wclk), .Q(\fiforeg[4][4] ) );
  DFFPOSX1 \fiforeg_reg[3][4]  ( .D(n240), .CLK(wclk), .Q(\fiforeg[3][4] ) );
  DFFPOSX1 \fiforeg_reg[2][4]  ( .D(n241), .CLK(wclk), .Q(\fiforeg[2][4] ) );
  DFFPOSX1 \fiforeg_reg[1][4]  ( .D(n242), .CLK(wclk), .Q(\fiforeg[1][4] ) );
  DFFPOSX1 \fiforeg_reg[0][4]  ( .D(n243), .CLK(wclk), .Q(\fiforeg[0][4] ) );
  DFFPOSX1 \fiforeg_reg[7][3]  ( .D(n244), .CLK(wclk), .Q(\fiforeg[7][3] ) );
  DFFPOSX1 \fiforeg_reg[6][3]  ( .D(n245), .CLK(wclk), .Q(\fiforeg[6][3] ) );
  DFFPOSX1 \fiforeg_reg[5][3]  ( .D(n246), .CLK(wclk), .Q(\fiforeg[5][3] ) );
  DFFPOSX1 \fiforeg_reg[4][3]  ( .D(n247), .CLK(wclk), .Q(\fiforeg[4][3] ) );
  DFFPOSX1 \fiforeg_reg[3][3]  ( .D(n248), .CLK(wclk), .Q(\fiforeg[3][3] ) );
  DFFPOSX1 \fiforeg_reg[2][3]  ( .D(n249), .CLK(wclk), .Q(\fiforeg[2][3] ) );
  DFFPOSX1 \fiforeg_reg[1][3]  ( .D(n250), .CLK(wclk), .Q(\fiforeg[1][3] ) );
  DFFPOSX1 \fiforeg_reg[0][3]  ( .D(n251), .CLK(wclk), .Q(\fiforeg[0][3] ) );
  DFFPOSX1 \fiforeg_reg[7][2]  ( .D(n252), .CLK(wclk), .Q(\fiforeg[7][2] ) );
  DFFPOSX1 \fiforeg_reg[6][2]  ( .D(n253), .CLK(wclk), .Q(\fiforeg[6][2] ) );
  DFFPOSX1 \fiforeg_reg[5][2]  ( .D(n254), .CLK(wclk), .Q(\fiforeg[5][2] ) );
  DFFPOSX1 \fiforeg_reg[4][2]  ( .D(n255), .CLK(wclk), .Q(\fiforeg[4][2] ) );
  DFFPOSX1 \fiforeg_reg[3][2]  ( .D(n256), .CLK(wclk), .Q(\fiforeg[3][2] ) );
  DFFPOSX1 \fiforeg_reg[2][2]  ( .D(n257), .CLK(wclk), .Q(\fiforeg[2][2] ) );
  DFFPOSX1 \fiforeg_reg[1][2]  ( .D(n258), .CLK(wclk), .Q(\fiforeg[1][2] ) );
  DFFPOSX1 \fiforeg_reg[0][2]  ( .D(n259), .CLK(wclk), .Q(\fiforeg[0][2] ) );
  DFFPOSX1 \fiforeg_reg[7][1]  ( .D(n260), .CLK(wclk), .Q(\fiforeg[7][1] ) );
  DFFPOSX1 \fiforeg_reg[6][1]  ( .D(n261), .CLK(wclk), .Q(\fiforeg[6][1] ) );
  DFFPOSX1 \fiforeg_reg[5][1]  ( .D(n262), .CLK(wclk), .Q(\fiforeg[5][1] ) );
  DFFPOSX1 \fiforeg_reg[4][1]  ( .D(n263), .CLK(wclk), .Q(\fiforeg[4][1] ) );
  DFFPOSX1 \fiforeg_reg[3][1]  ( .D(n264), .CLK(wclk), .Q(\fiforeg[3][1] ) );
  DFFPOSX1 \fiforeg_reg[2][1]  ( .D(n265), .CLK(wclk), .Q(\fiforeg[2][1] ) );
  DFFPOSX1 \fiforeg_reg[1][1]  ( .D(n266), .CLK(wclk), .Q(\fiforeg[1][1] ) );
  DFFPOSX1 \fiforeg_reg[0][1]  ( .D(n267), .CLK(wclk), .Q(\fiforeg[0][1] ) );
  DFFPOSX1 \fiforeg_reg[7][0]  ( .D(n275), .CLK(wclk), .Q(\fiforeg[7][0] ) );
  DFFPOSX1 \fiforeg_reg[6][0]  ( .D(n268), .CLK(wclk), .Q(\fiforeg[6][0] ) );
  DFFPOSX1 \fiforeg_reg[5][0]  ( .D(n269), .CLK(wclk), .Q(\fiforeg[5][0] ) );
  DFFPOSX1 \fiforeg_reg[4][0]  ( .D(n270), .CLK(wclk), .Q(\fiforeg[4][0] ) );
  DFFPOSX1 \fiforeg_reg[3][0]  ( .D(n271), .CLK(wclk), .Q(\fiforeg[3][0] ) );
  DFFPOSX1 \fiforeg_reg[2][0]  ( .D(n272), .CLK(wclk), .Q(\fiforeg[2][0] ) );
  DFFPOSX1 \fiforeg_reg[1][0]  ( .D(n273), .CLK(wclk), .Q(\fiforeg[1][0] ) );
  DFFPOSX1 \fiforeg_reg[0][0]  ( .D(n274), .CLK(wclk), .Q(\fiforeg[0][0] ) );
  MUX2X1 U2 ( .B(wdata[7]), .A(n202), .S(n1), .Y(n278) );
  INVX8 U3 ( .A(wenable), .Y(n1) );
  INVX4 U4 ( .A(raddr[0]), .Y(n65) );
  BUFX2 U5 ( .A(raddr[1]), .Y(n2) );
  INVX1 U6 ( .A(n2), .Y(n3) );
  INVX1 U7 ( .A(raddr[1]), .Y(n61) );
  MUX2X1 U8 ( .B(n21), .A(n187), .S(n13), .Y(n224) );
  MUX2X1 U9 ( .B(n23), .A(n167), .S(n13), .Y(n232) );
  MUX2X1 U10 ( .B(n25), .A(n147), .S(n13), .Y(n240) );
  MUX2X1 U11 ( .B(n27), .A(n127), .S(n13), .Y(n248) );
  INVX4 U12 ( .A(n210), .Y(n13) );
  MUX2X1 U13 ( .B(n20), .A(n186), .S(n40), .Y(n225) );
  INVX8 U14 ( .A(n41), .Y(n203) );
  INVX2 U15 ( .A(wenable), .Y(n11) );
  INVX1 U16 ( .A(n64), .Y(n4) );
  BUFX4 U17 ( .A(n289), .Y(n5) );
  BUFX4 U18 ( .A(n285), .Y(n6) );
  MUX2X1 U19 ( .B(n29), .A(n107), .S(n13), .Y(n256) );
  MUX2X1 U20 ( .B(n31), .A(n87), .S(n13), .Y(n264) );
  INVX1 U21 ( .A(wenable), .Y(n12) );
  MUX2X1 U22 ( .B(n19), .A(n288), .S(n13), .Y(n216) );
  MUX2X1 U23 ( .B(n19), .A(n282), .S(n10), .Y(n219) );
  INVX4 U24 ( .A(n10), .Y(n276) );
  INVX2 U25 ( .A(n9), .Y(n10) );
  MUX2X1 U26 ( .B(n18), .A(n286), .S(n40), .Y(n217) );
  BUFX2 U27 ( .A(n182), .Y(n21) );
  INVX1 U28 ( .A(waddr[1]), .Y(n7) );
  INVX2 U29 ( .A(waddr[1]), .Y(n45) );
  INVX1 U30 ( .A(waddr[1]), .Y(n8) );
  INVX1 U31 ( .A(n34), .Y(n9) );
  MUX2X1 U32 ( .B(wdata[5]), .A(n158), .S(n11), .Y(n162) );
  MUX2X1 U33 ( .B(wdata[4]), .A(n138), .S(n11), .Y(n142) );
  MUX2X1 U34 ( .B(wdata[3]), .A(n118), .S(n11), .Y(n122) );
  MUX2X1 U35 ( .B(wdata[2]), .A(n98), .S(n11), .Y(n102) );
  MUX2X1 U36 ( .B(wdata[1]), .A(n78), .S(n12), .Y(n82) );
  MUX2X1 U37 ( .B(wdata[0]), .A(n53), .S(n14), .Y(n32) );
  MUX2X1 U38 ( .B(n32), .A(n67), .S(n13), .Y(n271) );
  INVX4 U39 ( .A(waddr[2]), .Y(n46) );
  INVX4 U40 ( .A(n194), .Y(n33) );
  INVX4 U41 ( .A(waddr[0]), .Y(n47) );
  INVX1 U42 ( .A(wenable), .Y(n14) );
  MUX2X1 U43 ( .B(wdata[0]), .A(n53), .S(n14), .Y(n57) );
  AND2X2 U44 ( .A(n17), .B(n65), .Y(n15) );
  AND2X2 U45 ( .A(n17), .B(raddr[0]), .Y(n16) );
  INVX2 U46 ( .A(n193), .Y(n35) );
  INVX2 U47 ( .A(n195), .Y(n39) );
  INVX2 U48 ( .A(n196), .Y(n37) );
  AND2X2 U49 ( .A(raddr[1]), .B(raddr[2]), .Y(n17) );
  BUFX4 U50 ( .A(n278), .Y(n18) );
  BUFX4 U51 ( .A(n278), .Y(n19) );
  BUFX4 U52 ( .A(n182), .Y(n20) );
  BUFX4 U53 ( .A(n162), .Y(n22) );
  BUFX4 U54 ( .A(n162), .Y(n23) );
  BUFX4 U55 ( .A(n142), .Y(n24) );
  BUFX4 U56 ( .A(n142), .Y(n25) );
  BUFX4 U57 ( .A(n122), .Y(n26) );
  BUFX4 U58 ( .A(n122), .Y(n27) );
  BUFX4 U59 ( .A(n102), .Y(n28) );
  BUFX4 U60 ( .A(n102), .Y(n29) );
  BUFX4 U61 ( .A(n82), .Y(n30) );
  BUFX4 U62 ( .A(n82), .Y(n31) );
  INVX4 U63 ( .A(n42), .Y(n205) );
  INVX4 U64 ( .A(n43), .Y(n207) );
  INVX4 U65 ( .A(n44), .Y(n277) );
  INVX8 U66 ( .A(n33), .Y(n34) );
  INVX8 U67 ( .A(n35), .Y(n36) );
  INVX8 U68 ( .A(n37), .Y(n38) );
  INVX8 U69 ( .A(n39), .Y(n40) );
  INVX2 U70 ( .A(\fiforeg[6][0] ), .Y(n54) );
  NAND3X1 U71 ( .A(waddr[2]), .B(waddr[1]), .C(n47), .Y(n41) );
  NAND3X1 U72 ( .A(waddr[2]), .B(waddr[1]), .C(waddr[0]), .Y(n42) );
  AOI22X1 U73 ( .A(\fiforeg[6][0] ), .B(n203), .C(\fiforeg[7][0] ), .D(n205), 
        .Y(n52) );
  NAND3X1 U74 ( .A(waddr[2]), .B(n47), .C(n7), .Y(n43) );
  NAND3X1 U75 ( .A(waddr[2]), .B(waddr[0]), .C(n8), .Y(n44) );
  AOI22X1 U76 ( .A(\fiforeg[4][0] ), .B(n207), .C(\fiforeg[5][0] ), .D(n277), 
        .Y(n51) );
  NAND3X1 U77 ( .A(n45), .B(n46), .C(n47), .Y(n194) );
  INVX2 U78 ( .A(\fiforeg[0][0] ), .Y(n62) );
  NAND3X1 U79 ( .A(waddr[0]), .B(n45), .C(n46), .Y(n193) );
  INVX2 U80 ( .A(\fiforeg[1][0] ), .Y(n63) );
  OAI22X1 U81 ( .A(n62), .B(n34), .C(n36), .D(n63), .Y(n49) );
  NAND3X1 U82 ( .A(waddr[1]), .B(waddr[0]), .C(n46), .Y(n196) );
  INVX2 U83 ( .A(\fiforeg[3][0] ), .Y(n67) );
  NAND3X1 U84 ( .A(waddr[1]), .B(n46), .C(n47), .Y(n195) );
  INVX2 U85 ( .A(\fiforeg[2][0] ), .Y(n66) );
  OAI22X1 U86 ( .A(n38), .B(n67), .C(n40), .D(n66), .Y(n48) );
  NOR2X1 U87 ( .A(n49), .B(n48), .Y(n50) );
  NAND3X1 U88 ( .A(n52), .B(n51), .C(n50), .Y(n53) );
  MUX2X1 U89 ( .B(n54), .A(n32), .S(n203), .Y(n268) );
  INVX2 U90 ( .A(\fiforeg[7][0] ), .Y(n55) );
  MUX2X1 U91 ( .B(n55), .A(n57), .S(n205), .Y(n275) );
  INVX2 U92 ( .A(\fiforeg[4][0] ), .Y(n56) );
  MUX2X1 U93 ( .B(n56), .A(n32), .S(n207), .Y(n270) );
  INVX2 U94 ( .A(n40), .Y(n209) );
  MUX2X1 U95 ( .B(n66), .A(n57), .S(n209), .Y(n272) );
  INVX2 U96 ( .A(n38), .Y(n210) );
  INVX2 U97 ( .A(n36), .Y(n211) );
  MUX2X1 U98 ( .B(n63), .A(n57), .S(n211), .Y(n273) );
  MUX2X1 U99 ( .B(n62), .A(n57), .S(n276), .Y(n274) );
  INVX2 U100 ( .A(\fiforeg[5][0] ), .Y(n58) );
  MUX2X1 U101 ( .B(n58), .A(n32), .S(n277), .Y(n269) );
  NAND3X1 U102 ( .A(raddr[0]), .B(n4), .C(n61), .Y(n59) );
  INVX2 U103 ( .A(n59), .Y(n281) );
  NAND3X1 U104 ( .A(n4), .B(n3), .C(n65), .Y(n60) );
  INVX2 U105 ( .A(n60), .Y(n280) );
  AOI22X1 U106 ( .A(\fiforeg[5][0] ), .B(n281), .C(\fiforeg[4][0] ), .D(n280), 
        .Y(n72) );
  AOI22X1 U107 ( .A(\fiforeg[7][0] ), .B(n16), .C(\fiforeg[6][0] ), .D(n15), 
        .Y(n71) );
  INVX2 U108 ( .A(raddr[2]), .Y(n64) );
  NAND3X1 U109 ( .A(raddr[0]), .B(n61), .C(n64), .Y(n285) );
  NAND3X1 U110 ( .A(n65), .B(n61), .C(n64), .Y(n283) );
  OAI22X1 U111 ( .A(n6), .B(n63), .C(n283), .D(n62), .Y(n69) );
  NAND3X1 U112 ( .A(n2), .B(raddr[0]), .C(n64), .Y(n289) );
  NAND3X1 U113 ( .A(n2), .B(n65), .C(n64), .Y(n287) );
  OAI22X1 U114 ( .A(n5), .B(n67), .C(n287), .D(n66), .Y(n68) );
  NOR2X1 U115 ( .A(n69), .B(n68), .Y(n70) );
  NAND3X1 U116 ( .A(n72), .B(n71), .C(n70), .Y(rdata[0]) );
  INVX2 U117 ( .A(\fiforeg[6][1] ), .Y(n79) );
  AOI22X1 U118 ( .A(\fiforeg[6][1] ), .B(n203), .C(\fiforeg[7][1] ), .D(n205), 
        .Y(n77) );
  AOI22X1 U119 ( .A(\fiforeg[4][1] ), .B(n207), .C(\fiforeg[5][1] ), .D(n277), 
        .Y(n76) );
  INVX2 U120 ( .A(\fiforeg[0][1] ), .Y(n84) );
  INVX2 U121 ( .A(\fiforeg[1][1] ), .Y(n85) );
  OAI22X1 U122 ( .A(n34), .B(n84), .C(n36), .D(n85), .Y(n74) );
  INVX2 U123 ( .A(\fiforeg[3][1] ), .Y(n87) );
  INVX2 U124 ( .A(\fiforeg[2][1] ), .Y(n86) );
  OAI22X1 U125 ( .A(n38), .B(n87), .C(n40), .D(n86), .Y(n73) );
  NOR2X1 U126 ( .A(n74), .B(n73), .Y(n75) );
  NAND3X1 U127 ( .A(n77), .B(n76), .C(n75), .Y(n78) );
  MUX2X1 U128 ( .B(n79), .A(n30), .S(n203), .Y(n261) );
  INVX2 U129 ( .A(\fiforeg[7][1] ), .Y(n80) );
  MUX2X1 U130 ( .B(n80), .A(n30), .S(n205), .Y(n260) );
  INVX2 U131 ( .A(\fiforeg[4][1] ), .Y(n81) );
  MUX2X1 U132 ( .B(n81), .A(n30), .S(n207), .Y(n263) );
  MUX2X1 U133 ( .B(n86), .A(n30), .S(n209), .Y(n265) );
  MUX2X1 U134 ( .B(n85), .A(n31), .S(n211), .Y(n266) );
  MUX2X1 U135 ( .B(n84), .A(n31), .S(n276), .Y(n267) );
  INVX2 U136 ( .A(\fiforeg[5][1] ), .Y(n83) );
  MUX2X1 U137 ( .B(n83), .A(n31), .S(n277), .Y(n262) );
  AOI22X1 U138 ( .A(\fiforeg[5][1] ), .B(n281), .C(\fiforeg[4][1] ), .D(n280), 
        .Y(n92) );
  AOI22X1 U139 ( .A(\fiforeg[7][1] ), .B(n16), .C(\fiforeg[6][1] ), .D(n15), 
        .Y(n91) );
  OAI22X1 U140 ( .A(n6), .B(n85), .C(n283), .D(n84), .Y(n89) );
  OAI22X1 U141 ( .A(n5), .B(n87), .C(n287), .D(n86), .Y(n88) );
  NOR2X1 U142 ( .A(n89), .B(n88), .Y(n90) );
  NAND3X1 U143 ( .A(n92), .B(n91), .C(n90), .Y(rdata[1]) );
  INVX2 U144 ( .A(\fiforeg[6][2] ), .Y(n99) );
  AOI22X1 U145 ( .A(\fiforeg[6][2] ), .B(n203), .C(\fiforeg[7][2] ), .D(n205), 
        .Y(n97) );
  AOI22X1 U146 ( .A(\fiforeg[4][2] ), .B(n207), .C(\fiforeg[5][2] ), .D(n277), 
        .Y(n96) );
  INVX2 U147 ( .A(\fiforeg[0][2] ), .Y(n104) );
  INVX2 U148 ( .A(\fiforeg[1][2] ), .Y(n105) );
  OAI22X1 U149 ( .A(n34), .B(n104), .C(n36), .D(n105), .Y(n94) );
  INVX2 U150 ( .A(\fiforeg[3][2] ), .Y(n107) );
  INVX2 U151 ( .A(\fiforeg[2][2] ), .Y(n106) );
  OAI22X1 U152 ( .A(n38), .B(n107), .C(n40), .D(n106), .Y(n93) );
  NOR2X1 U153 ( .A(n94), .B(n93), .Y(n95) );
  NAND3X1 U154 ( .A(n97), .B(n96), .C(n95), .Y(n98) );
  MUX2X1 U155 ( .B(n99), .A(n28), .S(n203), .Y(n253) );
  INVX2 U156 ( .A(\fiforeg[7][2] ), .Y(n100) );
  MUX2X1 U157 ( .B(n100), .A(n28), .S(n205), .Y(n252) );
  INVX2 U158 ( .A(\fiforeg[4][2] ), .Y(n101) );
  MUX2X1 U159 ( .B(n101), .A(n28), .S(n207), .Y(n255) );
  MUX2X1 U160 ( .B(n106), .A(n28), .S(n209), .Y(n257) );
  MUX2X1 U161 ( .B(n105), .A(n29), .S(n211), .Y(n258) );
  MUX2X1 U162 ( .B(n104), .A(n29), .S(n276), .Y(n259) );
  INVX2 U163 ( .A(\fiforeg[5][2] ), .Y(n103) );
  MUX2X1 U164 ( .B(n103), .A(n29), .S(n277), .Y(n254) );
  AOI22X1 U165 ( .A(\fiforeg[5][2] ), .B(n281), .C(\fiforeg[4][2] ), .D(n280), 
        .Y(n112) );
  AOI22X1 U166 ( .A(\fiforeg[7][2] ), .B(n16), .C(\fiforeg[6][2] ), .D(n15), 
        .Y(n111) );
  OAI22X1 U167 ( .A(n6), .B(n105), .C(n283), .D(n104), .Y(n109) );
  OAI22X1 U168 ( .A(n5), .B(n107), .C(n287), .D(n106), .Y(n108) );
  NOR2X1 U169 ( .A(n109), .B(n108), .Y(n110) );
  NAND3X1 U170 ( .A(n112), .B(n111), .C(n110), .Y(rdata[2]) );
  INVX2 U171 ( .A(\fiforeg[6][3] ), .Y(n119) );
  AOI22X1 U172 ( .A(\fiforeg[6][3] ), .B(n203), .C(\fiforeg[7][3] ), .D(n205), 
        .Y(n117) );
  AOI22X1 U173 ( .A(\fiforeg[4][3] ), .B(n207), .C(\fiforeg[5][3] ), .D(n277), 
        .Y(n116) );
  INVX2 U174 ( .A(\fiforeg[0][3] ), .Y(n124) );
  INVX2 U175 ( .A(\fiforeg[1][3] ), .Y(n125) );
  OAI22X1 U176 ( .A(n34), .B(n124), .C(n36), .D(n125), .Y(n114) );
  INVX2 U177 ( .A(\fiforeg[3][3] ), .Y(n127) );
  INVX2 U178 ( .A(\fiforeg[2][3] ), .Y(n126) );
  OAI22X1 U179 ( .A(n38), .B(n127), .C(n40), .D(n126), .Y(n113) );
  NOR2X1 U180 ( .A(n114), .B(n113), .Y(n115) );
  NAND3X1 U181 ( .A(n117), .B(n116), .C(n115), .Y(n118) );
  MUX2X1 U182 ( .B(n119), .A(n26), .S(n203), .Y(n245) );
  INVX2 U183 ( .A(\fiforeg[7][3] ), .Y(n120) );
  MUX2X1 U184 ( .B(n120), .A(n26), .S(n205), .Y(n244) );
  INVX2 U185 ( .A(\fiforeg[4][3] ), .Y(n121) );
  MUX2X1 U186 ( .B(n121), .A(n26), .S(n207), .Y(n247) );
  MUX2X1 U187 ( .B(n126), .A(n26), .S(n209), .Y(n249) );
  MUX2X1 U188 ( .B(n125), .A(n27), .S(n211), .Y(n250) );
  MUX2X1 U189 ( .B(n124), .A(n27), .S(n276), .Y(n251) );
  INVX2 U190 ( .A(\fiforeg[5][3] ), .Y(n123) );
  MUX2X1 U191 ( .B(n123), .A(n27), .S(n277), .Y(n246) );
  AOI22X1 U192 ( .A(\fiforeg[5][3] ), .B(n281), .C(\fiforeg[4][3] ), .D(n280), 
        .Y(n132) );
  AOI22X1 U193 ( .A(\fiforeg[7][3] ), .B(n16), .C(\fiforeg[6][3] ), .D(n15), 
        .Y(n131) );
  OAI22X1 U194 ( .A(n6), .B(n125), .C(n283), .D(n124), .Y(n129) );
  OAI22X1 U195 ( .A(n5), .B(n127), .C(n287), .D(n126), .Y(n128) );
  NOR2X1 U196 ( .A(n129), .B(n128), .Y(n130) );
  NAND3X1 U197 ( .A(n132), .B(n131), .C(n130), .Y(rdata[3]) );
  INVX2 U198 ( .A(\fiforeg[6][4] ), .Y(n139) );
  AOI22X1 U199 ( .A(\fiforeg[6][4] ), .B(n203), .C(\fiforeg[7][4] ), .D(n205), 
        .Y(n137) );
  AOI22X1 U200 ( .A(\fiforeg[4][4] ), .B(n207), .C(\fiforeg[5][4] ), .D(n277), 
        .Y(n136) );
  INVX2 U201 ( .A(\fiforeg[0][4] ), .Y(n144) );
  INVX2 U202 ( .A(\fiforeg[1][4] ), .Y(n145) );
  OAI22X1 U203 ( .A(n34), .B(n144), .C(n36), .D(n145), .Y(n134) );
  INVX2 U204 ( .A(\fiforeg[3][4] ), .Y(n147) );
  INVX2 U205 ( .A(\fiforeg[2][4] ), .Y(n146) );
  OAI22X1 U206 ( .A(n38), .B(n147), .C(n40), .D(n146), .Y(n133) );
  NOR2X1 U207 ( .A(n134), .B(n133), .Y(n135) );
  NAND3X1 U208 ( .A(n137), .B(n136), .C(n135), .Y(n138) );
  MUX2X1 U209 ( .B(n139), .A(n24), .S(n203), .Y(n237) );
  INVX2 U210 ( .A(\fiforeg[7][4] ), .Y(n140) );
  MUX2X1 U211 ( .B(n140), .A(n24), .S(n205), .Y(n236) );
  INVX2 U212 ( .A(\fiforeg[4][4] ), .Y(n141) );
  MUX2X1 U213 ( .B(n141), .A(n24), .S(n207), .Y(n239) );
  MUX2X1 U214 ( .B(n146), .A(n24), .S(n209), .Y(n241) );
  MUX2X1 U215 ( .B(n145), .A(n25), .S(n211), .Y(n242) );
  MUX2X1 U216 ( .B(n144), .A(n25), .S(n276), .Y(n243) );
  INVX2 U217 ( .A(\fiforeg[5][4] ), .Y(n143) );
  MUX2X1 U218 ( .B(n143), .A(n25), .S(n277), .Y(n238) );
  AOI22X1 U219 ( .A(\fiforeg[5][4] ), .B(n281), .C(\fiforeg[4][4] ), .D(n280), 
        .Y(n152) );
  AOI22X1 U220 ( .A(\fiforeg[7][4] ), .B(n16), .C(\fiforeg[6][4] ), .D(n15), 
        .Y(n151) );
  OAI22X1 U221 ( .A(n6), .B(n145), .C(n283), .D(n144), .Y(n149) );
  OAI22X1 U222 ( .A(n5), .B(n147), .C(n287), .D(n146), .Y(n148) );
  NOR2X1 U223 ( .A(n149), .B(n148), .Y(n150) );
  NAND3X1 U224 ( .A(n152), .B(n151), .C(n150), .Y(rdata[4]) );
  INVX2 U225 ( .A(\fiforeg[6][5] ), .Y(n159) );
  AOI22X1 U226 ( .A(\fiforeg[6][5] ), .B(n203), .C(\fiforeg[7][5] ), .D(n205), 
        .Y(n157) );
  AOI22X1 U227 ( .A(\fiforeg[4][5] ), .B(n207), .C(\fiforeg[5][5] ), .D(n277), 
        .Y(n156) );
  INVX2 U228 ( .A(\fiforeg[0][5] ), .Y(n164) );
  INVX2 U229 ( .A(\fiforeg[1][5] ), .Y(n165) );
  OAI22X1 U230 ( .A(n34), .B(n164), .C(n36), .D(n165), .Y(n154) );
  INVX2 U231 ( .A(\fiforeg[3][5] ), .Y(n167) );
  INVX2 U232 ( .A(\fiforeg[2][5] ), .Y(n166) );
  OAI22X1 U233 ( .A(n38), .B(n167), .C(n40), .D(n166), .Y(n153) );
  NOR2X1 U234 ( .A(n154), .B(n153), .Y(n155) );
  NAND3X1 U235 ( .A(n157), .B(n156), .C(n155), .Y(n158) );
  MUX2X1 U236 ( .B(n159), .A(n22), .S(n203), .Y(n229) );
  INVX2 U237 ( .A(\fiforeg[7][5] ), .Y(n160) );
  MUX2X1 U238 ( .B(n160), .A(n22), .S(n205), .Y(n228) );
  INVX2 U239 ( .A(\fiforeg[4][5] ), .Y(n161) );
  MUX2X1 U240 ( .B(n161), .A(n22), .S(n207), .Y(n231) );
  MUX2X1 U241 ( .B(n166), .A(n22), .S(n209), .Y(n233) );
  MUX2X1 U242 ( .B(n165), .A(n23), .S(n211), .Y(n234) );
  MUX2X1 U243 ( .B(n164), .A(n23), .S(n276), .Y(n235) );
  INVX2 U244 ( .A(\fiforeg[5][5] ), .Y(n163) );
  MUX2X1 U245 ( .B(n163), .A(n23), .S(n277), .Y(n230) );
  AOI22X1 U246 ( .A(\fiforeg[5][5] ), .B(n281), .C(\fiforeg[4][5] ), .D(n280), 
        .Y(n172) );
  AOI22X1 U247 ( .A(\fiforeg[7][5] ), .B(n16), .C(\fiforeg[6][5] ), .D(n15), 
        .Y(n171) );
  OAI22X1 U248 ( .A(n6), .B(n165), .C(n283), .D(n164), .Y(n169) );
  OAI22X1 U249 ( .A(n5), .B(n167), .C(n287), .D(n166), .Y(n168) );
  NOR2X1 U250 ( .A(n169), .B(n168), .Y(n170) );
  NAND3X1 U251 ( .A(n172), .B(n171), .C(n170), .Y(rdata[5]) );
  INVX2 U252 ( .A(\fiforeg[6][6] ), .Y(n179) );
  AOI22X1 U253 ( .A(\fiforeg[6][6] ), .B(n203), .C(\fiforeg[7][6] ), .D(n205), 
        .Y(n177) );
  AOI22X1 U254 ( .A(\fiforeg[4][6] ), .B(n207), .C(\fiforeg[5][6] ), .D(n277), 
        .Y(n176) );
  INVX2 U255 ( .A(\fiforeg[0][6] ), .Y(n184) );
  INVX2 U256 ( .A(\fiforeg[1][6] ), .Y(n185) );
  OAI22X1 U257 ( .A(n184), .B(n34), .C(n36), .D(n185), .Y(n174) );
  INVX2 U258 ( .A(\fiforeg[3][6] ), .Y(n187) );
  INVX2 U259 ( .A(\fiforeg[2][6] ), .Y(n186) );
  OAI22X1 U260 ( .A(n38), .B(n187), .C(n40), .D(n186), .Y(n173) );
  NOR2X1 U261 ( .A(n174), .B(n173), .Y(n175) );
  NAND3X1 U262 ( .A(n177), .B(n176), .C(n175), .Y(n178) );
  MUX2X1 U263 ( .B(n178), .A(wdata[6]), .S(wenable), .Y(n182) );
  MUX2X1 U264 ( .B(n179), .A(n20), .S(n203), .Y(n221) );
  INVX2 U265 ( .A(\fiforeg[7][6] ), .Y(n180) );
  MUX2X1 U266 ( .B(n180), .A(n20), .S(n205), .Y(n220) );
  INVX2 U267 ( .A(\fiforeg[4][6] ), .Y(n181) );
  MUX2X1 U268 ( .B(n181), .A(n20), .S(n207), .Y(n223) );
  MUX2X1 U269 ( .B(n185), .A(n21), .S(n211), .Y(n226) );
  MUX2X1 U270 ( .B(n184), .A(n21), .S(n276), .Y(n227) );
  INVX2 U271 ( .A(\fiforeg[5][6] ), .Y(n183) );
  MUX2X1 U272 ( .B(n183), .A(n20), .S(n277), .Y(n222) );
  AOI22X1 U273 ( .A(\fiforeg[5][6] ), .B(n281), .C(\fiforeg[4][6] ), .D(n280), 
        .Y(n192) );
  AOI22X1 U274 ( .A(\fiforeg[7][6] ), .B(n16), .C(\fiforeg[6][6] ), .D(n15), 
        .Y(n191) );
  OAI22X1 U275 ( .A(n6), .B(n185), .C(n283), .D(n184), .Y(n189) );
  OAI22X1 U276 ( .A(n5), .B(n187), .C(n287), .D(n186), .Y(n188) );
  NOR2X1 U277 ( .A(n189), .B(n188), .Y(n190) );
  NAND3X1 U278 ( .A(n192), .B(n191), .C(n190), .Y(rdata[6]) );
  INVX2 U279 ( .A(\fiforeg[6][7] ), .Y(n204) );
  AOI22X1 U280 ( .A(n203), .B(\fiforeg[6][7] ), .C(n205), .D(\fiforeg[7][7] ), 
        .Y(n201) );
  AOI22X1 U281 ( .A(n207), .B(\fiforeg[4][7] ), .C(n277), .D(\fiforeg[5][7] ), 
        .Y(n200) );
  INVX2 U282 ( .A(\fiforeg[0][7] ), .Y(n282) );
  INVX2 U283 ( .A(\fiforeg[1][7] ), .Y(n284) );
  OAI22X1 U284 ( .A(n34), .B(n282), .C(n284), .D(n36), .Y(n198) );
  INVX2 U285 ( .A(\fiforeg[3][7] ), .Y(n288) );
  INVX2 U286 ( .A(\fiforeg[2][7] ), .Y(n286) );
  OAI22X1 U287 ( .A(n288), .B(n38), .C(n286), .D(n40), .Y(n197) );
  NOR2X1 U288 ( .A(n198), .B(n197), .Y(n199) );
  NAND3X1 U289 ( .A(n201), .B(n200), .C(n199), .Y(n202) );
  MUX2X1 U290 ( .B(n204), .A(n18), .S(n203), .Y(n213) );
  INVX2 U291 ( .A(\fiforeg[7][7] ), .Y(n206) );
  MUX2X1 U292 ( .B(n206), .A(n18), .S(n205), .Y(n212) );
  INVX2 U293 ( .A(\fiforeg[4][7] ), .Y(n208) );
  MUX2X1 U294 ( .B(n208), .A(n18), .S(n207), .Y(n215) );
  MUX2X1 U295 ( .B(n284), .A(n19), .S(n211), .Y(n218) );
  INVX2 U296 ( .A(\fiforeg[5][7] ), .Y(n279) );
  MUX2X1 U297 ( .B(n279), .A(n19), .S(n277), .Y(n214) );
  AOI22X1 U298 ( .A(\fiforeg[5][7] ), .B(n281), .C(\fiforeg[4][7] ), .D(n280), 
        .Y(n294) );
  AOI22X1 U299 ( .A(\fiforeg[7][7] ), .B(n16), .C(\fiforeg[6][7] ), .D(n15), 
        .Y(n293) );
  OAI22X1 U300 ( .A(n6), .B(n284), .C(n283), .D(n282), .Y(n291) );
  OAI22X1 U301 ( .A(n5), .B(n288), .C(n287), .D(n286), .Y(n290) );
  NOR2X1 U302 ( .A(n291), .B(n290), .Y(n292) );
  NAND3X1 U303 ( .A(n294), .B(n293), .C(n292), .Y(rdata[7]) );
endmodule


module write_ptr ( wclk, rst_n, wenable, wptr, wptr_nxt );
  output [3:0] wptr;
  output [3:0] wptr_nxt;
  input wclk, rst_n, wenable;
  wire   n9, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32;
  wire   [2:0] binary_nxt;
  wire   [3:0] binary_r;

  DFFSR \binary_r_reg[0]  ( .D(n12), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        binary_r[0]) );
  DFFSR \binary_r_reg[1]  ( .D(binary_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[1]) );
  DFFSR \binary_r_reg[2]  ( .D(binary_nxt[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[2]) );
  DFFSR \binary_r_reg[3]  ( .D(wptr_nxt[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[3]) );
  DFFSR \gray_r_reg[3]  ( .D(wptr_nxt[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[3]) );
  DFFSR \gray_r_reg[2]  ( .D(wptr_nxt[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[2]) );
  DFFSR \gray_r_reg[1]  ( .D(wptr_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[1]) );
  DFFSR \gray_r_reg[0]  ( .D(wptr_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[0]) );
  INVX1 U11 ( .A(n18), .Y(n9) );
  INVX1 U12 ( .A(n22), .Y(n23) );
  XOR2X1 U13 ( .A(n21), .B(n20), .Y(wptr_nxt[1]) );
  INVX1 U14 ( .A(n20), .Y(binary_nxt[1]) );
  INVX1 U15 ( .A(binary_r[0]), .Y(n18) );
  INVX1 U16 ( .A(binary_r[1]), .Y(n17) );
  INVX2 U17 ( .A(binary_r[3]), .Y(n14) );
  XNOR2X1 U18 ( .A(n20), .B(n12), .Y(wptr_nxt[0]) );
  XNOR2X1 U19 ( .A(n18), .B(n13), .Y(n12) );
  XNOR2X1 U20 ( .A(n24), .B(n14), .Y(n25) );
  BUFX2 U21 ( .A(wenable), .Y(n13) );
  INVX1 U22 ( .A(wenable), .Y(n15) );
  INVX4 U23 ( .A(n25), .Y(wptr_nxt[3]) );
  NOR2X1 U24 ( .A(n17), .B(n15), .Y(n16) );
  AOI22X1 U25 ( .A(n18), .B(n17), .C(n16), .D(binary_r[0]), .Y(n19) );
  OAI21X1 U26 ( .A(binary_r[1]), .B(n13), .C(n19), .Y(n20) );
  NAND3X1 U27 ( .A(wenable), .B(binary_r[0]), .C(binary_r[1]), .Y(n22) );
  XOR2X1 U28 ( .A(n22), .B(binary_r[2]), .Y(n21) );
  INVX2 U29 ( .A(n21), .Y(binary_nxt[2]) );
  NAND2X1 U30 ( .A(binary_r[2]), .B(n23), .Y(n24) );
  NAND2X1 U31 ( .A(binary_r[1]), .B(n14), .Y(n32) );
  NAND2X1 U32 ( .A(n13), .B(n9), .Y(n31) );
  INVX2 U33 ( .A(binary_r[2]), .Y(n26) );
  NAND3X1 U34 ( .A(binary_r[1]), .B(binary_r[0]), .C(n26), .Y(n29) );
  XOR2X1 U35 ( .A(binary_r[3]), .B(binary_r[2]), .Y(n28) );
  NOR2X1 U36 ( .A(n13), .B(n14), .Y(n27) );
  AOI22X1 U37 ( .A(n29), .B(n28), .C(n27), .D(n26), .Y(n30) );
  OAI21X1 U38 ( .A(n32), .B(n31), .C(n30), .Y(wptr_nxt[2]) );
endmodule


module write_fifo_ctrl ( wclk, rst_n, wenable, rptr, wenable_fifo, wptr, waddr, 
        full_flag );
  input [3:0] rptr;
  output [3:0] wptr;
  output [2:0] waddr;
  input wclk, rst_n, wenable;
  output wenable_fifo, full_flag;
  wire   n25, n26, \gray_wptr[2] , N5, n2, n4, n17, n18, n19, n20, n21, n22,
         n23, n24;
  wire   [3:0] wptr_nxt;
  wire   [3:0] wrptr_r2;
  wire   [3:0] wrptr_r1;

  write_ptr WPU1 ( .wclk(wclk), .rst_n(rst_n), .wenable(n25), .wptr(wptr), 
        .wptr_nxt(wptr_nxt) );
  DFFSR \wrptr_r1_reg[3]  ( .D(rptr[3]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[3]) );
  DFFSR \wrptr_r1_reg[2]  ( .D(rptr[2]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[2]) );
  DFFSR \wrptr_r1_reg[1]  ( .D(rptr[1]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[1]) );
  DFFSR \wrptr_r1_reg[0]  ( .D(rptr[0]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[0]) );
  DFFSR \wrptr_r2_reg[3]  ( .D(wrptr_r1[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[3]) );
  DFFSR \wrptr_r2_reg[2]  ( .D(wrptr_r1[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[2]) );
  DFFSR \wrptr_r2_reg[1]  ( .D(wrptr_r1[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[1]) );
  DFFSR \wrptr_r2_reg[0]  ( .D(wrptr_r1[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[0]) );
  DFFSR full_flag_r_reg ( .D(N5), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        full_flag) );
  DFFSR \waddr_reg[2]  ( .D(\gray_wptr[2] ), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(waddr[2]) );
  DFFSR \waddr_reg[1]  ( .D(wptr_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        waddr[1]) );
  DFFSR \waddr_reg[0]  ( .D(wptr_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        n26) );
  AND2X2 U15 ( .A(wenable), .B(n23), .Y(wenable_fifo) );
  INVX2 U16 ( .A(full_flag), .Y(n23) );
  INVX2 U17 ( .A(n24), .Y(n25) );
  INVX2 U18 ( .A(n26), .Y(n2) );
  INVX4 U19 ( .A(n2), .Y(waddr[0]) );
  XOR2X1 U20 ( .A(wrptr_r2[3]), .B(wrptr_r2[2]), .Y(n4) );
  XOR2X1 U21 ( .A(wptr_nxt[3]), .B(n4), .Y(n17) );
  XOR2X1 U22 ( .A(wptr_nxt[1]), .B(wrptr_r2[1]), .Y(n22) );
  XOR2X1 U23 ( .A(wptr_nxt[3]), .B(wrptr_r2[3]), .Y(n20) );
  XNOR2X1 U24 ( .A(n17), .B(wptr_nxt[2]), .Y(n19) );
  XNOR2X1 U25 ( .A(wptr_nxt[0]), .B(wrptr_r2[0]), .Y(n18) );
  NAND3X1 U26 ( .A(n20), .B(n18), .C(n19), .Y(n21) );
  NOR2X1 U27 ( .A(n22), .B(n21), .Y(N5) );
  NAND2X1 U28 ( .A(wenable), .B(n23), .Y(n24) );
  XOR2X1 U29 ( .A(wptr_nxt[3]), .B(wptr_nxt[2]), .Y(\gray_wptr[2] ) );
endmodule


module read_ptr ( rclk, rst_n, renable, rptr, rptr_nxt );
  output [3:0] rptr;
  output [3:0] rptr_nxt;
  input rclk, rst_n, renable;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58;
  wire   [2:0] binary_nxt;
  wire   [3:0] binary_r;

  DFFSR \binary_r_reg[0]  ( .D(binary_nxt[0]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[0]) );
  DFFSR \binary_r_reg[1]  ( .D(binary_nxt[1]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[1]) );
  DFFSR \binary_r_reg[2]  ( .D(binary_nxt[2]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[2]) );
  DFFSR \binary_r_reg[3]  ( .D(n24), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        binary_r[3]) );
  DFFSR \gray_r_reg[3]  ( .D(n24), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[3]) );
  DFFSR \gray_r_reg[2]  ( .D(n10), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[2]) );
  DFFSR \gray_r_reg[1]  ( .D(n22), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[1]) );
  DFFSR \gray_r_reg[0]  ( .D(n12), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(rptr[0]) );
  INVX1 U11 ( .A(rptr_nxt[2]), .Y(n9) );
  INVX1 U12 ( .A(n9), .Y(n10) );
  INVX1 U13 ( .A(rptr_nxt[0]), .Y(n11) );
  INVX1 U14 ( .A(n11), .Y(n12) );
  INVX4 U15 ( .A(n55), .Y(n32) );
  INVX4 U16 ( .A(n16), .Y(rptr_nxt[3]) );
  INVX2 U17 ( .A(binary_r[2]), .Y(n26) );
  NAND2X1 U18 ( .A(n19), .B(n27), .Y(n13) );
  OAI21X1 U19 ( .A(n14), .B(n13), .C(n15), .Y(n16) );
  INVX1 U20 ( .A(renable), .Y(n14) );
  INVX2 U21 ( .A(n51), .Y(n15) );
  AOI21X1 U22 ( .A(n17), .B(renable), .C(binary_r[3]), .Y(n51) );
  INVX1 U23 ( .A(n50), .Y(n17) );
  BUFX2 U24 ( .A(renable), .Y(n18) );
  AND2X2 U25 ( .A(binary_r[1]), .B(n31), .Y(n19) );
  INVX4 U26 ( .A(n19), .Y(n54) );
  INVX1 U27 ( .A(renable), .Y(n20) );
  INVX4 U28 ( .A(renable), .Y(n55) );
  INVX1 U29 ( .A(rptr_nxt[1]), .Y(n21) );
  INVX1 U30 ( .A(n21), .Y(n22) );
  INVX1 U31 ( .A(binary_r[1]), .Y(n40) );
  INVX1 U32 ( .A(rptr_nxt[3]), .Y(n23) );
  INVX1 U33 ( .A(n23), .Y(n24) );
  NOR2X1 U34 ( .A(n52), .B(n26), .Y(n27) );
  INVX1 U35 ( .A(n54), .Y(n28) );
  INVX1 U36 ( .A(n20), .Y(n29) );
  AND2X1 U37 ( .A(n26), .B(binary_r[3]), .Y(n30) );
  BUFX4 U38 ( .A(binary_r[0]), .Y(n31) );
  NAND2X1 U39 ( .A(n55), .B(n30), .Y(n56) );
  XOR2X1 U40 ( .A(n29), .B(n31), .Y(binary_nxt[0]) );
  INVX2 U41 ( .A(n31), .Y(n34) );
  NAND2X1 U42 ( .A(n34), .B(n40), .Y(n41) );
  OAI21X1 U43 ( .A(n54), .B(n20), .C(n41), .Y(n33) );
  AOI21X1 U44 ( .A(n20), .B(n40), .C(n33), .Y(binary_nxt[1]) );
  AOI22X1 U45 ( .A(n34), .B(n40), .C(binary_r[1]), .D(n31), .Y(n37) );
  NAND2X1 U46 ( .A(n41), .B(n54), .Y(n45) );
  OAI21X1 U47 ( .A(n31), .B(n45), .C(n54), .Y(n35) );
  NAND2X1 U48 ( .A(n35), .B(n18), .Y(n36) );
  OAI21X1 U49 ( .A(n32), .B(n37), .C(n36), .Y(n38) );
  INVX2 U50 ( .A(n38), .Y(rptr_nxt[0]) );
  NAND2X1 U51 ( .A(binary_r[2]), .B(n19), .Y(n50) );
  NAND2X1 U52 ( .A(n54), .B(n26), .Y(n44) );
  OAI21X1 U53 ( .A(n20), .B(n50), .C(n44), .Y(n39) );
  AOI21X1 U54 ( .A(n20), .B(n26), .C(n39), .Y(binary_nxt[2]) );
  OAI22X1 U55 ( .A(n40), .B(n26), .C(binary_r[2]), .D(binary_r[1]), .Y(n43) );
  NOR2X1 U56 ( .A(n41), .B(n44), .Y(n42) );
  AOI21X1 U57 ( .A(n55), .B(n43), .C(n42), .Y(n49) );
  INVX2 U58 ( .A(n44), .Y(n46) );
  OAI21X1 U59 ( .A(n46), .B(n45), .C(n50), .Y(n47) );
  NAND2X1 U60 ( .A(n32), .B(n47), .Y(n48) );
  AND2X2 U61 ( .A(n49), .B(n48), .Y(rptr_nxt[1]) );
  INVX2 U62 ( .A(binary_r[3]), .Y(n52) );
  NAND3X1 U63 ( .A(n28), .B(n52), .C(n32), .Y(n58) );
  XOR2X1 U64 ( .A(binary_r[3]), .B(binary_r[2]), .Y(n53) );
  OAI21X1 U65 ( .A(binary_r[2]), .B(n54), .C(n53), .Y(n57) );
  NAND3X1 U66 ( .A(n57), .B(n56), .C(n58), .Y(rptr_nxt[2]) );
endmodule


module read_fifo_ctrl ( rclk, rst_n, renable, wptr, rptr, raddr, empty_flag );
  input [3:0] wptr;
  output [3:0] rptr;
  output [2:0] raddr;
  input rclk, rst_n, renable;
  output empty_flag;
  wire   n29, renable_p2, \gray_rptr[2] , N3, n1, n2, n3, n4, n17, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28;
  wire   [3:0] rptr_nxt;
  wire   [3:0] rwptr_r2;
  wire   [3:0] rwptr_r1;

  read_ptr RPU1 ( .rclk(rclk), .rst_n(rst_n), .renable(renable_p2), .rptr(rptr), .rptr_nxt(rptr_nxt) );
  DFFSR \rwptr_r1_reg[3]  ( .D(wptr[3]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[3]) );
  DFFSR \rwptr_r1_reg[2]  ( .D(wptr[2]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[2]) );
  DFFSR \rwptr_r1_reg[1]  ( .D(wptr[1]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[1]) );
  DFFSR \rwptr_r1_reg[0]  ( .D(wptr[0]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[0]) );
  DFFSR \rwptr_r2_reg[3]  ( .D(rwptr_r1[3]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[3]) );
  DFFSR \rwptr_r2_reg[2]  ( .D(rwptr_r1[2]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[2]) );
  DFFSR \rwptr_r2_reg[1]  ( .D(rwptr_r1[1]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[1]) );
  DFFSR \rwptr_r2_reg[0]  ( .D(rwptr_r1[0]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[0]) );
  DFFSR empty_flag_r_reg ( .D(N3), .CLK(rclk), .R(1'b1), .S(rst_n), .Q(
        empty_flag) );
  DFFSR \raddr_reg[2]  ( .D(\gray_rptr[2] ), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(raddr[2]) );
  DFFSR \raddr_reg[1]  ( .D(n20), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(raddr[1]) );
  DFFSR \raddr_reg[0]  ( .D(n3), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(n29) );
  XOR2X1 U15 ( .A(rptr_nxt[2]), .B(n1), .Y(n23) );
  INVX8 U16 ( .A(rwptr_r2[2]), .Y(n1) );
  INVX1 U17 ( .A(rptr_nxt[0]), .Y(n2) );
  INVX1 U18 ( .A(n2), .Y(n3) );
  INVX4 U19 ( .A(n21), .Y(renable_p2) );
  XNOR2X1 U20 ( .A(n4), .B(rptr_nxt[3]), .Y(\gray_rptr[2] ) );
  INVX1 U21 ( .A(rptr_nxt[2]), .Y(n4) );
  INVX2 U22 ( .A(n29), .Y(n17) );
  INVX4 U23 ( .A(n17), .Y(raddr[0]) );
  INVX1 U24 ( .A(rptr_nxt[1]), .Y(n19) );
  INVX1 U25 ( .A(n19), .Y(n20) );
  NAND2X1 U26 ( .A(n28), .B(renable), .Y(n21) );
  XNOR2X1 U27 ( .A(rptr_nxt[0]), .B(rwptr_r2[0]), .Y(n22) );
  NAND2X1 U28 ( .A(n23), .B(n22), .Y(n27) );
  XNOR2X1 U29 ( .A(rptr_nxt[3]), .B(rwptr_r2[3]), .Y(n25) );
  XNOR2X1 U30 ( .A(rptr_nxt[1]), .B(rwptr_r2[1]), .Y(n24) );
  NAND2X1 U31 ( .A(n25), .B(n24), .Y(n26) );
  NOR2X1 U32 ( .A(n27), .B(n26), .Y(N3) );
  INVX2 U33 ( .A(empty_flag), .Y(n28) );
endmodule


module fifo ( r_clk, w_clk, n_rst, r_enable, w_enable, w_data, r_data, empty, 
        full );
  input [7:0] w_data;
  output [7:0] r_data;
  input r_clk, w_clk, n_rst, r_enable, w_enable;
  output empty, full;
  wire   wenable_fifo, n1, n2;
  wire   [2:0] waddr;
  wire   [2:0] raddr;
  wire   [3:0] rptr;
  wire   [3:0] wptr;

  fiforam UFIFORAM ( .wclk(w_clk), .wenable(wenable_fifo), .waddr({n2, n1, 
        waddr[0]}), .raddr(raddr), .wdata(w_data), .rdata(r_data) );
  write_fifo_ctrl UWFC ( .wclk(w_clk), .rst_n(n_rst), .wenable(w_enable), 
        .rptr(rptr), .wenable_fifo(wenable_fifo), .wptr(wptr), .waddr(waddr), 
        .full_flag(full) );
  read_fifo_ctrl URFC ( .rclk(r_clk), .rst_n(n_rst), .renable(r_enable), 
        .wptr(wptr), .rptr(rptr), .raddr(raddr), .empty_flag(empty) );
  BUFX4 U1 ( .A(waddr[1]), .Y(n1) );
  BUFX4 U2 ( .A(waddr[2]), .Y(n2) );
endmodule


module lab7_tx_fifo ( clk, n_rst, read_done, read_data, fifo_empty, fifo_full, 
        write_enable, write_data );
  output [7:0] read_data;
  input [7:0] write_data;
  input clk, n_rst, read_done, write_enable;
  output fifo_empty, fifo_full;


  fifo IP_FIFO ( .r_clk(clk), .w_clk(clk), .n_rst(n_rst), .r_enable(read_done), 
        .w_enable(write_enable), .w_data(write_data), .r_data(read_data), 
        .empty(fifo_empty), .full(fifo_full) );
endmodule


module lab7_timer ( clk, n_rst, start, stop, shift_enable, bit_done );
  input clk, n_rst, start, stop;
  output shift_enable, bit_done;
  wire   N74, n35, n36, n1, n2, n3, n4, n5, n6, n7, n8, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25;
  wire   [1:0] curr_state;
  wire   [2:0] clk_cnt;
  wire   [2:0] nxt_clk_cnt;
  assign shift_enable = N74;

  DFFSR \curr_state_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        curr_state[0]) );
  DFFSR \curr_state_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        curr_state[1]) );
  DFFSR \clk_cnt_reg[0]  ( .D(nxt_clk_cnt[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(clk_cnt[0]) );
  DFFSR \clk_cnt_reg[1]  ( .D(nxt_clk_cnt[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(clk_cnt[1]) );
  DFFSR \clk_cnt_reg[2]  ( .D(nxt_clk_cnt[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(clk_cnt[2]) );
  INVX2 U8 ( .A(n23), .Y(n1) );
  AND2X2 U9 ( .A(clk_cnt[2]), .B(n23), .Y(bit_done) );
  AND2X1 U10 ( .A(n19), .B(n3), .Y(n2) );
  INVX2 U11 ( .A(curr_state[1]), .Y(n19) );
  INVX2 U12 ( .A(curr_state[0]), .Y(n3) );
  NOR2X1 U13 ( .A(clk_cnt[0]), .B(n2), .Y(nxt_clk_cnt[0]) );
  NAND2X1 U14 ( .A(clk_cnt[1]), .B(clk_cnt[0]), .Y(n21) );
  OAI21X1 U15 ( .A(clk_cnt[1]), .B(clk_cnt[0]), .C(n1), .Y(n20) );
  INVX2 U16 ( .A(clk_cnt[2]), .Y(n4) );
  NAND3X1 U17 ( .A(curr_state[1]), .B(n20), .C(n4), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n5) );
  NAND2X1 U19 ( .A(n5), .B(n1), .Y(n15) );
  NAND2X1 U20 ( .A(curr_state[0]), .B(n19), .Y(n25) );
  INVX2 U21 ( .A(n25), .Y(n17) );
  INVX2 U22 ( .A(stop), .Y(n6) );
  NAND2X1 U23 ( .A(n17), .B(n6), .Y(n14) );
  INVX2 U24 ( .A(n21), .Y(n23) );
  OAI21X1 U25 ( .A(n23), .B(n19), .C(n7), .Y(n16) );
  AOI22X1 U26 ( .A(start), .B(n2), .C(curr_state[0]), .D(n16), .Y(n8) );
  NAND3X1 U27 ( .A(n15), .B(n14), .C(n8), .Y(n36) );
  AOI21X1 U28 ( .A(stop), .B(n17), .C(n16), .Y(n18) );
  OAI21X1 U29 ( .A(curr_state[0]), .B(n19), .C(n18), .Y(n35) );
  NOR2X1 U30 ( .A(n2), .B(n20), .Y(nxt_clk_cnt[1]) );
  XOR2X1 U31 ( .A(n1), .B(clk_cnt[2]), .Y(n22) );
  NOR2X1 U32 ( .A(n2), .B(n22), .Y(nxt_clk_cnt[2]) );
  NAND2X1 U33 ( .A(clk_cnt[2]), .B(n23), .Y(n24) );
  NOR2X1 U34 ( .A(n25), .B(n24), .Y(N74) );
endmodule


module lab7_tcu ( clk, n_rst, transmit, bit_done, bus_mode, stop, start, sync, 
        read_done, tx_sel, tx_enable_0, load_data_0, tx_enable_1, load_data_1
 );
  output [1:0] bus_mode;
  input clk, n_rst, transmit, bit_done;
  output stop, start, sync, read_done, tx_sel, tx_enable_0, load_data_0,
         tx_enable_1, load_data_1;
  wire   n17, n18, n19, n81, n83, n85, n89, n90, n91, n92, n2, n3, n4, n5, n6,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n86, n87, n88, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140;
  wire   [3:0] curr_state;
  wire   [2:0] bit_cnt;

  DFFSR \bit_cnt_reg[0]  ( .D(n85), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_cnt[0]) );
  DFFSR \bit_cnt_reg[1]  ( .D(n83), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_cnt[1]) );
  DFFSR \bit_cnt_reg[2]  ( .D(n81), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_cnt[2]) );
  DFFSR \curr_state_reg[0]  ( .D(n92), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        curr_state[0]) );
  DFFSR \curr_state_reg[3]  ( .D(n89), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        curr_state[3]) );
  DFFSR \curr_state_reg[1]  ( .D(n91), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        curr_state[1]) );
  DFFSR \curr_state_reg[2]  ( .D(n90), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        curr_state[2]) );
  NOR2X1 U9 ( .A(n18), .B(n19), .Y(n17) );
  NAND2X1 U11 ( .A(bit_done), .B(bit_cnt[0]), .Y(n18) );
  INVX1 U3 ( .A(n21), .Y(n8) );
  OR2X2 U4 ( .A(n117), .B(n118), .Y(tx_enable_1) );
  INVX1 U5 ( .A(n38), .Y(n2) );
  INVX4 U6 ( .A(n2), .Y(n42) );
  INVX2 U7 ( .A(n86), .Y(n47) );
  INVX1 U8 ( .A(n86), .Y(n29) );
  INVX1 U10 ( .A(n56), .Y(n3) );
  AND2X2 U12 ( .A(n9), .B(n63), .Y(n4) );
  AND2X2 U13 ( .A(n51), .B(n48), .Y(n5) );
  AND2X1 U14 ( .A(n49), .B(n52), .Y(n6) );
  INVX2 U15 ( .A(n135), .Y(sync) );
  INVX1 U16 ( .A(n127), .Y(n7) );
  INVX2 U17 ( .A(n127), .Y(n21) );
  INVX2 U18 ( .A(n37), .Y(n43) );
  AND2X2 U19 ( .A(n39), .B(n5), .Y(n9) );
  INVX2 U20 ( .A(n94), .Y(n26) );
  INVX2 U21 ( .A(n129), .Y(n10) );
  AND2X2 U22 ( .A(n51), .B(n48), .Y(n129) );
  INVX1 U23 ( .A(n16), .Y(n11) );
  INVX1 U24 ( .A(n11), .Y(n12) );
  BUFX2 U25 ( .A(n46), .Y(n13) );
  INVX1 U26 ( .A(n61), .Y(n14) );
  INVX1 U27 ( .A(n14), .Y(n15) );
  AND2X2 U28 ( .A(n28), .B(n62), .Y(n16) );
  INVX1 U29 ( .A(n122), .Y(n123) );
  AND2X2 U30 ( .A(n98), .B(n55), .Y(n57) );
  INVX1 U31 ( .A(n9), .Y(n20) );
  INVX2 U32 ( .A(n48), .Y(n49) );
  INVX1 U33 ( .A(curr_state[1]), .Y(n22) );
  INVX1 U34 ( .A(n22), .Y(n23) );
  INVX1 U35 ( .A(n31), .Y(n24) );
  INVX1 U36 ( .A(n39), .Y(n25) );
  INVX2 U37 ( .A(n28), .Y(n50) );
  NAND2X1 U38 ( .A(n15), .B(n12), .Y(n27) );
  INVX2 U39 ( .A(n36), .Y(n28) );
  INVX2 U40 ( .A(n121), .Y(n31) );
  AND2X2 U41 ( .A(n23), .B(n36), .Y(n131) );
  INVX1 U42 ( .A(n36), .Y(n30) );
  NAND2X1 U43 ( .A(n93), .B(n136), .Y(n32) );
  NAND2X1 U44 ( .A(n33), .B(n88), .Y(n91) );
  INVX2 U45 ( .A(n32), .Y(n33) );
  INVX1 U46 ( .A(n50), .Y(n34) );
  INVX1 U47 ( .A(n53), .Y(n35) );
  BUFX2 U48 ( .A(curr_state[0]), .Y(n36) );
  INVX1 U49 ( .A(curr_state[0]), .Y(n48) );
  INVX1 U50 ( .A(n52), .Y(n37) );
  INVX4 U51 ( .A(n51), .Y(n52) );
  INVX4 U52 ( .A(n53), .Y(n127) );
  INVX1 U53 ( .A(curr_state[1]), .Y(n38) );
  INVX2 U54 ( .A(curr_state[1]), .Y(n51) );
  INVX1 U55 ( .A(curr_state[3]), .Y(n62) );
  AND2X2 U56 ( .A(n62), .B(n127), .Y(n39) );
  INVX2 U57 ( .A(n39), .Y(n94) );
  AND2X2 U58 ( .A(n110), .B(n109), .Y(n111) );
  BUFX2 U59 ( .A(n7), .Y(n40) );
  NAND2X1 U60 ( .A(n16), .B(n61), .Y(n115) );
  INVX1 U61 ( .A(n95), .Y(n41) );
  OR2X2 U62 ( .A(n122), .B(n43), .Y(n104) );
  AND2X2 U63 ( .A(n46), .B(n38), .Y(n44) );
  AND2X2 U64 ( .A(n52), .B(n30), .Y(n45) );
  BUFX4 U65 ( .A(curr_state[3]), .Y(n46) );
  INVX1 U66 ( .A(n27), .Y(n95) );
  INVX1 U67 ( .A(n53), .Y(n121) );
  BUFX4 U68 ( .A(curr_state[2]), .Y(n53) );
  INVX1 U69 ( .A(load_data_1), .Y(n99) );
  INVX1 U70 ( .A(n10), .Y(n124) );
  NAND2X1 U71 ( .A(n127), .B(n46), .Y(n116) );
  INVX2 U72 ( .A(n116), .Y(n56) );
  NAND2X1 U73 ( .A(n56), .B(n45), .Y(n93) );
  NAND2X1 U74 ( .A(n21), .B(n62), .Y(n120) );
  INVX2 U75 ( .A(n120), .Y(n138) );
  NAND2X1 U76 ( .A(n138), .B(n5), .Y(n109) );
  NAND2X1 U77 ( .A(n93), .B(n109), .Y(load_data_1) );
  XOR2X1 U78 ( .A(bit_done), .B(bit_cnt[0]), .Y(n85) );
  INVX2 U79 ( .A(bit_cnt[1]), .Y(n19) );
  XOR2X1 U80 ( .A(n19), .B(n18), .Y(n83) );
  XOR2X1 U81 ( .A(n17), .B(bit_cnt[2]), .Y(n81) );
  NAND2X1 U82 ( .A(n56), .B(n50), .Y(n122) );
  NAND2X1 U83 ( .A(n44), .B(n40), .Y(n137) );
  AND2X2 U84 ( .A(n104), .B(n137), .Y(n70) );
  NAND2X1 U85 ( .A(n49), .B(n52), .Y(n114) );
  NAND2X1 U86 ( .A(n138), .B(n6), .Y(n119) );
  INVX2 U87 ( .A(n119), .Y(n67) );
  MUX2X1 U88 ( .B(n121), .A(n3), .S(n52), .Y(n54) );
  NAND2X1 U89 ( .A(n49), .B(n54), .Y(n71) );
  INVX2 U90 ( .A(n71), .Y(n60) );
  NAND3X1 U98 ( .A(n13), .B(n40), .C(n45), .Y(n140) );
  INVX2 U99 ( .A(transmit), .Y(n63) );
  NAND2X1 U100 ( .A(n63), .B(n9), .Y(n55) );
  NAND2X1 U101 ( .A(n5), .B(n56), .Y(n98) );
  NAND3X1 U102 ( .A(n137), .B(n140), .C(n57), .Y(n59) );
  INVX2 U103 ( .A(bit_done), .Y(n58) );
  OAI22X1 U104 ( .A(n60), .B(n59), .C(n4), .D(n58), .Y(n86) );
  NOR2X1 U105 ( .A(n86), .B(n62), .Y(n66) );
  NAND3X1 U106 ( .A(bit_cnt[0]), .B(bit_cnt[1]), .C(bit_cnt[2]), .Y(n72) );
  INVX2 U107 ( .A(n72), .Y(n107) );
  NOR2X1 U108 ( .A(n127), .B(n38), .Y(n61) );
  NAND3X1 U109 ( .A(n107), .B(n63), .C(n95), .Y(n64) );
  INVX2 U110 ( .A(n64), .Y(n65) );
  NOR3X1 U111 ( .A(n67), .B(n65), .C(n66), .Y(n69) );
  AND2X2 U112 ( .A(n93), .B(n98), .Y(n68) );
  NAND3X1 U113 ( .A(n70), .B(n68), .C(n69), .Y(n89) );
  NAND2X1 U114 ( .A(n26), .B(n45), .Y(n136) );
  NAND2X1 U115 ( .A(n71), .B(n137), .Y(n105) );
  INVX2 U116 ( .A(n105), .Y(n75) );
  NAND3X1 U117 ( .A(n49), .B(n42), .C(n26), .Y(n135) );
  OAI21X1 U118 ( .A(n104), .B(n72), .C(n41), .Y(n73) );
  OAI21X1 U119 ( .A(n94), .B(n114), .C(n27), .Y(n108) );
  AOI22X1 U120 ( .A(transmit), .B(n73), .C(n72), .D(n108), .Y(n74) );
  NAND3X1 U121 ( .A(n75), .B(n135), .C(n74), .Y(n87) );
  MUX2X1 U122 ( .B(n87), .A(n52), .S(n47), .Y(n88) );
  OAI21X1 U123 ( .A(n42), .B(n25), .C(n104), .Y(n96) );
  MUX2X1 U124 ( .B(n96), .A(n95), .S(n107), .Y(n97) );
  NAND2X1 U125 ( .A(n97), .B(n20), .Y(n101) );
  NAND3X1 U126 ( .A(n136), .B(n98), .C(n99), .Y(n100) );
  NOR2X1 U127 ( .A(n101), .B(n100), .Y(n102) );
  MUX2X1 U128 ( .B(n102), .A(n34), .S(n47), .Y(n92) );
  INVX2 U129 ( .A(n108), .Y(n103) );
  OAI21X1 U130 ( .A(transmit), .B(n104), .C(n103), .Y(n106) );
  AOI21X1 U131 ( .A(n107), .B(n106), .C(n105), .Y(n112) );
  OAI21X1 U132 ( .A(n108), .B(n29), .C(n40), .Y(n110) );
  OAI21X1 U133 ( .A(n47), .B(n112), .C(n111), .Y(n90) );
  NAND3X1 U134 ( .A(n50), .B(n31), .C(n44), .Y(n113) );
  OAI21X1 U135 ( .A(n120), .B(n114), .C(n113), .Y(n118) );
  OAI21X1 U136 ( .A(n116), .B(n10), .C(n115), .Y(n117) );
  OR2X2 U137 ( .A(n117), .B(n118), .Y(tx_sel) );
  NAND2X1 U138 ( .A(n135), .B(n119), .Y(load_data_0) );
  MUX2X1 U139 ( .B(n138), .A(n24), .S(n52), .Y(n126) );
  AOI21X1 U140 ( .A(n124), .B(n40), .C(n123), .Y(n125) );
  NAND2X1 U141 ( .A(n126), .B(n125), .Y(tx_enable_0) );
  NAND2X1 U142 ( .A(n8), .B(n46), .Y(n134) );
  NAND2X1 U143 ( .A(n52), .B(n30), .Y(n133) );
  NOR2X1 U144 ( .A(n46), .B(n35), .Y(n130) );
  NOR2X1 U145 ( .A(n46), .B(n127), .Y(n128) );
  AOI22X1 U146 ( .A(n130), .B(n131), .C(n129), .D(n128), .Y(n132) );
  OAI21X1 U147 ( .A(n134), .B(n133), .C(n132), .Y(read_done) );
  INVX2 U148 ( .A(n136), .Y(start) );
  INVX2 U149 ( .A(n137), .Y(stop) );
  NOR2X1 U150 ( .A(n138), .B(n44), .Y(n139) );
  OAI21X1 U151 ( .A(n40), .B(n42), .C(n139), .Y(bus_mode[0]) );
  INVX2 U152 ( .A(n140), .Y(bus_mode[1]) );
endmodule


module lab7_tx_sr_0 ( clk, n_rst, shift_enable, tx_enable, tx_data, load_data, 
        tx_out );
  input [7:0] tx_data;
  input clk, n_rst, shift_enable, tx_enable, load_data;
  output tx_out;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58;
  wire   [7:1] curr_val;

  DFFSR \curr_val_reg[7]  ( .D(n57), .CLK(clk), .R(n13), .S(1'b1), .Q(
        curr_val[7]) );
  DFFSR \curr_val_reg[6]  ( .D(n56), .CLK(clk), .R(n13), .S(1'b1), .Q(
        curr_val[6]) );
  DFFSR \curr_val_reg[5]  ( .D(n55), .CLK(clk), .R(n13), .S(1'b1), .Q(
        curr_val[5]) );
  DFFSR \curr_val_reg[4]  ( .D(n54), .CLK(clk), .R(n13), .S(1'b1), .Q(
        curr_val[4]) );
  DFFSR \curr_val_reg[3]  ( .D(n53), .CLK(clk), .R(n13), .S(1'b1), .Q(
        curr_val[3]) );
  DFFSR \curr_val_reg[2]  ( .D(n52), .CLK(clk), .R(n13), .S(1'b1), .Q(
        curr_val[2]) );
  DFFSR \curr_val_reg[1]  ( .D(n51), .CLK(clk), .R(n13), .S(1'b1), .Q(
        curr_val[1]) );
  DFFSR \curr_val_reg[0]  ( .D(n58), .CLK(clk), .R(n13), .S(1'b1), .Q(tx_out)
         );
  INVX4 U11 ( .A(n18), .Y(n11) );
  INVX1 U12 ( .A(n47), .Y(n9) );
  INVX4 U13 ( .A(n20), .Y(n47) );
  INVX1 U14 ( .A(n15), .Y(n10) );
  INVX1 U15 ( .A(shift_enable), .Y(n17) );
  INVX2 U16 ( .A(n14), .Y(n13) );
  INVX2 U17 ( .A(n_rst), .Y(n14) );
  INVX1 U18 ( .A(tx_enable), .Y(n16) );
  BUFX2 U19 ( .A(n10), .Y(n12) );
  INVX2 U20 ( .A(load_data), .Y(n15) );
  NAND3X1 U21 ( .A(tx_enable), .B(n15), .C(shift_enable), .Y(n20) );
  OAI21X1 U22 ( .A(n17), .B(n16), .C(n15), .Y(n18) );
  MUX2X1 U23 ( .B(tx_data[7]), .A(curr_val[7]), .S(n11), .Y(n19) );
  NAND2X1 U24 ( .A(n9), .B(n19), .Y(n57) );
  NAND2X1 U25 ( .A(curr_val[7]), .B(n47), .Y(n23) );
  NAND2X1 U26 ( .A(curr_val[6]), .B(n11), .Y(n22) );
  NAND2X1 U27 ( .A(tx_data[6]), .B(n12), .Y(n21) );
  NAND3X1 U28 ( .A(n23), .B(n21), .C(n22), .Y(n56) );
  NAND2X1 U29 ( .A(curr_val[6]), .B(n47), .Y(n26) );
  NAND2X1 U30 ( .A(curr_val[5]), .B(n11), .Y(n25) );
  NAND2X1 U31 ( .A(tx_data[5]), .B(n12), .Y(n24) );
  NAND3X1 U32 ( .A(n26), .B(n24), .C(n25), .Y(n55) );
  NAND2X1 U33 ( .A(curr_val[5]), .B(n47), .Y(n37) );
  NAND2X1 U34 ( .A(curr_val[4]), .B(n11), .Y(n28) );
  NAND2X1 U35 ( .A(tx_data[4]), .B(n12), .Y(n27) );
  NAND3X1 U36 ( .A(n37), .B(n27), .C(n28), .Y(n54) );
  NAND2X1 U37 ( .A(curr_val[4]), .B(n47), .Y(n40) );
  NAND2X1 U38 ( .A(n11), .B(curr_val[3]), .Y(n39) );
  NAND2X1 U39 ( .A(tx_data[3]), .B(n12), .Y(n38) );
  NAND3X1 U40 ( .A(n40), .B(n39), .C(n38), .Y(n53) );
  NAND2X1 U41 ( .A(curr_val[3]), .B(n47), .Y(n43) );
  NAND2X1 U42 ( .A(curr_val[2]), .B(n11), .Y(n42) );
  NAND2X1 U43 ( .A(tx_data[2]), .B(n12), .Y(n41) );
  NAND3X1 U44 ( .A(n43), .B(n41), .C(n42), .Y(n52) );
  NAND2X1 U45 ( .A(curr_val[2]), .B(n47), .Y(n46) );
  NAND2X1 U46 ( .A(n11), .B(curr_val[1]), .Y(n45) );
  NAND2X1 U47 ( .A(tx_data[1]), .B(n12), .Y(n44) );
  NAND3X1 U48 ( .A(n46), .B(n45), .C(n44), .Y(n51) );
  NAND2X1 U49 ( .A(n47), .B(curr_val[1]), .Y(n50) );
  NAND2X1 U50 ( .A(tx_out), .B(n11), .Y(n49) );
  NAND2X1 U51 ( .A(tx_data[0]), .B(n12), .Y(n48) );
  NAND3X1 U52 ( .A(n50), .B(n48), .C(n49), .Y(n58) );
endmodule


module lab7_usb_transmitter ( clk, n_rst, d_plus, d_minus, transmit, 
        write_enable, write_data, fifo_empty, fifo_full );
  input [7:0] write_data;
  input clk, n_rst, transmit, write_enable;
  output d_plus, d_minus, fifo_empty, fifo_full;
  wire   tx_sel_int, tx_out_0_int, tx_out_1_int, sync_int, \tx_data_int[7] ,
         tx_value_int, shift_enable_int, tx_enable_0_int, load_data_0_int,
         tx_enable_1_int, load_data_1_int, read_done_int, start_int, stop_int,
         bit_done_int, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13;
  wire   [7:0] read_data_int;
  wire   [1:0] bus_mode_int;

  lab7_out_ctrl OCTRL ( .clk(clk), .n_rst(n_rst), .d_plus(d_plus), .d_minus(
        d_minus), .bus_mode(bus_mode_int), .tx_value(tx_value_int) );
  lab7_encoder ENC ( .clk(clk), .n_rst(n_rst), .tx_bit(n1), .shift_enable(n5), 
        .tx_value(tx_value_int) );
  lab7_tx_sr_1 T_SR_0 ( .clk(clk), .n_rst(n_rst), .shift_enable(
        shift_enable_int), .tx_enable(tx_enable_0_int), .tx_data({
        \tx_data_int[7] , n12, n11, n10, n9, n8, n7, n6}), .load_data(
        load_data_0_int), .tx_out(tx_out_0_int) );
  lab7_tx_sr_0 T_SR_1 ( .clk(clk), .n_rst(n_rst), .shift_enable(
        shift_enable_int), .tx_enable(tx_enable_1_int), .tx_data({
        \tx_data_int[7] , n12, n11, n10, n9, n8, n7, n6}), .load_data(
        load_data_1_int), .tx_out(tx_out_1_int) );
  lab7_tx_fifo T_FIFO ( .clk(clk), .n_rst(n_rst), .read_done(read_done_int), 
        .read_data(read_data_int), .fifo_empty(fifo_empty), .fifo_full(
        fifo_full), .write_enable(write_enable), .write_data(write_data) );
  lab7_timer TIM ( .clk(clk), .n_rst(n_rst), .start(start_int), .stop(stop_int), .shift_enable(shift_enable_int), .bit_done(bit_done_int) );
  lab7_tcu CTRL ( .clk(clk), .n_rst(n_rst), .transmit(transmit), .bit_done(
        bit_done_int), .bus_mode(bus_mode_int), .stop(stop_int), .start(
        start_int), .sync(sync_int), .read_done(read_done_int), .tx_sel(
        tx_sel_int), .tx_enable_0(tx_enable_0_int), .load_data_0(
        load_data_0_int), .tx_enable_1(tx_enable_1_int), .load_data_1(
        load_data_1_int) );
  INVX2 U3 ( .A(tx_out_1_int), .Y(n3) );
  INVX2 U4 ( .A(tx_out_0_int), .Y(n2) );
  INVX4 U5 ( .A(sync_int), .Y(n13) );
  MUX2X1 U6 ( .B(n2), .A(n3), .S(tx_sel_int), .Y(n1) );
  INVX1 U7 ( .A(shift_enable_int), .Y(n4) );
  INVX2 U8 ( .A(n4), .Y(n5) );
  AND2X2 U9 ( .A(read_data_int[0]), .B(n13), .Y(n6) );
  AND2X2 U10 ( .A(read_data_int[1]), .B(n13), .Y(n7) );
  AND2X2 U11 ( .A(read_data_int[2]), .B(n13), .Y(n8) );
  AND2X2 U12 ( .A(read_data_int[3]), .B(n13), .Y(n9) );
  AND2X2 U13 ( .A(read_data_int[4]), .B(n13), .Y(n10) );
  AND2X2 U14 ( .A(read_data_int[5]), .B(n13), .Y(n11) );
  AND2X2 U15 ( .A(read_data_int[6]), .B(n13), .Y(n12) );
  OR2X2 U16 ( .A(read_data_int[7]), .B(sync_int), .Y(\tx_data_int[7] ) );
endmodule


module lab7_layout_design_t ( clk, n_rst, d_plus, d_minus, transmit, 
        write_enable, write_data, fifo_empty, fifo_full );
  input [7:0] write_data;
  input clk, n_rst, transmit, write_enable;
  output d_plus, d_minus, fifo_empty, fifo_full;


  lab7_usb_transmitter LD ( .clk(clk), .n_rst(n_rst), .d_plus(d_plus), 
        .d_minus(d_minus), .transmit(transmit), .write_enable(write_enable), 
        .write_data(write_data), .fifo_empty(fifo_empty), .fifo_full(fifo_full) );
endmodule

module  lab7_layout_design ( clk, n_rst, d_plus, d_minus, transmit, write_enable, 
	write_data, fifo_empty, fifo_full );

input   [7:0] write_data;
input   clk, n_rst, transmit, write_enable;
output  d_plus, d_minus, fifo_empty, fifo_full;
wire	nclk, nn_rst, ntransmit, nwrite_enable, nd_plus, nd_minus, nfifo_empty, nfifo_full;

wire	[7:0] nwrite_data;
        lab7_layout_design_t I0 ( .clk(nclk), .n_rst(nn_rst), .d_plus(nd_plus), 
	.d_minus(nd_minus), .transmit(ntransmit), .write_enable(nwrite_enable), .write_data(nwrite_data), 
	.fifo_empty(nfifo_empty), .fifo_full(nfifo_full) );

PADVDD U1 (  );
PADGND U2 (  );
PADOUT U3 ( .DO(nd_minus), .YPAD(d_minus) );
PADOUT U4 ( .DO(nd_plus), .YPAD(d_plus) );
PADOUT U5 ( .DO(nfifo_empty), .YPAD(fifo_empty) );
PADOUT U6 ( .DO(nfifo_full), .YPAD(fifo_full) );
PADINC U7 ( .DI(nclk), .YPAD(clk) );
PADINC U8 ( .DI(nn_rst), .YPAD(n_rst) );
PADINC U9 ( .DI(ntransmit), .YPAD(transmit) );
PADINC U10 ( .DI(nwrite_data[0]), .YPAD(write_data[0]) );
PADINC U11 ( .DI(nwrite_data[1]), .YPAD(write_data[1]) );
PADINC U12 ( .DI(nwrite_data[2]), .YPAD(write_data[2]) );
PADINC U13 ( .DI(nwrite_data[3]), .YPAD(write_data[3]) );
PADINC U14 ( .DI(nwrite_data[4]), .YPAD(write_data[4]) );
PADINC U15 ( .DI(nwrite_data[5]), .YPAD(write_data[5]) );
PADINC U16 ( .DI(nwrite_data[6]), .YPAD(write_data[6]) );
PADINC U17 ( .DI(nwrite_data[7]), .YPAD(write_data[7]) );
PADINC U18 ( .DI(nwrite_enable), .YPAD(write_enable) );

endmodule
