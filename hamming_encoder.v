module hamming_encoder(input [64:1] din, output reg [71:1] codeword);
  
  reg [7:1] p = 7'b0;
  reg [71:1] temp;
  integer i;
  
  always @(*) begin
    
    temp = {din[64:58],p[7],din[57:27],p[6],din[26:12],p[5],din[11:5],p[4],din[4:2],p[3],din[1],p[2:1]};
    
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
    temp[32] = temp[32] ^ (^temp[63:33]);
    temp[64] = temp[64] ^ (^temp[71:65]);
 
   end
   assign codeword = temp;
                   
endmodule
