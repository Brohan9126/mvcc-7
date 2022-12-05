// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype wire

`timescale 1 ns / 1 ps

module counter_tb;
    // Signals declaration
    reg clock;
    reg RSTB;
	wire [3:0] out;
    reg power1, power2;
  
    always #12.5 clock <= (clock === 1'b0);

    initial begin
        clock = 0;
    end

    

    initial begin
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);

        // Repeat cycles of 1000 clock edges as needed to complete testbench
        repeat (5) begin
            repeat (1000) @(posedge clock);
		end
        $finish;
    end

    // Reset Operation
    initial begin		
        RSTB <= 1'b0;
        #500;
        RSTB <= 1'b1;       	// Release reset
    end

    initial begin		// Power-up sequence
        power1 <= 1'b0;
        power2 <= 1'b0;
        #200;
        power1 <= 1'b1;
        #200;
        power2 <= 1'b1;
    end

counter c0 (
	.clk (clock),
	.rstn (RSTB),
	.out(out)
);

endmodule
`default_nettype wire
