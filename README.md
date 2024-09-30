# Improved AES 128 Encryprtion Verification Environment 

## Key Improvements:

- **Clarity and Conciseness**: The design and verification processes are focused on essential details.
- **Technical Accuracy**: Ensures correct use of terminology and concepts.
- **Organization**: Logically structured into clear sections for ease of understanding.
- **Verification Depth**: Provides comprehensive verification coverage suggestions.

## AES Encryprtion:

**- AES (Advanced Encryption Standard)** is a widely used symmetric encryption algorithm. Here's a concise overview:

**Type:** Symmetric block cipher
**Key sizes:** 128 bits
**Block size:** 128 bits

**Process:** Operates on a 4×4 matrix of bytes, using substitutions and permutations
Rounds: 10, 12, or 14, depending on key size
**Used in:** Secure communications, file encryption, HTTPS, Wi-Fi security (WPA2), and more

AES replaced the older DES (Data Encryption Standard) and is considered secure for top-secret information by the NSA.
Would you like more details on how AES works, its applications, or its security properties?

## RTL Implementation:

- **Language**: Verilog

## Verification Environments:

- **Languages/Tools**: SystemVerilog using UVM (Universal Verification Methodology)
- **Verification Approach**: Constrained randomization.
- **Functional Coverage**: Implemented using a subscriber class to track coverage metrics.

## Input/Output Ports:

- **Inputs**:
  - in
  - Key
- **Outputs**:
  - out

## Test Sequences:
1. **Randomized Sequence**:
   - in and key operations with randomized transaction counts.
2. **Termination Criteria**:
   - End simulation after sequence completion or scoreboard verification.

## Additional Considerations:

### Functional Coverage (100% Target):
- Functional coverage tracking implemented via a subscriber class.
- Add coverage points for the operations (in , key).

### Performance Analysis:
- Evaluate memory access time and throughput.
- Use SystemVerilog assertions to track performance metrics.

### Code Coverage (80% Target).

### Corner Case Testing:
- Test boundary values (minimum/maximum in , key ).
