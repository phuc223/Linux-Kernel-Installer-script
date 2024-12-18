#! /bin/bash
if [ "$EUID" -ne 0 ]; then # Check root permisson
        echo "Error, your permisson is far from the absolute perfection. Please come again later after you have acquired what it truly is."
        exit 1
fi

read -p "Enter the version of Kernel you would like to install: " KERNEL_VERSION
read -p "Which is the series of it(Eg: 6): " KERNEL_SERIES #Note only input the number 

# KERNEL_VERSION="6.12.5" this is my old creation, my laziness has overcome me to delete it
KERNEL_ARCHIVE="linux-$KERNEL_VERSION.tar.xz"
# KERNEL_NUMBER="6" yet, I still do not have the proficiency to delete it

if [ ! -f "$KERNEL_ARCHIVE" ]; then
	echo "The Almighty did not find the $KERNEL_ARCHIVE, we must reinstall one and rejoice."
	wget "https://cdn.kernel.org/pub/linux/kernel/v$KERNEL_SERIES.x/linux-$KERNEL_VERSION.tar.xz" || {  
		echo "The product of the Almighty has been declined, which is shameful, we might declare an exit for this outcome."
		exit 1
}
fi
echo "For what to be done, we must remove the trace of the old sunlight, and rebuild it with the new sunshine."
rm -rf "linux-$KERNEL_VERSION"
echo "Subsequently, the gift of the creation must be laided and inspected wisely. With all the wisdom, I shall declare a way to inspect it the Extracting."
sleep 5
tar xf "linux-$KERNEL_VERSION.tar.xz" || {  
	echo "This has been the biggest shame for the creation. The gift has refused itself to be inspected. Hence, the program will have nothing to continue."
	exit 1
}
cp "/boot/config-$(uname -r)" "linux-$KERNEL_VERSION/.config"
cd "linux-$KERNEL_VERSION" || exit 1
scripts/config --disable SYSTEM_TRUSTED_KEYS #Disable System_Trusted_Keys
scripts/config --disable SYSTEM_REVOCATION_KEYS #Disable System_Revocation_Keys
echo "I shall ask you to do something for me: embeding your creativity to this own creation. This is the essential stage, please do all of this by yourself. Hence, the gift can be done."
sleep 3
make menuconfig
echo "We have finally done. Henceforth, the installation may be automatic."
sleep 3
make -j$(nproc)
make modules_install
make install
update-initramfs -c -k "$KERNEL_VERSION"
echo "With all of the grace, the grub shall recieve the same treatment a new form - a new beauty of the creation."
sleep 3
update-grub || {echo "Once again, the only thing that declined the evolusion, has always been the GRUB."; exit 1;}
echo "Done. The gift is prepared now, your machine needs to be rebooted in order to see what truly is."
read -p "In the term of new experiment, do you wish for a reboot? (Y/N): " REBOOT
if [[ "$REBOOT" =~ ^[Yy]$ ]]; then
	echo "Farewell my noble friend, this along trip may end with a reboot of your computer."
	sleep 3
	reboot now
else
	echo "You have declined our kindness, now you may manually do everything by yourself."
fi