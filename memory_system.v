module memory_system(
    input [7:0] data, 
    input store,
    input [1:0] addr,
    output reg [7:0] memory 
    );
    
    wire [7:0] dataToByte[3:0];
    wire storeToByte[3:0];
    wire [7:0] byteOutput[3:0];
    
    // Instantiate 4 instances of BitMemory 
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : bitMem
            BitMemory bitMem (
                .data(dataToByte[i]),
                .store(storeToByte[i]),
                .memory(byteOutput[i])
            );
        end
     endgenerate 
     
     // Demultiplex data and store
     reg [7:0] dataDemuxOutReg[3:0];
     always @(*) begin 
        // Defualt: All outputs are zero
        dataDemuxOutReg[0] = 8'h00;
        dataDemuxOutReg[1] = 8'h00;
        dataDemuxOutReg[2] = 8'h00;
        dataDemuxOutReg[3] = 8'h00;
        
        case(addr)
            // Byte lane being selected 
            2'b00: dataDemuxOutReg[0] = data; 
            2'b01: dataDemuxOutReg[1] = data;
            2'b10: dataDemuxOutReg[2] = data;
            2'b11: dataDemuxOutReg[3] = data;
        endcase
     end
     
     assign dataToByte[0] = dataDemuxOutReg[0];
     assign dataToByte[1] = dataDemuxOutReg[1];
     assign dataToByte[2] = dataDemuxOutReg[2];
     assign dataToByte[3] = dataDemuxOutReg[3];
     
     reg storeDemuxOutReg[3:0];
     always @(*) begin 
        // Defualt: All outputs are zero 
        storeDemuxOutReg[0] = 1'b0;
        storeDemuxOutReg[1] = 1'b0;
        storeDemuxOutReg[2] = 1'b0;
        storeDemuxOutReg[3] = 1'b0;
        
        case(addr)
            2'b00: storeDemuxOutReg[0] = store;
            2'b01: storeDemuxOutReg[1] = store;
            2'b10: storeDemuxOutReg[2] = store;
            2'b11: storeDemuxOutReg[3] = store;
        endcase
     end
     
     assign storeToByte[0] = storeDemuxOutReg[0];
     assign storeToByte[1] = storeDemuxOutReg[1];
     assign storeToByte[2] = storeDemuxOutReg[2];
     assign storeToByte[3] = storeDemuxOutReg[3];
     
     // Multiplex the output of the memory 
     always @(*) begin 
        case(addr)
            2'b00: memory = byteOutput[0];
            2'b01: memory = byteOutput[1];
            2'b10: memory = byteOutput[2];
            2'b11: memory = byteOutput[3];
            default: memory = 8'b0;
        endcase
     end 
endmodule
