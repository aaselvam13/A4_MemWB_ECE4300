//memoryTB.v

module memoryTB();
    reg clk;
    reg [31:0] ALUResult, WriteData;
    reg [4:0] WriteReg;
    reg [1:0] WBControl;
    reg MemWrite, MemRead, Branch, Zero;
    wire [31:0] ReadData, ALUResult_out;
    wire [4:0] WriteReg_out;
    wire [1:0] WBControl_out;
    wire PCSrc;

    MEMORY uut (
        .clk(clk),
        .alu_result(ALUResult),
        .rdata2out(WriteData),
        .five_bit_muxout(WriteReg),
        .wb_ctlout(WBControl),
        .memwrite(MemWrite),
        .memread(MemRead),
        .branch(Branch),
        .zero(Zero),
        .read_data(ReadData),
        .mem_alu_result(ALUResult_out),
        .mem_write_reg(WriteReg_out),
        .MEM_WB_regwrite(WriteReg_out),
        .MEM_WB_memtoreg(WBControl_out[0]),
        .MEM_PCSrc(PCSrc)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
     // Mem Read
    ALUResult = 32'h00000004;
    WriteData = 32'h12345678;
    WriteReg = 5'h02;
    WBControl = 2'b01;
    MemWrite = 0;
    MemRead = 1;
    Branch = 0;
    Zero = 0;

    #10; 

    // Mem Write
    MemWrite = 1;
    MemRead = 0;
    #10; // Allow write to occur
    MemWrite = 0;
    MemRead = 1;
    #10; // Verify write by reading back

    // Branch
    Branch = 1;
    Zero = 1;
    #10; // Check PCSrc

    $finish;
end
endmodule