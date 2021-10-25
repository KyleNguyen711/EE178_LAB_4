`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2021 02:55:15 PM
// Design Name: 
// Module Name: Lab4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Lab4(
//clock signal, 100 MHz from oscillator
input wire clk, 
//frequency select
input wire [3:0] note, 
//be silent
input wire hush,
//audio output
output wire speaker
);
//Sixteen keys cover more than one octave, which should be sufficient.
//The frequency of a key called "Concert A" or A4 is 440 Hz.
//The twelfth root of two relates the frequencies of adjacent keys.
//The single clock used in this design is running at a nominal 100 MHz
reg [17:0] clockcount;
reg clockoutput;
//Oscillator Frequency 100000000
//Oscillator Period 0.00000001
reg [16:0] Hertz;

always@(posedge clk)
begin
    case(note)
        //A4
        4'b0000 : Hertz = 17'b11011101111100011; 
        //A#/Bb     
        4'b0001 : Hertz = 17'b11010001011111001; 
        //B/Cb
        4'b0010 : Hertz = 17'b11000101101110101; 
        //C/B#
        4'b0011 : Hertz = 17'b10111010101000011;
        //C#/Db 
        4'b0100 : Hertz = 17'b10110000001010000; 
        //D
        4'b0101 : Hertz = 17'b10100110010001010;
        //D#/Eb 
        4'b0110 : Hertz = 17'b10011100111100000; 
        //E/Fb
        4'b0111 : Hertz = 17'b10010100001000010; 
        //F/E#
        4'b1000 : Hertz = 17'b10001011110100001; 
        //F#/Gb
        4'b1001 : Hertz = 17'b10000011111110000; 
        //G
        4'b1010 : Hertz = 17'b01111100100011111; 
        //G#/Ab
        4'b1011 : Hertz = 17'b01110101100100100; 
        //A5
        4'b1100 : Hertz = 17'b01101110111110001; 
        //A#/Bb
        4'b1101 : Hertz = 17'b01101000101111100; 
        //B/Cb
        4'b1110 : Hertz = 17'b01100010110111010; 
        //C/B#
        4'b1111 : Hertz = 17'b01011101010100001; 
        default : Hertz = 17'b00000000000000000;
    endcase
end

initial
begin
    clockoutput <= 0;
    clockcount <= 0;
end

always@(posedge clk)
begin
    clockcount <= clockcount + 1;
    if ((clockcount == Hertz) && (hush == 1'b0))
begin
        clockcount <= 0;
        clockoutput <= !clockoutput;
    end
end
assign speaker = clockoutput;
endmodule
