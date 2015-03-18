# prototype
Template Project for Rapid Prototype Creation - Rails, Angular.js, Cucumber, CoffeeScript, Sass

# run things
(It is often smoothest to prefix all of these with `bundle exec`)

`cucumber` to run through-the-browser full stack acceptance tests

`rspec`    to run rails API specs (model & controller tests)

`teaspoon` to run angular javascript unit tests

`rake bower:install` to install bower dependencies (or `bower install`)

# credit where credit is due
This application is based on the [angular rails book](http://angular-rails.com/). There are a couple of tweaks, like using cucumber, but you can get up to speed on the what and why the sample code is doing by reviewing the great tutorial there.


# Generating sample data

Placeholder data services can be run to import csv files from `rails console`
* `> FdicSdiService.read_definitions` and `> FdicSdiService.read_files` (latter takes a really long time)
* `> SocialSecurityBeneficiaryService.read_workbook`
* `> %x(python ./db/migrate/import_irs_agi.py)`