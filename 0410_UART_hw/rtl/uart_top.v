`timescale 1ns / 1ps

module uart_top (
    input        clk,
    input        rst,
    input        tx_start,
    input  [7:0] tx_data,
    input        uart_rx,
    output       uart_tx,
    output       tx_busy,
    output       tx_done,
    output [7:0] rx_data,
    output       rx_done

);

    wire w_b_tick;

    uart_tx U_UART_TX (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .b_tick(w_b_tick),
        .tx_data(tx_data),
        .tx_busy(tx_busy),
        .tx_done(tx_done),
        .uart_tx(uart_tx)
    );

    uart_rx U_UART_RX (
        .clk(clk),
        .rst(rst),
        .rx(uart_rx),
        .b_tick(w_b_tick),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    baud_tick U_BAUD_TCIK (
        .clk(clk),
        .rst(rst),
        .b_tick(w_b_tick)
    );

endmodule