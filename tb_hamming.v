module tb_hamming;

  reg [64:1] din;
  wire [71:1] enc_codeword;
  
  reg [71:1] dec_codeword;
  wire [64:1] dout;
  

    hamming_encoder enc (
      .din(din),
      .codeword(enc_codeword)
    );
  
 	hamming_decoder dec (
      .codeword(dec_codeword),
      .dout(dout)
    );

    initial begin
        din = 64'hDEADBEEFCAFEBABE;
        #10;
      $display("Data : %d, Codeword Generated : %d", din, enc_codeword);
      
      $display("------------------------------------------------");
      $display("Recieved Codeword      | Retreived Data         ");
      $display("------------------------------------------------");
      
        dec_codeword = 71'b11011110010101101101111101110111111001011011111110101110010101111110010;
        #10;
      $display("%d | %d", dec_codeword, dout);
      
      	dec_codeword = 71'b11011110010101101101111101110111111001011011111110101110010111111110010;
        #10;
      $display("%d | %d", dec_codeword, dout);
      
      
      	dec_codeword = 71'b11011110010101101101111101110111111001011011111110101110010101111110011;
        #10;
      $display("%d | %d", dec_codeword, dout);
      
      	dec_codeword = 71'b01011110010101101101111101110111111001011011111110101110010101111110010;
        #10;
      $display("%d | %d", dec_codeword, dout);
      
      dec_codeword = 71'b11011110010101101101111101110101111001011011111110101110010101111110010;
        #10;
      $display("%d | %d", dec_codeword, dout);
      
      
      	#10
        $finish;
    end

endmodule

