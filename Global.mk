CC        := gcc
LD        := ld
AR        := ar
PYTHON    := python
CSCOPE    := cscope
RUST      := rustc

RSFLAGS   += -g --target=i386-unknown-linux-gnu -Z no-landing-pads
CFLAGS    += -fno-builtin -nostdinc -ansi -g3 -fno-stack-protector -m32 -march=i686 -fsigned-char -Iinclude
CFLAGS    += -Wall -Wredundant-decls -Wundef -Wpointer-arith -Wfloat-equal -Wnested-externs -Wvla -Winline -Wextra -Wno-unused-parameter -Wno-unused-function -Wno-unused-variable
ASFLAGS   := -D__ASSEMBLY__

###

include ../Config.mk
include ../CheckTools.mk

RSFLAGS   += $(foreach bool,$(COMPILE_CONFIG_BOOLS), \
             $(if $(findstring 1,$($(bool))),--cfg __$(bool)__))

CFLAGS    += $(foreach bool,$(COMPILE_CONFIG_BOOLS), \
             $(if $(findstring 1,$($(bool))),-D__$(bool)__=$(strip $($(bool)))))
CFLAGS    += $(foreach def,$(COMPILE_CONFIG_DEFS), \
             $(if $($(def)),-D__$(def)__=$(strip $($(def))),))
