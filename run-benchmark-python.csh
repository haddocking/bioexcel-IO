#!/bin/tcsh

foreach i ( `seq 0 250000 1000000` )
#foreach i ( `seq 0 1 5` )

	echo $i
	ls -U -d pdbs/* | head -n $i > in.file
	time /home/rodrigo/miniconda3/bin/python calc-batch-hs.py in.file
	\rm in.file 
end
