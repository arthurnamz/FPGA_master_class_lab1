In this lab we are implementing the ALU for OR, AND, XOR, and XNOR. The result of the ALU is displayed on the 7-segment display board of the Urbana board.

# Simulation Setup

## How to Run Simulation

1. **Command-line Simulation:**
   - Run `simulate.sh` with the top-level module name as argument (e.g., `./simulate.sh aluSegWrapper_tb`).
   - This script will:
     - Compile all Verilog files (`xvlog *.v`)
     - Elaborate the top-level testbench (`xelab $TOP_LEVEL -timescale 1ns/1ps`)
     - Run the simulation in batch mode (`xsim $TOP_LEVEL -R`)

2. **GUI Simulation:**
   - Run `simulateGUI.sh` with the top-level module name as argument (e.g., `./simulateGUI.sh aluSegWrapper_tb`).
   - This script will:
     - Compile and elaborate as above
     - Launch the simulation in GUI mode (`xsim $TOP_LEVEL -g`)

3. **Cleaning Up:**
   - Run `clean.sh` to remove generated log, database, and temporary files from previous runs.

## File Relationships

- `alu.v`: Implements the ALU logic for OR, AND, XOR, and XNOR operations.
- `alu7seg.v`: Converts 3-bit values to 7-segment display encoding.
- `aluSegWrapper.v`: Top-level module that connects the ALU and 7-segment display logic. It instantiates `alu` and multiple `alu7seg` modules to show OPA, OPB, OPCODE, and ALU result on displays.
- `aluSegWrapper_tb.v`: Testbench for `aluSegWrapper`. It generates test vectors, checks outputs, and validates the design.
- `simulate.sh`: Shell script to compile, elaborate, and run the simulation in batch mode.
- `simulateGUI.sh`: Shell script to compile, elaborate, and run the simulation in GUI mode.
- `clean.sh`: Shell script to clean up simulation artifacts.
- `README.md`: This file. Provides project overview and instructions.
