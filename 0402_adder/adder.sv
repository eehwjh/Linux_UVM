module adder (
	input logic [7:0] a,
	input logic [7:0] b,
	output logic [8:0] y
);
	assign y = a + b;
endmodule //이건 adder 모듈 입니다.
