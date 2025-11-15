# Projeto
PROJECT = piscaled
SOURCES = $(PROJECT).v
BOARD = tangnano1k   # Board para openFPGALoader

# Dispositivo e família Gowin
DEVICE = GW1NZ-1
FAMILY = GW1NZ
PINS = tangnano.cst

# Ferramentas
YOSYS = yosys
NEXTPNR = nextpnr-himbaechel
GOWIN_PACK = gowin_pack
OPENFPGALOADER = openFPGALoader

# Flags
YOSYS_FLAGS = -p "synth_gowin -top $(PROJECT) -json $(PROJECT).json" $(SOURCES)
NEXTPNR_FLAGS = --device $(DEVICE) --json $(PROJECT).json --cst $(PINS) --write $(PROJECT)_pnr.json --freq 27
PACK_FLAGS = -d $(DEVICE) -o $(PROJECT).fs $(PROJECT)_pnr.json
LOADER_FLAGS = -b $(BOARD) $(PROJECT).fs

# Regras
all: $(PROJECT).fs

$(PROJECT).json: $(SOURCES)
	$(YOSYS) $(YOSYS_FLAGS)

$(PROJECT)_pnr.json: $(PROJECT).json $(PINS)
	$(NEXTPNR) $(NEXTPNR_FLAGS)

$(PROJECT).fs: $(PROJECT)_pnr.json
	$(GOWIN_PACK) $(PACK_FLAGS)

load: $(PROJECT).fs
	$(OPENFPGALOADER) $(LOADER_FLAGS)

clean:
	rm -f *.json *.fs *.log

.PHONY: all load clean
