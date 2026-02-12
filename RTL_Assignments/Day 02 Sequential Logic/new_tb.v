`timescale 1ns/1ps

module tb_register_8bit;

    reg clk;
    reg async_rst;
    reg load;
    reg [7:0] data_in;
    wire [7:0] data_out;

    register_8bit dut (
        .clk(clk),
        .async_rst(async_rst),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        load = 0;
        data_in = 8'hAA;

        // Step 1: Apply async reset
        async_rst = 0;
        #20;

        // Step 2: Prepare data
        load = 1;

        // Step 3: De-assert reset VERY CLOSE to clock edge
        #4.9 async_rst = 1;   // clock edge at 5ns → dangerous release

        // Step 4: Observe behavior
        #50;

        $finish;
    end

    initial begin
        $dumpfile("reset_hazard.vcd");
        $dumpvars(0, tb_register_8bit);
    end

endmodule

