module IIR_Cheby1_Lowpass_Real (Data_out_r, Data_in, clock, reset);
	parameter order = 9;
	parameter word_size_in = 64;
	parameter word_size_out = 2*word_size_in+2;
	parameter frac_bit = 52;

	parameter b0=64'b0000000000000000000100101001101111011101111000011111110001101000;
	parameter b1=64'b0000000000000000101001110111101011001100111100011101111110101100;
	parameter b2=64'b0000000000000010100111011110101100110011110001110111111010110001;
	parameter b3=64'b0000000000000110000110110010010011001110001001101101001001001000;
	parameter b4=64'b0000000000001001001010001011011100110101001110100011101101101011;
	parameter b5=64'b0000000000001001001010001011011100110101001110100011101101101011;
	parameter b6=64'b0000000000000110000110110010010011001110001001101101001001001000;
	parameter b7=64'b0000000000000010100111011110101100110011110001110111111010110001;
	parameter b8=64'b0000000000000000101001110111101011001100111100011101111110101100;
	parameter b9=64'b0000000000000000000100101001101111011101111000011111110001101000;
	              
	parameter a1=64'b1111111111110111110101110110001010001000001010111111001101000101;
	parameter a2=64'b0000000000100011011010010010010110000100110110100010100001000010;
	parameter a3=64'b1111111111100101100010010101011001011100001010101110001110000001;
	parameter a4=64'b0000000000100011111000010011011101010111110010100011011011101010;
	parameter a5=64'b1111111111100100111111011100100000010000101111111100001000010110;
	parameter a6=64'b0000000000010100001100101000101001010010001001010001100110001110;
	parameter a7=64'b1111111111110100010000000010111011000010100010011001010001101011;
	parameter a8=64'b0000000000000100111111010110011011110001000110111110101111101101;
	parameter a9=64'b1111111111111110000111101011110111101100011100110011111100000000;

	output[word_size_in-1:0] Data_out_r;
	input[word_size_in-1:0] Data_in;
	input clock, reset;

	wire[word_size_out-1:0] Data_feedforward;
 	wire[word_size_out-1:0] Data_feedback;
	wire[word_size_out-1:0] Data_out;
	reg[word_size_in-1:0] Sample_in[1:order];
	reg[word_size_in-1:0] Sample_out[1:order];
	
	integer k;

	assign Data_feedforward = b0*Data_in+b1*Sample_in[1]+b2*Sample_in[2]+b3*Sample_in[3]+b4*Sample_in[4]+b5*Sample_in[5]+b6*Sample_in[6]+b7*Sample_in[7]+b8*Sample_in[8]+b9*Sample_in[9];	
	assign Data_feedback = a1*Sample_out[1]+a2*Sample_out[2]+a3*Sample_out[3]+a4*Sample_out[4]+a5*Sample_out[5]+a6*Sample_out[6]+a7*Sample_out[7]+a8*Sample_out[8]+a9*Sample_out[9];

	assign Data_out = (Data_feedforward - Data_feedback);
	
	assign Data_out_r = Data_out[129:66]; //To properly analyze, 64-bit output as integer size is 64

	
	always @ (posedge clock)
		if (reset==1) 
		begin 
			for (k=1;k<=order;k=k+1) 
			begin
				Sample_in[k]<=0;
				Sample_out[k]<=0;
			end 
		end
		else 
		begin
			Sample_in[1]<=Data_in;
			Sample_out[1]<=Data_out[129:66]; //Truncation to fit in 64-bit Sample_out
			for (k=2;k<=order;k=k+1)
 			begin
				Sample_in[k]<=Sample_in[k-1];
				Sample_out[k]<=Sample_out[k-1];				
			end
		end
endmodule
