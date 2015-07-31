/* -*- C++ -*- */

// Time-stamp: <2015-07-31 15:05:07 Friday by ahei>

/**
 * @file (>>>FILE<<<)
 * @author ahei
 */

#include <stdlib.h>
#include <getopt.h>
#include <iostream>

using namespace std;

static void usage(int code = 1);
static void shift(int & argc, char ** & argv, int offset);

int main(int argc, char * argv[])
{
    int opt = 0;
    int longindex = 0;
    const char optstring[] = ":h";
    const option longopts[] =
        {{"help", no_argument, NULL, 'h'},
         {NULL  , no_argument, NULL, 0}};

    std::string arg;

    while ((opt = getopt_long_only(argc, argv, optstring, longopts, &longindex)) != -1)
    {
        switch(opt)
        {
        case 'h':
            usage(0);
            break;

        case ':':
            arg = argv[optind-1];
            std::cerr << "Option `" << arg << "' need argument.\n";
            usage();
            break;

        case '?':
            std::cerr << "Invalid option `" << argv[optind-1] << "'.\n";
            usage();
            break;
        }
    }

    shift(argc, argv, optind - 1);

    // other non-option arguments
    for (int i = 1; i < argc; i++)
    {
        std::cout << argv[i] << endl;
    }

    return 0;
}

void usage(int code /* = 1 */)
{
    std::ostream * os = NULL;

    if (code != 0)
    {
        os = &std::cerr;
    }
    else
    {
        os = &std::cout;
    }

    *os << "usage: "
        << PROGRAM_NAME << " [OPTIONS]\n" << endl;

    *os << "This program .\n" << endl;

    *os << "Options:" << endl;
    *os << "\t-h, --help" << endl;
    *os << "\t\tOutput this help." << endl;
    *os << endl;

    *os << "Version: " PROGRAM_VERSION << endl;
    *os << "Last Make: " << __DATE__ << " " << __TIME__ << "." << endl;

    exit(code);
}

void shift(int & argc, char ** & argv, int offset)
{
    argv[offset] = argv[0];
    argv += offset;
    argc -= offset;
}
