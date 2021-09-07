# README

This small app demostrates the use of `ActionController::Live` Rails controller concern to slowly generate a CSV file without triggering the Heroku's timeout limits of 30'' responses.

### Notes

* Ruby version: should be ok with 2.x

* Tested with rails 6.x and 7 edge

* No Database required

### Usage

Use the browser and follow the link to start the CSV generation that takes more than 30'' to finish or use a CLI tool like curl to see line by line the generated output:

`curl -i http://localhost:3000/exporter.csv`
