##**** before you run the do file change the diroctory from file->change diroctory to the recent file 


## for quit the last simulation
quit -sim

## for compile the files "we here compile with f files for more general case "
vlog -coveropt 3 +cover +acc -sv my_top.sv -v AES_DUT.v

## for run the simulation
vsim -coverage -novopt -suppress 12110 work.my_top -c -do "coverage save -onexit -directive -codeAll cover_repo.ucdb"
add wave -position insertpoint sim:/my_top/dut1/in
add wave -position insertpoint sim:/my_top/dut1/key
add wave -noupdate -height 60 -divider "divider"
add wave -position insertpoint sim:/my_top/dut1/out
 
 run -all

radix -binary -showbase
radix signal sim:/my_top/dut1/in hexadecimal -showbase
radix signal sim:/my_top/dut1/key hexadecimal -showbase
radix signal sim:/my_top/dut1/out hexadecimal -showbase
 
 #for generate the report
coverage report -details -output coverage_report.txt
vcover report -html cover_repo.ucdb

##vcover merge -o combined_coverage.ucdb Adds.ucdb early.ucdb Lt_fall_gen2s.ucdb Lt_fall_gen3s.ucdb Lt_fall_gen4s.ucdb Normal_gen2_1s.ucdb normal_gen3_1s.ucdb normal_gen3_2s.ucdb normal_gen4s.ucdb sbrx_gen4s.ucdb sbrx_gen2s.ucdb sbrx_gen3s.ucdb