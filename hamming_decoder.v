module hamming_decoder(input [71:1] codeword, output reg [64:1] dout);
  
  reg [7:1] np = 7'b0;
  reg [7:1] s,p;
  reg [71:1] temp;
  integer i;
  
  always @(*) begin
    
    p = {codeword[64],codeword[32],codeword[16],codeword[8],codeword[4],codeword[2],codeword[1]};
    temp = codeword;
   
    for (i=1; i <72; i=i+2) begin 
      temp[1] = temp[1] ^ temp[i];
    end
    for (i=2; i <72; i=i+4) begin 
      temp[2] = temp[2] ^ temp[i] ^ temp[i+1];
    end
    for (i=4; i <72; i=i+8) begin 
      temp[4] = temp[4] ^ temp[i] ^ temp[i+1] ^ temp[i+2] ^ temp[i+3];
    end
    for (i=8; i <72; i=i+16) begin 
      temp[8] = temp[8] ^ temp[i] ^ temp[i+1] ^ temp[i+2] ^ temp[i+3] ^ temp[i+4] ^ temp[i+5] ^ temp[i+6] ^ temp[i+7];
    end
    for (i=16; i <72; i=i+32) begin 
      temp[16] = temp[16] ^ temp[i] ^ temp[i+1] ^ temp[i+2] ^ temp[i+3] ^ temp[i+4] ^ temp[i+5] ^ temp[i+6] ^ temp[i+7];
    end
    temp[32] = temp[32] ^ (^temp[63:32]);
    temp[64] = temp[64] ^ (^temp[71:64]);
    
    np = {temp[64],temp[32],temp[16],temp[8],temp[4],temp[2],temp[1]};
    s = np ^ p;
    $display("Syndrome: %d", s);
    temp[s] = ~temp[s];
   end
  
  assign dout = {temp[71:65],temp[63:33],temp[31:17],temp[15:9],temp[7:5],temp[3]};
                   
endmodule

