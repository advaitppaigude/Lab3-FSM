#include "Vdut.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"


int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);

    // initialise top verilog instance
    Vdut* top = new Vdut;

    // initialise trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("counter.vcd");

    // init Vbuddy
    if (vbdOpen() != 1) return (-1);
    vbdHeader("2.2 F1 FSM");
    vbdSetMode(1);

    // initialise simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->en = 0;

    for (i = 0; i < 1000000; i++) {

        for (clk = 0; clk < 2; clk++) {
            top->clk = !top->clk;
            top->eval();
            tfp->dump(2*i + clk);
        }

        vbdBar(top->data_out & 0xFF);

        top->rst = (i < 2);
        top->en = vbdFlag();

        if (Verilated::gotFinish()) exit(0);
    }
    vbdClose();
    tfp->close();
    exit(0);
}