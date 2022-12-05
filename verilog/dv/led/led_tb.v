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

module led_tb;
    // Signals declaration
    reg clock;
    reg RSTB;
	wire [7:0] led;
    reg power1, power2;
    wire  [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;

    assign io_in[10] = clock;
    assign io_in[11] = RSTB;
    assign led = io_out[18:12];
  
    always #12.5 clock <= (clock === 1'b0);

    initial begin
        clock = 0;
    end

    

    initial begin
        $dumpfile("led_tb.vcd");
        $dumpvars(0, led_tb);

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

user_proj_example mprj (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),	
    .vssd1(vssd1),
`endif
    .io_in(io_in),
    .io_out(io_out),
    .io_oeb(io_oeb)

);

endmodule
`default_nettype wire
