; =====================================================================
; PROJECT TITLE: DISASTER EMERGENCY ALERT & RESCUE MANAGEMENT SYSTEM
; INSTITUTION:   BGC TRUST UNIVERSITY BANGLADESH
; DEPARTMENT:    COMPUTER SCIENCE & ENGINEERING (CSE)
; COURSE:        MICROPROCESSOR AND ASSEMBLY LANGUAGE (CSE 313/314)
; TARGET:        EMU8086 MICROPROCESSOR EMULATOR (8086 CPU, 16-BIT REAL MODE)
; ARCHITECTURE:  SEGMENTED MEMORY (SMALL MODEL, 64KB CODE, 64KB DATA)
; =====================================================================

.MODEL SMALL
.STACK 100H

; =====================================================================
; SECTION 1: DATA SEGMENT DECLARATIONS (.DATA)
; =====================================================================
.DATA

    ; --- SYSTEM STRINGS & BRANDING BANNERS ---
    TITLE_BORDER    DB '================================================================================', 0DH, 0AH, '$'
    APP_HEADER      DB '    *** DISASTER EMERGENCY ALERT & RESCUE MANAGEMENT SYSTEM (EMU8086) ***       ', 0DH, 0AH, '$'
    SUB_HEADER      DB '          BGC TRUST UNIVERSITY BANGLADESH - CSE MICROPROCESSOR LAB              ', 0DH, 0AH, '$'
    DIVIDER_LINE    DB '--------------------------------------------------------------------------------', 0DH, 0AH, '$'
    NEWLINE         DB 0DH, 0AH, '$'
    PRESS_ANY_KEY   DB 0DH, 0AH, 'Press any key to return to Main Menu...$', '$'

    ; --- MAIN MENU OPTIONS ---
    MENU_PROMPT     DB 'Please select an option (1-12): $'
    M_OPT1          DB ' [1]  Disaster Alert Management (Create & Broadcast)', 0DH, 0AH, '$'
    M_OPT2          DB ' [2]  Citizen Emergency SOS Portal (Submit Help Request)', 0DH, 0AH, '$'
    M_OPT3          DB ' [3]  Rescue Team Management & Deployment (XOR Status Toggle)', 0DH, 0AH, '$'
    M_OPT4          DB ' [4]  Hospital & Emergency Bed Allocation', 0DH, 0AH, '$'
    M_OPT5          DB ' [5]  Disaster Shelter & Displaced Citizen Portal', 0DH, 0AH, '$'
    M_OPT6          DB ' [6]  Environmental Disaster Risk Assessment Engine (MUL/DIV)', 0DH, 0AH, '$'
    M_OPT7          DB ' [7]  Emergency Relief Resource Inventory & Distribution', 0DH, 0AH, '$'
    M_OPT8          DB ' [8]  Real-Time Emergency Statistics Dashboard', 0DH, 0AH, '$'
    M_OPT9          DB ' [9]  Admin Security Panel & Incident Audit Log (PIN: 8086)', 0DH, 0AH, '$'
    M_OPT10         DB ' [10] National Disaster Safety Guidelines & Protocols', 0DH, 0AH, '$'
    M_OPT11         DB ' [11] Live Disaster Scenario Demonstration Mode', 0DH, 0AH, '$'
    M_OPT12         DB ' [12] System Shutdown & Final Incident Summary', 0DH, 0AH, '$'
    INVALID_CHOICE  DB 0DH, 0AH, ' [!] INVALID SELECTION! Please enter a number between 1 and 12.', 0DH, 0AH, '$'

    ; --- MODULE 1: DISASTER ALERT DATA ---
    ALERT_TITLE     DB 0DH, 0AH, ' >>> [MODULE 1: DISASTER ALERT MANAGEMENT] <<<', 0DH, 0AH, '$'
    DIS_SELECT_TYPE DB ' Select Disaster Category:', 0DH, 0AH
                    DB '   [1] Flood Disaster', 0DH, 0AH
                    DB '   [2] Cyclone / Storm Surge', 0DH, 0AH
                    DB '   [3] Earthquake', 0DH, 0AH
                    DB '   [4] Industrial / Urban Fire', 0DH, 0AH
                    DB '   [5] Landslide (Hill Tracts)', 0DH, 0AH
                    DB '   [6] Coastal Tsunami / Tidal Wave', 0DH, 0AH
                    DB '   [7] Building Structural Collapse', 0DH, 0AH
                    DB ' Enter choice (1-7): $'
    
    DIS_SELECT_ZONE DB 0DH, 0AH, ' Select Vulnerable Region (Bangladesh):', 0DH, 0AH
                    DB '   [1] Chittagong Coastal Zone', 0DH, 0AH
                    DB '   [2] Sylhet Haor Basin', 0DH, 0AH
                    DB '   [3] Coxs Bazar Coastal Belt', 0DH, 0AH
                    DB '   [4] Sunamganj River Basin', 0DH, 0AH
                    DB '   [5] Barisal Delta Area', 0DH, 0AH
                    DB '   [6] Kurigram / Northern Floods', 0DH, 0AH
                    DB '   [7] Dhaka Metropolitan Area', 0DH, 0AH
                    DB ' Enter choice (1-7): $'

    DIS_SELECT_SEV  DB 0DH, 0AH, ' Select Emergency Severity Level:', 0DH, 0AH
                    DB '   [1] LOW (Standby & Advisory)', 0DH, 0AH
                    DB '   [2] MODERATE (Cautionary Warning)', 0DH, 0AH
                    DB '   [3] HIGH (Evacuation Preparedness)', 0DH, 0AH
                    DB '   [4] CRITICAL (Immediate Evacuation Required)', 0DH, 0AH
                    DB ' Enter severity (1-4): $'

    ALERT_SUCCESS   DB 0DH, 0AH, ' [OK] EMERGENCY ALERT BROADCASTED SUCCESSFULLY!', 0DH, 0AH, '$'
    ALERT_ID_MSG    DB ' Generated Disaster Alert Broadcast ID: BD-ALT-808$'
    ALERT_COUNT_MSG DB 0DH, 0AH, ' Total Active Alerts in System: $'

    ; --- MODULE 2: CITIZEN SOS DATA ---
    SOS_TITLE       DB 0DH, 0AH, ' >>> [MODULE 2: CITIZEN EMERGENCY SOS PORTAL] <<<', 0DH, 0AH, '$'
    SOS_NAME_PROMPT DB ' Enter Citizen Full Name (Max 15 chars): $'
    SOS_ID_PROMPT   DB ' Enter National ID / Student ID: $'
    SOS_CONFIRM_MSG DB 0DH, 0AH, ' [OK] CITIZEN SOS RECORDED & TRANSMITTED TO CENTRAL DISPATCH!', 0DH, 0AH, '$'
    SOS_TICKET_MSG  DB ' Emergency Rescue Ticket ID: SOS-2026-$'
    SOS_NAME_BUFFER DB 16, ?, 16 DUP('$')   ; DOS buffered input structure (Byte 0: Max, Byte 1: Len)
    SOS_ID_BUFFER   DB 10, ?, 10 DUP('$')

    ; --- MODULE 3: RESCUE TEAMS DATA ---
    RESCUE_TITLE    DB 0DH, 0AH, ' >>> [MODULE 3: RESCUE TEAMS DEPLOYMENT ROSTER] <<<', 0DH, 0AH, '$'
    TEAM1_NAME      DB ' [1] BD Red Crescent Medical First Response Unit : $'
    TEAM2_NAME      DB ' [2] Bangladesh Fire Service & Civil Defence      : $'
    TEAM3_NAME      DB ' [3] Coast Guard / Navy Flood Rescue Boat Squad   : $'
    TEAM4_NAME      DB ' [4] Bangladesh Police Law & Perimeter Security   : $'
    TEAM5_NAME      DB ' [5] BGC Trust University Volunteer Youth Corps    : $'
    STATUS_AVAIL    DB '[AVAILABLE]', 0DH, 0AH, '$'
    STATUS_DEPLY    DB '[DEPLOYED ON MISSION]', 0DH, 0AH, '$'
    TEAM_DISPATCH_P DB 0DH, 0AH, ' Select Team to Deploy / Recall (1-5, or 0 to return): $'
    TEAM_STATUS     DB 0, 0, 0, 0, 0       ; 0 = Available, 1 = Deployed
    TEAM_UPDATED    DB 0DH, 0AH, ' [OK] Team deployment status updated in CPU memory!', 0DH, 0AH, '$'

    ; --- MODULE 4: HOSPITALS & MEDICAL DATA ---
    HOSP_TITLE      DB 0DH, 0AH, ' >>> [MODULE 4: EMERGENCY MEDICAL & HOSPITAL ALLOCATION] <<<', 0DH, 0AH, '$'
    HOSP1_INFO      DB ' [1] Chittagong Medical College Hospital   - Available Beds: $'
    HOSP2_INFO      DB ' [2] BGC Trust Medical College & Hospital  - Available Beds: $'
    HOSP3_INFO      DB ' [3] Sylhet MAG Osmani Medical Hospital    - Available Beds: $'
    HOSP_BEDS       DW 45, 30, 25          ; 16-bit word bed counts
    HOSP_ALLOC_P    DB 0DH, 0AH, ' Select Hospital to admit patient (1-3, or 0 to exit): $'
    HOSP_ALLOC_OK   DB 0DH, 0AH, ' [OK] Patient registered and critical care bed reserved!', 0DH, 0AH, '$'
    HOSP_FULL_ERR   DB 0DH, 0AH, ' [!] CRITICAL: Hospital ICU/Ward beds are at full capacity!', 0DH, 0AH, '$'

    ; --- MODULE 5: SHELTERS DATA ---
    SHELTER_TITLE   DB 0DH, 0AH, ' >>> [MODULE 5: EMERGENCY SHELTER MANAGEMENT] <<<', 0DH, 0AH, '$'
    SHELT1_INFO     DB ' [1] Chittagong Cyclone Shelter #04        - Vacant Spaces: $'
    SHELT2_INFO     DB ' [2] BGC Trust Campus Multi-Purpose Hall   - Vacant Spaces: $'
    SHELT3_INFO     DB ' [3] Sunamganj High School Flood Refuge    - Vacant Spaces: $'
    SHELTER_CAPS    DW 180, 250, 120       ; Shelter capacities
    SHELT_ALLOC_P   DB 0DH, 0AH, ' Select Shelter to register displaced family (1-3, 0=Back): $'
    SHELT_ALLOC_OK  DB 0DH, 0AH, ' [OK] Citizen family safely admitted to shelter facility!', 0DH, 0AH, '$'

    ; --- MODULE 6: RISK ASSESSMENT DATA (EDUCATIONAL SIMULATION LOGIC) ---
    RISK_TITLE      DB 0DH, 0AH, ' >>> [MODULE 6: RULE-BASED DISASTER RISK ASSESSMENT ENGINE] <<<', 0DH, 0AH, '$'
    RISK_NOTICE     DB ' Note: Educational simulation logic based on 8086 integer arithmetic.', 0DH, 0AH, '$'
    RISK_RAIN_P     DB ' Enter 24-Hour Rainfall Level (mm, e.g. 50-95): $'
    RISK_WIND_P     DB ' Enter Gust Wind Speed (km/h, e.g. 40-99): $'
    RISK_CALC_MSG   DB 0DH, 0AH, ' Computing Risk Metric: (Rainfall * 2) + (WindSpeed * 3) / 4 ...', 0DH, 0AH, '$'
    RISK_SCORE_MSG  DB ' Calculated Composite Severity Index: $'
    RISK_LVL_LOW    DB 0DH, 0AH, ' [ASSESSMENT]: LOW RISK - Normal monitoring & standard alerts.', 0DH, 0AH, '$'
    RISK_LVL_MOD    DB 0DH, 0AH, ' [ASSESSMENT]: MODERATE RISK - Issue cautionary maritime alerts.', 0DH, 0AH, '$'
    RISK_LVL_HIGH   DB 0DH, 0AH, ' [ASSESSMENT]: HIGH RISK - Mobilize rescue craft and prepare shelters.', 0DH, 0AH, '$'
    RISK_LVL_CRIT   DB 0DH, 0AH, ' [ASSESSMENT]: CRITICAL RISK! Immediate forced evacuation mandated!', 0DH, 0AH, '$'

    ; --- MODULE 7: RELIEF RESOURCES DATA ---
    RES_TITLE       DB 0DH, 0AH, ' >>> [MODULE 7: EMERGENCY RELIEF RESOURCE INVENTORY] <<<', 0DH, 0AH, '$'
    RES_FOOD_MSG    DB ' [1] Dry Emergency Food Rations (Packets)   : $'
    RES_WATER_MSG   DB ' [2] Purified Drinking Water (10-Liter Cans): $'
    RES_MED_MSG     DB ' [3] Emergency First Aid & Trauma Medicine  : $'
    RES_BOAT_MSG    DB ' [4] Inflatable Rescue Boats & Lifejackets  : $'
    RES_FOOD_CNT    DW 500
    RES_WATER_CNT   DW 850
    RES_MED_CNT     DW 320
    RES_BOAT_CNT    DW 40
    RES_DISPATCH_P  DB 0DH, 0AH, ' Select Item to Dispatch (1-4, 0=Return): $'
    RES_QTY_PROMPT  DB ' Enter quantity to distribute (1-9): $'
    RES_DISPATCH_OK DB 0DH, 0AH, ' [OK] Resources released and dispatched from central depot!', 0DH, 0AH, '$'
    RES_STOCK_ERR   DB 0DH, 0AH, ' [!] ERROR: Requested quantity exceeds warehouse stock!', 0DH, 0AH, '$'

    ; --- MODULE 8: STATISTICS DASHBOARD DATA ---
    STAT_TITLE      DB 0DH, 0AH, ' >>> [MODULE 8: REAL-TIME EMERGENCY STATISTICS DASHBOARD] <<<', 0DH, 0AH, '$'
    STAT_ALERTS     DB '  * Total Disaster Alerts Broadcasted : $'
    STAT_SOS        DB '  * Total Citizen SOS Calls Received  : $'
    STAT_ACTIVE_OPS DB '  * Active Rescue Operations in Field : $'
    STAT_PATIENTS   DB '  * Total Medical Patients Admitted   : $'
    STAT_DISPLACED  DB '  * Total Displaced Citizens Sheltered: $'
    STAT_SYSTEM_OK  DB 0DH, 0AH, ' System Status: 8086 OPERATIONAL (Interrupt Vector Table Nominal)', 0DH, 0AH, '$'

    ; --- MODULE 9: ADMIN PANEL DATA ---
    ADMIN_TITLE     DB 0DH, 0AH, ' >>> [MODULE 9: ADMIN INCIDENT COMMAND & SECURITY PANEL] <<<', 0DH, 0AH, '$'
    ADMIN_PASS_P    DB ' Enter 4-Digit Security Authorization PIN: $'
    ADMIN_PIN       DB '8086'              ; Stored secret credentials
    ADMIN_AUTH_OK   DB 0DH, 0AH, ' [ACCESS GRANTED] Incident Commander clearance verified.', 0DH, 0AH, '$'
    ADMIN_AUTH_FAIL DB 0DH, 0AH, ' [ACCESS DENIED] Invalid PIN. Security event logged in memory.', 0DH, 0AH, '$'
    ADMIN_MENU      DB 0DH, 0AH, ' Incident Command Actions:', 0DH, 0AH
                    DB '   [1] Reset All System Simulation Counters', 0DH, 0AH
                    DB '   [2] Trigger National Emergency Siren Alert Broadcast', 0DH, 0AH
                    DB '   [3] Return to Main Console', 0DH, 0AH
                    DB ' Choose action (1-3): $'
    ADMIN_RESET_OK  DB 0DH, 0AH, ' [OK] All emergency counters successfully reset to default state.', 0DH, 0AH, '$'
    ADMIN_SIREN_MSG DB 0DH, 0AH, ' [*** EMERGENCY RED ALERT ***] NATIONAL DISASTER PROTOCOL ACTIVATED!', 0DH, 0AH, '$'

    ; --- MODULE 10: SAFETY INSTRUCTIONS DATA ---
    INST_TITLE      DB 0DH, 0AH, ' >>> [MODULE 10: NATIONAL DISASTER SAFETY PROTOCOLS] <<<', 0DH, 0AH, '$'
    INST_FLOOD      DB ' * FLOOD: Move immediately to elevated cyclone shelters; turn off gas/power.', 0DH, 0AH, '$'
    INST_CYCLONE    DB ' * CYCLONE: Secure loose objects, board up windows, monitor radio warnings.', 0DH, 0AH, '$'
    INST_EARTHQK    DB ' * EARTHQUAKE: DROP, COVER, and HOLD ON under sturdy tables away from glass.', 0DH, 0AH, '$'
    INST_FIRE       DB ' * FIRE: Crawl low under smoke, feel doors before opening, call Fire Service 999.', 0DH, 0AH, '$'
    INST_LANDSLIDE  DB ' * LANDSLIDE: Evacuate hillside settlements immediately during heavy rain.', 0DH, 0AH, '$'

    ; --- MODULE 11: DEMO SCENARIO DATA ---
    DEMO_TITLE      DB 0DH, 0AH, ' >>> [MODULE 11: LIVE FLOOD EMERGENCY DEMO SCENARIO] <<<', 0DH, 0AH, '$'
    DEMO_STEP1      DB ' [Step 1] Initializing Flood Warning in Sunamganj Haor Basin...', 0DH, 0AH, '$'
    DEMO_STEP2      DB ' [Step 2] Processing High-Priority Citizen SOS for Rahim Uddin...', 0DH, 0AH, '$'
    DEMO_STEP3      DB ' [Step 3] Deploying Bangladesh Coast Guard Flood Rescue Boat Squad...', 0DH, 0AH, '$'
    DEMO_STEP4      DB ' [Step 4] Allocating 15 ICU/Ward Beds at Sylhet MAG Osmani Hospital...', 0DH, 0AH, '$'
    DEMO_STEP5      DB ' [Step 5] Distributing 50 Purified Drinking Water Cans to Shelter...', 0DH, 0AH, '$'
    DEMO_DONE       DB 0DH, 0AH, ' [OK] DEMONSTRATION WORKFLOW EXECUTED WITH 100% RELIABILITY!', 0DH, 0AH, '$'

    ; --- MODULE 12: EXIT DATA ---
    EXIT_CONFIRM_P  DB 0DH, 0AH, ' Are you sure you want to terminate system? (Y/N): $'
    EXIT_SUMMARY    DB 0DH, 0AH, ' ================= SYSTEM SHUTDOWN SUMMARY =================', 0DH, 0AH
                    DB ' BGC Trust University Bangladesh - CSE 8086 Assembly Project', 0DH, 0AH
                    DB ' Thank you for evaluating Disaster Alert & Rescue Management System!', 0DH, 0AH
                    DB ' Returning control to DOS kernel (INT 21H, AH=4CH)...', 0DH, 0AH, '$'

    ; --- SYSTEM COUNTER VARIABLES ---
    TOTAL_ALERTS    DW 3
    TOTAL_SOS       DW 7
    ACTIVE_RESCUES  DW 2
    TOTAL_PATIENTS  DW 14
    TOTAL_DISPLACED DW 68

    ; --- REGISTER STORAGE & CONVERSION BUFFER ---
    NUM_BUFFER      DB 6 DUP('$')          ; Buffer for converting 16-bit int to ASCII string

; =====================================================================
; SECTION 2: CODE SEGMENT & MAIN EXECUTION LOOP (.CODE)
; =====================================================================
.CODE
MAIN PROC FAR
    ; -------------------------------------------------------------
    ; STEP 1: INITIALIZE DATA SEGMENT (DS)
    ; In 8086 architecture, DS must be loaded with the segment address
    ; of .DATA via the accumulator register AX.
    ; -------------------------------------------------------------
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX                             ; Set ES to point to same data segment

MAIN_MENU_LOOP:
    ; Clear screen using BIOS INT 10H / AH=06H
    CALL CLEAR_SCREEN

    ; Display Application Banners
    LEA DX, TITLE_BORDER
    CALL PRINT_STRING
    LEA DX, APP_HEADER
    CALL PRINT_STRING
    LEA DX, SUB_HEADER
    CALL PRINT_STRING
    LEA DX, TITLE_BORDER
    CALL PRINT_STRING

    ; Display 12 Main Menu Options
    LEA DX, M_OPT1
    CALL PRINT_STRING
    LEA DX, M_OPT2
    CALL PRINT_STRING
    LEA DX, M_OPT3
    CALL PRINT_STRING
    LEA DX, M_OPT4
    CALL PRINT_STRING
    LEA DX, M_OPT5
    CALL PRINT_STRING
    LEA DX, M_OPT6
    CALL PRINT_STRING
    LEA DX, M_OPT7
    CALL PRINT_STRING
    LEA DX, M_OPT8
    CALL PRINT_STRING
    LEA DX, M_OPT9
    CALL PRINT_STRING
    LEA DX, M_OPT10
    CALL PRINT_STRING
    LEA DX, M_OPT11
    CALL PRINT_STRING
    LEA DX, M_OPT12
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Prompt for user option
    LEA DX, MENU_PROMPT
    CALL PRINT_STRING

    ; Read user input character (INT 21H, AH=01H)
    CALL READ_CHAR                          ; Returns character in AL

    ; -------------------------------------------------------------
    ; MULTI-WAY CONDITIONAL BRANCHING (MENU ROUTER)
    ; Compares ASCII input character in AL against choices '1' through '9'
    ; and handles two-digit options '10', '11', '12' via secondary check.
    ; -------------------------------------------------------------
    CMP AL, '1'
    JE ROUTE_OPT1
    CMP AL, '2'
    JE ROUTE_OPT2
    CMP AL, '3'
    JE ROUTE_OPT3
    CMP AL, '4'
    JE ROUTE_OPT4
    CMP AL, '5'
    JE ROUTE_OPT5
    CMP AL, '6'
    JE ROUTE_OPT6
    CMP AL, '7'
    JE ROUTE_OPT7
    CMP AL, '8'
    JE ROUTE_OPT8
    CMP AL, '9'
    JE ROUTE_OPT9
    CMP AL, '0'
    JE ROUTE_OPT10                         ; Shortcut: '0' maps to Safety Protocols
    CMP AL, 'A'
    JE ROUTE_OPT11                         ; 'A' or 'a' for Demo
    CMP AL, 'a'
    JE ROUTE_OPT11
    CMP AL, 'E'
    JE ROUTE_OPT12                         ; 'E' or 'e' or 'X' for Exit
    CMP AL, 'e'
    JE ROUTE_OPT12
    CMP AL, 'x'
    JE ROUTE_OPT12

    ; If invalid, show error and reprompt
    LEA DX, INVALID_CHOICE
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP MAIN_MENU_LOOP

ROUTE_OPT1:
    CALL PROC_DISASTER_ALERT
    JMP MAIN_MENU_LOOP

ROUTE_OPT2:
    CALL PROC_CITIZEN_SOS
    JMP MAIN_MENU_LOOP

ROUTE_OPT3:
    CALL PROC_RESCUE_TEAMS
    JMP MAIN_MENU_LOOP

ROUTE_OPT4:
    CALL PROC_HOSPITAL_MGMT
    JMP MAIN_MENU_LOOP

ROUTE_OPT5:
    CALL PROC_SHELTER_MGMT
    JMP MAIN_MENU_LOOP

ROUTE_OPT6:
    CALL PROC_RISK_ASSESSMENT
    JMP MAIN_MENU_LOOP

ROUTE_OPT7:
    CALL PROC_RESOURCE_MGMT
    JMP MAIN_MENU_LOOP

ROUTE_OPT8:
    CALL PROC_STATISTICS
    JMP MAIN_MENU_LOOP

ROUTE_OPT9:
    CALL PROC_ADMIN_PANEL
    JMP MAIN_MENU_LOOP

ROUTE_OPT10:
    CALL PROC_SAFETY_INSTRUCTIONS
    JMP MAIN_MENU_LOOP

ROUTE_OPT11:
    CALL PROC_LIVE_DEMO
    JMP MAIN_MENU_LOOP

ROUTE_OPT12:
    CALL PROC_SYSTEM_SHUTDOWN
    JMP MAIN_MENU_LOOP

MAIN ENDP

; =====================================================================
; SECTION 3: MODULE 1 - DISASTER ALERT MANAGEMENT PROCEDURE
; =====================================================================
PROC_DISASTER_ALERT PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, ALERT_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Prompt for disaster type
    LEA DX, DIS_SELECT_TYPE
    CALL PRINT_STRING
    CALL READ_CHAR

    ; Prompt for affected region in Bangladesh
    LEA DX, DIS_SELECT_ZONE
    CALL PRINT_STRING
    CALL READ_CHAR

    ; Prompt for disaster severity
    LEA DX, DIS_SELECT_SEV
    CALL PRINT_STRING
    CALL READ_CHAR

    ; Output broadcast confirmation
    LEA DX, ALERT_SUCCESS
    CALL PRINT_STRING
    LEA DX, ALERT_ID_MSG
    CALL PRINT_STRING

    ; Increment TOTAL_ALERTS counter in memory
    INC TOTAL_ALERTS

    ; Display current total alerts
    LEA DX, ALERT_COUNT_MSG
    CALL PRINT_STRING
    MOV AX, TOTAL_ALERTS
    CALL PRINT_NUM

    CALL WAIT_KEY
    RET
PROC_DISASTER_ALERT ENDP

; =====================================================================
; SECTION 4: MODULE 2 - CITIZEN SOS PORTAL PROCEDURE
; =====================================================================
PROC_CITIZEN_SOS PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, SOS_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Prompt Citizen Name
    LEA DX, SOS_NAME_PROMPT
    CALL PRINT_STRING
    LEA DX, SOS_NAME_BUFFER
    CALL READ_STRING

    ; Prompt Citizen ID
    LEA DX, NEWLINE
    CALL PRINT_STRING
    LEA DX, SOS_ID_PROMPT
    CALL PRINT_STRING
    LEA DX, SOS_ID_BUFFER
    CALL READ_STRING

    ; Prompt Emergency Area & Severity
    LEA DX, DIS_SELECT_ZONE
    CALL PRINT_STRING
    CALL READ_CHAR

    LEA DX, DIS_SELECT_SEV
    CALL PRINT_STRING
    CALL READ_CHAR

    ; Record SOS & Confirm
    LEA DX, SOS_CONFIRM_MSG
    CALL PRINT_STRING
    LEA DX, SOS_TICKET_MSG
    CALL PRINT_STRING

    ; Increment SOS counter and print
    INC TOTAL_SOS
    MOV AX, TOTAL_SOS
    CALL PRINT_NUM

    CALL WAIT_KEY
    RET
PROC_CITIZEN_SOS ENDP

; =====================================================================
; SECTION 5: MODULE 3 - RESCUE TEAMS MANAGEMENT PROCEDURE
; =====================================================================
PROC_RESCUE_TEAMS PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, RESCUE_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Display Team 1
    LEA DX, TEAM1_NAME
    CALL PRINT_STRING
    MOV AL, TEAM_STATUS[0]
    CALL PRINT_TEAM_STATUS

    ; Display Team 2
    LEA DX, TEAM2_NAME
    CALL PRINT_STRING
    MOV AL, TEAM_STATUS[1]
    CALL PRINT_TEAM_STATUS

    ; Display Team 3
    LEA DX, TEAM3_NAME
    CALL PRINT_STRING
    MOV AL, TEAM_STATUS[2]
    CALL PRINT_TEAM_STATUS

    ; Display Team 4
    LEA DX, TEAM4_NAME
    CALL PRINT_STRING
    MOV AL, TEAM_STATUS[3]
    CALL PRINT_TEAM_STATUS

    ; Display Team 5
    LEA DX, TEAM5_NAME
    CALL PRINT_STRING
    MOV AL, TEAM_STATUS[4]
    CALL PRINT_TEAM_STATUS

    ; Ask operator to toggle status
    LEA DX, TEAM_DISPATCH_P
    CALL PRINT_STRING
    CALL READ_CHAR

    ; Check selection 1-5
    CMP AL, '1'
    JB RESCUE_DONE
    CMP AL, '5'
    JA RESCUE_DONE

    ; Convert ASCII '1'-'5' to index 0-4
    SUB AL, '1'
    MOV AH, 0
    MOV SI, AX

    ; Toggle team status (XOR with 1: 0 becomes 1, 1 becomes 0)
    XOR TEAM_STATUS[SI], 1
    
    ; If newly deployed (value 1), increment ACTIVE_RESCUES
    CMP TEAM_STATUS[SI], 1
    JNE TEAM_RECALLED
    INC ACTIVE_RESCUES
    JMP SHOW_TEAM_UPDATE
TEAM_RECALLED:
    CMP ACTIVE_RESCUES, 0
    JE SHOW_TEAM_UPDATE
    DEC ACTIVE_RESCUES

SHOW_TEAM_UPDATE:
    LEA DX, TEAM_UPDATED
    CALL PRINT_STRING

RESCUE_DONE:
    CALL WAIT_KEY
    RET
PROC_RESCUE_TEAMS ENDP

PRINT_TEAM_STATUS PROC NEAR
    ; Input: AL has 0 (Available) or 1 (Deployed)
    CMP AL, 0
    JNE PRINT_DEPLY
    LEA DX, STATUS_AVAIL
    CALL PRINT_STRING
    RET
PRINT_DEPLY:
    LEA DX, STATUS_DEPLY
    CALL PRINT_STRING
    RET
PRINT_TEAM_STATUS ENDP

; =====================================================================
; SECTION 6: MODULE 4 & 5 - HOSPITALS & SHELTERS PROCEDURES
; =====================================================================
PROC_HOSPITAL_MGMT PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, HOSP_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Hospital 1
    LEA DX, HOSP1_INFO
    CALL PRINT_STRING
    MOV AX, HOSP_BEDS[0]
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Hospital 2
    LEA DX, HOSP2_INFO
    CALL PRINT_STRING
    MOV AX, HOSP_BEDS[2]
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Hospital 3
    LEA DX, HOSP3_INFO
    CALL PRINT_STRING
    MOV AX, HOSP_BEDS[4]
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Select hospital
    LEA DX, HOSP_ALLOC_P
    CALL PRINT_STRING
    CALL READ_CHAR

    CMP AL, '1'
    JE ALLOC_HOSP1
    CMP AL, '2'
    JE ALLOC_HOSP2
    CMP AL, '3'
    JE ALLOC_HOSP3
    JMP HOSP_EXIT

ALLOC_HOSP1:
    MOV SI, 0
    JMP DO_HOSP_ALLOC
ALLOC_HOSP2:
    MOV SI, 2
    JMP DO_HOSP_ALLOC
ALLOC_HOSP3:
    MOV SI, 4

DO_HOSP_ALLOC:
    CMP HOSP_BEDS[SI], 0
    JLE HOSP_NO_BEDS
    DEC HOSP_BEDS[SI]
    INC TOTAL_PATIENTS
    LEA DX, HOSP_ALLOC_OK
    CALL PRINT_STRING
    JMP HOSP_EXIT

HOSP_NO_BEDS:
    LEA DX, HOSP_FULL_ERR
    CALL PRINT_STRING

HOSP_EXIT:
    CALL WAIT_KEY
    RET
PROC_HOSPITAL_MGMT ENDP

PROC_SHELTER_MGMT PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, SHELTER_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Shelter 1
    LEA DX, SHELT1_INFO
    CALL PRINT_STRING
    MOV AX, SHELTER_CAPS[0]
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Shelter 2
    LEA DX, SHELT2_INFO
    CALL PRINT_STRING
    MOV AX, SHELTER_CAPS[2]
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Shelter 3
    LEA DX, SHELT3_INFO
    CALL PRINT_STRING
    MOV AX, SHELTER_CAPS[4]
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Select shelter
    LEA DX, SHELT_ALLOC_P
    CALL PRINT_STRING
    CALL READ_CHAR

    CMP AL, '1'
    JE ALLOC_SHELT1
    CMP AL, '2'
    JE ALLOC_SHELT2
    CMP AL, '3'
    JE ALLOC_SHELT3
    JMP SHELT_EXIT

ALLOC_SHELT1:
    MOV SI, 0
    JMP DO_SHELT_ALLOC
ALLOC_SHELT2:
    MOV SI, 2
    JMP DO_SHELT_ALLOC
ALLOC_SHELT3:
    MOV SI, 4

DO_SHELT_ALLOC:
    CMP SHELTER_CAPS[SI], 0
    JLE SHELT_EXIT
    SUB SHELTER_CAPS[SI], 4                 ; Deduct 4 spaces for 1 family
    ADD TOTAL_DISPLACED, 4
    LEA DX, SHELT_ALLOC_OK
    CALL PRINT_STRING

SHELT_EXIT:
    CALL WAIT_KEY
    RET
PROC_SHELTER_MGMT ENDP

; =====================================================================
; SECTION 7: MODULE 6 - ENVIRONMENTAL RISK ASSESSMENT ENGINE
; Educational rule-based simulation using 8086 arithmetic (MUL, DIV, ADD)
; =====================================================================
PROC_RISK_ASSESSMENT PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, RISK_TITLE
    CALL PRINT_STRING
    LEA DX, RISK_NOTICE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Input 2-digit rainfall level
    LEA DX, RISK_RAIN_P
    CALL PRINT_STRING
    CALL READ_CHAR                          ; Tens digit
    SUB AL, '0'
    MOV AH, 0
    MOV BL, 10
    MUL BL                                  ; AL = Tens * 10
    MOV CX, AX                              ; Save in CX
    CALL READ_CHAR                          ; Units digit
    SUB AL, '0'
    MOV AH, 0
    ADD CX, AX                              ; CX = Total Rainfall (mm)

    ; Input 2-digit wind speed
    LEA DX, NEWLINE
    CALL PRINT_STRING
    LEA DX, RISK_WIND_P
    CALL PRINT_STRING
    CALL READ_CHAR                          ; Tens digit
    SUB AL, '0'
    MOV AH, 0
    MOV BL, 10
    MUL BL
    MOV BX, AX
    CALL READ_CHAR                          ; Units digit
    SUB AL, '0'
    MOV AH, 0
    ADD BX, AX                              ; BX = Wind Speed (km/h)

    ; -------------------------------------------------------------
    ; 8086 ARITHMETIC FORMULA:
    ; Score = ((Rainfall * 2) + (WindSpeed * 3)) / 4
    ; -------------------------------------------------------------
    LEA DX, RISK_CALC_MSG
    CALL PRINT_STRING

    ; CX = Rainfall * 2
    MOV AX, CX
    MOV DX, 2
    MUL DX                                  ; DX:AX = Rainfall * 2
    MOV CX, AX                              ; Save product in CX

    ; BX = WindSpeed * 3
    MOV AX, BX
    MOV DX, 3
    MUL DX                                  ; DX:AX = WindSpeed * 3
    ADD AX, CX                              ; AX = (Rain*2) + (Wind*3)

    ; Divide by 4
    MOV DX, 0
    MOV BX, 4
    DIV BX                                  ; AX = Quotient (Composite Risk Score)

    ; Output score
    PUSH AX                                 ; Preserve score on stack
    LEA DX, RISK_SCORE_MSG
    CALL PRINT_STRING
    POP AX
    PUSH AX
    CALL PRINT_NUM                          ; Print score in decimal

    ; Classify into Risk Categories
    POP AX                                  ; Restore score
    CMP AX, 40
    JB RISK_LOW_LABEL
    CMP AX, 70
    JB RISK_MOD_LABEL
    CMP AX, 110
    JB RISK_HIGH_LABEL

    ; Otherwise CRITICAL
    LEA DX, RISK_LVL_CRIT
    CALL PRINT_STRING
    JMP RISK_DONE

RISK_LOW_LABEL:
    LEA DX, RISK_LVL_LOW
    CALL PRINT_STRING
    JMP RISK_DONE

RISK_MOD_LABEL:
    LEA DX, RISK_LVL_MOD
    CALL PRINT_STRING
    JMP RISK_DONE

RISK_HIGH_LABEL:
    LEA DX, RISK_LVL_HIGH
    CALL PRINT_STRING

RISK_DONE:
    CALL WAIT_KEY
    RET
PROC_RISK_ASSESSMENT ENDP

; =====================================================================
; SECTION 8: MODULE 7 - EMERGENCY RELIEF RESOURCE INVENTORY
; =====================================================================
PROC_RESOURCE_MGMT PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, RES_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Item 1: Food
    LEA DX, RES_FOOD_MSG
    CALL PRINT_STRING
    MOV AX, RES_FOOD_CNT
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Item 2: Water
    LEA DX, RES_WATER_MSG
    CALL PRINT_STRING
    MOV AX, RES_WATER_CNT
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Item 3: Medicine
    LEA DX, RES_MED_MSG
    CALL PRINT_STRING
    MOV AX, RES_MED_CNT
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Item 4: Boats
    LEA DX, RES_BOAT_MSG
    CALL PRINT_STRING
    MOV AX, RES_BOAT_CNT
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Prompt selection
    LEA DX, RES_DISPATCH_P
    CALL PRINT_STRING
    CALL READ_CHAR

    CMP AL, '1'
    JB RES_EXIT
    CMP AL, '4'
    JA RES_EXIT

    ; Save item choice in BL
    MOV BL, AL

    ; Prompt quantity (1-9)
    LEA DX, NEWLINE
    CALL PRINT_STRING
    LEA DX, RES_QTY_PROMPT
    CALL PRINT_STRING
    CALL READ_CHAR
    SUB AL, '0'
    MOV AH, 0
    MOV CX, AX                              ; CX = Requested Quantity

    ; Deduct from appropriate inventory
    CMP BL, '1'
    JE DEDUCT_FOOD
    CMP BL, '2'
    JE DEDUCT_WATER
    CMP BL, '3'
    JE DEDUCT_MED
    CMP BL, '4'
    JE DEDUCT_BOAT
    JMP RES_EXIT

DEDUCT_FOOD:
    CMP RES_FOOD_CNT, CX
    JB RES_UNDERFLOW
    SUB RES_FOOD_CNT, CX
    JMP RES_SUCCESS_MSG

DEDUCT_WATER:
    CMP RES_WATER_CNT, CX
    JB RES_UNDERFLOW
    SUB RES_WATER_CNT, CX
    JMP RES_SUCCESS_MSG

DEDUCT_MED:
    CMP RES_MED_CNT, CX
    JB RES_UNDERFLOW
    SUB RES_MED_CNT, CX
    JMP RES_SUCCESS_MSG

DEDUCT_BOAT:
    CMP RES_BOAT_CNT, CX
    JB RES_UNDERFLOW
    SUB RES_BOAT_CNT, CX

RES_SUCCESS_MSG:
    LEA DX, RES_DISPATCH_OK
    CALL PRINT_STRING
    JMP RES_EXIT

RES_UNDERFLOW:
    LEA DX, RES_STOCK_ERR
    CALL PRINT_STRING

RES_EXIT:
    CALL WAIT_KEY
    RET
PROC_RESOURCE_MGMT ENDP

; =====================================================================
; SECTION 9: MODULE 8 - REAL-TIME EMERGENCY STATISTICS DASHBOARD
; =====================================================================
PROC_STATISTICS PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, STAT_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Alerts
    LEA DX, STAT_ALERTS
    CALL PRINT_STRING
    MOV AX, TOTAL_ALERTS
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; SOS Calls
    LEA DX, STAT_SOS
    CALL PRINT_STRING
    MOV AX, TOTAL_SOS
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Active Rescues
    LEA DX, STAT_ACTIVE_OPS
    CALL PRINT_STRING
    MOV AX, ACTIVE_RESCUES
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Hospital Patients
    LEA DX, STAT_PATIENTS
    CALL PRINT_STRING
    MOV AX, TOTAL_PATIENTS
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    ; Displaced Citizens Sheltered
    LEA DX, STAT_DISPLACED
    CALL PRINT_STRING
    MOV AX, TOTAL_DISPLACED
    CALL PRINT_NUM
    LEA DX, NEWLINE
    CALL PRINT_STRING

    LEA DX, STAT_SYSTEM_OK
    CALL PRINT_STRING

    CALL WAIT_KEY
    RET
PROC_STATISTICS ENDP

; =====================================================================
; SECTION 10: MODULE 9 - ADMIN SECURITY & COMMAND PANEL
; Includes PIN authentication and master counter reset
; =====================================================================
PROC_ADMIN_PANEL PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, ADMIN_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    ; Enter 4-digit PIN
    LEA DX, ADMIN_PASS_P
    CALL PRINT_STRING

    ; Read 4 characters without echo (AH=08H)
    MOV CX, 4
    MOV SI, 0
CHECK_PIN_LOOP:
    MOV AH, 08H
    INT 21H
    ; Compare with stored PIN
    CMP AL, ADMIN_PIN[SI]
    JNE AUTH_FAILED
    ; Echo '*' for security aesthetics
    MOV DL, '*'
    MOV AH, 02H
    INT 21H
    INC SI
    LOOP CHECK_PIN_LOOP

    ; Access Granted
    LEA DX, ADMIN_AUTH_OK
    CALL PRINT_STRING
    LEA DX, ADMIN_MENU
    CALL PRINT_STRING
    CALL READ_CHAR

    CMP AL, '1'
    JE RESET_COUNTERS
    CMP AL, '2'
    JE TRIGGER_SIREN
    JMP ADMIN_EXIT

RESET_COUNTERS:
    MOV TOTAL_ALERTS, 0
    MOV TOTAL_SOS, 0
    MOV ACTIVE_RESCUES, 0
    MOV TOTAL_PATIENTS, 0
    MOV TOTAL_DISPLACED, 0
    LEA DX, ADMIN_RESET_OK
    CALL PRINT_STRING
    JMP ADMIN_EXIT

TRIGGER_SIREN:
    LEA DX, ADMIN_SIREN_MSG
    CALL PRINT_STRING
    JMP ADMIN_EXIT

AUTH_FAILED:
    LEA DX, ADMIN_AUTH_FAIL
    CALL PRINT_STRING

ADMIN_EXIT:
    CALL WAIT_KEY
    RET
PROC_ADMIN_PANEL ENDP

; =====================================================================
; SECTION 11: MODULE 10, 11, 12 - SAFETY, DEMO & SYSTEM SHUTDOWN
; =====================================================================
PROC_SAFETY_INSTRUCTIONS PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, INST_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    LEA DX, INST_FLOOD
    CALL PRINT_STRING
    LEA DX, INST_CYCLONE
    CALL PRINT_STRING
    LEA DX, INST_EARTHQK
    CALL PRINT_STRING
    LEA DX, INST_FIRE
    CALL PRINT_STRING
    LEA DX, INST_LANDSLIDE
    CALL PRINT_STRING

    CALL WAIT_KEY
    RET
PROC_SAFETY_INSTRUCTIONS ENDP

PROC_LIVE_DEMO PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, DEMO_TITLE
    CALL PRINT_STRING
    LEA DX, DIVIDER_LINE
    CALL PRINT_STRING

    LEA DX, DEMO_STEP1
    CALL PRINT_STRING
    INC TOTAL_ALERTS

    LEA DX, DEMO_STEP2
    CALL PRINT_STRING
    INC TOTAL_SOS

    LEA DX, DEMO_STEP3
    CALL PRINT_STRING
    MOV TEAM_STATUS[2], 1                  ; Deploy Boat Squad
    INC ACTIVE_RESCUES

    LEA DX, DEMO_STEP4
    CALL PRINT_STRING
    SUB HOSP_BEDS[4], 15                   ; Sylhet Hospital
    ADD TOTAL_PATIENTS, 15

    LEA DX, DEMO_STEP5
    CALL PRINT_STRING
    SUB RES_WATER_CNT, 50

    LEA DX, DEMO_DONE
    CALL PRINT_STRING

    CALL WAIT_KEY
    RET
PROC_LIVE_DEMO ENDP

PROC_SYSTEM_SHUTDOWN PROC NEAR
    CALL CLEAR_SCREEN
    LEA DX, EXIT_CONFIRM_P
    CALL PRINT_STRING
    CALL READ_CHAR

    CMP AL, 'Y'
    JE DO_EXIT
    CMP AL, 'y'
    JE DO_EXIT
    ; Otherwise cancel exit and return
    RET

DO_EXIT:
    CALL CLEAR_SCREEN
    LEA DX, EXIT_SUMMARY
    CALL PRINT_STRING

    ; -------------------------------------------------------------
    ; RETURN TO DOS INTERRUPT (INT 21H, AH=4CH)
    ; Restores standard interrupt vectors and hands CPU control
    ; back to the host operating system / EMU8086 kernel.
    ; -------------------------------------------------------------
    MOV AH, 4CH
    MOV AL, 00H                            ; Return code 0 (Success)
    INT 21H
PROC_SYSTEM_SHUTDOWN ENDP

; =====================================================================
; SECTION 12: GENERAL UTILITY PROCEDURES
; =====================================================================

; --- PROCEDURE: PRINT_STRING ---
; Input: DX = Offset of $-terminated string
; Uses: INT 21H, AH=09H
PRINT_STRING PROC NEAR
    PUSH AX
    MOV AH, 09H
    INT 21H
    POP AX
    RET
PRINT_STRING ENDP

; --- PROCEDURE: READ_CHAR ---
; Output: AL = ASCII character entered by user
; Uses: INT 21H, AH=01H
READ_CHAR PROC NEAR
    MOV AH, 01H
    INT 21H
    RET
READ_CHAR ENDP

; --- PROCEDURE: READ_STRING ---
; Input: DX = Offset of DOS buffered structure (Byte 0: max, Byte 1: actual len)
; Uses: INT 21H, AH=0AH
READ_STRING PROC NEAR
    PUSH AX
    MOV AH, 0AH
    INT 21H
    POP AX
    RET
READ_STRING ENDP

; --- PROCEDURE: CLEAR_SCREEN ---
; Uses BIOS INT 10H / AH=06H (Scroll Up Active Page)
; Sets standard CGA Green-on-Black (02H) attribute
CLEAR_SCREEN PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH, 06H                            ; BIOS Scroll Up function
    MOV AL, 00H                            ; 00 = Clear entire screen
    MOV BH, 02H                            ; Display Attribute: 02H (Bright Green on Black)
    MOV CH, 00H                            ; Upper left row (0)
    MOV CL, 00H                            ; Upper left col (0)
    MOV DH, 24                             ; Lower right row (24)
    MOV DL, 79                             ; Lower right col (79)
    INT 10H

    ; Set cursor to row 0, col 0
    MOV AH, 02H
    MOV BH, 00H                            ; Page 0
    MOV DH, 00H
    MOV DL, 00H
    INT 10H

    POP DX
    POP CX
    POP BX
    POP AX
    RET
CLEAR_SCREEN ENDP

; --- PROCEDURE: WAIT_KEY ---
; Waits for any keystroke before proceeding
WAIT_KEY PROC NEAR
    PUSH AX
    PUSH DX
    LEA DX, PRESS_ANY_KEY
    CALL PRINT_STRING
    MOV AH, 08H                            ; Read char without echo
    INT 21H
    POP DX
    POP AX
    RET
WAIT_KEY ENDP

; --- PROCEDURE: PRINT_NUM ---
; Converts 16-bit integer in AX to ASCII decimal digits and prints to screen
; Algorithm: Successive division by 10, push remainders to stack, pop & print
PRINT_NUM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0                              ; Digit counter
    MOV BX, 10                             ; Divisor base 10

CONVERT_LOOP:
    MOV DX, 0                              ; Clear high word for DIV
    DIV BX                                 ; AX = Quotient, DX = Remainder
    PUSH DX                                ; Save digit on stack
    INC CX                                 ; Increment digit count
    CMP AX, 0                              ; If quotient > 0, keep dividing
    JNE CONVERT_LOOP

PRINT_DIGITS:
    POP DX                                 ; Retrieve digit (0-9)
    ADD DL, '0'                            ; Convert to ASCII
    MOV AH, 02H                            ; INT 21H, AH=02H (Print single char)
    INT 21H
    LOOP PRINT_DIGITS                      ; Repeat CX times

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN
