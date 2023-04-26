# A simple nextflow that performs hmmsearch

## Usage

````
nextflow run main.nf --help
````

````
nextflow run main.nf --genomes genomes.csv --hmms hmms.csv --outdir results -profile local,conda
````

You can switch to parallel execution on a SLURM cluster via 

````
-profile slurm,conda
````
