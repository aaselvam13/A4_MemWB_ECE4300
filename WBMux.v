
module WBMux(
        input wire clk,
        input wire [31:0] ReadData,
        input wire [31:0] MEM_ALU_Result,
        input wire MemToReg,
        output reg [31:0] WriteData
    );
    always @(posedge clk) begin
    WriteData <= MemToReg ? ReadData : MEM_ALU_Result;
    end 
    //writedata = readdata if memtoreg = 1, else writedata = memaluresult
endmodule
