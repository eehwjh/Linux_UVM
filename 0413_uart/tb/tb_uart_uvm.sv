import uvm_pkg::*;
`include "uvm_macros.svh"

interface interfacename (
    input logic clk,
    input logic reset
);
    logic [7:0] tx_data,
    logic tx_start,
    logic tx,
    logic tx_busy,
    logic rx,
    logic [7:0] rx_data,
    logic rx_valid

    clocking drv_cb @(posedge clk);
        default input #1step output #0;
        output tx_data,
        output tx_start,
        output tx,
        output tx_busy,
        input  rx,
        input  rx_data,
        input  rx_valid
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        input tx_data,
        input tx_start,
        input tx,
        input tx_busy,
        input rx,
        input rx_data,
        input rx_valid
    endclocking
endinterface // 

class uart_seq_item extends uvm_sequence_item;
    `uvm_object_utils(uart_base_seq)

    function new(string name="uart_base_seq");
        super.new(name); 
    endfunction //new()

endclass 

class uart_base_seq extends uvm_sequence #(uart_seq_item);
    `uvm_object_utils(uart_base_seq)

    function new(string name="uart_base_seq");
        super.new(name); 
    endfunction //new()

endclass //uart_base_test 

class uart_coverage extends uvm_subscriber #(uart_seq_item);
    `uvm_component_utils(uart_coverage)
    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);

    endtask //
endclass //uart_base_test 

class uart_scoreboard extends uvm_socreboard;
    `uvm_component_utils(uart_socreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);

    endtask //
endclass //uart_base_test 

class uart_monitor extends uvm_monitor;
    `uvm_component_utils(uart_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);

    endtask //
endclass //uart_base_test 

class uart_driver extends uvm_driver #(uart_seq_item);
    `uvm_component_utils(uart_driver)

    virtual uart_if u_if;

    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual uart_if)::get(this,"","u_if", u_if)) begin
            `uvm_fatal(get_type_name(), "uart interface를 config db에서 찾을 수 없음.");
        end
        
    endfunction
    
    task run_phase(uvm_phase phase);
        uart_seq_item item;

        u_if.tx_data <= 8'h00;
        u_if.tx_start <= 1'b0;
        @(negedge u_if.reset);
        repeat(3) @(u_if.drv_cb);

        forever begin
            seq_item_port.get_next_item(item);
            while(u_if.drv_cb.tx_busy) @(u_if.drv_cb);
            @(u_if.drv_cb);
            u_if.tx_data <= item.tx_data;
            u_if.tx_start <= 1'b1;
            @(u_if.drv_cb);
            u_if.tx_start <= 1'b0;
            `uvm_info(get_type_name(), $sformatf("전송 시작: tx_data = 0x%02h", item.tx_data), 
                      UVM_HIGH)
            @(u_if.drv_cb);
            while(!u_if.drv_cb.tx_busy) @(u_if.drv_cb); // busy 올라갈때 까지
            while(u_if.drv_cb.tx_busy) @(u_if.drv_cb); // busy 내려갈때 까지
            `uvm_info(get_type_name(), $sformatf("전송 완료: tx_data = 0x%02h", item.tx_data), 
                      UVM_HIGH)

            seq_item_port.item_done();
        end 
    endtask //
endclass //uart_base_test 

class uart_agent extends uvm_agent;
    `uvm_component_utils(uart_base_test)

    uart_driver drv;
    uart_monitor mon;
    uvm_sequencer #(uart_seq_item) sqr;

    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = uart_driver::type_id::create("drv", this);
        mon = uart_monitor::type_id::create("mon", this);
        sqr = uvm_sequencer#(uart_seq_item)::type_id::create("sqr", this);
        
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);

    endfunction
    
endclass //uart_base_test 

class uart_env extends uvm_env;
    `uvm_component_utils(uart_env)

    uart_agent agt;
    uart_scoreboard scb;
    uart_coverage cov;

    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = uart_agent::type_id::create("agt", this);
        scb = uart_scoreboard::type_id::create("scb", this);
        cov = uart_coverage::type_id::create("cov", this);
        
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agt.mon.ap.connect(scb.ap_imp);
        agt.mon.ap.connect(cov.analysis_export);

    endfunction
    
    task run_phase(uvm_phase phase);

    endtask //
endclass //uart_base_test 

class uart_base_test extends uvm_test;
    `uvm_component_utils(uart_base_test)

    uart_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = uart_env::type_id::create("env", this); 
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

    endfunction
    
    task run_phase(uvm_phase phase);
        uart_base_seq seq;
        phase.raise_objection(this);

        phase.drop_objection(this);
    endtask //
endclass //uart_base_test 









module tb_uart_uvm ();
    
    logic clk;
    logic reset;
    
    always #5 clk = ~clk;

    initial begin
        clk = 0; 
        reset = 1;
        repeat(3) @(posedge clk);
        reset = 0;
        @(posedge clk);
    end

    uart_if u_if(clk, reset);

uart #(
    .BAUD_RATE(9600)
) dut (
    .clk(clk),
    .reset(reset),
    .tx_data(u_if.tx_data),
    .tx_start(u_if.tx_start),
    .tx(u_if.tx),
    .tx_busy(u_if.tx_busy),
    .rx(u_if.rx),
    .rx_data(u_if.rx_data),
    .rx_valid(u_if.valid)
);

    assign u_if.rx = u_if.tx;

    initial begin
        uvm_config_db#(virtual uart_if)::set(null, "*", "u_if", u_if);
        run_test();
    end

    initial begin
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, tb_uart, "+all");
    end
endmodule