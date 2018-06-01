PFUNIT = /home/qwerty/documents/fortran/pfunit
F90_VENDOR = Intel

include $(PFUNIT)/include/base.mk


FFLAGS += -cpp -I$(PFUNIT)/mod -DM=$(M) -O2 -std=f2008
LIBS = $(PFUNIT)/lib/libpfunit$(LIB_EXT)

PFS = $(wildcard *.pf)
OBJS = $(PFS:.pf=.o)

%.f90: %.pf
	$(PFUNIT)/bin/pFUnitParser.py $< $@

%.o: %.f90
	$(F90) $(FFLAGS) -c $<

test: testSuites.inc $(M).o $(OBJS)
	$(F90) -o $@_$(M) -I. -I$(PFUNIT)/mod -I$(PFUNIT)/include \
		$(PFUNIT)/include/driver.F90 \
		./*$(OBJ_EXT) $(LIBS) $(FFLAGS); \
	./test_$(M)

MODULES = mm0 mm1 mm2 mm3 mm4

measure:
	mkdir out; \
	for m in $(MODULES); do \
		$(call compile,$$m); \
		out/./main_$$m > times/$$m; \
	done; \
	rm -rf out

compile = ifort -funroll-loops $(1).f90 main.f90 -o out/main_$(1) -fpp -std08 -O2 -DM=$(1)
