
//对10个数进行并行排序
module sort_paralell(
				input 					clk, 
				input 					rst_n,
				input						en,
				input 		[15:0] 	in0, in1, in2, in3, in4, in5, in6, in7, 
				output reg				complete,
				output reg 	[15:0] 	out0, out1, out2, out3, out4, out5, out6,out7
						);
						

reg [15:0] out_temp[7:0];				//输出数据放入此二维数组中

//下面定义的变量用于存储比较结果，如in0 > in1,则a0 <= 1,否则a0 <= 0; 
reg  [6:0] a;
reg  [6:0] b;
reg  [6:0] c;
reg  [6:0] d;
reg  [6:0] e;
reg  [6:0] f;
reg  [6:0] g;
reg  [6:0] h;
		
reg add_start; //该变量的作用是判断比较是否结束，比较结束后赋值为1，进入相加模块
reg assignm_start; //该变量作用在于判断相加模块执行是否结束，结束后赋值为1，进入下一个输出模块
//下面定义的变量用于存储上述中间变量累加结果，9个1位2进制数相加最多4位
reg out_start;
reg [3:0] mid0, mid1, mid2, mid3, mid4, mid5, mid6, mid7;
		
		//并行比较模块（第一个时钟）
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			a <= 7'b000_0000;
			b <= 7'b000_0000;
			c <= 7'b000_0000;
			d <= 7'b000_0000;
			e <= 7'b000_0000;
			f <= 7'b000_0000;
			g <= 7'b000_0000;
			h <= 7'b000_0000;

			add_start <= 0;

		end
		
		else if(en)
			begin
				if(in0 >= in1) a[0] <= 1'b1; //in0和所有除自己外的其他数据比较，大于则标志置1
				else a[0] <= 1'b0;
				if(in0 >= in2) a[1] <= 1'b1;
				else a[1] <= 1'b0;
				if(in0 >= in3) a[2] <= 1'b1;
				else a[2] <= 1'b0;
				if(in0 >= in4) a[3] <= 1'b1;
				else a[3] <= 1'b0;
				if(in0 >= in5) a[4] <= 1'b1;
				else a[4] <= 1'b0;
				if(in0 >= in6) a[5] <= 1'b1;
				else a[5] <= 1'b0;
				if(in0 >= in7) a[6] <= 1'b1;
				else a[6] <= 1'b0;

						
				if(in1 > in0) b[0] <= 1'b1;//in1和所有除自己外的数据比较，大于标志位置1，否则为0
				else b[0] <= 1'b0;
				if(in1 >= in2) b[1] <= 1'b1;
				else b[1] <= 1'b0;
				if(in1 >= in3) b[2] <= 1'b1;
				else b[2] <= 1'b0;
				if(in1 >= in4) b[3] <= 1'b1;
				else b[3] <= 1'b0;
				if(in1 >= in5) b[4] <= 1'b1;
				else b[4] <= 1'b0;
				if(in1 >= in6) b[5] <= 1'b1;
				else b[5] <= 1'b0;
				if(in1 >= in7) b[6] <= 1'b1;
				else b[6] <= 1'b0;

						
				if(in2 > in0) c[0] <= 1'b1;
				else c[0] <= 1'b0;
				if(in2 > in1) c[1] <= 1'b1;
				else c[1] <= 1'b0;
				if(in2 >= in3) c[2] <= 1'b1;
				else c[2] <= 1'b0;
				if(in2 >= in4) c[3] <= 1'b1;
				else c[3] <= 1'b0;
				if(in2 >= in5) c[4] <= 1'b1;
				else c[4] <= 1'b0;
				if(in2 >= in6) c[5] <= 1'b1;
				else c[5] <= 1'b0;
				if(in2 >= in7) c[6] <= 1'b1;
				else c[6] <= 1'b0;

						
				if(in3 > in0) d[0] <= 1'b1;
				else d[0] <= 1'b0;
				if(in3 > in1) d[1] <= 1'b1;
				else d[1] <= 1'b0;
				if(in3 > in2) d[2] <= 1'b1;
				else d[2] <= 1'b0;
				if(in3 >= in4) d[3] <= 1'b1;
				else d[3] <= 1'b0;
				if(in3 >= in5) d[4] <= 1'b1;
				else d[4] <= 1'b0;
				if(in3 >= in6) d[5] <= 1'b1;
				else d[5] <= 1'b0;
				if(in3 >= in7) d[6] <= 1'b1;
				else d[6] <= 1'b0;

						
				if(in4 > in0) e[0] <= 1'b1;
				else e[0] <= 1'b0;
				if(in4 > in1) e[1] <= 1'b1;
				else e[1] <= 1'b0;
				if(in4 > in2) e[2] <= 1'b1;
				else e[2] <= 1'b0;
				if(in4 > in3) e[3] <= 1'b1;
				else e[3] <= 1'b0;
				if(in4 >= in5) e[4] <= 1'b1;
				else e[4] <= 1'b0;
				if(in4 >= in6) e[5] <= 1'b1;
				else e[5] <= 1'b0;
				if(in4 >= in7) e[6] <= 1'b1;
				else e[6] <= 1'b0;

						
				if(in5 > in0) f[0] <= 1'b1;
				else f[0] <= 1'b0;
				if(in5 > in1) f[1] <= 1'b1;
				else f[1] <= 1'b0;
				if(in5 > in2) f[2] <= 1'b1;
				else f[2] <= 1'b0;
				if(in5 > in3) f[3] <= 1'b1;
				else f[3] <= 1'b0;
				if(in5 > in4) f[4] <= 1'b1;
				else f[4] <= 1'b0;
				if(in5 >= in6) f[5] <= 1'b1;
				else f[5] <= 1'b0;
				if(in5 >= in7) f[6] <= 1'b1;
				else f[6] <= 1'b0;

						
				if(in6 > in0) g[0] <= 1'b1;
				else g[0] <= 1'b0;
				if(in6 > in1) g[1] <= 1'b1;
				else g[1] <= 1'b0;
				if(in6 > in2) g[2] <= 1'b1;
				else g[2] <= 1'b0;
				if(in6 > in3) g[3] <= 1'b1;
				else g[3] <= 1'b0;
				if(in6 > in4) g[4] <= 1'b1;
				else g[4] <= 1'b0;
				if(in6 > in5) g[5] <= 1'b1;
				else g[5] <= 1'b0;
				if(in6 >= in7) g[6] <= 1'b1;
				else g[6] <= 1'b0;

						
				if(in7 > in0) h[0] <= 1'b1;
				else h[0] <= 1'b0;
				if(in7 > in1) h[1] <= 1'b1;
				else h[1] <= 1'b0;
				if(in7 > in2) h[2] <= 1'b1;
				else h[2] <= 1'b0;
				if(in7 > in3) h[3] <= 1'b1;
				else h[3] <= 1'b0;
				if(in7 > in4) h[4] <= 1'b1;
				else h[4] <= 1'b0;
				if(in7 > in5) h[5] <= 1'b1;
				else h[5] <= 1'b0;
				if(in7 > in6) h[6] <= 1'b1;
				else h[6] <= 1'b0;
				
						
				add_start <= 1; //比较结束标志，相加开始标志
			end
end
	//相加模块，mid（i）的值代表着in（i）所在输出数组中的位置，（第二个时钟）
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			mid0 <= 7'b000_0000;
			mid1 <= 7'b000_0000;
			mid2 <= 7'b000_0000;
			mid3 <= 7'b000_0000;
			mid4 <= 7'b000_0000;
			mid5 <= 7'b000_0000;
			mid6 <= 7'b000_0000;
			mid7 <= 7'b000_0000;
		end
		
	else if(add_start == 1)
		begin
			mid0 <= a[0] + a[1] + a[2] + a[3] + a[4] + a[5] + a[6]; //标志位相加，所得结果就是其所在位置
			mid1 <= b[0] + b[1] + b[2] + b[3] + b[4] + b[5] + b[6];
			mid2 <= c[0] + c[1] + c[2] + c[3] + c[4] + c[5] + c[6];
			mid3 <= d[0] + d[1] + d[2] + d[3] + d[4] + d[5] + d[6];
			mid4 <= e[0] + e[1] + e[2] + e[3] + e[4] + e[5] + e[6];
			mid5 <= f[0] + f[1] + f[2] + f[3] + f[4] + f[5] + f[6];
			mid6 <= g[0] + g[1] + g[2] + g[3] + g[4] + g[5] + g[6];
			mid7 <= h[0] + h[1] + h[2] + h[3] + h[4] + h[5] + h[6];
		end
		
	assignm_start <= 1;//相加结束，赋值开始标志
end
		
		//输出模块，将排序好的数据放入输出数组中（第三个时钟）
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			out_temp[0]  <= 16'b00000000_00000000;
			out_temp[1]  <= 16'b00000000_00000000;
			out_temp[2]  <= 16'b00000000_00000000;
			out_temp[3]  <= 16'b00000000_00000000;
			out_temp[4]  <= 16'b00000000_00000000;
			out_temp[5]  <= 16'b00000000_00000000;
			out_temp[6]  <= 16'b00000000_00000000;
			out_temp[7]  <= 16'b00000000_00000000;
			out_start <= 0;
		end
			
	else if(assignm_start == 1)
		begin
			out_temp[mid0] <= in0;
			out_temp[mid1] <= in1;
			out_temp[mid2] <= in2;
			out_temp[mid3] <= in3;
			out_temp[mid4] <= in4;
			out_temp[mid5] <= in5;
			out_temp[mid6] <= in6;
			out_temp[mid7] <= in7;

					
			out_start <= 1;//赋值结束，输出开始标志位
		end
end


always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			out0 <= 16'b00000000_00000000;
			out1 <= 16'b00000000_00000000;
			out2 <= 16'b00000000_00000000;
			out3 <= 16'b00000000_00000000;
			out4 <= 16'b00000000_00000000;
			out5 <= 16'b00000000_00000000;
			out6 <= 16'b00000000_00000000;
			out7 <= 16'b00000000_00000000;
			
			complete <= 0;
		end
		
	else if(out_start == 1)
		begin
			out0 <= out_temp[0];
			out1 <= out_temp[1];
			out2 <= out_temp[2];
			out3 <= out_temp[3];
			out4 <= out_temp[4];
			out5 <= out_temp[5];
			out6 <= out_temp[6];
			out7 <= out_temp[7];
			
			complete <= 1;

		end	
			
end
	
	
endmodule
