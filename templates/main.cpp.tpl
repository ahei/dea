/* -*- C++ -*- */

// Time-stamp: <2016-07-14 17:09:01 Thursday by ahei>

/**
 * @file (>>>FILE<<<)
 * @author ahei
 */

#include <stdlib.h>
#include <getopt.h>
#include <iostream>

using namespace std;

static void usage(char * argv[], int code = 1);
static void shift(int & argc, char ** & argv, int offset);

int main(int argc, char * argv[]) {
    int opt = 0;
    int longindex = 0;
    const char optstring[] = ":h";
    const option longopts[] =
        {{"help", no_argument, NULL, 'h'},
         {NULL  , no_argument, NULL, 0}};

    std::string arg;

    while ((opt = getopt_long_only(argc, argv, optstring, longopts, &longindex)) != -1) {
        switch(opt) {
        case 'h':
            usage(argv, 0);
            break;

        case ':':
            arg = argv[optind-1];
            std::cerr << "Option `" << arg << "' need argument.\n";
            usage(argv);
            break;

        case '?':
            std::cerr << "Invalid option `" << argv[optind-1] << "'.\n";
            usage(argv);
            break;
        }
    }

    shift(argc, argv, optind - 1);

    // other non-option arguments
    for (int i = 1; i < argc; i++) {
        std::cout << argv[i] << endl;
    }

    return 0;
}

void usage(char * argv[], int code /* = 1 */) {
    std::ostream * os = NULL;

    if (code != 0) {
        os = &std::cerr;
    } else {
        os = &std::cout;
    }

    *os << "usage: "
        << argv[0] << " [OPTIONS]\n" << endl;

    *os << "This program .\n" << endl;

    *os << "Options:" << endl;
    *os << "\t-h, --help" << endl;
    *os << "\t\tOutput this help." << endl;
    *os << endl;

    *os << "Version: " PROGRAM_VERSION << endl;
    *os << "Last Make: " << __DATE__ << " " << __TIME__ << "." << endl;

    exit(code);
}

void shift(int & argc, char ** & argv, int offset) {
    argv[offset] = argv[0];
    argv += offset;
    argc -= offset;
}
