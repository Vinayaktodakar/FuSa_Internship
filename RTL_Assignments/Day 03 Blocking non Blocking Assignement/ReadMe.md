# RTL Training — Assignment 3  
## Blocking vs Non-Blocking — Answers

---

## 1. Counter using blocking assignments (incorrect sequential style)

### Answer

```systemverilog
module counter_blocking (
    input  logic clk,
    output logic [3:0] count
);

always @(posedge clk) begin
    count = count + 1; // blocking assignment (bad practice for flops)
end

endmodule
```

Blocking assignments update immediately, which can cause simulation ordering issues in sequential logic.

---

## 2. Counter using non-blocking assignments (correct style)

### Answer

```systemverilog
module counter_nonblocking (
    input  logic clk,
    output logic [3:0] count
);

always_ff @(posedge clk) begin
    count <= count + 1;
end

endmodule
```

Non-blocking assignments model flip-flop behavior correctly and avoid race conditions.

---

## 3. Simulation comparison — waveform behavior

### Answer

- Blocking version updates immediately within the time step.
- Non-blocking version updates at the end of the clock cycle.

Observed differences:

| Aspect | Blocking | Non-Blocking |
|--------|----------|-------------|
| Update timing | Immediate | Scheduled |
| Sequential accuracy | Poor | Accurate |
| Race risk | High | Low |

---

## 4. Race condition explanation

### Answer

A race condition occurs when multiple signals update in an unpredictable order during simulation, causing inconsistent results. Blocking assignments in clocked logic can trigger such behavior.

---

## 5. Why blocking assignments are unsafe for flip-flops

### Answer

Blocking assignments execute sequentially within the same clock event, allowing later statements to see updated values. Real hardware flip-flops update simultaneously, so blocking assignments can misrepresent hardware behavior.

---

## 6. Can non-blocking assignments be used in combinational logic?

### Answer

Technically yes, but **not recommended**. Combinational logic expects immediate evaluation. Using non-blocking assignments may obscure intent and complicate simulation behavior.

Best practice:

- Combinational → blocking (`=`)
- Sequential → non-blocking (`<=`)

---

## 7. Mixing blocking and non-blocking assignments

### Answer

Mixing assignment types inside the same always block can cause:

- Simulation mismatches
- Debug difficulty
- Race hazards

Consistent assignment style prevents ambiguity.

---

## 8. Realistic race condition example

### Answer

```systemverilog
always @(posedge clk) begin
    a = b;
    b = a;
end
```

Depending on execution order, values may swap incorrectly or collapse to the same value — unlike real hardware.

This demonstrates how race conditions can produce unsafe or incorrect logic behavior.

---

## Summary

- Blocking assignments are unsafe for sequential logic.
- Non-blocking assignments model hardware timing correctly.
- Mixing styles introduces race risks.
- Follow strict RTL coding discipline.

---

**End of Assignment**
