#!/bin/bash

function help(){
    echo "Usage: 
    bash create_api_structure.sh [ -n | --api_name ]
                                [ -p ] --path (optional)
                                [ -h | --help  ]"
    exit 1
}

function fill_env() {
cat <<EOT >> $path/.env
IS_DEBUG=False
API_KEY='serdarakyol55@outlook.com'
EOT
}

function fill_readme(){
cat <<EOT >> $path/README.md
# $api_name api created by bash script
EOT
}

function current_folder_create_api(){
    virtualenv venv

    touch "README.md" "Dockerfile" "requirements.txt" ".env"

    fill_env

    fill_readme

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
}   

function path_create_api(){
    # create virtual env
    virtualenv $path/venv

    touch "$path/.env" "$path/Dockerfile" "$path/README.md" "$path/requirements.txt" 

    fill_env    

    fill_readme
        
    mkdir $path$api_name"_api"
    cd $path$api_name"_api"
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
}

while getopts ":n:p:" o; do
    case "${o}" in
        n)
            api_name=${OPTARG}
            ;;
        p)
            path=${OPTARG}
            ;;
        *)
            help
            ;;
    esac
done
shift $((OPTIND-1))


# if lenght of api_name is zero 
if [ -z $api_name ]; then
    help
else
    # if lenght of path is greater than zero
    if [ -d "$path" ]; then
        path_create_api $path $api_name
    else
        echo "Directory is NOT exist or specified. Do you want to create the structure in current folder? $(pwd)"
        current_path = $(pwd)
        select yn in "Yes" "No"; do
            case $yn in
                Yes )
                    current_folder_create_api $api_name
                    break;;
                No )
                    echo "Existing script..."; 
                    exit;;
            esac
        done
    fi
fi
