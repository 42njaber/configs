
if did_filetype()
  finish
endif
if getline(1) =~ '^#!.*\<bash\>'
  echom "filetype bash"
  setfiletype bash
endif
