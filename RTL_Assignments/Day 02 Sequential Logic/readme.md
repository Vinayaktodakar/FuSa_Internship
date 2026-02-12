# RTL Training — Assignment 2  
## Sequential Logic & Reset — Answers

---

## 1. Design an 8-bit register with synchronous reset (reset dominates)

### Answer

```systemverilog
module reg_sync_reset (
    input  logic clk,
    input  logic rst,
    input  logic [7:0] d,
    output logic [7:0] q
);

always_ff @(posedge clk) begin
    if (rst)
        q <= 8'b0;
    else
        q <= d;
end

endmodule
```

Reset is checked first, giving it priority over data.

---

## 2. Modify to asynchronous active-low reset

### Answer

```systemverilog
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 8'b0;
    else
        q <= d;
end
```

Proper sensitivity list ensures glitch-free reset behavior.

---

## 3. Simulation comparison — synchronous vs asynchronous reset

### Answer

- **Synchronous reset** → takes effect only on clock edge  
- **Asynchronous reset** → immediate response  

Waveform impact:

| Reset Type | Assertion | De-assertion | Timing |
|------------|-----------|--------------|--------|
| Sync | Clock dependent | Clean | Predictable |
| Async | Immediate | Risk of metastability | Timing sensitive |

---

## 4. Unsafe async reset de-assertion example

### Answer

```systemverilog
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 0;
    else
        q <= d; // may violate setup/hold during release
end
```

If reset releases near clock edge → metastability risk.

---

## 5. Safe reset de-assertion (synchronizer)

### Answer

```systemverilog
logic rst_sync1, rst_sync2;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rst_sync1 <= 0;
        rst_sync2 <= 0;
    end else begin
        rst_sync1 <= 1;
        rst_sync2 <= rst_sync1;
    end
end
```

Two-stage synchronizer ensures deterministic release.

---

## 6. Reset dominance explanation

### Answer

Reset dominance means reset must override data updates.  
Incorrect priority:

```systemverilog
if (enable)
    q <= d;
else if (rst)
    q <= 0;
```

Here reset may be ignored → functional failure.

---

## 7. Missed reset scenario

### Answer

If reset is missed for one cycle:

- Registers power up unknown
- FSM enters illegal state
- System behavior becomes unpredictable

Safe startup requires guaranteed reset capture.

---

## 8. DFT perspective — reset controllability

### Answer

During scan testing:

- Reset must be controllable
- Must not block scan chain shifting
- Observable reset states ensure coverage

Improper reset reduces fault detection.

---

## 9. Improper reset impact on scan

### Answer

Bad reset design can cause:

- Scan chain lockup
- State corruption
- Coverage loss
- ATPG pattern rejection

Reset design must be scan-aware.

---

## 10. FuSa comparison — sync vs async reset

### Answer

| Aspect | Sync Reset | Async Reset |
|--------|------------|-------------|
| Predictability | High | Medium |
| Timing safety | Strong | Risky |
| DFT friendliness | Good | Complex |
| FuSa suitability | Preferred | Controlled use |

Synchronous resets are generally favored in safety-critical designs.

---

## Summary

- Reset priority matters.
- Async resets require synchronization.
- Deterministic startup is critical.
- Safety + DFT favor synchronous reset designs.

---

**End of Assignment**
