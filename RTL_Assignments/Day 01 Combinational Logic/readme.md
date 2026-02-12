# RTL Coding Assignment — Answers

## 1. Write a 2:1 MUX using `always_comb`

### Answer

```systemverilog
module mux2to1 (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);

always_comb begin
    if (sel)
        y = b;
    else
        y = a;
end

endmodule
```

This implementation uses `always_comb`, ensuring proper combinational behavior with no unintended storage.

---

## 2. Modify the code to intentionally infer a latch

### Answer

```systemverilog
always_comb begin
    if (sel)
        y = b;
end
```

Here, `y` is not assigned when `sel == 0`, so synthesis infers a latch to hold the previous value.

---

## 3. Explain why the latch was inferred

### Answer

A latch is inferred because the output signal `y` is not assigned in all execution paths. When `sel` is false, `y` retains its previous value, requiring memory storage — which synthesis implements as a latch.

---

## 4. Rewrite the code to remove the latch

### Answer

```systemverilog
always_comb begin
    if (sel)
        y = b;
    else
        y = a;
end
```

All conditions assign `y`, preventing latch inference.

---

## 5. Difference between `always @(*)` and `always_comb`

### Answer

| Feature | `always @(*)` | `always_comb` |
|--------|--------------|---------------|
| Sensitivity handling | Automatic | Automatic + stricter checks |
| Latch detection | Tool dependent | Enforced |
| Simulation safety | Moderate | High |
| SystemVerilog support | No | Yes |

`always_comb` provides stronger guarantees for combinational logic correctness.

---

## 6. Why are latches unsafe in FuSa designs?

### Answer

Latches introduce:

- Non-deterministic timing
- Sensitivity to glitches
- Hold-time violations
- Verification complexity

These behaviors can compromise predictability, which is critical in Functional Safety (FuSa) systems.

---

## 7. Can latches ever be acceptable?

### Answer

Yes — but only in controlled situations:

- Low-power clock gating designs
- Asynchronous interfaces
- Specialized timing architectures

They require strict verification and documentation.

---

## 8. How do latches affect timing analysis?

### Answer

Latches complicate timing analysis because:

- They allow time borrowing
- Timing becomes phase-dependent
- Static timing tools must handle transparency windows

This reduces predictability and increases verification effort.

---

## Summary

- Complete assignments prevent latch inference.
- `always_comb` is safer than `always @(*)`.
- Latches introduce timing uncertainty.
- Avoid latches unless explicitly required.

---

**End of Assignment**
