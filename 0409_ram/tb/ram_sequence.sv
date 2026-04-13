`ifndef RAM_SEQUENCE_SV
`define RAM_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ram_seq_item.sv"

class ram_random_sequence extends uvm_sequence#(ram_seq_item);
    `uvm_object_utils(ram_random_sequence)
    int num_transaction = 0;
    
    function new(string name = "ram_sequence");
        super.new(name); 
    endfunction //new()

    virtual task body();
        repeat (num_transaction) begin
            ram_seq_item item = ram_seq_item::type_id::create("item");

            start_item(item);
            if(!item.randomize()) `uvm_fatal(get_type_name(), "Randomization Fail!");
            finish_item(item);
        end
    endtask //
endclass //component 

class ram_write_read_sequence extends uvm_sequence#(ram_seq_item);
    `uvm_object_utils(ram_write_read_sequence)
    int num_transaction = 0;
    
    function new(string name = "ram_sequence");
        super.new(name); 
    endfunction //new()

    virtual task body();

        repeat (num_transaction) begin
            ram_seq_item item = ram_seq_item::type_id::create("item");

            start_item(item); // wait driver signal
            if(!item.randomize() with {wr == 1; }) `uvm_fatal(get_type_name(), "Randomization Fail!");
            finish_item(item); // send item driver

            start_item(item); // wait driver signal
            item.wr = 0;
            finish_item(item); // send item driver
        end
    endtask //
endclass //component 


class ram_full_sweep_sequence extends uvm_sequence#(ram_seq_item);
    `uvm_object_utils(ram_full_sweep_sequence)
    
    function new(string name = "ram_sequence");
        super.new(name); 
    endfunction //new()

    virtual task body();

            ram_seq_item item = ram_seq_item::type_id::create("item");

            start_item(item); // wait driver signal
            for (int i = 0; i < 2 ** 8; i++) begin
            if(!item.randomize() with {
                wr == 1;
                addr == i; 
                }) 
                `uvm_fatal(get_type_name(), "Randomization Fail!");
            end
            finish_item(item); // send item driver

            start_item(item); // wait driver signal
            for (int i = 0; i < 2 ** 8; i++) begin
                item.wr = 0;
                item.addr = i;
            end
            finish_item(item); // send item driver
    endtask //
endclass //component 

`endif