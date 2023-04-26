process hmmsearch {
    label 'hmmsearch'
    // Ausgabe ist results/hmm_id/genom_id/hmm.table
    publishDir "${params.output}/${hmm_id}/${genome_id}", mode: 'copy', pattern: "${genome_id}.${hmm_id}.table"

    input:
        tuple val(genome_id), path(genome), val(hmm_id), path(hmm) 
    
    output:
	    tuple val(genome_id), path(genome), val(hmm_id), path(hmm), path("${genome_id}.${hmm_id}.table")
    
    script:
    """
    hmmsearch --tblout ${genome_id}.${hmm_id}.table ${hmm} ${genome} > ${genome_id}.${hmm_id}.bin
    """
}

/* Input channel is smt like
[Cav_10DC88, /Users/martin/git/nf-hmmsearch/test-data/Cav_10DC88.fasta, hmm1, /Users/martin/git/nf-hmmsearch/test-data]
[Cav_11DC096, /Users/martin/git/nf-hmmsearch/test-data/Cav_11DC096.fasta, hmm1, /Users/martin/git/nf-hmmsearch/test-data]
[Cav_10DC88, /Users/martin/git/nf-hmmsearch/test-data/Cav_10DC88.fasta, hmm2, /Users/martin/git/nf-hmmsearch/test-data]
[Cav_11DC096, /Users/martin/git/nf-hmmsearch/test-data/Cav_11DC096.fasta, hmm2, /Users/martin/git/nf-hmmsearch/test-data]
*/
