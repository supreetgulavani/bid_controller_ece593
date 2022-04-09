######################################################################
# ECE593 - Fundamentals of Pre-Silicon Validation
#			Bid Controller
#
# Group 16: Supreet Gulavani, Sreeja Boyina
######################################################################

# Target
TARGET		:= bid_controller

# Directories for source files and builds
SRC_DIR 	:= src
BUILD_DIR 	:= work transcript *~ vsim.wlf *.log dgs.dbg dmslogdir

# sources and objects
SRCS	:= $(wildcard $(SRC_DIR)/*.sv)

# build recipies
all: setup compile opt $(TARGET)

setup:
		vlib work
		vmap work work

compile:
		vlog $(SRCS)
		vlog -f tb.f

opt:
		vopt top -o top_optimized +acc "+cover=sbfec+bidder(rtl)."

build: all 

.PHONY: all clean setup compile sopt info

.DEFAULT_GOAL	:= build
clean:
		rm -rf $(BUILD_DIR) $(TARGET)
		@echo "Cleanup done!"

info:
	@echo "Application:\t" $(TARGET)
	@echo "Sources:\t" $(SRCS)