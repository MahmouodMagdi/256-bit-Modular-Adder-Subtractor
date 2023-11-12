# Modualr-Adder-Subtractor
Hardware Implementation of a 256-bit Pipelined Modular Adder/Subtractor which is used for Elliptic Curve Cryptography Scalar Multiplication "ECSM" Operations 
 
### Modular addition/subtraction algorithm
- Steps from 2 :7 represent the modular addition operatio and the steps 10 : 15 represent the modular subtraction
- The SEL_OP selects which to perform: 0 --> for addition & 1 --> for subtraction

```
Input: a, b ∈ [0, p − 1], p and SEL_OP
Output: S = a ± b(modp)

1: if (SEL_OP == 0) then
2:   S1 = a + b
3:   S2 = S1 + (∼ p) + (∼ SEL_OP)
4:   if (Cout1|Cout2) then
5:     S = S2
6:   else
7:     S = S1
8:   end if
9: else
10:   S1 = a + (∼ b) + SEL_OP
11:   S2 = S1 + p
12:   if (Cout1) then
13:     S = S2
14:   else
15:     S = S1
16:   end if
17: end if
18: return S
```

### Hardware Architecture 

- The pipelined hardware architecture is shown in the figure below
- In the case of **modular addition S = a + b(modp)**:
    - The signal **SEL_OP** shall be set to **0**
    - The *first adder* executes *addition* between the two inputs a, b providing sum S1 and carry Cout1
    - The *second one* performs *subtraction* between S1 and p with outputs S2 and Cout2.
    - At the end, S1 and S2 are multiplexed according to line 4 of the Algorithm

- In the case of **modular subtraction S = a − b(modp)**
   - The signal **SEL_OP** shall be set to **1**
   - The *first adder* performs *subtraction* between the inputs a, b
   - The *second one adds* the result S1 to the modulo p.
   - Similarly to the first case, S1 and S2 are multiplexed according to to line 12 of the Algorithm

- Subtraction operation is done using the 2's complement 
     
![Pipelined_Mod_Add_Sub](https://github.com/MahmouodMagdi/Modualr-Adder-Subtractor/assets/72949261/ffdae362-3a2f-4b38-80f1-984c1336e2a8)



* This design is pipelined for better performance
* It requires **4 cycles** to calculate the result with frequency up to **110 MHz** 
  
