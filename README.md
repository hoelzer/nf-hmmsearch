# A simple nextflow that performs hmmsearch

Hmmsearch all input HMMs against all input protein FAA sequences. 

## Usage

```bash
# install the pipeline
nextflow pull hoelzer/nf-hmmsearch

# get information and available releases, e.g. switch below to newest release
nextflow info hoelzer/nf-hmmsearch

# run a specific release and get help
nextflow run hoelzer/nf-hmmsearch -r 0.0.2 --help

# run w/ example data, locally
git clone https://github.com/hoelzer/nf-hmmsearch.git
cd nf-hmmsearch
nextflow run hoelzer/nf-hmmsearch -r 0.0.2 --proteins test-data/proteins.csv --hmms test-data/hmms.csv --outdir results -profile local,conda

# switch to parallel execution on a SLURM cluster and using your own input data 
nextflow run hoelzer/nf-hmmsearch -r 0.0.2 --proteins proteins.csv --hmms hmms.csv --outdir results -profile slurm,conda
```

**Attention:** nextflow always writes a `work` folder for intermediate data. You can change the path via `-w /path/to/work/dir` if necessary. Also, this folder might become huge and is not deleted automatically.  
