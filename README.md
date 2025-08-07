#  Simon Cipher ASIC Implementation

This repository contains the full ASIC design flow of the **Simon block cipher**, from **RTL to GDSII**, using the **Cadence digital design toolchain**. 
---

## Project Overview

- **Cipher:** Simon (Lightweight block cipher)
- **Design Type:** ASIC implementation (full-custom flow)
- **Toolchain:** Cadence (Genus, Innovus, Virtuoso)
- **Design Language:** Verilog 
- **Target Technology:** [SCL 180nm technology]
- **Flow:** RTL → Synthesis → PnR → GDSII → Signoff

## About Simon cipher
  Simon is a family of lightweight block ciphers publicly released by the National Security Agency (NSA) in June 2013. Simon has been optimized for performance in hardware implementations, while its sister algorithm, Speck, has been optimized for software implementations. The NSA began working on the Simon and Speck ciphers in 2011. The agency anticipated some agencies in the US federal government would need a cipher that would operate well on a diverse collection of Internet of Things devices while maintaining an acceptable level of security.The Simon cipher family offers excellent performance characteristics in hardware implementations while maintaining strong cryptographic security, making it ideal for resource-constrained applications where traditional ciphers would be prohibitively expensive in terms of power and area.
Key Applications:
- Internet of Things (IoT) devices and sensor networks
- RFID tags and smart cards
- Embedded systems with limited computational resources
- Battery-powered wireless devices
- Automotive and industrial control systems
- Mobile device security processors

<img width="330" height="384" alt="Simon_block_cipher" src="https://github.com/user-attachments/assets/77d9ff93-6b07-42d2-a29c-fe08ee9aa217" />

---
## Cipher Configuration

- **Block Size**: 32 bits
- **Key Size**: 64 bits
- **Rounds**: 32
- **Architecture**: Feistel Network with Round Key Mixing
- **Security Profile**: Sufficient for lightweight cryptographic needs

---

## I/O and Pin Configuration

- **Total Pins**: 48
### Power Pins
- 16 pins (4 per side): `VDD`, `VSS`, `VDDO`, `VSSO`

### Control Signals
- `CLK`: Clock input  
- `RST`: Active reset  
- `START`: Trigger encryption  
- `DONE`: Signals encryption complete

### Data Interface
- **Key Input**: 8-bit serial-in (converted to 64-bit internally)
- **Plaintext Input**: 4-bit serial-in (converted to 32-bit internally)
- **Ciphertext Output**: 4-bit serial-out (from internal 32-bit data)

### Interface Processing Modules
- **SIPO (Serial-In Parallel-Out)**:
  - Reduces I/O overhead while maintaining full-width operation
- **PISO (Parallel-In Serial-Out)**:
  - Enables serialized encrypted output

### Test and Debug
- 6 dedicated test pins for enhanced validation and debugging

---


## Design Architecture

Modular RTL design with the following key components:

| Module           | Description |
|------------------|-------------|
| `Top.v`          | Top-level integrator and controller |
| `input_taker_5.v`| Serial interface for plaintext and key |
| `key_gen.v`      | Simon 64-bit key expansion module |
| `encrypt.v`      | 32-round Feistel-style encryption engine |
| `output_giver.v` | Ciphertext serialization and output logic |
| `simon_newer.v`  | Alternate encryption core (for A/B testing) |
| `Top_tb.v`       | Functional verification testbench |

Pad cells (`pc3c01.v`, `pc3o05.v`, `pc3d01.v`) were used to model real-world I/O behavior in synthesis and layout stages.

---

## Physical Design Flow

Performed using **Cadence Innovus** and standard physical design stages:

- Die Size: **2000 µm × 2000 µm**
- **Steps**:
  - Floorplanning
  - Power planning (post-synthesis VDD/VSS pad insertion)
  - Placement
  - Clock Tree Synthesis (CTS)
  - Routing
  - Timing analysis (Setup & Hold)
  - GDSII export

### Signoff Checks

| Check              | Tool/Stage        | 
|--------------------|-------------------|
| Functional GLS     | Post-layout       |
| Logic Equivalence  | Netlist vs RTL    |
| DRC & Antenna DRC  | Layout Compliance |
| LVS                | Schematic vs Layout |

---
