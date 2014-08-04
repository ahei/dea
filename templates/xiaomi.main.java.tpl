/**
 * [Copyright]
 * @author ahei
 */

import java.io.PrintStream;

import org.apache.commons.cli.Options;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.PosixParser;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class (>>>FILE_SANS<<<) {
    private static final String PROGRAM_NAME = "(>>>FILE_SANS<<<)";

    @SuppressWarnings("static-access")
    public static void main(String[] args) {
        Options options = new Options();
        options.addOption("h", "help", false, "Print this usage information");
        options.addOption(OptionBuilder.withLongOpt("debug")
                          .withDescription("Set debug level, LEVEL can be: ALL, DEBUG, INFO, WARN, ERROR, FATAL, OFF, default is DEBUG.")
                          .hasOptionalArg()
                          .withArgName("LEVEL")
                          .create('d'));

        CommandLineParser parser = new PosixParser();
        CommandLine commandLine = null;
        try {
            commandLine = parser.parse(options, args);
        } catch (ParseException e) {
            exit("You provided wrong arguments, reason:`%s'!\n", e);
            return;
        }

        if (commandLine.hasOption("help")) {
            usage();
        }

        String[] leftArgs = commandLine.getArgs();
        int argsLen = leftArgs.length;
        (>>>POINT<<<)
    }

    private static void exit(String format, Object... args) {
        if (!format.isEmpty()) {
            System.err.printf(format, args);
        }
        usage(System.err);
        System.exit(1);
    }
    
    private static void usage() {
        usage(System.out);
    }
    
    private static void usage(PrintStream ps) {
        String help =
            "Usage: " + PROGRAM_NAME + " [OPTIONS]\n\n"
            + "This program .\n\n"
            + "Options:\n"
            + "    -d, --debug\n"
            + "        Set debug level, can be: ALL, DEBUG, INFO, WARN, ERROR, FATAL, OFF.\n"
            + "    -h, --help\n"
            + "        Output this help.\n\n"
            + "Report bugs to <ahei0802@gmail.com>.";

        ps.println(help);
    }
}
