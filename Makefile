default: all
.PHONY: run dbg all clean clean-all

GTEST_DIR = ./gtest-1.7.0

EXE=exe
#CPPFLAGS?=
CXXFLAGS=-g -Wall -Wextra
OBJS= SimpleLock_test.o SimpleLock.o 

run: $(EXE)
	./$(<)
dbg: $(EXE)
	gdb ./$(<)
all: $(EXE)

$(EXE): $(OBJS) gtest.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -pthread $(^) -o $(@)
%.o: %.cpp %.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(<) -o $(@)
%_test.o: %_test.cpp 
	$(CXX) -I$(GTEST_DIR)/include $(CPPFLAGS) $(CXXFLAGS) -c $(<) -o $(@)
clean:
	rm -f $(EXE) $(OBJS)


# build gtest
clean-all: clean
	rm -rf gtest*a gtest*o doc/
#GTEST_SRCS_ = $(GTEST_DIR)/include/gtest/*.h \
#							$(GTEST_DIR)/include/gtest/internal/*.h \
#							$(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h
#gtest-all.o : $(GTEST_SRCS_)
#	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR)/include -I$(GTEST_DIR) $(CXXFLAGS) -c \
#            $(GTEST_DIR)/src/gtest-all.cc
#
#gtest_main.o : $(GTEST_SRCS_)
#	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR)/include -I$(GTEST_DIR) $(CXXFLAGS) -c \
#            $(GTEST_DIR)/src/gtest_main.cc
#
#gtest.a : gtest-all.o
#	$(AR) $(ARFLAGS) $(@) $(^)
#
#gtest_main.a : gtest-all.o gtest_main.o
#	$(AR) $(ARFLAGS) $(@) $(^)
