rm -rf xcelium.d waves.shm xrun.log xrun.history

xrun \
  -64bit \
  -sv \
  -top tb_top \
  -f filelist.f \
  -timescale 1ns/1ps \
  +incdir+../tb \
  +incdir+../rtl \
  -coverage functional \
  -covoverwrite \
  -access +rwc \
  -gui \
  -l xrun.log
