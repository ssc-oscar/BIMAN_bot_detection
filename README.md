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

### Running BIN (name based detection) approach:

` ./BIN.sh |file with list of Author IDs|`

Example Author ID file structure:

```
dependabot[bot] <support@dependabot.com>
greenkeeper <felixhennigfh@gmail.com>
Greenkeeper <support@greenkeeper.io>
greenkeeper.io <support@greenkeeper.io>
greenkeeper-keeper <nodaguti+keeper@gmail.com>
greenkeeper <greenkeeper@users.noreply.github.com>
Greenkeeper <green@fxck.it>
Greenkeeper <support@greenkeeper.io>
SPOT robot <spotbot@ebi-cli-003.ebi.ac.uk>
```

### Running BIM: 
Use code in `bot_datagen.ipynb`

### Running BICA:
Prepare data using code in `bot_datagen.ipynb`
Run Random Forest using Code in `bot_flow.ipynb`

You can use the Pre-Trained model for prediction directly: `BICA_model.Rdata`

### Running BIMAN:
Code snippet available in `bot_flow.ipynb`

You can use the Pre-Trained model for prediction directly: `ensemble.Rdata`
