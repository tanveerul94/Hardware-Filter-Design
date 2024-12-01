`timescale 1ns/10ps
module FIR_testbench;
	parameter word_size_in = 8;
	parameter word_size_out = 2*word_size_in+2;

	reg[word_size_in-1:0] Data_in;
	reg clock, reset;
	wire[word_size_out-1:0] Data_out;

	FIR_Hamming_Lowpass_ DUT (
		.clock(clock),
		.reset(reset), 
		.Data_in(Data_in),
		.Data_out(Data_out)
	);

    	initial 
        begin
           clock = 1'b0;
	   forever 
	   begin
	      #10416 clock = ~clock;
	      $display("At Time: %d  Filter Output=%d",$time,Data_out);
	   end  
        end

	initial
	begin
	  #0  reset=1;
	  Data_in=8'd0;
	  #20832  reset=0;
	  #20833  Data_in=8'd52;
	  #20834  Data_in=8'd198;
	  #20833  Data_in=8'd96;
	  #20833  Data_in=8'd36;
	  #20834  Data_in=8'd17;
	  #20833  Data_in=8'd226;
	  #20833  Data_in=8'd210;
	  #20834  Data_in=8'd153;
	  #20833  Data_in=8'd150;
	  #20833  Data_in=8'd143;
	  #20834  Data_in=8'd143;
	  #20833  Data_in=8'd220;
	  #20833  Data_in=8'd235;
	  #20834  Data_in=8'd23;
	  #20833  Data_in=8'd19;
	  #20833  Data_in=8'd108;
	  #20834  Data_in=8'd202;
	  #20833  Data_in=8'd62;
	  #20833  Data_in=8'd21;
	  #20834  Data_in=8'd42;
	  #20833  Data_in=8'd192;
	  #20833  Data_in=8'd83;
	  #20834  Data_in=8'd53;
	  #20833  Data_in=8'd13;
	  #20833  Data_in=8'd216;
	  #20834  Data_in=8'd200;
	  #20833  Data_in=8'd163;
	  #20833  Data_in=8'd155;
	  #20834  Data_in=8'd136;
	  #20833  Data_in=8'd132;
	  #20833  Data_in=8'd229;
	  #20834  Data_in=8'd242;
	  #20833  Data_in=8'd30;
	  #20833  Data_in=8'd2;
	  #20834  Data_in=8'd119;
	  #20833  Data_in=8'd205;
	  #20833  Data_in=8'd73;
	  #20834  Data_in=8'd42;
	  #20833  Data_in=8'd34;
	  #20833  Data_in=8'd185;
	  #20834  Data_in=8'd69;
	  #20833  Data_in=8'd69;
	  #20833  Data_in=8'd9;
	  #20834  Data_in=8'd204;
	  #20833  Data_in=8'd188;
	  #20833  Data_in=8'd172;
	  #20834  Data_in=8'd158;
	  #20833  Data_in=8'd127;
	  #20833  Data_in=8'd121;
	  #20834  Data_in=8'd237;
	  #20833  Data_in=8'd248;
	  #20833  Data_in=8'd38;
	  #20834  Data_in=8'd13;
	  #20833  Data_in=8'd129;
	  #20833  Data_in=8'd206;
	  #20834  Data_in=8'd85;
	  #20833  Data_in=8'd63;
	  #20833  Data_in=8'd26;
	  #20834  Data_in=8'd177;
	  #20833  Data_in=8'd55;
	  #20833  Data_in=8'd85;
	  #20834  Data_in=8'd7;
	  #20833  Data_in=8'd190;
	  #20833  Data_in=8'd176;
	  #20834  Data_in=8'd180;
	  #20833  Data_in=8'd160;
	  #20833  Data_in=8'd116;
	  #20834  Data_in=8'd110;
	  #20833  Data_in=8'd243;
	  #20833  Data_in=8'd252;
	  #20834  Data_in=8'd46;
	  #20833  Data_in=8'd30;
	  #20833  Data_in=8'd138;
	  #20834  Data_in=8'd206;
	  #20833  Data_in=8'd97;
	  #20833  Data_in=8'd83;
	  #20834  Data_in=8'd20;
	  #20833  Data_in=8'd167;
	  #20833  Data_in=8'd40;
	  #20834  Data_in=8'd100;
	  #20833  Data_in=8'd6;
	  #20833  Data_in=8'd176;
	  #20834  Data_in=8'd164;
	  #20833  Data_in=8'd187;
	  #20833  Data_in=8'd160;
	  #20834  Data_in=8'd104;
	  #20833  Data_in=8'd99;
	  #20833  Data_in=8'd248;
	  #20834  Data_in=8'd255;
	  #20833  Data_in=8'd55;
	  #20833  Data_in=8'd46;
	  #20834  Data_in=8'd145;
	  #20833  Data_in=8'd205;
	  #20833  Data_in=8'd110;
	  #20834  Data_in=8'd103;
	  #20833  Data_in=8'd14;
	  #20833  Data_in=8'd156;
	  #20834  Data_in=8'd24;
	  #20833  Data_in=8'd115;
	  #20833  Data_in=8'd6;
	  #20834  Data_in=8'd160;
	  #20833  Data_in=8'd151;
	  #20833  Data_in=8'd193;
	  #20834  Data_in=8'd159;
	  #20833  Data_in=8'd92;
	  #20833  Data_in=8'd88;
	  #20834  Data_in=8'd252;
	  #20833  Data_in=8'd255;
	  #20833  Data_in=8'd65;
	  #20834  Data_in=8'd61;
	  #20833  Data_in=8'd151;
	  #20833  Data_in=8'd203;
	  #20834  Data_in=8'd123;
	  #20833  Data_in=8'd122;
	  #20833  Data_in=8'd10;
	  #20834  Data_in=8'd144;
	  #20833  Data_in=8'd9;
	  #20833  Data_in=8'd129;
	  #20834  Data_in=8'd7;
	  #20832  $stop;
	end

	initial 
	begin
		$dumpfile("FIR_dump.vcd");
		$dumpvars;
	end
endmodule