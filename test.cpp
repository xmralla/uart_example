#include "uart_core.h"
#include "verilated.h"

int main(int argc, char** argv)
{
Verilated::commandArgs(argc, argv);
uart_core* u1 = new uart_core;
uart_core* u2 = new uart_core;

while (!Verilated::gotFinish()) { u1->eval(); }
delete u1;
delete u2;
exit(0);
}
