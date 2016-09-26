#!/bin/bash          
git add .
git commit -m "Heroku"
git push heroku master
heroku run pg:reset DATABASE_URL
heroku run rake db:migrate

