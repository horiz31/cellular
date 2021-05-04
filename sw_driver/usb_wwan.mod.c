#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.arch = MODULE_ARCH_INIT,
};

#ifdef RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x3c98d0cd, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0xdefc71f5, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x1fdc7df2, __VMLINUX_SYMBOL_STR(_mcount) },
	{ 0x84bc974b, __VMLINUX_SYMBOL_STR(__arch_copy_from_user) },
	{ 0xddab50b8, __VMLINUX_SYMBOL_STR(usb_get_from_anchor) },
	{ 0x1d438fd, __VMLINUX_SYMBOL_STR(usb_kill_urb) },
	{ 0x5bc0ea64, __VMLINUX_SYMBOL_STR(usb_autopm_get_interface) },
	{ 0xe927e89f, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0xa87cf413, __VMLINUX_SYMBOL_STR(clear_bit) },
	{ 0x2a59ee64, __VMLINUX_SYMBOL_STR(usb_unlink_urb) },
	{ 0x526c3a6c, __VMLINUX_SYMBOL_STR(jiffies) },
	{ 0xab40cca9, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0xd3259d65, __VMLINUX_SYMBOL_STR(test_and_set_bit) },
	{ 0xa054af2e, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x97fdbab9, __VMLINUX_SYMBOL_STR(_raw_spin_unlock_irqrestore) },
	{ 0x68a22401, __VMLINUX_SYMBOL_STR(usb_autopm_put_interface_async) },
	{ 0x728b53e9, __VMLINUX_SYMBOL_STR(usb_control_msg) },
	{ 0x8fa8f791, __VMLINUX_SYMBOL_STR(_raw_spin_unlock_irq) },
	{ 0x50f93ee2, __VMLINUX_SYMBOL_STR(tty_insert_flip_string_fixed_flag) },
	{ 0x7e9d9fd3, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0xc6cbbc89, __VMLINUX_SYMBOL_STR(capable) },
	{ 0x14111e6b, __VMLINUX_SYMBOL_STR(usb_submit_urb) },
	{ 0xe318d7b9, __VMLINUX_SYMBOL_STR(usb_autopm_get_interface_async) },
	{ 0x93fca811, __VMLINUX_SYMBOL_STR(__get_free_pages) },
	{ 0xb35dea8f, __VMLINUX_SYMBOL_STR(__arch_copy_to_user) },
	{ 0x20ffa7f6, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irq) },
	{ 0x8dd1990a, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_trace) },
	{ 0x256b5e21, __VMLINUX_SYMBOL_STR(__dynamic_dev_dbg) },
	{ 0x96220280, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irqsave) },
	{ 0x4302d0eb, __VMLINUX_SYMBOL_STR(free_pages) },
	{ 0x433e2e1f, __VMLINUX_SYMBOL_STR(usb_autopm_get_interface_no_resume) },
	{ 0x409873e3, __VMLINUX_SYMBOL_STR(tty_termios_baud_rate) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x4829a47e, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0x7bc62d12, __VMLINUX_SYMBOL_STR(tty_flip_buffer_push) },
	{ 0x1a1475a, __VMLINUX_SYMBOL_STR(usb_serial_port_softint) },
	{ 0xf4d4127b, __VMLINUX_SYMBOL_STR(usb_free_urb) },
	{ 0xa2b3e680, __VMLINUX_SYMBOL_STR(usb_autopm_put_interface) },
	{ 0x7dc2ff93, __VMLINUX_SYMBOL_STR(usb_anchor_urb) },
	{ 0xc985ecc6, __VMLINUX_SYMBOL_STR(usb_alloc_urb) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "0E02DF747127CF35C5BD38C");
