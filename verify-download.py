import os
import json

"""
This script verifies that the data downloaded from PEP is complete, based on the list-data-out.json file
that is generated by running PEP CLI list and pivot-list-data.py (see pivot-list-data.py for more details).
"""

DATADIR = '/projects/0/einf2658/PPP'

file_path = f'{DATADIR}/list-data-out.json'
with open(file_path, 'r') as file:
    data = json.load(file)

def check_dir(column, participant):
    file_count = len(os.listdir(f'{DATADIR}/{column}/{participant}'))
    if file_count == 0:
        print(f'Missing data, but folder exists: {column} / {participant}')
    if file_count == 2:
        print(f'Multiple files for {column} / {participant}')

for column, participants in data.items():
    participant_dirs = os.listdir(f'{DATADIR}/{column}')
    if '.pepData' in participant_dirs: participant_dirs.remove('.pepData')
    if 'pepData.specification.json' in participant_dirs: participant_dirs.remove('pepData.specification.json')
    for participant in participants:
        participant_new = f'POMU{participant[0:16]}' # New pseudonym format
        if participant in participant_dirs:
            check_dir(column, participant)
            participant_dirs.remove(participant)
        elif participant_new in participant_dirs:
            check_dir(column, participant_new)
            participant_dirs.remove(participant_new)
        else:
            print(f'Missing on file system: {column} / {participant}')

    for remaining_participant in participant_dirs:
        print(f'Missing in meta data: {column} / {remaining_participant}')
