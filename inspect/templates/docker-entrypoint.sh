#!/bin/bash
#
# Configure and start rhizo-server
#

if [ ! -f "/var/lib/sqlite/rhizo.db" ]; then

    echo "INFO Configuring rhizo..."
    python prep_config.py

    echo "DISCLAIMER = 'This is pre-release code; the API and database structure will probably change.'" >> settings/config.py

    sed -i "s/SQLALCHEMY_DATABASE_URI = 'sqlite:\/\/\/rhizo.db'/SQLALCHEMY_DATABASE_URI = 'sqlite:\/\/\/\/var\/lib\/sqlite\/rhizo.db'/g" settings/config.py

    echo "INFO Configuring flow-server extension..."
    
    sed -i "s/EXTENSIONS = \[\]/EXTENSIONS = \['flow-server'\]/g" settings/config.py

    echo "INFO Creating db..."
    python run.py --init-db
    python run.py --create-admin admin@test.com:password

fi

echo "INFO Starting rhizo-server..."

python run.py -s

