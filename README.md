# Project_3 Civil Services and Crime</br>---</br></br>
Sarah Brittle, Harriet Orleans, Rebecca Skinner</br>---</br></br>
##Project Summary</br>---</br>
This ETL project brought together several databases for a one stop look at how the availability of civil services within a county relates to the amount of crime. The services chosen were libraries and schools. The crime data if from the FBI and covers both violent crimes and assult crimes. The idea behind this project was to create an easy to read and access database from which many kinds of analysis can be achieved.</br></br></br>

### Aplications</br></br>
-Pandas</br>
-Glob</br>
-LFS</br></br>

### Data Sources</br></br>
The resources decided on for this project all orginate from the US government. These institutions are interested in collecting facts and data as it serves the US population. As such, it is the belief of these group members that the data collected is as subjective as possible. In addition, these government agencies release their information to the public for stastical analysis. An important consideration for the FBI data is that no singular data source can ever be considered an exhaustive source of all crime. The FBI is limited in what local agencies submit to them, and local agencies are limited in what gets reported to them.
1.Crime data</br>
Clarke, Philippa, Melendez, Robert, and Chenoweth, Megan. National Neighborhood Data Archive (NaNDA): Crimes by County, United States, 2002-2014. Ann Arbor, MI: Inter-university Consortium for Political and Social Research [distributor], 2019-12-02. https://doi.org/10.3886/E115006V1 </br>
This is the source for the already cleaned FBI file with the FIPS code added. The FBI website has data download, however this one was already transformed into a CSV file for us to use more conveniently.</br></br>
2. School data</br>
https://nces.ed.gov/ccd/elsi/tableGenerator.aspx</br>
http://nces.ed.gov/ccd/elsi/</br>
The school data comes from the National Center for Education Statistics. Linked above the table generater, which can be used to pull as much or as little data as is wanted. Our data rows were organized by School and included the 50 states + outlying areas.</br></br>
3. Library data</br>
https://www.imls.gov/research-evaluation/data-collection/public-libraries-survey</br>
The library data is from the Institute of Museum and Library Services. Each year will have to be downloaded individually and then merged.
</br></br></br>

### Other Resources</br></br>
1. https://www.nber.org/research/data/ssa-federal-information-processing-series-fips-state-and-county-crosswalk</br>
The FBI data includes FIPS code. The FIPS code is a five digit code representing the state and county. The first two digits corresond to state, and the last three digits correspond to county. This crosswalk provided by the National Bureau of Economic Research can be used to get the state and county names in the data.</br>
2. https://www.imls.gov/sites/default/files/legacy/assets/1/AssetManager/PLS_Defs_FY03.pdf</br>
The is where to find the documentation guide for the library data.
3. https://git-lfs.com/</br>
These datasets are very large. It might be necessarry to dowload the LFS add-on to load these large file to GitHub.</br></br></br>

# Extract, Transform, and Load</br>---</br></br>
## Extract</br></br>
The datasets all came from the sources listed above. All members of our group used pandas and python to load the data from CSVs.</br></br>
## Transform</br></br>
1. Crime Data</br>Before begining the coding part, the CSV needs to be opened and the first four rows deleted so the CSV and headers can be more easily loaded and read.</br>The code sheet is loaded in and transformed first. After loading in the code sheet, the data is first filtered by the 'Summary Level' column to equal 40. This is because the summary level indicates which municipal level the data has been recorded for. Level 40 is the state level. This new variable will be used as the state code sheet when merging later.</br>The crime data is loaded in once the two code dataframes have been assigned a variable. For legibility, the columns which are being kept are renamed, and the unneeded columns are dropped.</br>The first merge needs to be between the state code dataframe and the crime dataframe. This will result in a column with a state assigned for each row. The second merge is between the county code dataframe and the recently merged state/crime dataframe. This will result in a new county column with a county assigned to each row of data.</br>After merging, the other summary levels need to be dropped so that the dataframe only contains states and counties. The overlapping columns can be dropped and the index should be named for ease of loading into PostGres.</br></br>
2. School Data</br>The school data was first cleaned by dropping any duplicates and NAs. The data is obtained with a "†" symbol marking NA data, so for ease of reading the symbol was turned into an NA. (It is important to drop NA before replacing the "†" symbol, otherwise most of the data will be dropped if the drop is performed after).</br>The data as it originally comes is not well organized and not conducive to the data structure in crime and library data, so the data must be melted using pd.melt. This brings the multiple columns for each subject for each year and stacks them in one column and the data in another column (like unpivot in excel). The school name and state columns should be used as the index for this function.</br>The new stacked column is then split at the year to seperate the year into a seperate column and the data subject into its own column. The year column needs some more splitting before it is only a four digit year in each row. The unnessecary columns are dropped. </br>The remaining columns are reorganized. It is important for the School Name, state, and year columns to be on the left of the dataframe. This is because in the pivot those three columns will act as the index, and the subject and data columns will be 'unstacked' so to say so that now the data is spread down a column instead of across the dataframe as it did in its original form. After some cleaning, this data is now conducive to the crime and library data and can be saved for PostGresl.</br></br>
3. Library data</br>Each years worth of data must be loaded and encoded using UTF-8.</br>Glob library is used to read and print all the files. Once all of the CSVs are read in, glob can again be used in a for loop to add a year column to the dataframe by extracting the year from the file name.</br>The data frames are then concacted using pd.concat. After concactination, the needed columns are kept and the rest are dropped. The kept columns are renamed and reordered for legibility.</br>The word 'county' needs to be added to the counties of this dataset in order for it to be matchable to the other datasets in PostGres. This is accomplished with .astype(str) + ' county'. The index is named for ease of use in PostGres and the dtypes are double checked and recast if they are incorrect. The data is now ready to be downloaded for PostGres. </br></br>
## Load</br></br>
The database used in this project is PostGres. Table schema of the three tables are created to create the correct tables in the database. The CSVs are loaded in. The ID column is the primary key for each table. County, state, and year are the foriegn keys. Because some counties in different states share names, it is important to use all of these foriegn keys to ensure the correct data is accessed. </br></br></br>

# How to use and interact with this database</br></br>
The data can be downloaded using the resources posted above. Any column can be kept from the datasets and the code can still be followed. It is the hope that this database can provide a basis for crime and civil service research. Not only do these datasets have data on number of schools and libraries, but there are also factors such as student to teacher ratios and library usage. These many subjects joined together make for several relationships that can be examined between a location's access to government funded services and its experience of crime. 

### Code resources
https://stackoverflow.com/questions/22216076/unicodedecodeerror-utf8-codec-cant-decode-byte-0xa5-in-position-0-invalid-s</br>
source for "unicode_escape"</br>

https://librarycarpentry.org/lc-python-intro/looping-data-sets.html</br>
source for adding year column in library loop</br>

https://stackoverflow.com/questions/71564504/pandas-merge-returning-more-results-than-either-original-dataframe</br>
source for indicator=True when merging dataframes</br>

https://medium.com/@akarabaev96/pandas-merge-best-practices-stop-wasting-your-time-on-debugging-the-merge-operations-72778845d9b7</br>
source for suffixes: _overlapping when merging dataframes</br>

https://librarycarpentry.org/lc-python-intro/looping-data-sets.html</br>
source for appending file name as a column</br>

https://stackoverflow.com/questions/20025882/add-a-string-prefix-to-each-value-in-a-pandas-string-column</br>
source for adding county to column </br>

https://pandas.pydata.org/docs/user_guide/reshaping.html</br>
pandas pivot/unpivot background info</br>

