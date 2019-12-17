# Azurill
## Set your AWS environmental variables based off your stored profile name
Parameters:
-p : Named AWS profile as it appears in your credentials file, i.e. js-dpp1
-v : Named variable to retrieve from AWS profile for when you only want to set one variable (optional)

This script is useful for when you're running something that requires AWS authentication, you've logged in via aws-azure-login, but you're still getting access denied errors. Generally, the workaround for this that I've found is setting your AWS_PROFILE environmental variable, as well as the others listed in your credentials file. This basic script resolves that problem and sets them for you.

You will need to run it by running "source azurill.sh -p js-dpp1", otherwise the environmental variables will not be set correctly because they're lost to the subshell. I will seek a workaround at some point for this. As an alternative, you can write an alias that does this for you.

