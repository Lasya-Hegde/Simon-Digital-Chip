# Physical Design Workflow

This repository showcases the full backend layout flow of an ASIC design, covering key stages from floorplanning to final layout. Each stage includes corresponding visual outputs generated using industry-standard tools.

---

## Floorplan  
Defines the physical partitioning and placement regions of standard cells, macros, and I/O pads.

<img width="658" height="490" alt="Floorplan" src="https://github.com/user-attachments/assets/44345f65-6783-4b30-a9c9-97719dcb192f" />

---

## I/O Cells  
Placement of I/O pads and ESD cells around the periphery.

<img width="613" height="491" alt="IO cells" src="https://github.com/user-attachments/assets/7f3bd5d9-99e0-4767-8e0b-2e0aead3e0df" />

---

## Power Plan  
Power distribution network including VDD and GND rings and stripes for uniform power delivery.

<img width="613" height="489" alt="Powerplan" src="https://github.com/user-attachments/assets/ad46eb2a-3d2d-4be5-b2e3-825ef327536f" />

---

## Placement  
Legalized and optimized placement of standard cells within the defined floorplan.

<img width="639" height="479" alt="Placement" src="https://github.com/user-attachments/assets/463e22c0-7194-4a9c-82ef-0f9a9eaef301" />

---

## Clock Tree Synthesis (CTS)  
Insertion of buffers/inverters to distribute the clock signal with minimal skew.

<img width="1366" height="637" alt="CTS" src="https://github.com/user-attachments/assets/7b64f342-24c9-42b0-831f-6b66ab2de3d5" />

---

## Routing  
Full signal routing of all placed standard cells using metal layers with DRC clean design.

<img width="606" height="486" alt="Routing" src="https://github.com/user-attachments/assets/44607882-669f-4455-a35a-7d64febd453a" />

---

## Fillers  
Insertion of filler cells to ensure well tie-offs and manufacturing rule compliance.

<img width="1158" height="550" alt="Fillers" src="https://github.com/user-attachments/assets/02f7ec45-3749-49ad-8787-43d5d4939b2b" />

---

## Final Layout  
Final tapeout-ready layout including all design and filler cells, power network, clock tree, and routing.

<img width="779" height="588" alt="Final_layout" src="https://github.com/user-attachments/assets/e4ce4a00-024c-4bec-914f-c0dae88c7c4f" />

---
