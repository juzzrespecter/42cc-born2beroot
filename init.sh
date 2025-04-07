HOST_OS=Rocky-9.5-x86_64-dvd.iso
B2BR_IMG=b2br.qcow2

check_host_os() {
    if [ ! -e $HOST_OS ]; then
        echo "No host OS found. Stopping..." 1>&2
        exit 1
    fi
}
check_img() {
    if [ ! -e $B2BR_IMG ]; then
        echo "No host disk image found, creating one..."
        qemu-img create -f qcow2 ./$B2BR_IMG 20G
    fi
}
print_usage() {
    echo "usage: ./init.sh [-i|-b|-c]" >&2
    exit 1
}

OPTSTR=":ibc"
while getopts "$OPTSTR" opt; do
    case $opt in
        i) INSTALL_FLAG=1 ;;
        b) BOOT_FLAG=1    ;;
        c) CONVERT_FLAG=1 ;;
        ?)
            echo "$0: invalid option: -${OPTARG}" >&2
            print_usage
            ;;
    esac
done

if [ ! -z ${INSTALL_FLAG+x} ]; then
    check_host_os
    check_img
    qemu-system-x86_64 \
        -smp 2 \
        -boot d \
        -m 4096 \
        -cpu host \
        -enable-kvm \
        -drive file=$B2BR_IMG,format=qcow2 \
        -cdrom $HOST_OS \
        -netdev user,id=net0,hostfwd=tcp::4242-:22 \
        -device e1000,netdev=net0 \
        -display default,show-cursor=on
    exit 0
fi

if [ ! -z ${BOOT_FLAG+x} ]; then
    check_host_os
    if [ ! -e $B2BR_IMG ]; then
        echo "No host disk image found, stopping..." >&2
        exit 1
    fi
    qemu-system-x86_64 \
        -m 4G \
        -smp 2\
        -enable-kvm \
        -cpu host \
        -boot c \
        -m 4096 \
        -drive file=$B2BR_IMG,format=qcow2 \
        -netdev user,id=net0,hostfwd=tcp::4242-:22 \
        -device e1000,netdev=net0 \
        -display default,show-cursor=on
    exit 0
fi

if [ ! -z ${CONVERT_FLAG+x} ]; then
    # Convert to VBox format
    if [ -e $HOST_IMG]; then
        echo "No host disk image found, stopping..." >&2
        exit 1
    fi
    qemu-img convert -f qcow2 $B2BR_IMG -O vdi b2br.vdi
    exit 0
fi

print_usage