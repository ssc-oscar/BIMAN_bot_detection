# BIMAN: Bot Identification by commit Message, commit Association, and author Name
Code for running the BIMAN bot detection method, as stated in the MSR 2020 paper: 

"Detecting and Characterizing Bots that Commit Code"


# Data Processing Steps Listed below using [WoC](https://github.com/woc-hack/tutorial):

###  Get Author to Commit maps (a2c):
`cat bot_authors| ~/lookup/getValues -vQ a2c |gzip > paper_a2c.gz # all commits for all bot authors`

### Getting List of all Commits from a2c map: 
Use code in `bot_datagen.ipynb` (first code block)

### Getting Commit Contents from List of Commits:
`zcat commits.gz| ~/lookup/showCnt commit 2 | gzip > paper_cnt.gz`

### Getting Commit to Project map (c2p):
`zcat commits.gz| ~/lookup/getValues -vQ c2p | gzip > paper_c2p.gz`

### Getting Commit to File map (c2f):
`zcat commits.gz| ~/lookup/getValues -vQ c2f | gzip > paper_c2f.gz`

## Snapshot of the Data
Snapshot of the different data files used by the scripts is available in `data_snapshot` folder. This is for demonstration purpose, so that researchers using this Tool know how to format their data if they are not using WoC tool to generate the data.

# Running BIMAN

### Running BIN (name based detection) approach:

` ./BIN.sh |file with list of Author IDs|`

Example Author ID file structure:

```
dependabot[bot] <support@dependabot.com>
felix <felixhennigfh@gmail.com>
John Smith <support@support-bot.io>
Abbot <abbot@ebi-cli-003.ebi>
```

Only `dependabot[bot] <support@dependabot.com>` should come out as a bot.

### Running BIM: 
Use code in `bot_datagen.ipynb`

### Running BICA:
Prepare data using code in `bot_datagen.ipynb`
Run Random Forest using Code in `BICA_BIMAN.ipynb`

You can use the Pre-Trained model for prediction directly: `BICA_model.Rdata`

Predictors (In Order):

`'Uniq.File.Exten' 'Tot.FilesChanged' 'Std.File.pCommit' 'Tot.uniq.Projects' 'Avg.File.pCommit' 'Median.Project.pCommit'`

Description:
| Variable Name           	|                                                                                                               Variable Description                                                                                                              	|
|-------------------------	|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:	|
| Tot.FilesChanged        	| Total number of files changed by the author in all their commits (including duplicates)                                                                                                                                                         	|
| Uniq.File.Exten         	| Total number of different file extensions in all the author's commits                                                                                                                                                                            	|
| Std.File.pCommit        	| Std. Deviation of the number of files per commit                                                                                                                                                                                                	|
| Avg.File.pCommit        	| Mean number of files per Commit                                                                                                                                                                                                                 	|
| Tot.uniq.Projects       	| Total number of different projects the author's commits have been associated with                                                                                                                                                                	|
| Median.Project. pCommit 	| Median number of projects the author's commits have been associated with (with duplicates); we took the median value, because the distribution of projects per commit was very skewed, and the mean was heavily influenced by the maximum value. 	|

### Running BIMAN:
Code snippet available in `BICA_BIMAN.ipynb`

You can use the Pre-Trained model for prediction directly: `ensemble.Rdata`

Predictors (In Order):

`p, ratio, name`

Description:

| Variable Name 	|                                       Variable Description                                       	|
|---------------	|:------------------------------------------------------------------------------------------------:	|
| p             	| Probability of Author being a bot from BICA prediction                                           	|
| name          	| Whether the author has the word "Bot" in their name in the required pattern, as indicated by BIN 	|
| ratio         	| 1-(no. of message templates detected/no. of messages), as calculated by BIM                      	|
