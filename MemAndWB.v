//combined memory and writeback stages
module MemAndWB(
 input wire clk,
 input wire [1:0] wb_ctlout,
 input wire branch, memread, memwrite,
 input wire zero,
 input wire [31:0] alu_result, rdata2out,
 input wire [4:0] five_bit_muxout,
 output wire MEM_PCSrc, //from AND gate
 output wire MEM_WB_regwrite, MEM_WB_memtoreg,
 output wire [31:0] read_data, mem_alu_result,
 output wire [4:0] mem_write_reg,
 output wire [31:0] write_data
    );


    MEMORY memory(
     .clk(clk),
     .wb_ctlout(wb_ctlout),
     .branch(branch),
     .memread(memread),
     .memwrite(memwrite),
     .zero(zero),
     .alu_result(alu_result),
     .rdata2out(rdata2out),
     .five_bit_muxout(five_bit_muxout),
     .MEM_PCSrc(MEM_PCSrc), //from AND gate
     .MEM_WB_regwrite(MEM_WB_regwrite),
     .MEM_WB_memtoreg(MEM_WB_memtoreg),
     .read_data(read_data),
     .mem_alu_result(mem_alu_result),
     .mem_write_reg(mem_write_reg)
    );
    
    
    WBMux wb_mux(
        .clk(clk),
        .ReadData(read_data),
        .MEM_ALU_Result(mem_alu_result),
        .MemToReg(MEM_WB_memtoreg),
        .WriteData(write_data)
    );
 
endmodule