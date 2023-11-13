Dir:
	mkdir log
	mkdir reports

spyglass: 
	sg_shell -t spy.tcl |tee log/run.log

.PHONY: spyglass clean 

clean:
	-@rm -rf async_fifo *.rpt *.log
