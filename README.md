# Azurill
## Set your AWS environmental variables based off your stored profile name
Parameters:

-p : Named AWS profile as it appears in your credentials file, i.e. js-dpp1

-v : Named variable to retrieve from AWS profile for when you only want to set one variable (optional) [This is not yet supported - will be implemented if I ever find a need for it]


This script is useful for when you're running something that requires AWS authentication, you've logged in via aws-azure-login, but you're still getting access denied errors. Generally, the workaround for this that I've found is setting your AWS_PROFILE environmental variable, as well as the others listed in your credentials file. This basic script resolves that problem and sets them for you.

Currently you need to copy and paste the export commands that the script spits out into the terminal. I will seek a workaround at some point for this. However, as things stand it's still far better than trying to manually create and run these commands every single time you want to switch your AWS user.
