
module testFA();
reg A, B, Cin;
FA fa1 (A, B, Cin, S, Cout);
initial begin
    A=0; B=0; Cin=0; #5;
    A=1; B=0; #5;
    A=0; B=1; #5;
    A=1; B=1; #5;
    A=0; B=0; Cin=1; #5;
    A=1; B=0; #5;
    A=0; B=1; #5;
    A=1; B=1; #5;
end
endmodule

module testALU();
reg [3:0] A, B, OPCODE;
wire [3:0] S;
reg Cin;
wire Cout, OF;
initial begin
    //add
    A=4'b0110; B=4'b0011; Cin=0; OPCODE=4'b1000; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //add with Cin
    A=4'b0111; B=4'b0101; Cin=1; OPCODE=4'b1001; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //sub b from a
    A=4'b0111; B=4'b0101; Cin=0; OPCODE=4'b1010; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //bitwise NAND
    A=4'b0110; B=4'b1111; Cin=0; OPCODE=4'b0000; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //bitwise NOR
    A=4'b0110; B=4'b0001; Cin=0; OPCODE=4'b0001; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //bitwise XOR
    A=4'b0101; B=4'b1111; Cin=0; OPCODE=4'b0010; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //bitwise NOT
    A=4'b1101; B=4'b0000; Cin=0; OPCODE=4'b0100; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //logical right shift
    A=4'b0101; B=4'b0000; Cin=0; OPCODE=4'b0101; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    //function given
    A=4'b0110; B=4'b0011; Cin=0; OPCODE=4'b1111; #5;
    $display("A= %b, B=%b, C= %b, Sum= %b, OPCODE= %b, Cout= %b, OF=%b", A,B,Cin,S,OPCODE,Cout,OF);
    
end
ALU alu1 (A, B, OPCODE, Cin, S, Cout, OF);
endmodule