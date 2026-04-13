interface uart_if(
    input logic clk,
    input logic rst
);
    logic       tx_start,
    logic [7:0] tx_data,
    logic       uart_rx,
    logic       uart_tx,
    logic       tx_busy,
    logic       tx_done,
    logic [7:0] rx_data,
    logic       rx_done

    clocking tx_drv_cb @(posedge clk);
        default input #1step output #0;
        output tx_start;
        output tx_data;
        input uart_tx;
        input tx_busy;
        input tx_done;
    endclocking

    clocking rx_drv_cb @(posedge clk);
        default input #1step output #0;
        output uart_rx;
        input rx_data;
        input rx_done;
    endclocking

    clocking tx_mon_cb @(posedge clk);
        default input #1step;
        input tx_start;
        input tx_data;
        input uart_tx;
        input tx_busy;
        input tx_done;
    endclocking

    clocking rx_mon_cb @(posedge clk);
        default input #1step;
        input uart_rx;
        input rx_data;
        input rx_done;
    endclocking

    modport mp_tx_drv(clocking tx_drv_cb, input clk, input rst);
    modport mp_tx_mon(clocking tx_mon_cb, input clk, input rst);
    modport mp_rx_drv(clocking rx_drv_cb, input clk, input rst);
    modport mp_rx_mon(clocking rx_mon_cb, input clk, input rst);


endinterface //uart_if