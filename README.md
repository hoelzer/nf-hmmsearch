# A simple nextflow that performs hmmsearch

## Usage

```bash
# install the pipeline
nextlow pull hoelzer/nf-hmmsearch

# get information and available releases
nextflow info hoelzer/nf-hmmsearch

# run a specific release and get help
nextflow run hoelzer/nf-hmmsearch -r 0.0.1 --help

# run w/ example data, locally
nextflow run hoelzer/nf-hmmsearch --genomes genomes.csv --hmms hmms.csv --outdir results -profile local,conda

# switch to parallel execution on a SLURM cluster via 
-profile slurm,conda
```
