vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.FIFO_top -classdebug -uvmcontrol=all -cover

add wave -position insertpoint  \
sim:/FIFO_top/FIFO_inter/almostempty \
sim:/FIFO_top/FIFO_inter/almostfull \
sim:/FIFO_top/FIFO_inter/clk \
sim:/FIFO_top/FIFO_inter/data_in \
sim:/FIFO_top/FIFO_inter/data_out \
sim:/FIFO_top/FIFO_inter/empty \
sim:/FIFO_top/FIFO_inter/FIFO_DEPTH \
sim:/FIFO_top/FIFO_inter/FIFO_WIDTH \
sim:/FIFO_top/FIFO_inter/full \
sim:/FIFO_top/FIFO_inter/overflow \
sim:/FIFO_top/FIFO_inter/rd_en \
sim:/FIFO_top/FIFO_inter/rst_n \
sim:/FIFO_top/FIFO_inter/underflow \
sim:/FIFO_top/FIFO_inter/wr_ack \
sim:/FIFO_top/FIFO_inter/wr_en

coverage save FIFO.ucdb -onexit

run -all
coverage exclude -cvgpath {/FIFO_Cover_pkg/FIFO_Cover_Class/CVR/#cross__0#/<auto[0],auto[1]>}
coverage exclude -cvgpath {/FIFO_Cover_pkg/FIFO_Cover_Class/CVR/#cross__1#/<auto[0],auto[1]>}
coverage exclude -cvgpath {/FIFO_Cover_pkg/FIFO_Cover_Class/CVR/#cross__3#/<auto[0],auto[1]>}
coverage exclude -cvgpath {/FIFO_Cover_pkg/FIFO_Cover_Class/CVR/#cross__8#/<auto[1],auto[1]>}
coverage exclude -cvgpath {/FIFO_Cover_pkg/FIFO_Cover_Class/CVR/#cross__9#/<auto[0],auto[1]>}
coverage exclude -cvgpath {/FIFO_Cover_pkg/FIFO_Cover_Class/CVR/#cross__10#/<auto[1],auto[1]>}
coverage exclude -cvgpath {/FIFO_Cover_pkg/FIFO_Cover_Class/CVR/#cross__11#/<auto[0],auto[1]>}