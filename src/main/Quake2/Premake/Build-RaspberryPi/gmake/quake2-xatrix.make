# GNU Make project makefile autogenerated by Premake
ifndef config
  config=release
endif

ifndef verbose
  SILENT = @
endif

CC = gcc
CXX = g++
AR = ar

ifndef RESCOMP
  ifdef WINDRES
    RESCOMP = $(WINDRES)
  else
    RESCOMP = windres
  endif
endif

ifeq ($(config),release)
  OBJDIR     = ../../../Output/Targets/RaspberryPi/Release/obj/quake2-xatrix
  TARGETDIR  = ../../../Output/Targets/RaspberryPi/Release/bin/xatrix
  TARGET     = $(TARGETDIR)/game.so
  DEFINES   += -D__RASPBERRY_PI__ -DARCH=\"i386\" -DOSTYPE=\"Linux\" -DNOUNCRYPT -DZIP
  INCLUDES  += -I/opt/vc/include -I../../../../../Engine/External/include -I../../../Sources -I../../../Sources/xatrix/src
  ALL_CPPFLAGS  += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS    += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -ffast-math -Wall -Wextra -O2 -fPIC -std=gnu99 -Wno-unused-function -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-switch -Wno-missing-field-initializers -fPIC -fvisibility=hidden
  ALL_CXXFLAGS  += $(CXXFLAGS) $(ALL_CFLAGS)
  ALL_RESFLAGS  += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS   += $(LDFLAGS) -L../../../Output/Targets/RaspberryPi/Release/lib -s -shared
  LDDEPS    +=
  LIBS      += $(LDDEPS)
  LINKCMD    = $(CC) -o $(TARGET) $(OBJECTS) $(RESOURCES) $(ARCH) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

ifeq ($(config),debug)
  OBJDIR     = ../../../Output/Targets/RaspberryPi/Debug/obj/quake2-xatrix
  TARGETDIR  = ../../../Output/Targets/RaspberryPi/Debug/bin/xatrix
  TARGET     = $(TARGETDIR)/game.so
  DEFINES   += -D__RASPBERRY_PI__ -DARCH=\"i386\" -DOSTYPE=\"Linux\" -DNOUNCRYPT -DZIP
  INCLUDES  += -I/opt/vc/include -I../../../../../Engine/External/include -I../../../Sources -I../../../Sources/xatrix/src
  ALL_CPPFLAGS  += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS    += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -ffast-math -Wall -Wextra -g -fPIC -std=gnu99 -Wno-unused-function -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-switch -Wno-missing-field-initializers -fPIC -fvisibility=hidden
  ALL_CXXFLAGS  += $(CXXFLAGS) $(ALL_CFLAGS)
  ALL_RESFLAGS  += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS   += $(LDFLAGS) -L../../../Output/Targets/RaspberryPi/Debug/lib -shared
  LDDEPS    +=
  LIBS      += $(LDDEPS)
  LINKCMD    = $(CC) -o $(TARGET) $(OBJECTS) $(RESOURCES) $(ARCH) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

OBJECTS := \
	$(OBJDIR)/flash.o \
	$(OBJDIR)/rand.o \
	$(OBJDIR)/shared.o \
	$(OBJDIR)/g_ai.o \
	$(OBJDIR)/g_chase.o \
	$(OBJDIR)/g_cmds.o \
	$(OBJDIR)/g_combat.o \
	$(OBJDIR)/g_func.o \
	$(OBJDIR)/g_items.o \
	$(OBJDIR)/g_main.o \
	$(OBJDIR)/g_misc.o \
	$(OBJDIR)/g_monster.o \
	$(OBJDIR)/g_phys.o \
	$(OBJDIR)/g_spawn.o \
	$(OBJDIR)/g_svcmds.o \
	$(OBJDIR)/g_target.o \
	$(OBJDIR)/g_trigger.o \
	$(OBJDIR)/g_turret.o \
	$(OBJDIR)/g_utils.o \
	$(OBJDIR)/g_weapon.o \
	$(OBJDIR)/berserker.o \
	$(OBJDIR)/boss2.o \
	$(OBJDIR)/boss3.o \
	$(OBJDIR)/boss31.o \
	$(OBJDIR)/boss32.o \
	$(OBJDIR)/boss5.o \
	$(OBJDIR)/brain.o \
	$(OBJDIR)/chick.o \
	$(OBJDIR)/fixbot.o \
	$(OBJDIR)/flipper.o \
	$(OBJDIR)/float.o \
	$(OBJDIR)/flyer.o \
	$(OBJDIR)/gekk.o \
	$(OBJDIR)/gladb.o \
	$(OBJDIR)/gladiator.o \
	$(OBJDIR)/gunner.o \
	$(OBJDIR)/hover.o \
	$(OBJDIR)/infantry.o \
	$(OBJDIR)/insane.o \
	$(OBJDIR)/medic.o \
	$(OBJDIR)/move.o \
	$(OBJDIR)/mutant.o \
	$(OBJDIR)/parasite.o \
	$(OBJDIR)/soldier.o \
	$(OBJDIR)/supertank.o \
	$(OBJDIR)/tank.o \
	$(OBJDIR)/client.o \
	$(OBJDIR)/hud.o \
	$(OBJDIR)/trail.o \
	$(OBJDIR)/view.o \
	$(OBJDIR)/weapon.o \
	$(OBJDIR)/savegame.o \

RESOURCES := \

SHELLTYPE := msdos
ifeq (,$(ComSpec)$(COMSPEC))
  SHELLTYPE := posix
endif
ifeq (/bin,$(findstring /bin,$(SHELL)))
  SHELLTYPE := posix
endif

.PHONY: clean prebuild prelink

all: $(TARGETDIR) $(OBJDIR) prebuild prelink $(TARGET)
	@:

$(TARGET): $(GCH) $(OBJECTS) $(LDDEPS) $(RESOURCES)
	@echo Linking quake2-xatrix
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning quake2-xatrix
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(GCH): $(PCH)
	@echo $(notdir $<)
	$(SILENT) $(CC) -x c-header $(ALL_CFLAGS) -MMD -MP $(DEFINES) $(INCLUDES) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
endif

$(OBJDIR)/flash.o: ../../../Sources/common/shared/flash.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/rand.o: ../../../Sources/common/shared/rand.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/shared.o: ../../../Sources/common/shared/shared.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_ai.o: ../../../Sources/xatrix/src/g_ai.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_chase.o: ../../../Sources/xatrix/src/g_chase.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_cmds.o: ../../../Sources/xatrix/src/g_cmds.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_combat.o: ../../../Sources/xatrix/src/g_combat.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_func.o: ../../../Sources/xatrix/src/g_func.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_items.o: ../../../Sources/xatrix/src/g_items.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_main.o: ../../../Sources/xatrix/src/g_main.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_misc.o: ../../../Sources/xatrix/src/g_misc.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_monster.o: ../../../Sources/xatrix/src/g_monster.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_phys.o: ../../../Sources/xatrix/src/g_phys.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_spawn.o: ../../../Sources/xatrix/src/g_spawn.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_svcmds.o: ../../../Sources/xatrix/src/g_svcmds.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_target.o: ../../../Sources/xatrix/src/g_target.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_trigger.o: ../../../Sources/xatrix/src/g_trigger.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_turret.o: ../../../Sources/xatrix/src/g_turret.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_utils.o: ../../../Sources/xatrix/src/g_utils.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/g_weapon.o: ../../../Sources/xatrix/src/g_weapon.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/berserker.o: ../../../Sources/xatrix/src/monster/berserker/berserker.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/boss2.o: ../../../Sources/xatrix/src/monster/boss2/boss2.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/boss3.o: ../../../Sources/xatrix/src/monster/boss3/boss3.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/boss31.o: ../../../Sources/xatrix/src/monster/boss3/boss31.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/boss32.o: ../../../Sources/xatrix/src/monster/boss3/boss32.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/boss5.o: ../../../Sources/xatrix/src/monster/boss5/boss5.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/brain.o: ../../../Sources/xatrix/src/monster/brain/brain.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/chick.o: ../../../Sources/xatrix/src/monster/chick/chick.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/fixbot.o: ../../../Sources/xatrix/src/monster/fixbot/fixbot.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/flipper.o: ../../../Sources/xatrix/src/monster/flipper/flipper.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/float.o: ../../../Sources/xatrix/src/monster/float/float.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/flyer.o: ../../../Sources/xatrix/src/monster/flyer/flyer.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/gekk.o: ../../../Sources/xatrix/src/monster/gekk/gekk.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/gladb.o: ../../../Sources/xatrix/src/monster/gladiator/gladb.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/gladiator.o: ../../../Sources/xatrix/src/monster/gladiator/gladiator.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/gunner.o: ../../../Sources/xatrix/src/monster/gunner/gunner.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/hover.o: ../../../Sources/xatrix/src/monster/hover/hover.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/infantry.o: ../../../Sources/xatrix/src/monster/infantry/infantry.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/insane.o: ../../../Sources/xatrix/src/monster/insane/insane.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/medic.o: ../../../Sources/xatrix/src/monster/medic/medic.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/move.o: ../../../Sources/xatrix/src/monster/misc/move.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/mutant.o: ../../../Sources/xatrix/src/monster/mutant/mutant.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/parasite.o: ../../../Sources/xatrix/src/monster/parasite/parasite.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/soldier.o: ../../../Sources/xatrix/src/monster/soldier/soldier.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/supertank.o: ../../../Sources/xatrix/src/monster/supertank/supertank.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/tank.o: ../../../Sources/xatrix/src/monster/tank/tank.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/client.o: ../../../Sources/xatrix/src/player/client.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/hud.o: ../../../Sources/xatrix/src/player/hud.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/trail.o: ../../../Sources/xatrix/src/player/trail.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/view.o: ../../../Sources/xatrix/src/player/view.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/weapon.o: ../../../Sources/xatrix/src/player/weapon.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/savegame.o: ../../../Sources/xatrix/src/savegame/savegame.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF $(@:%.o=%.d) -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
endif
