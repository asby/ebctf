
.PHONY: all subdir clean

all: install.tgz

install.tgz:
	cd deploy && tar -cvzf ../install.tgz * && cd ..

clean:
	rm -f install.tgz
