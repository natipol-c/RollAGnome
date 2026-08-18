# 🧙‍♂️ Roll A Gnome - Dynamic Reactive System Architecture Specification
> **เอกสารข้อกำหนดสถาปัตยกรรมระบบไดนามิกอัจฉริยะ (Dynamic Reactive Engine)**
> จัดทำขึ้นสำหรับการปรับโครงสร้างความสัมพันธ์ ลำดับความสำคัญ และการจัดสรรทรัพยากรทุกระบบในสคริปต์ Roll A Gnome ให้ทำงานร่วมกันได้อย่างราบรื่น 100%

---

## 📑 สารบัญ (Table of Contents)
1. [บทนำและวิสัยทัศน์ของระบบ (Vision & Core Objectives)](#1-บทนำและวิสัยทัศน์ของระบบ)
2. [สารบบ 12 ลูประบบอัตโนมัติ (Complete Subsystem Inventory)](#2-สารบบ-12-ลูประบบอัตโนมัติ)
3. [การวิเคราะห์ปัญหาและจุดขัดแย้งเดิม (Root Cause Analysis & Conflict Matrix)](#3-การวิเคราะห์ปัญหาและจุดขัดแย้งเดิม)
4. [สถาปัตยกรรม Dynamic Reactive Engine (New System Architecture)](#4-สถาปัตยกรรม-dynamic-reactive-engine)
5. [โหมดกลยุทธ์ไดนามิก (Dynamic Strategy Modes)](#5-โหมดกลยุทธ์ไดนามิก)
6. [นโยบายการควบคุมที่ผู้เล่นปรับแต่งได้ (Customizable Policy Matrix)](#6-นโยบายการควบคุมที่ผู้เล่นปรับแต่งได้)
7. [โปรโตคอลการจัดการทรัพยากรและคิวงาน (Resource & Lock Management Protocol)](#7-โปรโตคอลการจัดการทรัพยากรและคิวงาน)
8. [แผนผังการเชื่อมต่อ UI และการบันทึกโปรไฟล์ (UI Integration & Persistence)](#8-แผนผังการเชื่อมต่อ-ui-และการบันทึกโปรไฟล์)
9. [แผนการดำเนินการและขั้นตอนการทดสอบ (Implementation & Verification Roadmap)](#9-แผนการดำเนินการและขั้นตอนการทดสอบ)

---

## 1. บทนำและวิสัยทัศน์ของระบบ
ระบบอัตโนมัติของ Roll A Gnome ประกอบด้วยระบบย่อยมากมาย ทั้งการสุ่มโนม (Roll), การจัดโนมลงแปลง (Best 30), การเก็บเกี่ยวผลผลิต (Harvest), การขายผลผลิต (Sell), การใช้ไอเทมดูแลฟาร์ม (Use Items), การซื้อของร้านค้า (Shop), การขยายแปลง (Expansion), การอัปเกรด (Upgrade) และการเกิดใหม่ (Rebirth)

### 🎯 เป้าหมายหลัก (Core Objectives)
1. **Zero-Starvation (ไม่มีระบบใดถูกทอดทิ้ง):** ทุกฟังก์ชันที่ผู้ใช้เปิดใช้งานจะต้องได้รับการจัดสรรเวลาและทรัพยากรเพื่อทำงานจริง 100%
2. **Context-Aware Reactivity (ปรับตัวตามสถานการณ์จริง):** ระบบต้องรู้ว่าเวลาไหนควรเน้นอะไร (เช่น กระเป๋าเต็ม ➔ เคลียร์ของ, เจอโนมเทพ ➔ ระดมทุนซื้อ, ผักยังไม่สุก ➔ แวะไปร้านค้า)
3. **User-Empowered Customization (ผู้ใช้เลือกสไตล์การเล่นได้เอง):** ไม่ฟิกซ์พฤติกรรมตายตัวในโค้ด แต่เปิดให้ผู้ใช้เลือกโหมดกลยุทธ์ (Strategies) และนโยบายย่อย (Policies) ผ่านหน้า UI ได้อย่างอิสระ
4. **100% Feature Preservation (คงฟังก์ชันเดิมครบทุกอย่าง):** ทุกระบบเดิม ทั้งการกรอง Mutation, Keep Targets, Normal Option, Auto Sell, Multi-language (TH/EN), Profile System ต้องทำงานได้สมบูรณ์เหมือนเดิม

---

## 2. สารบบ 12 ลูประบบอัตโนมัติ

| ID | ลูประบบ (Subsystem) | บรรทัดโค้ด | Remote / Action ที่ใช้ | ทรัพยากรที่ต้องการ (Locks) | ความถี่เดิม (Tick Rate) |
| :---: | :--- | :---: | :--- | :--- | :---: |
| **L01** | **Auto Roll** | L4928 | `invoke("Roll")` | `{"Roll"}` | 0.05s - 0.20s |
| **L02** | **Auto Buy Gnome** | L4908 / L4847 | `invoke("BuyFarmer")` | `{"Economy"}` | รันทันทีเมื่อสุ่มเจอ |
| **L03** | **Best 30 & Auto Place** | L3801 / L3376 | `invoke("PlaceGnome")` | `{"Equipment", "Gnome"}` | 0.55s |
| **L04** | **Auto Sell Gnome** | L3855 / L3657 | `invoke("SellThis")` | `{"Movement", "Equipment", "Gnome"}` | รันตามรอบ Best 30 |
| **L05** | **Auto Collect** | L4952 / L4964 | `invoke("CollectPlant")` | `{"Movement", "Farm"}` | 0.10s - 0.25s |
| **L06** | **Auto Sell Produce** | L5062 / L5071 | `invoke("SellThis")` | `{"Movement", "Farm", "Equipment"}` | 0.10s - 0.25s |
| **L07** | **Auto Use Items** | L4448 / L4287 | `Activate Tool` / คลิกวาง | `{"Movement", "Equipment", "Farm"}` | 0.75s - 1.25s |
| **L08** | **Auto Buy Shop** | L5343 / L5377 | `GetStock` / UI Remote | `{"Movement", "Economy"}` | 1.00s - 1.75s |
| **L09** | **Auto Buy Expansion** | L5773 / L5617 | `fire("ExpandPlot")` | `{"Economy"}` | 1.00s - 1.75s |
| **L10** | **Auto Upgrade** | L5760 / L5656 | `invoke("Upgrade")` | `{"Economy"}` | 1.25s |
| **L11** | **Auto Rebirth** | L5784 / L5796 | `invoke("Rebirth")` | `{"*"}` (Exclusive Lock) | 1.00s - 1.75s |
| **L12** | **Auto Give / Gifts** | L4603 / L4614 | `invoke("GiveItem")` | `{"Movement", "Equipment"}` | 1.50s |

---

## 3. การวิเคราะห์ปัญหาและจุดขัดแย้งเดิม (Conflict Matrix)

### 1. Movement Starvation (ระบบเก็บผักผูกขาดตัวละคร)
- `Auto Collect` มีรอบการทำงานที่เร็วมาก (0.1s) เมื่อผักในแปลงทยอยสุกต่อเนื่อง ตัวละครจะถูกวาร์ปไปเก็บผักแทบตลอดเวลา
- `Auto Buy Shop` ที่ต้องวาร์ปไปคุยกับ NPC ร้านค้า จะถูกปฏิเสธสิทธิ์ `"Movement"` ซ้ำๆ (`"busy"`) จนไม่สามารถซื้อของร้านค้าได้เลย

### 2. Tool & Equipment Collision (ไอเทมในมือตีกัน)
- เมื่อ `Auto Use Items` กำลังถือสปริงเกอร์ แต่ `Auto Sell Produce` หรือ `Auto Sell Gnome` สั่งถือผลผลิต/โนมไปขายพร้อมกัน
- การสั่ง `EquipTool` ซ้อนกันทำให้ตัวละครสลับถือไอเทมไปมา คำสั่งขายอาจล้มเหลว หรืออาจนำไอเทมผิดชิ้นไปขายทิ้ง

### 3. Economy Draining (ระบบอัปเกรดแอบผลาญเงินที่ต้องใช้ซื้อโนมเทพ)
- เมื่อสุ่มเจอโนมระดับหายาก (Godly / Impossible / Mutation พิเศษ) ระบบจะหยุดสุ่มเพื่อรอเงินซื้อ (`PauseRollUntilAffordable`)
- แต่ระบบ `Auto Upgrade` และ `Auto Expansion` ยังคงทำงานและดึงเงินที่เพิ่งเก็บได้ไปอัปเกรดแปลง ทำให้เงินสะสมไม่ถึงราคาโนมสักที

---

## 4. สถาปัตยกรรม Dynamic Reactive Engine

สถาปัตยกรรมใหม่จะใช้ **Central Task Coordinator (ตัวจัดคิวงานกลางอัจฉริยะ)** ร่วมกับ **Event-Driven Dispatcher (ระบบกระจายงานตามเหตุการณ์)**:

1. **ตรวจสอบ State & Inventory** ➔ เลือกลำดับ Priority ตาม Strategy Mode ที่เลือก
2. **แบ่งช่วงเวลาสิทธิ์การใช้ตัวละคร (Time-Sliced Movement Lease)** อย่างยุติธรรม
3. **กักเงินสำรองตามนโยบาย (Strict Money Guard)** ก่อนจ่ายให้ระบบอัปเกรด
4. **เคลียร์มือให้ว่าง (Clean Hands Policy)** ก่อนสลับถือไอเทมชิ้นถัดไป

---

## 5. โหมดกลยุทธ์ไดนามิก (Dynamic Strategy Modes)

ผู้ใช้สามารถเลือกโหมดการทำงานหลักได้ผ่านเมนู UI Dropdown:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ 1. 👑 MAX PROGRESSION (Rebirth & Growth Focus)                              │
│    • วัตถุประสงค์: เร่ง Rebirth ให้ไวที่สุด และปลดล็อคแปลงเต็มศักยภาพ       │
│    • ลำดับความสำคัญ: Rebirth ➔ Expansion & Upgrades ➔ Farm Cycle ➔ Roll     │
│    • พฤติกรรมเงิน: กักเงิน Rebirth เป็นอันดับ 1 เงินส่วนเกินนำไปขยายแปลง    │
├─────────────────────────────────────────────────────────────────────────────┤
│ 2. 🧙 GNOME HUNTER (Target & Rare Collector)                                │
│    • วัตถุประสงค์: ตามล่าโนมระดับสูง (Godly/Impossible) และ Mutation หายาก  │
│    • ลำดับความสำคัญ: Roll Preview ➔ Target Lock ➔ Harvest Rush ➔ Upgrades   │
│    • พฤติกรรมเงิน: เมื่อเจอโนมเป้าหมาย จะระงับการใช้เงินอื่น 100% ทันที      │
├─────────────────────────────────────────────────────────────────────────────┤
│ 3. 💰 MONEY MACHINE (Maximum Yield & Economy)                               │
│    • วัตถุประสงค์: ปั๊มเงินเข้ากระเป๋าให้ไวที่สุด ฟาร์มผักเต็มประสิทธิภาพ    │
│    • ลำดับความสำคัญ: Fast Harvest ➔ Batch Sell ➔ Use Buffs ➔ Best 30        │
│    • พฤติกรรมเงิน: เน้นลงทุนกับสปริงเกอร์ ปุ๋ย และการขยายแปลงเพิ่มผลผลิต    │
├─────────────────────────────────────────────────────────────────────────────┤
│ 4. ⚖️ BALANCED DYNAMIC (Smart Reactive - Default)                           │
│    • วัตถุประสงค์: สมดุลทุกมิติ ปรับตัวตามสถานการณ์จริงแบบอัตโนมัติ         │
│    • พฤติกรรม: สลับโหมดอัตโนมัติตามสภาพฟาร์ม (ผักว่างไปร้านค้า, ของเต็มไปขาย)│
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 6. นโยบายการควบคุมที่ผู้เล่นปรับแต่งได้ (Customizable Policy Matrix)

| นโยบาย (Policy Name) | ตัวเลือกที่ปรับได้ (Options) | รายละเอียดพฤติกรรม |
| :--- | :--- | :--- |
| **Movement Balance Policy** | • `Harvest First`<br>• `Shop First`<br>• `Smart Time-Share` (แนะนำ) | กำหนดว่าเมื่อมีผักสุกและร้านค้ามีของพร้อมกัน ใครจะได้สิทธิ์วาร์ปก่อน |
| **Money Guard Policy** | • `Strict Target Reserve`<br>• `Percentage Reserve`<br>• `Uncapped Spending` | ควบคุมการกักเงินสำรองเพื่อป้องกันไม่ให้ระบบอัปเกรดแอบใช้เงินจนหมด |
| **Inventory Overflow Policy**| • `Flush All (Produce & Junk Gnomes)`<br>• `Sell Produce Only`<br>• `Pause & Alert` | จัดการสิ่งที่ต้องทำเมื่อกระเป๋าเต็มอย่างเด็ดขาด |
| **Roll vs Rebirth Policy** | • `Target First`<br>• `Rebirth First`<br>• `Smart Hybrid` (ตามระดับโนม) | เลือกว่าจะให้ความสำคัญกับโนมเป้าหมายหรือการเกิดใหม่ก่อน |

---

## 7. โปรโตคอลการจัดการทรัพยากรและคิวงาน (Resource & Lock Protocol)

### 4 กฎเหล็กของโปรโตคอล (The 4 Golden Rules):
1. **Time-Sliced Movement Leasing:** การถือครองสิทธิ์การเคลื่อนที่จะมี Timeout ชัดเจน (เช่น ร้านค้าได้ 2.0s, เก็บผักได้ชุดละ 1.5s) ห้ามระบบใดผูกขาดถาวร
2. **Clean Hands Guarantee:** ทุกครั้งก่อนหยิบไอเทมใหม่ ต้องตรวจสอบว่าไอเทมเดิมถูกถอนการถือ (`UnequipTools`) เรียบร้อยแล้ว
3. **Atomic Economy Transactions:** การตรวจสอบเงินและการหักเงินต้องเกิดขึ้นพร้อมกับการล็อคกลุ่ม `"Economy"` ป้องกันการซื้อชนกัน
4. **Smart State Invalidation:** เมื่อ Rebirth หรือเปลี่ยนการตั้งค่า แคชทั้งหมด (ราคา, เมล็ดพันธุ์, รายการร้านค้า) จะถูกล้างและรีเฟรชใหม่ทันที

---

## 8. แผนผังการเชื่อมต่อ UI และการบันทึกโปรไฟล์

### การจัดวางในหน้าต่าง UI (UI Layout Structure)
1. **หน้า Settings / Strategy (เพิ่มส่วนใหม่):**
   - `Dropdown`: **Automation Strategy** (`Balanced Dynamic`, `Max Progression`, `Gnome Hunter`, `Money Machine`)
   - `Dropdown`: **Movement Priority** (`Smart Time-Share`, `Harvest First`, `Shop First`)
   - `Dropdown`: **Roll vs Rebirth** (`Target First`, `Rebirth First`, `Smart Hybrid`)
2. **ระบบภาษา (Localization):**
   - รองรับการสลับภาษาไทย (TH) และอังกฤษ (EN) ครบทุกป้ายคำอธิบาย
3. **ระบบโปรไฟล์ (Profile Persistence):**
   - บันทึกการตั้งค่าไดนามิกทั้งหมดลงในไฟล์ JSON ของแต่ละโปรไฟล์
   - รองรับการโหลดค่าเริ่มต้น (Autoload) เมื่อเปิดสคริปต์

---

## 9. แผนการดำเนินการและขั้นตอนการทดสอบ (Roadmap)

```
[ขั้นตอนที่ 1] สร้างตัวควบคุมคิวกลาง (Central Task Coordinator)
    │
[ขั้นตอนที่ 2] ปรับปรุงระบบ Money Guard และ Time-Slice Movement
    │
[ขั้นตอนที่ 3] เชื่อมต่อระบบตัวเลือก Strategy & Policies เข้ากับหน้า UI
    │
[ขั้นตอนที่ 4] ทดสอบการทำงานคู่ขนานและจำลองสถานการณ์ขัดแย้ง (Stress & Conflict Testing)
    │
[ขั้นตอนที่ 5] รันผ่าน Lua VM ตรวจสอบไวยากรณ์และความปลอดภัย 100%
    │
[ขั้นตอนที่ 6] บิลด์ไฟล์ Production (main.min.lua) และพร้อมใช้งาน
```

---

> 📌 **เอกสารฉบับนี้ถูกบันทึกไว้ในโปรเจกต์ที่:** `DYNAMIC_SYSTEM_ARCHITECTURE.md`
> เพื่อเป็นพิมพ์เขียวมาตรฐานในการพัฒนาและตรวจสอบระบบทั้งหมดให้สมบูรณ์แบบที่สุดครับ!
