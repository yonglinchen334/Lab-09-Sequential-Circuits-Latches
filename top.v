module top(
    input [15:0] sw,
    input btnC,
    output [15:0] led
    );
    
    wire [7:0] part2_mem_out;
    
    DLatch part1 (
        .D(sw[0]),
        .Q(led[0]),
        .NotQ(led[1]),
        .E(btnC)
    );
    
    memory_system part2 (
        .data(sw[15:8]),
        .addr(sw[7:6]),
        .store(btnC),
        .memory(part2_mem_out) 
    );
    
    assign led[15:8] = part2_mem_out;
    
    assign led[5:2] = 4'b0000;
endmodule
