CXX = g++

LIB_DIR		= 
DEPS_DIR	= .deps
SRC_DIR		= ..

LIBS		= $(SRC_DIR)/.a $(LIB_DIR)/.a
CXXFLAGS	= -std=c++11 -g -gdwarf-2 -I $(LIB_DIR) -I $(SRC_DIR)
LDFLAGS		= $(LIBS) -lgtest -lpthread

TARGETS		= runtest
SOURCES		= $(wildcard *.cpp)

all:

check: ${TARGETS}
	./runtest

%.o: %.cpp
	$(CXX) -o $@ -c $< $(CXXFLAGS)

-include $(patsubst %.cpp, $(DEPS_DIR)/%.d, $(SOURCES))

$(DEPS_DIR)/%.d: %.cpp
	@set -e;									\
	rm -f $@;									\
	mkdir -p $(DEPS_DIR);						\
	$(CXX) -MM $< $(CXXFLAGS) > $@;				\
	sed 's,\($*\)\.o[ :]*,\1.o $@: ,g' $@ -i;

runtest: $(SOURCES:.cpp=.o) $(LIBS)
	$(CXX) -o $@ $^ $(LDFLAGS)

clean:
	rm -rf $(TARGETS) *.o $(DEPS_DIR)

.PHONY: clean
