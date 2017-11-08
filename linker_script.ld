/* Linker script cofigures memory regions */

SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys)

MEMORY
{
	FLASH (rx) : ORIGIN = 0x0, LENGTH = 0x80000
	RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 0x20028000
}