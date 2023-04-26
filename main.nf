#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Author: hoelzer.martin@gmail.com

// terminal prints
println " "
println "\u001B[32mProfile: $workflow.profile\033[0m"
println " "
println "\033[2mCurrent User: $workflow.userName"
println "Nextflow-version: $nextflow.version"
println "Starting time: $nextflow.timestamp"
println "Workdir location:"
println "  $workflow.workDir\u001B[0m"
println " "
if (params.help) { exit 0, helpMSG() }
if (params.proteins == '') {exit 1, "input missing, use [--proteins]"}
if (params.hmms == '') {exit 1, "input missing, use [--hmms]"}

// generate input channels
genome_input_ch = Channel
    .fromPath(params.proteins, checkIfExists: true)
    .splitCsv()
    .map { row -> [row[0], file("${row[1]}", checkIfExists: true)] }
    //.view()

hmm_input_ch = Channel
    .fromPath(params.hmms, checkIfExists: true)
    .splitCsv()
    .map { row -> [row[0], file("${row[1]}", checkIfExists: true)] }
    //.view()

// load module
include {hmmsearch} from './modules/hmmsearch'

// main workflow
workflow {

    combined_ch = genome_input_ch.combine(hmm_input_ch)
    //combined_ch.view()

    hmmsearch(combined_ch)
}

// --help
def helpMSG() {
    c_green = "\033[0;32m";
    c_reset = "\033[0m";
    c_yellow = "\033[0;33m";
    c_blue = "\033[0;34m";
    c_dim = "\033[2m";
    log.info """
    ____________________________________________________________________________________________
    
    Simple HMMsearch workflow. Hmmer all input HMMs against all input proteins.
    
    ${c_yellow}Usage example:${c_reset}
    nextflow run main.nf --proteins proteins.csv --hmms hmms.csv 

    ${c_yellow}Input:${c_reset}
    ${c_green} --proteins ${c_reset}            A CSV w/ no header and one protein (multi) FASTA per row, styled: `genome_id,/path/to/fasta`
    ${c_green} --hmms ${c_reset}                A CSV w/ no header and one HMM per row, styled: `hmm_id,/path/to/hmm`

    ${c_yellow}Options:${c_reset}
    --cores             max cores per process for local use [default: $params.cores]
    --max_cores         max cores (in total) for local use [default: $params.max_cores]
    --memory            max memory for local use [default: $params.memory]
    --output            name of the result folder [default: $params.output]

    ${c_dim}Nextflow options:
    -with-report rep.html    cpu / ram usage (may cause errors)
    -with-dag chart.html     generates a flowchart for the process tree
    -with-timeline time.html timeline (may cause errors)

    ${c_yellow}Caching:${c_reset}
    --condaCacheDir         Location for storing the conda environments [default: $params.condaCacheDir]
    -w                      Working directory for all intermediate results [default: work] 

    ${c_yellow}Execution/Engine profiles:${c_reset}
    The pipeline supports profiles to run via different ${c_green}Executers${c_reset} and ${c_blue}Engines${c_reset} e.g.: -profile ${c_green}local${c_reset},${c_blue}conda${c_reset}
    
    ${c_green}Executer${c_reset} (choose one):
      local
      slurm
    
    ${c_blue}Engines${c_reset} (choose one):
      conda
    
    Per default: -profile local,conda is executed.
    
    ${c_reset}
    """.stripIndent()
}