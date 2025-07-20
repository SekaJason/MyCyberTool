# Nom du compilateur et options
CC       := gcc
CFLAGS   := -Wall -Wextra -Iinclude

# Répertoires du projet
SRCDIR    := src
INCDIR    := include
OBJDIR    := obj
OUTPUTDIR := output

# Exécutable final
TARGET    := CyberToolbox

# Lister tous les .c et générer la liste des .o correspondants
SOURCES   := $(wildcard $(SRCDIR)/*.c)
OBJECTS   := $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SOURCES))

# Cibles "virtuelles"
.PHONY: all dirs clean

# Règle par défaut : créer les dossiers puis compiler
all: dirs $(TARGET)

# Crée les répertoires obj/ et output/ s’ils n’existent pas
dirs:
	@mkdir -p $(OBJDIR) $(OUTPUTDIR)

# Compilation individuelle : src/foo.c → obj/foo.o
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Edition des liens : tous les .o → CyberToolbox
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@
	@echo "Build terminé : $(TARGET)"

# Nettoyage des objets et de l’exécutable
clean:
	rm -rf $(OBJDIR) $(TARGET)
