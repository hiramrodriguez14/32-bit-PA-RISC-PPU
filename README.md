# 32-bit Pipelined Processing Unit (PA-RISC Subset)

This project was developed for the course *Computer Architecture and Organization*. It implements a 32-bit pipelined processing unit based on a subset of the Hewlett-Packard Precision Architecture (PA-RISC).

The processor supports a simplified **instruction set architecture (ISA)** with **25 instructions**. The design follows the Harvard architecture model, featuring separate instruction and data memory. The datapath is fully pipelined, with the following five stages:
- **Fetch**
- **Decode**
- **Execute**
- **Memory**
- **Write Back**
  
### Block Diagram

![Block Diagram](PA-RISC BLOCK DIAGRAM FINAL.png)


The processor includes:
- A register file with **32 general-purpose registers**
  - Register **R0** is hardwired to zero and used for unconditional branches
- Separate **instruction memory** and **data memory**
- A Verilog HDL implementation of the entire architecture
- A block diagram for visualization
- Three sample programs in machine code, each with its own testbench

---

## Instruction Set

### Three-Register Arithmetic and Logical Instructions  
*(opcode = `000010`)*

| Mnemonic | Binary Code | Description                      |
|----------|-------------|----------------------------------|
| ADD      | `011000`    | Add                              |
| ADDC     | `011100`    | Add with Carry                   |
| ADDL     | `101000`    | Add Long                         |
| SUB      | `010000`    | Subtract                         |
| SUBB     | `010100`    | Subtract with Borrow             |
| OR       | `001001`    | Bitwise OR                       |
| XOR      | `001010`    | Bitwise XOR                      |
| AND      | `001000`    | Bitwise AND                      |

### Memory Access Instructions

| Mnemonic | Binary Code | Description         |
|----------|-------------|---------------------|
| LDW      | `010010`    | Load Word           |
| LDH      | `010001`    | Load Half Word      |
| LDB      | `010000`    | Load Byte           |
| STW      | `011010`    | Store Word          |
| STH      | `011001`    | Store Half Word     |
| STB      | `011000`    | Store Byte          |

### Immediate and Offset Instructions

| Mnemonic | Binary Code | Description         |
|----------|-------------|---------------------|
| LOA      | `001101`    | Load Offset         |
| LI       | `001000`    | Load Immediate      |
| ADDI     | `101101`    | Add Immediate       |
| SUBI     | `100101`    | Subtract Immediate  |

### Branch Instructions

| Mnemonic | Binary Code | Description                    |
|----------|-------------|--------------------------------|
| BL       | `111010`    | Branch and Link                |
| CBT      | `100000`    | Compare and Branch if True     |
| CBF      | `100010`    | Compare and Branch if False    |

### Shift Instructions  
*(opcodes `110100` for right shift, `110101` for left shift — controlled by bits `[12:10]`)*

**Shift Right (`110100`):**

| Function | Bits `[12:10]` | Name   |
|----------|----------------|--------|
| Logical  | `110`          | EXTRU  |
| Arithmetic | `111`        | EXTRS  |

**Shift Left (`110101`):**

| Function | Bits `[12:10]` | Name   |
|----------|----------------|--------|
| Zero-extend | `010`       | ZDEP   |

### Other

| Mnemonic | Binary Code | Description     |
|----------|-------------|-----------------|
| NOP      | `000000`    | No Operation    |

---

## Architecture Summary

- **ISA:** Subset of PA-RISC
- **Pipeline Stages:** Fetch, Decode, Execute, Memory, Write Back
- **Architecture Style:** Harvard (separate instruction/data memory)
- **Registers:** 32 general-purpose (R0 hardwired to 0)
- **Instruction Memory:** Loads one of three provided programs
- **Testbenches:** Each program is tested individually
- **HDL:** Verilog

---

## Files Included

- Verilog source code (`*.v`)
- Block diagram of the processor
- Three sample programs (machine code)
- Corresponding testbenches for simulation

---

## How to Use

1. Open the Verilog project in your preferred HDL environment (e.g., ModelSim, Icarus Verilog).
2. Load one of the machine code programs into instruction memory.
3. Run the simulation using the provided testbench.
4. Observe the processor’s behavior through waveform analysis or terminal output.

---

Let me know if you'd like to add simulation instructions, waveform screenshots, or documentation formatting tips.
