PFUNIT = /home/qwerty/documents/fortran/pfunit
F90_VENDOR = Intel

include $(PFUNIT)/include/base.mk

FFLAGS += -cpp -I$(PFUNIT)/mod
LIBS = $(PFUNIT)/lib/libpfunit$(LIB_EXT)

PFS = $(wildcard *.pf)
OBJS = $(PFS:.pf=.o)

%.f90: %.pf
	$(PFUNIT)/bin/pFUnitParser.py $< $@

%.o: %.f90
	$(F90) $(FFLAGS) -c $<

test: testSuites.inc mm0.o $(OBJS)
	$(F90) -o $@ -I. -I$(PFUNIT)/mod -I$(PFUNIT)/include \
		$(PFUNIT)/include/driver.F90 \
		./*$(OBJ_EXT) $(LIBS) $(FFLAGS)
