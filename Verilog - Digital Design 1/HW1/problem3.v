`timescale 1ns/1ns

module tb_cmos();
   reg  source, gate;
   wire nmos_drain, pmos_drain;

   nmos u1(nmos_drain, source, gate);
   pmos u2(pmos_drain, source, gate);

   initial begin
      gate = 1'b0;
      source = 1'b0;
      #100;
      source = 1'b1;
      #100;
      gate = 1'b1;
      source = 1'b0;
      #100;
      source = 1'b1;
      #100;
   end

endmodule