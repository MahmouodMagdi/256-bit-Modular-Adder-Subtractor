`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:        Mahmoud Magdi 
// 
// Create Date:     11/08/2023 02:13:20 AM
// Design Name: 
// Module Name:     carry_look_ahead_adder
// Project Name:    Ellibtic Curve Scalar Multiplication 
// Target Devices:  
// Tool Versions:   2021.1
// Description: Binary Adder based on Carry-look ahead logic 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module carry_look_ahead_adder #(

	parameter DATA_WIDTH = 256
	
)(
    
	input  logic [DATA_WIDTH - 1 : 0] in_1,
    input  logic [DATA_WIDTH - 1 : 0] in_2,
	input  logic 					  c_in,
    output logic [DATA_WIDTH - 1 : 0] o_Sum,
	output logic 					  c_out
    
);


logic [DATA_WIDTH - 1 : 0] G, P, C;


// Carry Generation 
always_comb
begin


	for(int i = 0; i < 256; i++)
	begin
	
		G[i] = in_1[i] & in_2[i];
		P[i] = in_1[i] ^ in_2[i];
		
		if (i == 0)
		begin
		
			C[i] = G[i] | (P[i] & c_in);
			o_Sum[i] = P[i] ^ c_in;
			
		end
		else
		begin
					
			C[i] = G[i] | (P[i] & C[i-1]);
			o_Sum[i] = P[i] ^ C[i-1];
			
		end
	end


end


assign c_out = C[DATA_WIDTH - 1];
	
endmodule
