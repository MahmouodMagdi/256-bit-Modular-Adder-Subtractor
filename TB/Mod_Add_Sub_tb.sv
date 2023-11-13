////////////////////////////////////////
/////		 Test Macros 		   /////
////////////////////////////////////////
`timescale 1ns/1ps
`define delay   40							// Right Data should be captured after 4 clock cycles
`define CLK_PER 10


////////////////////////////////////////
////		Test parameters			////
////////////////////////////////////////
parameter Data_Width = 256;



///////////////////////////////////////////////////////
////////		Sequencer Class Creation	   ////////
///////////////////////////////////////////////////////
class Sequencer #();

  rand bit [Data_Width - 1:0] rand_A, rand_b, rand_c, rand_d, rand_g, rand_h, rand_x, rand_y;						// 4 random variables 
  constraint value_A {rand_A inside {[256'd0:256'd28]};}							// take a value from 0 to 28
  constraint value_b {rand_b inside {[256'd0:256'd28]};}							// take a value from 0 to 28
  constraint value_c {rand_c inside {[256'd0:256'd82]};}							// take a value from 0 to 83
  constraint value_d {rand_d inside {[256'd0:256'd82]};}							// take a value from 0 to 83
  constraint greater_than_constraint {
  
	rand_g	inside {[256'd0:256'd292]};
	rand_h  inside {[256'd0:256'd292]};
    rand_g > rand_h; 						// This constraint ensures that 'g' is always greater than 'h'
  }
  constraint g_than_constraint {
  
	rand_x	inside {[256'd0:256'd996]};
	rand_y  inside {[256'd0:256'd996]};
    rand_x > rand_y; 						// This constraint ensures that 'x' is always greater than 'y'
  }
endclass


module Mod_Add_Sub_tb;


	// Input Signals 
	logic						 i_clk_tb	;										// Test Bench Input Clock Signal 
	logic						 i_rst_n_tb	;										// Test Bench Input Reset Signal
	logic						 i_op_sel_tb;										// Test Bench Input Operation Select Signal
	logic	[Data_Width - 1 : 0] i_a_tb		;										// Test Bench Input integer a
	logic	[Data_Width - 1 : 0] i_b_tb		;										// Test Bench Input integer b
	logic	[Data_Width - 1 : 0] i_p_tb		;										// Test Bench Input Prime p

	logic	[Data_Width - 1 : 0] o_sum_tb	;										// Test Bench Output Modular Inverse Signal






	Sequencer #() item;																// Making a Class object 


//////////////////////////////////////////////////////
//////		Design Under Test Instantiation		//////
//////////////////////////////////////////////////////
		Mod_Add_Sub #(

			.DATA_WIDTH(Data_Width)

		) DUT (

			.i_clk      (i_clk_tb	),
			.i_rst_n    (i_rst_n_tb	),
			.i_op_sel   (i_op_sel_tb),
			.i_a        (i_a_tb		),
			.i_b        (i_b_tb		),
			.i_p        (i_p_tb		),

			.o_sum 		(o_sum_tb	)
			
			);



///////////////////////////////////////////////
////////	Clock Generation Block	   ////////
///////////////////////////////////////////////
always #(`CLK_PER/2) i_clk_tb = ~i_clk_tb;




///////////////////////////////////////////////////////
////////		Applying Test Stimulus 	   		///////
///////////////////////////////////////////////////////
initial 
begin

  i_p_tb   = 256'd29;																// Set the Prime Number to decimal = 29
  i_clk_tb = 1'b1;  																// initialize i_clk_tb

	// Reset the System
	i_rst_n_tb = 0;
	
	// De-assert the reset signal 
	@(posedge i_clk_tb);
	i_rst_n_tb = 1;
	
	#`CLK_PER;
	
	item = new();

    repeat(30) 
	begin
		
		// Randomize the integer values using randomization
        item.randomize();
       
		   i_a_tb = item.rand_A;
		   i_b_tb = item.rand_b;
   
		

		// Addition Operation 
		i_op_sel_tb = 1'b0;
		
	
		
		#`delay
			$display("	----------- 	Addition Operation Selected !	 -----------\n");
			$display("T = %0t\ti_a = %0d\ti_b = %0d\ti_P = %0d\no_sum = %0d",$time, i_a_tb, i_b_tb, i_p_tb,o_sum_tb);
			$display("\n *********************************************************** \n");


		#6;
		
    end


	#1000;	  i_p_tb   = 256'd293;																// Set the Prime Number to decimal = 293
	
	repeat(290) 
	begin
		
		// Randomize the integer values using randomization
        item.randomize();
       
		i_a_tb = item.rand_g;
		i_b_tb = item.rand_h;
   
		

		// Subtraction Operation 
		i_op_sel_tb = 1'b1;
		
	
		
		#`delay
			$display("	----------- 	Subtraction Operation Selected !	 -----------\n");
			$display("T = %0t\ti_a = %0d\ti_b = %0d\ti_P = %0d\no_sum = %0d",$time, i_a_tb, i_b_tb, i_p_tb,o_sum_tb);
			$display("\n *********************************************************** \n");


		#6;
		
    end
	
	
	
	#1000;	  i_p_tb   = 256'd83;																// Set the Prime Number to decimal = 83
	
	repeat(80) 
	begin
		
		// Randomize the integer values using randomization
        item.randomize();
       
		i_a_tb = item.rand_c;
		i_b_tb = item.rand_d;
   
		

		// Addition Operation 
		i_op_sel_tb = 1'b0;
		
	
		
		#`delay
			$display("	----------- 	Addition Operation Selected !	 -----------\n");
			$display("T = %0t\ti_a = %0d\ti_b = %0d\ti_P = %0d\no_sum = %0d",$time, i_a_tb, i_b_tb, i_p_tb,o_sum_tb);
			$display("\n *********************************************************** \n");


		#6;
		
    end


	#1000;	  i_p_tb   = 256'd997;																// Set the Prime Number to decimal = 997
	
	repeat(500) 
	begin
		
		// Randomize the integer values using randomization
        item.randomize();
       
		i_a_tb = item.rand_x;
		i_b_tb = item.rand_y;
   
		

		// Subtraction Operation 
		i_op_sel_tb = 1'b1;
		
	
		
		#`delay
			$display("	----------- 	Subtraction Operation Selected !	 -----------\n");
			$display("T = %0t\ti_a = %0d\ti_b = %0d\ti_P = %0d\no_sum = %0d",$time, i_a_tb, i_b_tb, i_p_tb,o_sum_tb);
			$display("\n *********************************************************** \n");


		#6;
		
    end	
$finish;

end

///////////////////////////////////////////////////////
////////	Dump Changes into the .VCD File	   ////////
///////////////////////////////////////////////////////
	initial 
	begin

	  $dumpfile("dump.vcd");
	  $dumpvars;

	  #500000

	  $finish;

	end


endmodule
