import json

"""
This script pivots the list-data.json file to a dictionary with the following structure:
{   
    "column1": ["participant1", "participant2", "participant3"],
    "column2": ["participant1", "participant2", "participant3"],
    "column3": ["participant1", "participant2", "participant3"],
    ...
}

list-data.json is obtained from PEP, e.g. using the following command:

/app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json list -C Chrhypadis -P all-ppp -l -g --no-inline-data > list-data.json

"""

# Read the JSON file
file_path = './list-data.json'
with open(file_path, 'r') as file:
    data = json.load(file)

# Pivot the data
output = {}
for item in data:
    local_pseudonym = item['lp']
    ids = item['ids']
    for key, value in ids.items():
        if not key in output:
            output[key] = [local_pseudonym]
        else:
            output[key].append(local_pseudonym)

# Sort the keys
sorted_dict = {key: output[key] for key in sorted(output.keys())}

# Write the dictionary to a JSON file
with open('./list-data-out.json', 'w') as file:
    json.dump(sorted_dict, file, indent=2)
