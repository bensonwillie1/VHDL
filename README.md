# VHDL Modules Collection

This repository contains a variety of standalone VHDL modules developed for experimentation, coursework, or general-purpose design. **These files are not intended to work together as a single project**, but rather serve as reusable or independently testable logic blocks and interfaces.

---

## Module Descriptions

### Arithmetic and Logic

- `ALU.vhd`  
  A basic Arithmetic Logic Unit supporting common operations (e.g., add, subtract, AND, OR, etc.).

- `Full_adder.vhd`  
  1-bit full adder module for binary addition with carry in/out.

- `CarryLookaheadAdder.vhd`  
  N-bit carry lookahead adder to improve addition speed over ripple carry.

- `CLA16.vhd`  
  A 16-bit carry lookahead adder built from lower-bit modules.

- `XOR.vhd`  
  Simple XOR logic gate module.

---

### Calculator System

- `CALCULATOR.vhd`  
  Top-level calculator control logic.

- `CALC_STATE.vhd`  
  Finite State Machine (FSM) to manage calculator states.

- `Hold.vhd` / `Load.vhd`  
  Register modules to hold and load operand data.

- `Mux.vhd`  
  Generic multiplexer module for signal selection.

---

### Memory

- `Memory.vhd`  
  Basic memory block for read/write operations.

---

### Communication Interfaces

- `I2C.vhd`  
  Low-level I2C logic block (clock, data line handling).

- `I2C_master_ctrl.vhd`  
  Controller module for I2C master transactions.

- `SPI_master.vhd`  
  Simple SPI master interface for serial communication.

---

### Control Systems

- `garagecontroller.vhd`  
  State machine-based garage door controller logic.

- `big door.vhd`  
  Possibly an extended version or related door control module.

- `sync.vhd`  
  Clock domain synchronizer for clean signal transitions.

---

## Notes

- These files are **not integrated** or intended to simulate as a whole.
- Each file may require its own testbench to verify functionality..

---
