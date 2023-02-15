#!/bin/bash
echo "Running >>>>>>>>>>>>>>>>>>>>>>>> scripts/migrate_db.sh <<<<<<<<<<<<<<<<<<<<<<<<"
bundle exec rails db:migrate:reset db:seed