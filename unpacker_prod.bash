#!/bin/bash
# unpacker_prod.bash
# Unpacks Geneos packages and creates a "prod" softlink. This cannot be used on .zip files.

VERSION=${1}


if [ ${#} != 1 ]; then
	echo "Syntax should be: ./unpacker.bash <version>"
	echo "For example:"
	echo "1. For GA3 and below: ./unpacker.bash GA3.8.3-161105"
	echo "2. For GA4 and above: ./unpacker.bash gateway-4.1.0"
	exit
else
	rm prod
	mkdir ${VERSION}
	ln -sf ${VERSION} prod
	mv *${VERSION}*.tar.gz ${VERSION}/.
	cd ${VERSION}/
	gunzip *${VERSION}*.tar.gz
	tar -xf *${VERSION}*.tar
	rm *${VERSION}*.tar
fi
exit