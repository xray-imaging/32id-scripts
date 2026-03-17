#!/bin/bash

#Starting optique peter IOC and screen

conda activate mctoptics
cd /home/beams/USERTXM/epics/synApps/support/mctoptics/iocBoot/iocMCTOptics
start_IOC
#start_medm (in another terminal) -----> fix
python -i start_mctoptics.py

