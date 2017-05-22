/* -*- C++ -*- */

// Time-stamp: <2016-06-27 11:30:08 Monday by ahei>

/**
 * @file (>>>FILE<<<)
 * @author ahei
 */

#include <stdlib.h>
#include <getopt.h>
#include <iostream>

#include <log4cxx/logger.h>

using namespace std;
using namespace log4cxx;

static void usage(char * argv[], int code = 1);

LoggerPtr logger = Logger::getLogger("");

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

    // other non-option arguments
    for (int i = optind; i < argc; i++)
    {
        std::cout << argv[i] << std::endl;
    }

    return 0;
}

void usage(char * argv[], int code /* = 1 */)
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
        << argv[0] << " [OPTIONS]\n" << std::endl;

    *os << "This program .\n" << std::endl;

    *os << "Options:" << std::endl;
    *os << "\t-h, --help" << std::endl;
    *os << "\t\tOutput this help." << std::endl;
    *os << std::endl;

    *os << "Last Make: " << __DATE__ << " " << __TIME__ << "." << std::endl;

    exit(code);
}
