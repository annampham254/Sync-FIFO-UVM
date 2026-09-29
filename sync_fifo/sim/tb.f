+incdir+${UART_VIP_VERIF_PATH}/sequences
+incdir+${UART_VIP_VERIF_PATH}/testcases
+incdir+${UART_VIP_VERIF_PATH}/tb

// Compilation VIP design (agent) list
-f ${UART_VIP_ROOT}/fifo_vip.f

// Compilation Environment
${UART_VIP_VERIF_PATH}/tb/env_pkg.sv
${UART_VIP_VERIF_PATH}/sequences/seq_pkg.sv
${UART_VIP_VERIF_PATH}/testcases/test_pkg.sv
${UART_VIP_VERIF_PATH}/tb/testbench.sv

