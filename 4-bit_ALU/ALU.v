// 4 bit ALU
module ALU (input [3:0] A, B, OPCODE, input Cin, output reg [3:0] Sum, output reg Cout, output OF);
    reg [3:0] Ain, Bin;
    reg Ci;
    wire [3:0] Bn, S;
    wire Co;
    com2s C1 (B, Bn);
    FA4 FA1 (Ain, Bin, Ci, S, Co, OF);
    always @ (*) begin
        Ain = 4'b0000; Bin = 4'b0000; Sum = 4'b0000; Ci = 1'b0; Cout = 'b0;
        case (OPCODE)
        // A+B
        4'b1000 : begin
            Ain = A; Bin = B; Sum = S; Cout = Co;
        end
        // A-B
        4'b1010 : begin
            Ain = A; Bin = Bn; Sum = S; Cout = Co;
        end
        // add with Cin
        4'b1001 : begin
            Ain = A; Bin = B; Ci = Cin; Sum = S; Cout = Co;
        end
        // NAND ~(AB)
        4'b0000 : begin
            Sum = ~(A&B);
        end
        // NOR ~(A|B)
        4'b0001 : begin
            Sum = ~(A|B);
        end
        // XOR A^B
        4'b0010 : begin
            Sum = A^B;
        end
        // NOT ~A
        4'b0100 : begin
            Sum = ~A;
        end
        // Right Shift A>>1
        4'b0101 : begin
            Sum = A>>1;
        end
        // (A^B)+[(~(A&B))>>1]
        4'b1111 : begin
            Ain = A^B; Bin = (~(A&B))>>1;
        end
        // Default NOP
        default : begin
            Sum = 4'b0000; Cout = 0;
        end

        endcase
    end
endmodule

// 1 bit adder
module FA (a, b, cin, sum, cout);
    input a;
    input b;
    input cin;
    output cout;
    output sum;
assign sum = (a ^ b) ^ cin;
assign cout = (a & b) | (cin & a) | (cin & b);
endmodule

// 2s compliment
module com2s (input [3:0] B, output [3:0] Bn);
wire [3:0] Bn1;
wire OF;
assign Bn1 = ~B;
FA4 fa1 (Bn1, 4'b0000, 1'b1, Bn, Cout, OF);
endmodule

// 4 bit ripple carry adder
module FA4 ( input [3:0] A, B, input Cin, output [3:0] Sum, output Cout, OF);
FA fa1 (A[0], B[0], Cin, Sum[0], Cout1);
FA fa2 (A[1], B[1], Cout1, Sum[1], Cout2);
FA fa3 (A[2], B[2], Cout2, Sum[2], Cout3);
FA fa4 (A[3], B[3], Cout3, Sum[3], Cout);
xor X1 (OF, Cout3, Cout);
endmodule

// half adder
module HA (input A, B, output Sum, Cout);
assign Sum = A ^ B;
assign Cout = A & B;
endmodule

module ALU_pv (input [3:0] A, OPCODE, input Cin, output [3:0] Sum, output Cout, output OF);
wire [3:0] B;
assign B = 4'b0011;
ALU alu2 (A, B, OPCODE, Cin, Sum, Cout, OF);
endmodule