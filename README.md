## Toronto Planning Applications

This is a project of [Civic Tech Toronto](http://civictech.ca/) looking into [City of Toronto development project applications](http://app.toronto.ca/DevelopmentApplications/mapSearchSetup.do?action=init).

#### Usage

We're currently using Python ~2.7 and MySQL.

To get the raw data for all 44 wards:

`pip install requests`

`python scraper.py`

To parse that data and insert it into a mysql db:

Create a mysql db.  Change the info in the `dbcfg-sample.py` for your installation and rename it to `dbcfg.py`.

`mysql -uUser -Ddbname < schema.sql`

`pip install MySQL-python`

`python parse.py`

Or run both those things together with

`python run.py`