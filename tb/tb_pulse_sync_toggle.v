module tb_pulse_sync_toggle();

reg  clock_a     ;
reg  clock_b     ;
reg  async_rst_n ;
reg  pls_a       ;
wire pls_b       ;


pulse_sync_toggle pulse_sync_toggle_i(
  .clock_a    (clock_a    ),  
  .clock_b    (clock_b    ),  
  .async_rst_n(async_rst_n),  
  .pls_a      (pls_a      ),  
  .pls_b      (pls_b      )  
);

always
  begin
   #5 clock_a = ~clock_a;
  end

always
  begin
   #3.33 clock_b = ~clock_b;
  end

initial 
  begin
   clock_a     = 1'b0;    
   clock_b     = 1'b0;
   pls_a       = 1'b0;
   async_rst_n = 1'b0;
   #10;
   async_rst_n = 1'b1;
   pls_a       = 1'b0;
   #45;   
   pls_a       = 1'b1;
   #10;   
   pls_a       = 1'b0;
   #245;   
   pls_a       = 1'b1;
   #10;   
   pls_a       = 1'b0;
   #2000;
   $finish();
  end

endmodule

