(DIRS,SAMPLES,READS,) = glob_wildcards("data/{dir}/{sample}.coverage_mask.txt.{read}.depths")
READS=["1","2"]


rule all:
    input: 
        expand("results/{dir}/{sample}.pdf", zip, dir=DIRS, sample=SAMPLES)


rule pool_coverage:
    input: 
        dep1 = "data/{dir}/{sample}.coverage_mask.txt.1.depths",
        dep2 = "data/{dir}/{sample}.coverage_mask.txt.2.depths"
    output: 
        fig = "results/{dir}/{sample}.pdf"
    script:
        "amplicon_coverage.R"
 


