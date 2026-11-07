# Disaster Emergency Alert & Rescue Management System
### Advanced 8086 Assembly Language Project Using EMU8086
**BGC Trust University Bangladesh**  
**Department of Computer Science & Engineering (CSE)**  
**Course:** Microprocessor and Assembly Language (CSE 313 / 314 Sessional Lab)

---

[![Platform](https://img.shields.io/badge/Platform-EMU8086%20Microprocessor%20Emulator-007acc.svg)](https://emu8086.software.informer.com/)
[![Language](https://img.shields.io/badge/Language-8086%20Assembly%20(Pure%20MASM%2FTASM)-emerald.svg)](#)
[![Memory Model](https://img.shields.io/badge/Memory%20Model-.MODEL%20SMALL%20(64KB%20Code%2C%2064KB%20Data)-blue.svg)](#)
[![Institution](https://img.shields.io/badge/University-BGC%20Trust%20University%20Bangladesh-purple.svg)](https://www.bgctub.ac.bd/)
[![Status](https://img.shields.io/badge/Verification-100%25%20Tested%20%26%20Compilable-brightgreen.svg)](#)

---

## 📌 Project Overview

The **Disaster Emergency Alert & Rescue Management System** is an advanced, fail-safe 16-bit command-and-control simulation system implemented entirely in **8086 Assembly Language** for the **EMU8086 Microprocessor Emulator**.

Designed specifically in the socio-geographical context of **Bangladesh**, the system coordinates emergency response operations during natural disasters such as **monsoon flash floods (Sunamganj, Sylhet)**, **tropical cyclones (Chittagong, Cox's Bazar, Barisal)**, **landslides**, and **structural fires**. It manages citizen distress calls (SOS), rescue team mobilization, emergency hospital bed triage, evacuee shelter quotas, integer environmental risk calculation, and warehouse relief logistics.

---

## 📸 Screenshots & System Interface

### 1. Interactive 80x25 Virtual Terminal & Live 8086 CPU Registers
The terminal renders a classic green-on-black CGA Mode 03H screen with live 16-bit register tracking (`AX`, `BX`, `CX`, `DX`, `SI`, `DI`, `SP`, `IP`, `Flags`, `Interrupt Vector Table`).

![Virtual Emulator Terminal](docs/screenshots/01_emulator_terminal.png)

---

### 2. 8086 Assembly Code Explorer with Bengali Deep-Dive
Structured, section-by-section breakdown of all 12 modules with register maps, instruction explanations, and potential viva exam questions in simple Bengali (*সহজ বাংলায় কোড বিশ্লেষণ*).

![Assembly Code Viewer](docs/screenshots/02_assembly_code_viewer.png)

---

### 3. Full 950+ Line `DISASTER.ASM` Source Code View
Complete, continuous MASM/TASM source code ready for one-click copy or file download.

![Full Source Code View](docs/screenshots/03_full_source_code.png)

---

### 4. Automated Live Flood Disaster Demonstration Workflow
Executing a real-time, multi-step disaster response scenario in Sunamganj Haor Basin for university defense evaluation.

![Live Demo Scenario](docs/screenshots/04_live_terminal_demo.png)

---

## 🌟 Key Features (12 Core Modules)

| Module | Feature Name | Description & 8086 Implementation Strategy |
| :---: | :--- | :--- |
| **01** | **Disaster Alert Management** | Categorizes 7 hazards across 7 Bangladesh districts; issues unique broadcast tokens (`BD-ALT-808X`); increments `TOTAL_ALERTS`. |
| **02** | **Citizen Emergency SOS** | Captures citizen name and national ID using DOS buffered input (`INT 21H, AH=0AH`); generates `SOS-2026-X` rescue tickets. |
| **03** | **Rescue Team Management** | Roster of 5 emergency units (Red Crescent, Fire Service, Coast Guard, Police, Volunteers); uses branchless `XOR TEAM_STATUS[SI], 1` for O(1) status toggling. |
| **04** | **Hospital Bed Allocation** | Triage bed tracker for CMCH, BGC Trust Medical, and Sylhet MAG Osmani; decrements word-level capacities (`DEC HOSP_BEDS[SI]`) with zero-capacity boundary guards. |
| **05** | **Emergency Shelter Management** | Tracks displaced citizens in cyclone shelters; allocates space in 4-person family blocks (`SUB SHELTER_CAPS[SI], 4`). |
| **06** | **Environmental Risk Engine** | Rule-based meteorological formula `((Rainfall*2) + (WindSpeed*3)) / 4` executed via 8086 integer multiplication (`MUL`) and division (`DIV`). |
| **07** | **Relief Resource Inventory** | Tracks dry food packets, drinking water cans, medicine kits, and rescue boats; prevents negative stock underflow via `CMP` and `JB`. |
| **08** | **Live Statistics Dashboard** | Displays real-time decimal counters for all active alerts, distress calls, patients, and supplies using custom `PRINT_NUM`. |
| **09** | **Admin Security Panel** | 4-digit PIN authentication (`8086`) with masked keystrokes (`AH=08H`) without screen echo; enables master counter resets and siren broadcasts. |
| **10** | **Safety Protocols** | Official disaster-specific preparedness guidelines in clear English prose. |
| **11** | **Live Demo Scenario** | Scripted 5-step automated flood emergency simulation in Sunamganj Haor Basin. |
| **12** | **System Shutdown** | Clean CPU handover and return to DOS kernel via `INT 21H, AH=4CH`. |

---

## ⚙️ 8086 Microprocessor Architecture Used

```
+-------------------------------------------------------------------------------+
|                       8086 CPU ARCHITECTURE OVERVIEW                          |
+-------------------------------------------------------------------------------+
|  CPU Model       | Intel 8086 (16-bit ALU, 16-bit Registers, 4.77 MHz)       |
|  Memory Mode     | .MODEL SMALL (64 KB Code Segment, 64 KB Data Segment)      |
|  Address Bus     | 20-bit (Up to 1 MB Physical Memory Space in Real Mode)     |
|  Stack Segment   | .STACK 100H (256-byte LIFO stack)                          |
+-------------------------------------------------------------------------------+
|                       REGISTER UTILIZATION IN CODE                            |
+-------------------------------------------------------------------------------+
|  AX (AH/AL)      | Accumulator | Arithmetic (MUL/DIV), DOS interrupt codes    |
|  BX (BH/BL)      | Base        | Divisors (Base 10, Divisor 4), Memory offset |
|  CX (CH/CL)      | Counter     | Loop control (LOOP), string length counter   |
|  DX (DH/DL)      | Data        | String offsets (LEA DX, STR), remainder store|
|  SI & DI         | Index       | Array indexing (TEAM_STATUS, HOSP_BEDS)      |
|  SP & BP         | Stack       | Stack pointer & Procedure stack frames       |
|  Flags           | Status      | ZF (Zero - JE/JNE), CF (Carry - JB/JA)       |
+-------------------------------------------------------------------------------+
```

### Physical Address Generation Formula
In the 8086 segmented architecture:
$$\text{Physical Address} = (\text{Segment Register} \times 10\text{H}) + \text{Offset Address}$$

*Example:*  
If Data Segment $\text{DS} = 0710\text{H}$ and Offset $= 0108\text{H}$:
$$\text{Physical Address} = (0710\text{H} \times 16) + 0108\text{H} = 07100\text{H} + 0108\text{H} = 07208\text{H}$$

---

## 🛠️ Key Assembly Algorithms

### 1. Integer-to-Decimal ASCII Printer (`PRINT_NUM`)
Because DOS `INT 21H` only outputs individual ASCII characters, multi-digit numbers are converted using successive base-10 division and the LIFO stack:
```assembly
PRINT_NUM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0              ; Initialize digit counter
    MOV BX, 10             ; Divisor base 10

CONVERT_LOOP:
    MOV DX, 0              ; Clear high word for 16-bit division
    DIV BX                 ; AX = Quotient, DX = Remainder (0-9)
    PUSH DX                ; Push remainder onto stack
    INC CX                 ; Increment digit count
    CMP AX, 0              ; Continue until quotient is zero
    JNE CONVERT_LOOP

PRINT_DIGITS:
    POP DX                 ; Retrieve digit from stack (MSD first)
    ADD DL, '0'            ; Convert binary integer to ASCII char
    MOV AH, 02H            ; DOS character print interrupt
    INT 21H
    LOOP PRINT_DIGITS      ; Loop CX times

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP
```

### 2. Branchless Status Toggle (`XOR`)
```assembly
; Toggle rescue unit between 0 (Available) and 1 (Deployed)
SUB AL, '1'                ; Convert ASCII '1'-'5' to index 0-4
MOV AH, 0
MOV SI, AX
XOR TEAM_STATUS[SI], 1     ; 0 XOR 1 = 1; 1 XOR 1 = 0 (3 clock cycles)
```

---

## 📂 Repository File Structure

```
├── DISASTER.ASM                 # Complete 950+ lines pure 8086 Assembly Source Code
├── README.md                    # Comprehensive GitHub documentation with screenshots
├── docs/
│   └── screenshots/             # High-resolution screenshots of the terminal & code
│       ├── 01_emulator_terminal.png
│       ├── 02_assembly_code_viewer.png
│       ├── 03_full_source_code.png
│       └── 04_live_terminal_demo.png
├── src/                         # Interactive Web Emulator & Workbench
│   ├── components/
│   │   ├── VirtualEmu8086.tsx   # 80x25 CRT Terminal & CPU Register Simulator
│   │   └── AsmCodeViewer.tsx    # Syntax-highlighted code explorer & Bengali analyzer
│   ├── data/
│   │   ├── asmSourceCode.ts     # Authentic assembly code chunks & section maps
│   │   └── projectData.ts       # Viva questions, test cases, and academic notes
│   ├── App.tsx                  # Main dual-tab application container
│   ├── main.tsx
│   └── index.css
├── index.html
├── package.json
└── vite.config.ts
```

---

## 🚀 How to Run in EMU8086

1. **Clone or Download the Repository:**
   ```bash
   git clone https://github.com/your-username/emu8086-disaster-management.git
   ```
2. **Open EMU8086:**
   - Launch **EMU8086 - Microprocessor Emulator** on your computer.
   - Click **"New"** $\to$ Select **"Empty workspace"**.
3. **Load the Source Code:**
   - Open `DISASTER.ASM` or copy its contents into the emulator editor window.
4. **Compile and Run:**
   - Press **`F5`** (or click the green **"Emulate"** button).
   - In the emulation window, press **`F9`** (or click **"Run"**).
5. **Interact:**
   - The green-on-black CGA terminal will open. Type numbers `1` through `12` to navigate options.

---

## 🧪 Testing & Verification Matrix

| Test ID | Module | Input | Expected Output | Status |
| :---: | :--- | :--- | :--- | :---: |
| **TC-01** | Main Menu | Key `'1'` | Clears screen and navigates to Alert Management | **PASSED** |
| **TC-02** | Menu Boundary | Key `'9'` | Displays invalid choice warning; preserves RAM | **PASSED** |
| **TC-03** | Disaster Alert | Flood, Sunamganj, Critical | Issues `BD-ALT-8084`, increments `TOTAL_ALERTS` | **PASSED** |
| **TC-04** | Citizen SOS | "Rahim Uddin", NID | Records ticket `SOS-2026-8`, increments `TOTAL_SOS` | **PASSED** |
| **TC-05** | Rescue Team | Select Team 3 | Status toggles via `XOR`; updates active rescues | **PASSED** |
| **TC-06** | Hospital Bed | Select Hospital 2 | Decrements bed count; increments admitted patients | **PASSED** |
| **TC-07** | Bed Limit | Allocate at 0 capacity | Rejects admission with capacity warning | **PASSED** |
| **TC-08** | Risk Engine | Rain=85mm, Wind=75km/h | Computes score `98` $\to$ Classifies as `HIGH RISK` | **PASSED** |
| **TC-09** | Relief Stock | Dispatch 25 Cans Water | Decrements balance from 850 to 825 | **PASSED** |
| **TC-10** | Underflow Guard | Request 50 Boats (stock 40) | Intercepts via `JB RES_UNDERFLOW`; rejects request | **PASSED** |
| **TC-11** | Admin PIN | PIN `"8086"` | Displays `****` silently, unlocks command options | **PASSED** |
| **TC-12** | Admin Reject | PIN `"1234"` | Rejects authorization; records security event | **PASSED** |
| **TC-13** | Shutdown | Option 12, `'Y'` | Returns control cleanly to DOS (`INT 21H, AH=4CH`) | **PASSED** |

---

## 👥 Team Members & Contribution

This capstone project was completed by a 2-member undergraduate engineering team at **BGC Trust University Bangladesh**:

* **Team Member 1:** System Architecture, `.MODEL SMALL` Memory Layout, Main Menu Router, Disaster Alert Engine, Citizen SOS Buffering, Academic Documentation.
* **Team Member 2:** Rescue Team XOR Status Logic, Hospital & Shelter Capacity Allocation, 8086 Integer Risk Arithmetic (`MUL`/`DIV`), Relief Warehouse Inventory, Test Matrix & Verification.

---

## 📜 Academic Acknowledgements

Special gratitude to our respected course supervisor and the faculty of the **Department of Computer Science & Engineering (CSE)** at **BGC Trust University Bangladesh** for their guidance on microprocessor hardware architecture, assembly language programming, and low-level system design.

---

## 📄 License

This educational project is distributed under the **Apache-2.0 License**. Feel free to use and adapt it for university microprocessor coursework.
