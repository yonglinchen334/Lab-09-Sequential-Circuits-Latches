module DLatch(
    input D, E,
    output reg Q,
    output NotQ
    );
    
    // Changes when D or E changes 
    always @(D, E) begin 
        // Q follows D only when E is high (enabled)
        // When E is low, Q hold its current state 
        if (E) 
            Q <= D;
    end 
    
    assign NotQ = ~Q; 
endmodule
