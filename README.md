This project implements a simplified ARM single-cycle processor in SystemVerilog.
The processor supports the following instructions: ADD, SUB, AND, ORR, EOR, LDR, STR, BEQ, BGT, BLT, and B. All instruction execution, including fetch, decode, execute, memory access, and write-back, occurs within a single clock cycle.

The system consists of a top-level module (top.sv), a controller (controller.sv), datapath components (including the register file, ALU, adder, sign extender, multiplexers, data memory), instruction memory (imem.sv), and a testbench for simulation. 
The instruction memory loads machine code from a .dat file. The controller decodes instructions and generates the necessary control signals for ALU operations, memory access, register writes, and branching. A condition checker evaluates the NZCV flags to determine whether conditional branches update the program counter.

To run the project, open a Quartus project, ensure all SystemVerilog files are included, compile the design, and run simulation using ModelSim. A successful run will print “Simulation succeeded.” 
To test custom programs, write ARM assembly code, convert it to machine code, save it as a .dat file, update imem.sv accordingly, and re-run simulation.

The current assembly program used in the testbech (memfile.dat) executes the following instructions:
```asm
MAIN    SUB R0, R15, R15
        ADD R1, R0, #255
        ADD R2, R1, R1
        STR R2, [R0, #16]
        STR R1, [R0, #20]
        EOR R3, R1, #77
        AND R4, R3, #0x55
        SUB R5, R3, R4
         AND R6, R5, #0x50
        ORR R7, R6, #0x10
        LDR R8, [R7]
        LDR R9, [R7, #4]
        SUBS R10, R8, R9
        BGT HERE
        STR R10, [R4, #4]
        B MAIN
HERE    STR R10, [R0, #4]
