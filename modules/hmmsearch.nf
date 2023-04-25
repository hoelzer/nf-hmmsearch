process hmmsearch {
    label 'hmmsearch'
    publishDir "${params.output}/", mode: 'copy', pattern: "${fasta.baseName}.blast"

    input:
        tuple val(name), path(fasta) 
    
    output:
	    tuple val(name), path("${name}.blast") 
    
    script:
    """
    hmmsearch ...
    """
}
