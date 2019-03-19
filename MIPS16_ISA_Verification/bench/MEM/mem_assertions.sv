    `include "mips_16_defs.v"

program mem_assertions(
    mem_if.memory           mif,
    input [15:0] ram [(2**`DATA_MEM_ADDR_WIDTH)-1:0],
    logic                   rst
);
    
    property mem_write;
        @(posedge mif.clk) disable iff (rst)
        mif.mem_write_en && !$isunknown(mif.mem_access_addr) && !$isunknown(mif.mem_write_data) |=> ram[$past(mif.mem_access_addr)] ==? $past(mif.mem_write_data);
    endproperty
    assert property (mem_write)
    else
    begin
        $error("ASSERTION MEM WRITE FAILED -- MEM ADDR = %h, WRITE DATA = %h, ACTUAL VALUE =%h", $past(mif.mem_access_addr), $past(mif.mem_write_data), ram[$past(mif.mem_access_addr)]);
    end
    mem_write_c: cover property (mem_write);

    property mem_read;
        @(posedge mif.clk) disable iff (rst)
        !$isunknown(mif.mem_access_addr) |-> mif.mem_read_data ==? ram[mif.mem_access_addr];
    endproperty
    assert property (mem_read);
    mem_read_c: cover property (mem_read);

endprogram