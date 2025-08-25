vim9s

silent eval system('mkdir -p ~/.vimstore/sessions/{backup,undo}')

# TODO:
# Strong undo persistence
# (some logic for enabling persistence)
# if (persistence enabled) {
#   backup enabled
#   if (undo invalid) {
#       read backup
#       read undo
#       read current file
#   }
# }

setg viminfo=
setg viminfo=<50,'100,/100,:500,@0,

setg hidden
setg autoread

setg bdir=.,~/.vimstore/backup
setg writebackup
setg backupcopy=auto
set  nobackup
set  noswapfile

set  history=1000
set  undolevels=100000 # Remember all changes

setg undodir=~/.vimstore/undo
set  undofile
