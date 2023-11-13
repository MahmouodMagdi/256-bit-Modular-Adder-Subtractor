#!SPYGLASS_PROJECT_FILE
#!VERSION 3.0
#  -------------------------------------------------------------------
#  This is a software generated project file. Manual edits to this file could be lost during the next save operation
#  Copyright Synopsys Inc.
#  -------------------------------------------------------------------


# Top Design Name 
set top Mod_Add_Sub


# --------------------------------------------------------------
#			Project Setup Section 			
# --------------------------------------------------------------

# Create a new project 
new_project $top -force




# --------------------------------------------------------------
#			Data Import Section 			
# --------------------------------------------------------------

# Reading RTL Files
#read_file -type verilog {../src/carry_look_ahead_adder.sv ../src/Mod_Add_Sub.sv}


# Adding a source file list
read_file -type sourcelist /home/ICer/Projects/MOD_ADD_SUB/spyglass/sources.f

# Specify the top to define the top module
set_option top $top


# Read Spyglass design constraints 
read_file -type sgdc SGDC/$top.sgdc





# --------------------------------------------------------------
#			Common Options Section 			
# --------------------------------------------------------------

#set_option projectwdir 
set_option language_mode mixed
#set_option designread_enable_synthesis no
set_option designread_disable_flatten no
set_option enableSV yes
set_option enableSV09 yes
set_option hdlin_translate_off_skip_text yes





# --------------------------------------------------------------
#			Goal Setup Section 			
# --------------------------------------------------------------

current_methodology $SPYGLASS_HOME/GuideWare/latest/block/rtl_handoff

# define goal scope

current_goal lint/lint_rtl -top $top
run_goal

current_goal lint/lint_turbo_rtl -top $top
run_goal

current_goal lint/lint_functional_rtl -top $top
run_goal

current_goal lint/lint_abstract -top $top
run_goal

current_goal adv_lint/adv_lint_struct -top $top
run_goal

current_goal adv_lint/adv_lint_struct -top $top
run_goal

#current_goal cdc/cdc_verify_struct
#run_goal

#current_goal cdc/cdc_verify
#run_goal





# --------------------------------------------------------------
#		     Reports Generation Section 			
# --------------------------------------------------------------
capture /home/ICer/Projects/MOD_ADD_SUB/spyglass/reports/summary.rpt {write_report summary}
capture /home/ICer/Projects/MOD_ADD_SUB/spyglass/reports/spyglass_violations.rpt {write_report spyglass_violations}
capture /home/ICer/Projects/MOD_ADD_SUB/spyglass/reports/elab_summary.rpt {write_report elab_summary}
capture /home/ICer/Projects/MOD_ADD_SUB/spyglass/reports/ADV-LINT.rpt {write_report ADV-LINT}
capture /home/ICer/Projects/MOD_ADD_SUB/spyglass/reports/score.rpt {write_report score}


# --------------------------------------------------------------
#			GUI Start Section 			
# --------------------------------------------------------------
gui_start














