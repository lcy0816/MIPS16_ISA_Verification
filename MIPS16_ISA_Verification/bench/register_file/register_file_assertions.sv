program register_file_assertions(
    input               clk,
    input               rst,    
    input               reg_write_en,
    input       [2:0]   reg_write_dest,
    input       [15:0]  reg_write_data, 
    input       [2:0]   reg_read_addr_1,
    input       [15:0]  reg_read_data_1,
    input       [2:0]   reg_read_addr_2,
    input       [15:0]  reg_read_data_2,
    input       [15:0]  reg_array [7:0]
);

    property rf_addr1_read;
        @(posedge clk) disable iff( rst )
        (reg_read_addr_1 !=0) |-> (reg_read_data_1 === reg_array[reg_read_addr_1]);
    endproperty
    assert property(rf_addr1_read);
    rf_addr1_read_c: cover property (rf_addr1_read);

    property rf_addr2_read;
        @(posedge clk) disable iff( rst )
        (reg_read_addr_2 !=0) |-> (reg_read_data_2 === reg_array[reg_read_addr_2]);
    endproperty
    assert property(rf_addr2_read);
    rf_addr2_read_c: cover property (rf_addr2_read);

    property rf_addr1_0_read;
        @(posedge clk) disable iff( rst )
        (reg_read_addr_1 ==0) |-> (reg_read_data_1 == 0);
    endproperty
    assert property(rf_addr1_0_read);
    rf_addr1_0_read_c: cover property (rf_addr1_0_read);

    property rf_addr2_0_read;
        @(posedge clk) disable iff( rst )
        (reg_read_addr_2 ==0) |-> (reg_read_data_2 == 0);
    endproperty
    assert property(rf_addr2_0_read);
    rf_addr2_0_read_c: cover property (rf_addr2_0_read);

    logic[2:0] dest_d;
    logic[15:0]value_d;

    task store( logic[2:0] d, logic [15:0] v);
        dest_d = d;
        value_d = v;
    endtask

    property rf_write;
        logic[2:0] dest;
        logic[15:0]value;
        @(posedge clk) disable iff( rst )    
            (reg_write_en, dest=reg_write_dest, value=reg_write_data, store(dest, value))  |=> (reg_array[dest] === value);
    endproperty            
    assert property (rf_write)else
    begin
        $display("ASSERTION FAILED - DEST %d VALUE %d", dest_d, value_d );
    end
    rf_write_c: cover property (rf_write);



endprogram