# DiwaliSMS.rb - Send lots of personalised SMS messages! ;)
# Sumeet Mulani
# <http://sumeet.info/>
# <mail@sumeet.info>
# October 27th, 2008.

require 'rubygems'
require 'serialport'

# params for serial port
# Modify port_str accordingly
port_str = "/dev/tty.Nokia6303-COM1"
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

# Read CSV file name from command line
fileName = ARGV[0]

f = File.open(fileName, 'r')
count = 0

f.readlines.each { |line|
        
        # avoid new lines in between
        if line != "\n"
                details = line.split(",")
                print details[0] + "|" + details[1]
        
            # Compose the SMS
            # Modify the body of 'message' accordingly
            message = "Hi, #{details[0]}. Wishing you a very happy and prosperous Diwali!\n-Sumeet Mulani."
            # Send it!
            sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
            sp.write("AT+CMGF=1" + "\n\r")
            number = details[1].chomp
            sleep(1)
            sp.write("AT+CMGS=\"#{number}\"" + "\n\r")
            puts "Sending message to " + number
            puts message
            sleep(1)
            sp.write(message + "\C-z")
            sp.close
            
        count = count+1
        sleep(5) 
        end
        
}

print "\nNumber of messages sent = #{count}.\n"

f.close
