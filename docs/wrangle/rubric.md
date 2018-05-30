# Assignment - Data Wrangling - rubric

## submisson & setup

- **4 pts:**
    - 2: files present & correct
        - 2: all
        - 1: some
    - 1: pathnames correct (no absolute, no `setwd()`)
    - 1: libraries correct

## import & tidy

- Read the gazetteer data as-is (all columns; no type conversion) into a `gaz_raw` tibble (122,308 x 20).
    - **2 pts:**
      - 2: used `read_delim`
      - 1: something else that more-or-less worked

- Copy only the [following](https://ucsb-bren.github.io/ESM262/wrangle/asst_wrangle.html) columns into a `gaz` tibble (you can rename them if you like) (122,308 x 13).
  - **1 pt**

- Convert the `gaz` columns to the appropriate type. Convert any placeholders for unknown data to `NA`
  - **4 pts:**
    - non-character/factor types:
      - 2: all correct
      - 1: some correct
    - NA
      - 2: all correct
      - 1: some correct

- Delete from `gaz` rows where: (121,222 rows x 13)
  - **2 pts:**
    - 1: the **primary** latitude or longitude are unknown
    - 1: the feature is not in California

- Write the `gaz` tibble to a CSV file (using `"|"` as a delimiter).
    - **2 pts:**
      - 2: correct
      - 1: complete but incorrect (non-tibble, wrong delim, etc.)

## analyze

- What is the most-frequently-occuring feature name?
    - **1 pt**
- What is the least-frequently-occuring feature class?
  - **1 pt**
- What is the approximate center point of each county?
  - **2 pts:**
    - 2: correct
    - 1: ok except for mean instead of midpt
- What are the fractions of the total number of features in each county that are natural? man-made?
  - **5 pts:**
    - 1: categories specified (mostly) correctly
    - 1: fractions by county (vs single pair of fractions for entire state)
    - 1: used a join
    - 1: got something close to the right answer
    - 1: reasonably easy to follow what you did (e.g., no useless code)
