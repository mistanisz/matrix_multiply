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
		./*$(OBJ_EXT) $(LIBS) $(FFLAGS)

cmain: 
	ifort -funroll-loops $(M).f90 main.f90 -o main_$(M).f90 -fpp -std08 -O2 
