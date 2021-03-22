module pulse_sync_toggle(
  input      clock_a,     //Sending Clock Domain
  input      clock_b,     //Receiving Clock Domain
  input      async_rst_n, // Reset
  input      pls_a,       //Sending Pulse
  output     pls_b        //Synchronized Pulse 
);

reg pls_toggle;      
reg pls_toggle_synca;
reg pls_toggle_syncb;
reg pls_toggle_syncc;

//--------------------------------------------------
//   Toggle Flop Circuit
//---------------------------------------------------

  always @ (posedge clock_a or negedge async_rst_n)
    begin
      if(!async_rst_n)
        begin
	  pls_toggle <= 1'b0;
        end		
      else if(pls_a)
        begin
	  pls_toggle <= ~pls_toggle;
        end
      else
        begin
	  pls_toggle <= pls_toggle;
        end		
    end

//--------------------------------------------------
//   Double Flop Bit Synchronizer
//---------------------------------------------------

  always @ (posedge clock_b or negedge async_rst_n)
    begin
      if(!async_rst_n)
        begin
	  pls_toggle_synca <= 1'b0;
	  pls_toggle_syncb <= 1'b0;
        end		
      else
        begin
	  pls_toggle_synca <= pls_toggle;
	  pls_toggle_syncb <= pls_toggle_synca;
        end		
    end

//--------------------------------------------------
//   Delay Logic of Output signal
//---------------------------------------------------

  always @ (posedge clock_b or negedge async_rst_n)
    begin
      if(!async_rst_n)
        begin
	  pls_toggle_syncc <= 1'b0;
        end		
      else
        begin
	  pls_toggle_syncc <= pls_toggle_syncb;
        end		
    end

//--------------------------------------------------
//   Assign Statement for posedge and negedge detection
//---------------------------------------------------

assign pls_b = pls_toggle_syncc ^ pls_toggle_syncb;

endmodule
