# Azurill
## Set your AWS environmental variables based off your stored profile name
Parameters:

-p : Named AWS profile as it appears in your credentials file, i.e. js-dpp1

-v : Named variable to retrieve from AWS profile for when you only want to set one variable (optional) [This is not yet supported - will be implemented if I ever find a need for it]


This script is useful for when you're running something that requires AWS authentication, you've logged in via aws-azure-login, but you're still getting access denied errors. Generally, the workaround for this that I've found is setting your AWS_PROFILE environmental variable, as well as the others listed in your credentials file. This basic script resolves that problem and sets them for you.

To run the script properly, you need to use the source command. This will set up the necessary environmental variables for you in your current shell. Executing the script will leave you empty handed.
