module jiaotong(CLK,RST,Num,SEG1,SEG2,SEG3,SEG4,SEG5,SEG6,MLED,CLED,S,LED6,LED7,LED8,LED9);
	input CLK,RST,S;
	output reg LED6,LED7,LED8,LED9;
	output reg [2:0]MLED,CLED;
	output reg [7:0]Num;
	output reg [6:0]SEG1,SEG2,SEG3,SEG4,SEG5,SEG6;
	reg[3:0] Num1;
	reg[3:0] Num2;
	reg [25:0]cnt;
	reg C;
	reg [2:0]state;
	parameter S1=3'b000,S2=3'b001,S3=3'b010,S4=3'b011;
	
	initial
		begin
			LED6=0;
			LED7=0;
			LED8=0;
			LED9=0;
			SEG3=7'b1111111;
			SEG4=7'b1111111;
			SEG5=7'b1111111;
			SEG6=7'b1111111;
			Num=8'd60;
			Num2=4'd0;
			Num1=4'd0;
			cnt=26'd0;			
			C=1'b0;
			state=S1;
		end
	always @(posedge CLK)
		begin
			cnt<=cnt+1;
			if(cnt>(9999999))		//49999999
				begin
					cnt<=0;
					C<=1'b1;
				end
			else
				C<=1'b0;
		end
		
	always @(posedge CLK or negedge RST)
		begin
			if(!RST)
				begin
					state=S1;
					MLED=3'b001;
					CLED=3'b100;
					Num<='d60;
				end
			else				
				begin
					Num<=Num-1;
					case(state)
						S1:
							begin
								if(Num=='d0)
									begin
										if(S==1)
											begin
												state=S2;
												MLED=3'b010;
												CLED=3'b001;
												Num<='d4;
											end										
										else
											begin
												state=S1;
												MLED=3'b001;
												CLED=3'b100;
												Num<='d60;
											end
									end
							end
						S2:
							begin
								if(S==0)
									begin
										state=S4;
										MLED=3'b100;
										CLED=3'b010;
										Num<='d4;
									end
								else
									begin
										if(Num=='d0)
											begin
												state=S3;
												MLED=3'b100;
												CLED=3'b001;
												Num<='d20;
											end
									end
							end
						S3:
							begin
								if(S==0)
									begin
										state=S4;
										MLED=3'b100;
										CLED=3'b010;
										Num<='d4;
									end
								if(Num=='d0)
									begin
										state=S4;
										MLED=3'b100;
										CLED=3'b010;
										Num<='d4;
									end
							end
						S4:
							begin
								if(Num=='d0)
									begin
										state=S1;
										MLED=3'b001;
										CLED=3'b100;
										Num<='d60;
									end
							end
						default:
							begin
								state=S1;
								MLED=3'b001;
								CLED=3'b100;
								Num<='d60;
							end
					endcase
				end
		end
		always @(Num)
			begin
				Num2<=(Num/10%10);
				Num1<=(Num%10);
				case(Num1)
					4'b0000:SEG1<=7'b1000000;
					4'b0001:SEG1<=7'b1111001;
					4'b0010:SEG1<=7'b0100100;
					4'b0011:SEG1<=7'b0110000;
					4'b0100:SEG1<=7'b0011001;
					4'b0101:SEG1<=7'b0010010;
					4'b0110:SEG1<=7'b0000010;
					4'b0111:SEG1<=7'b1111000;
					4'b1000:SEG1<=7'b0000000;
					4'b1001:SEG1<=7'b0010000;
					default:SEG1<=7'b0001110;
				endcase
				case(Num2)
					4'b0000:SEG2<=7'b1000000;
					4'b0001:SEG2<=7'b1111001;
					4'b0010:SEG2<=7'b0100100;
					4'b0011:SEG2<=7'b0110000;
					4'b0100:SEG2<=7'b0011001;
					4'b0101:SEG2<=7'b0010010;
					4'b0110:SEG2<=7'b0000010;
					4'b0111:SEG2<=7'b1111000;
					4'b1000:SEG2<=7'b0000000;
					4'b1001:SEG2<=7'b0010000;
					default:SEG2<=7'b0001110;
				endcase
			end
endmodule

