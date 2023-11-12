# Modualr-Adder-Subtractor
Hardware Implementation of a Pipelined Modular Adder/Subtractor which is used for Elliptic Curve Cryptography Scalar Multiplication "ECSM" Operations 
 
### Modular addition/subtraction algorithm
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

### Block Diagarm 
![Mod_Add_Sub](https://github.com/MahmouodMagdi/Modualr-Adder-Subtractor/assets/72949261/8b7350de-5789-4a73-b1c8-81036ddc649c)


