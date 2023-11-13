`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:        Mahmoud Magdi
// 
// Create Date:     11/08/2023 01:04:18 AM
// Design Name: 
// Module Name:     Mod_Add_Sub
// Project Name: 
// Target Devices: 
// Tool Versions:   2020.1
// Description:     Modular Adder-Subtractor 
// 
// Dependencies:    carry_look_ahead_adder.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mod_Add_Sub #(

    parameter DATA_WIDTH = 256

)(

    input   logic                        i_clk      ,
    input   logic                        i_rst_n    ,
    input   logic                        i_op_sel   ,
    input   logic   [DATA_WIDTH - 1 : 0] i_a        ,
    input   logic   [DATA_WIDTH - 1 : 0] i_b        ,
    input   logic   [DATA_WIDTH - 1 : 0] i_p        ,
    
    output  logic   [DATA_WIDTH - 1 : 0] o_sum 
    
    );
    
    
    logic cout_1, cout_1_reg_1, cout_1_reg_2, cout_2, cout_2_reg, c_in, c_in_2;
    logic [DATA_WIDTH - 1 : 0] S1, S1_reg, S1_reg_2, S2, S2_reg;
    logic [DATA_WIDTH - 1 : 0] a_reg, b_reg, p_reg_1, p_reg_2, b_MUX_out, p_MUX_out;
    
    assign b_MUX_out = (i_op_sel == 1'b0) ? i_b : ~i_b;                                // Select b for addition and ~b for subtraction 
    
    
    assign p_MUX_out = (i_op_sel == 1'b0) ? i_p : ~i_p;                                // Select p for addition and ~p for subtraction 
    
    // assign out_sel = (cout_1_reg_2 & i_op_sel) | ( (cout_1_reg_2 | cout_2_reg) & (~i_op_sel) );
    
    // assign output_MUX = (out_sel == 1'b1) ? S2_reg : S1_reg_2;
    
    always_ff @(posedge i_clk or negedge i_rst_n )
    begin
    
        if (!i_rst_n)
        begin
        
            o_sum        <= 'b0;
            a_reg        <= 'b0;
            b_reg        <= 'b0;
            p_reg_1      <= 'b0;
            p_reg_2      <= 'b0;
            c_in         <= 'b0;
            c_in_2       <= 'b0;
            S1_reg       <= 'b0;
            S1_reg_2     <= 'b0;
            S2_reg       <= 'b0;
            cout_1_reg_1 <= 'b0;
            cout_1_reg_2 <= 'b0;
            cout_2_reg   <= 'b0;
            
        end
        else
        begin
        
            a_reg   	 <= i_a         ;
            b_reg   	 <= b_MUX_out   ;
            p_reg_1 	 <= p_MUX_out   ; 
            c_in    	 <= i_op_sel    ;           
            c_in_2  	 <= ~c_in       ;  
            S1_reg  	 <= S1          ;
            S1_reg_2     <= S1_reg      ;
            S2_reg  	 <= S2          ;
            cout_1_reg_1 <= cout_1		;
            cout_1_reg_2 <= cout_1_reg_1;
            cout_2_reg   <= cout_2		;
            
            if(i_op_sel == 1'b0) 
            begin
                p_reg_2 <= ~p_reg_1;
                
                if(cout_1_reg_2 | cout_2_reg)
                begin
                    o_sum <= S2_reg;
                end
                else
                begin
                    o_sum <= S1_reg_2;          
                end
            end
            else
            begin
                p_reg_2 <= p_reg_1;
                if(cout_1_reg_2)
                begin
                    o_sum <= S1_reg_2;
                end
                else
                begin
                    o_sum <= S2_reg;
                end
            end
            

        end
        
    end 
    
carry_look_ahead_adder #(

            .DATA_WIDTH(DATA_WIDTH)
            
        ) ADDER_1 (
            
            .in_1	(a_reg  ),
            .in_2	(b_reg  ),
            .c_in	(c_in   ),
            .o_Sum	(S1     ),
            .c_out	(cout_1 )
    
);

carry_look_ahead_adder #(

            .DATA_WIDTH(DATA_WIDTH)
            
        ) ADDER_2 (
            
            .in_1	(S1_reg  ),
            .in_2	(p_reg_2 ),
            .c_in	(c_in_2  ),
            .o_Sum	(S2      ),
            .c_out	(cout_2  )
    
);



      
endmodule
