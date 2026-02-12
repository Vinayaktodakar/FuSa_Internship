module mux_2_1(sel,a,b,out);
    input sel,a,b;
    output reg out;

    always_comb  begin
        if(sel) out=b;
        else out=a;
    end
endmodule


module tb_mux;
    reg sel,a,b;
    wire out;
    
    mux_2_1 uut(.sel(sel), .a(a), .b(b), .out(out));
    
    always #5 a= ~a;
    always #10 b= ~b;
    always #50 sel=~sel;
    initial begin
        a=0;    b=0; sel=0;
        $monitor("Time : %0t\t | A = %0b\t | B =%0b\t | output Y = %0b", $time, a,b,out);
        #100
        $finish;
    end
endmodule   
