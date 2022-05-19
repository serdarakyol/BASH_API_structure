#!/bin/bash

help()
{
    echo "Usage: api_structure [ -n | --api_name ]
               [ -h | --help  ]"
    exit 2
}

SHORT=n:,h
LONG=api_name:,help
OPTS=$(getopt -n api_structure --options $SHORT --longoptions $LONG -- "$@")

VALID_ARGUMENTS=$# # Returns the count of arguments that are in short or long options

if [ "$VALID_ARGUMENTS" -eq 0 ]; then
  help
fi

eval set -- "$OPTS"

while :
do
  case "$1" in
    -n | --api_name )
      api_name="$2"
      shift 2
      ;;

    -h | --help)
      help
      ;;
    --)
      shift;
      break
      ;;
    *)
      echo "Unexpected option: $1"
      help
      ;;
  esac
done

virtualenv venv
source venv/bin/activate

touch "README.md" "Dockerfile" "requirements.txt" ".env"

# fill .env
cat <<EOT >> .env
IS_DEBUG=False
API_KEY='serdarakyol55@outlook.com'
EOT

# fill README.md
cat <<EOT >> README.md
# $api_name api created by bash script
EOT

mkdir $api_name"_api"
cd $api_name"_api"
mkdir "api" "core" "data" "models" "services" "utils" "test"

# create main file
touch "main.py"

# api folder
mkdir "api/routes"
touch "api/routes/router.py" "api/routes/router_"$api_name".py"

# core folder
touch "core/config.py" "core/event_handler.py" "core/messages.py" "core/security.py"

# model folder
touch "models/model_"$api_name".py"

# service folder
touch "services/service_"$api_name".py"

# utils folder
touch "utils/utils.py"