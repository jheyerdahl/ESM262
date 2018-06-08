# Assignment  - Database - rubric 

## submisson & setup

- [? / 4]
    - 2: files present & correct
        - 2: all needed to run your `.Rmd`
        - 1: `.Rmd` but not input file(s)
    - 1: pathnames correct (no absolute, no `setwd()`)
    - 1: libraries correct

## create database

- [? / 1] Create a connection to a new `gaz.db` SQLite database.
- [? / 1] Copy the `gaz` tibble (from assignment 1) into the `gaz.db` database.

## analyze

- [? / 2] What is the most-frequently-occuring feature name?
    - 2: pure SQL; only the most frequent names
    - 1: top N most frequent names (or mixed SQL and `dplyr`)
- [? / 2] What is the least-frequently-occuring feature class?
  - 2: pure SQL; only the least frequent classes
  - 1: top N least frequent classes (or mixed SQL and `dplyr`)
- [? / 2] What is the approximate center point of each county?
    - 2: pure SQL
    - 1: mixed SQL and `dplyr`
- [? / 4] What are the fractions of the total number of features in each county that are natural? man-made?
    - 5: (extra credit) pure SQL without creating any additional tables
    - 4: pure SQL
    - 3: mixed SQL and `dplyr`
    - 1--2: messed up, but valiant effort...

