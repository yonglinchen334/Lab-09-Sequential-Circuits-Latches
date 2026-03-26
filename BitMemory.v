module BitMemory(
    input [7:0] data,
    input store, 
    output [7:0] memory
    );
    
    wire [7:0] qOut;
    wire [7:0] notQOut;
    
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : bit_latch
            DLatch dLatchInst (
                .D(data[i]),
                .E(store),
                .Q(qOut[i]),
                .NotQ(notQOut[i])
            );
        end 
     endgenerate
    
     assign memory = qOut;
endmodule
