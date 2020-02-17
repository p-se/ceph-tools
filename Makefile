.phony:
	nop
install:
	ln -sf ${PWD}/ceph-tools ~/bin/ceph-tools
	chmod +x ~/bin/ceph-tools
