import subprocess
BASE = input("URL of GitHub Link: ")

with open('nomos.txt', 'w') as outfile:
    subprocess.call(['rm -r temppy; git clone ' + BASE + ' temppy'], shell=True)
    subprocess.call(['dosocs2 oneshot temppy &> nomos.txt'], shell=True, stdout=outfile)

