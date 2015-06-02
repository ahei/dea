CXX = g++

DEPS_DIR	= .deps
LIB_DIR		= 

INCLUDE		= 
CXXFLAGS	= -std=c++11 -g -gdwarf-2 -O2 -Wall $(INCLUDE)
LDFLAGS		= 

TARGETS = 
SOURCES = 

all: ${TARGETS}

%.o: %.cpp
	$(CXX) -o $@ -c $< $(CXXFLAGS)

-include $(patsubst %.cpp, $(DEPS_DIR)/%.d, $(SOURCES))

$(DEPS_DIR)/%.d: %.cpp
	@set -e;									\
	rm -f $@;									\
	mkdir -p $(DEPS_DIR);						\
	$(CXX) -MM $< $(CXXFLAGS) > $@;				\
	sed 's,\($*\)\.o[ :]*,\1.o $@: ,g' $@ -i;

clean:
	rm -rf $(TARGETS) *.o $(DEPS_DIR)

.PHONY: clean
