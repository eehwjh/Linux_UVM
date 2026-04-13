`include "uvm_macros.svh"
import uvm_pkg::*;


interface ram_if(
    input logic clk
);
    logic   we;
    logic [7:0] addr;
    logic [15:0] wdata;
    logic [15:0] rdata;

    clocking drv_cb @(posedge clk);
        default input #1step output #0;
        output we;
        output addr;
        output wdata;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
            input we;
            input addr;
            input wdata;
            input rdata;
    endclocking
        
endinterface // ram_interface

class ram_seq_item extends uvm_sequence_item;
    rand bit we;
    rand bit [7:0] addr;
    rand bit [15:0] wdata;
    logic [15:0] rdata;

    `uvm_object_utils_begin(ram_seq_item)
        `uvm_field_int(we, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(wdata, UVM_ALL_ON)
        `uvm_field_int(rdata, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "ram_seq_item");
        super.new(name);
    endfunction // new()

    function string convert2string();
        return $sformatf("we=%0b addr=%0h wdata=%0h rdata=%0h",we, addr, wdata, rdata);
    endfunction
endclass // ram_seq_item

class ram_write_seq extends uvm_sequence#(ram_seq_item);
    `uvm_object_utils(ram_write_seq)
    bit [7:0] target_addr; // Master가 정해주는 주소

    function new(string name = "ram_write_seq");
        super.new(name);
    endfunction // new()

    virtual task body();
    ram_seq_item item;
        item = ram_seq_item::type_id::create($sformatf("item"));

        start_item(item);
        if (!item.randomize() with {
            we == 1;
            addr == target_addr; 
        })
        `uvm_fatal(get_type_name(), "Randomization failed")
        finish_item(item);
    endtask // body
endclass // ram_write_seq

class ram_read_seq extends uvm_sequence#(ram_seq_item);
    `uvm_object_utils(ram_read_seq)
    bit [7:0] target_addr;

    function new(string name = "ram_read_seq");
        super.new(name);
    endfunction 

    virtual task body();
    ram_seq_item item;
        item = ram_seq_item::type_id::create($sformatf("item"));

        start_item(item);
        if (!item.randomize() with {
            we == 0;
            addr == target_addr;
        })
        `uvm_fatal(get_type_name(), "Randomization failed")
        finish_item(item);
    endtask // body
endclass // ram_read_seq

class ram_master_seq extends uvm_sequence#(ram_seq_item);
    `uvm_object_utils(ram_master_seq)


    function new(string name = "ram_master_seq");
        super.new(name);
    endfunction // new()

    virtual task body();
        ram_write_seq w_seq;
        ram_read_seq r_seq;
        bit [7:0] temp_addr; 
        
        w_seq = ram_write_seq::type_id::create("write_seq");
       r_seq = ram_read_seq::type_id::create("read_seq");

        for (int i=0; i<6; i++) begin
            temp_addr = $urandom_range(0, 255);
            `uvm_info(get_type_name(), $sformatf("--- Iteration %0d: Addr 0x%0h ---", i, temp_addr), UVM_MEDIUM)

        `uvm_info(get_type_name(), "===== Phase 1: Write =====", UVM_MEDIUM) 
            w_seq.target_addr = temp_addr;
            w_seq.start(m_sequencer);

        `uvm_info(get_type_name(), "===== Phase 2: Read =====", UVM_MEDIUM)
            r_seq.target_addr = temp_addr;
            r_seq.start(m_sequencer);
        end


       `uvm_info(get_type_name(), "===== Master Sequence done =====", UVM_MEDIUM)
    endtask // body
endclass // ram_master_seq

class ram_driver extends uvm_driver #(ram_seq_item);
    `uvm_component_utils(ram_driver)
    virtual ram_if r_if;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction // new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    if(!uvm_config_db#(virtual ram_if)::get(this,"","r_if", r_if))
        `uvm_fatal(get_type_name(), "r_if를 찾을 수 없습니다!")
    `uvm_info(get_type_name(), "driver build_phase 실행완료", UVM_HIGH);
    endfunction

    virtual task driver_item(ram_seq_item item);
        r_if.drv_cb.we <= item.we;
        r_if.drv_cb.addr <= item.addr;
        r_if.drv_cb.wdata <= item.wdata;
        
        @(r_if.drv_cb);
        `uvm_info(get_type_name(), item.convert2string(), UVM_MEDIUM);
    endtask

    virtual task run_phase(uvm_phase phase);
        ram_seq_item item;
        forever begin
            seq_item_port.get_next_item(item);
            driver_item(item);
            seq_item_port.item_done();
        end
    endtask

endclass // 

class ram_monitor extends uvm_monitor;
    `uvm_component_utils(ram_monitor)
    virtual ram_if r_if;
    uvm_analysis_port #(ram_seq_item) ap;    

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction // new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ram_if)::get(this,"","r_if", r_if))
            `uvm_fatal(get_type_name(), "r_if를 찾을 수 없습니다!")
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            ram_seq_item item = ram_seq_item::type_id::create("item");
            @(r_if.mon_cb);
            item.we = r_if.mon_cb.we;
            item.addr = r_if.mon_cb.addr;
            item.wdata = r_if.mon_cb.wdata;
            item.rdata = r_if.mon_cb.rdata;
            ap.write(item);
            `uvm_info(get_type_name(), item.convert2string(), UVM_MEDIUM);
        end
        //
    endtask

endclass //

//class ram_coverage extends uvm_subscriber #(ram_seq_item);
//    `uvm_component_utils(ram_coverage)
//
//    ram_seq_item item;
//
//    
//endclass // 

class ram_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(ram_scoreboard)
    // analysis implementation 선언, write함수를 구현하는 부분
    uvm_analysis_imp #(ram_seq_item, ram_scoreboard) ap_imp;

    logic [15:0] scb_mem [0:255];
    int error_count;
    int match_count;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap_imp = new("ap_imp", this);
        error_count = 0;
        match_count = 0;
    endfunction // new()


    virtual function void write(ram_seq_item item);
        `uvm_info(get_type_name(), $sformatf("Received: %s", item.convert2string()), UVM_MEDIUM);

    if (item.we) begin
        scb_mem[item.addr] = item.wdata;
        `uvm_info("SCB_WRITE", $sformatf("Memory Updated: Addr=%0h, Data=%0h", item.addr, item.wdata), UVM_LOW)
    end else begin
        if (scb_mem[item.addr] !== item.rdata) begin
            `uvm_error(get_type_name(), $sformatf("MISMATCH! scb_mem[%0h]=%0h, actual=%0h (we=%0b, addr=%0h)",
                                                    item.addr, scb_mem[item.addr], item.rdata, item.we, item.addr))
            error_count++;
        end else begin
            `uvm_info(get_type_name(), $sformatf("MATCH!: scb_mem[%0h]=%0h, rdata=%0h (we=%0b, addr=%0h)", 
                                                    item.addr, scb_mem[item.addr], item.rdata, item.we, item.addr), UVM_LOW)
            
            match_count++;
        end  
    end    

    endfunction

    virtual function void report_phase (uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), "===== Scoreboard Summary =====", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("  Total transactions: %0d", match_count + error_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("  Matches: %0d", match_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("  Error: %0d", error_count), UVM_LOW)

        if (error_count > 0) begin
            `uvm_error(get_type_name(), $sformatf("TEST FAILED: %0d mismatches detected!", error_count))
        end else begin
            `uvm_info(get_type_name(), $sformatf("TEST PASSED: %0d all matches detected!", match_count), UVM_LOW)
        end
    endfunction
endclass // ram_scoreboard

class ram_agent extends uvm_agent;
    `uvm_component_utils(ram_agent)

    uvm_sequencer#(ram_seq_item) sqr;    
    ram_driver drv;
    ram_monitor mon;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction // new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sqr = uvm_sequencer#(ram_seq_item)::type_id::create("sqr", this);
        `uvm_info(get_type_name(), "sqr 생성", UVM_DEBUG);
        drv = ram_driver::type_id::create("drv", this);
        `uvm_info(get_type_name(), "drv 생성", UVM_DEBUG);
        mon = ram_monitor::type_id::create("mon", this);
        `uvm_info(get_type_name(), "mon 생성", UVM_DEBUG);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction

endclass //

class ram_environment extends uvm_env;
    `uvm_component_utils(ram_environment)
    
    ram_agent agt;
    ram_scoreboard scb;
    

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction // new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = ram_agent::type_id::create("agt", this);
        scb = ram_scoreboard::type_id::create("scb", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agt.mon.ap.connect(scb.ap_imp);
    endfunction
endclass //



class ram_test extends uvm_test;
    `uvm_component_utils(ram_test)
    
    ram_environment env;

    virtual ram_if r_if;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), " test new 생성", UVM_DEBUG);
    endfunction // new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = ram_environment::type_id::create("env", this);
        `uvm_info(get_type_name(), "env 생성", UVM_DEBUG);
    endfunction

    virtual task run_phase(uvm_phase phase);
        ram_master_seq seq;

        phase.raise_objection(this);
        seq = ram_master_seq::type_id::create("seq");
        seq.start(env.agt.sqr);

        phase.drop_objection(this);
    endtask // run_phase
    
    virtual function void report_phase(uvm_phase phase);
        uvm_report_server svr = uvm_report_server::get_server();
        if(svr.get_severity_count(UVM_ERROR) == 0)
            `uvm_info(get_type_name(), "===== TEST PASS ! =====", UVM_LOW)
        else `uvm_info(get_type_name(), "===== TEST FAIL ! =====", UVM_LOW)
        uvm_top.print_topology();
    endfunction
endclass //

module tb_ram ();
    logic clk;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    ram_if r_if(clk);

    
    sram dut(
        .clk(clk),
        .we(r_if.we),
        .addr(r_if.addr),
        .wdata(r_if.wdata),
        .rdata(r_if.rdata)
    );

    initial begin
        uvm_config_db#(virtual ram_if)::set(null,"*","r_if", r_if);
        run_test("ram_test"); 
    end
    endmodule