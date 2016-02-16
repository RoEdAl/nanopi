#!/bin/bash

# Copyright (c) Jeff Kent <jeff@jkent.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


DEV_NAME='mmcblk0'
BLOCK_CNT=`cat /sys/block/${DEV_NAME}/size`;;

if [ -z ${BLOCK_CNT} -o ${BLOCK_CNT} -le 0 ]; then
	echo "error: ${DEV_NAME} is inaccessible"
	exit 1
fi

if [ ${BLOCK_CNT} -gt 134217727 ]; then
	echo "error: $1 size (${BLOCK_CNT}) is too large"
	exit 1
fi

if [ "sd$2" = "sdsd" -o ${BLOCK_CNT} -lt 4194303 ]; then
	echo "card type: sd"
	BL1_OFFSET=0
else
	echo "card type: sdhc"
	BL1_OFFSET=1024
fi

BL1_SIZE=16
ENV_SIZE=32
BL2_SIZE=512

let BL1_POSITION=${BLOCK_CNT}-${BL1_OFFSET}-${BL1_SIZE}-2
let BL2_POSITION=${BL1_POSITION}-${BL2_SIZE}-${ENV_SIZE}

dd if=/boot/nanoboot.bin of=/dev/${DEV_NAME} bs=512 seek=${BL2_POSITION} conv=fdatasync
dd if=/boot/nanoboot.bin of=/dev/${DEV_NAME} bs=512 seek=${BL1_POSITION} count=16 conv=fdatasync

echo "nanoboot fused"
