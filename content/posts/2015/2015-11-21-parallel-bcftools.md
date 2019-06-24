---
title: Parallelize bcftools functions
author: Daniel Cook
layout: post
aliases:
  -  /parallelize-bcftools/
date: 2015-11-21
---

[bcftools](http://samtools.github.io/bcftools/) is a great for working with [variant call files](http://www.1000genomes.org/wiki/analysis/variant%20call%20format/vcf-variant-call-format-version-41). In general, it is fast. However, I have found that the process of merging VCF files (using `bcftools merge`) and performing concordance checking (using `bcftools gtcheck`) can be a little bit slow. That is why I wrote two functions that take advantage of [GNU Parallel](http://www.gnu.org/software/parallel/) to parallelize them. 


```bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

function bam_chromosomes() {
    # Fetch chromosomes from a bam file
    samtools view -H $1 | \
    grep -Po 'SN:(.*)\t' | \
    cut -c 4-1000
}

function vcf_chromosomes() {
    # Fetch contigs from a vcf file.
    bcftools view -h $1 | \
    grep 'contig' | \
    egrep -o "ID=([^,]+)" | \
    sed 's/ID=//g' | \
    tr '\n' ' '
}


PARALLEL_CORES=6
function parallel_bcftools_merge() {
    file_set=`echo $@ | egrep -o '(\-l|\-\-file-list)(=|[ ]+)[^ ]+' | tr '=' ' ' | cut -f 2 -d ' '`
    if [ -n "${file_set}" ]
        then
            find_vcf=`cat ${file_set} | head -n 1`
        else
            find_vcf=`echo $@ | tr '\t' '\n' | egrep -o '[^ ]+.vcf.gz' | awk 'NR == 1 { print }' - `
    fi
    contigs=`vcf_chromosomes ${find_vcf}`
    current_dir=$(dirname ${find_vcf})
    hash_merge=`echo "$@" | md5sum | cut -c 1-5`
    output_prefix="${current_dir}/parallel_merge.${hash_merge}"
    
    parallel --gnu --workdir ${current_dir} \
    --env args -j ${PARALLEL_CORES} \
    'bcftools merge -r {1} -O u ' $@ ' > ' ${output_prefix}'.{1}.bcf' ::: ${contigs} 
    
    order=`echo $contigs | tr ' ' '\n' | awk -v "prefix=${output_prefix}" '{ print prefix "." $0 ".bcf" }'`
    bcftools concat -O v ${order} | grep -v 'parallel_merge' | sed 's/##bcftools_mergeCommand=merge -r I -O u /##bcftools_mergeCommand=merge /g' | bcftools view -O u
    rm ${order}
}


PARALLEL_CORES=6
function parallel_bcftools_gtcheck() {
    find_vcf=`echo $@ | tr '\t' '\n' | egrep -o '[^ ]+.vcf.gz' | awk 'NR == 1 { print }' - `
    contigs=`vcf_chromosomes ${find_vcf}`
    current_dir=$(dirname ${find_vcf})
    hash_merge=`echo "$@" | md5sum | cut -c 1-5`
    output_prefix="${current_dir}/parallel_concordance.${hash_merge}"
    gtcheck_options=`echo $@ | awk -v vcf=${find_vcf} '{ gsub(vcf,"",$0); print $0; }'`
    parallel --gnu  -j ${PARALLEL_CORES} --workdir ${current_dir} 'bcftools view ' ${find_vcf} ' {} | \
    bcftools gtcheck ' ${gtcheck_options} ' - | \
    awk -v chrom={} "/^CN/ { print \$0 \"\t\" chrom } \$0 !~ /.*CN.*/ { print } \$0 ~ /^# \[1\]CN/ { print \$0 \"\tchrom\"}" - > ' ${output_prefix}'.{}.tsv' ::: ${contigs}

    order=`echo $contigs | tr ' ' '\n' | awk -v "prefix=${output_prefix}" '{ print prefix "." $0 ".tsv" }'`
    cat ${order} | \
    grep 'CN' | \
    awk 'NR == 1 && /Discordance/ { print } NR > 1 && $0 !~ /Discordance/ { print }' | \
    awk '{ gsub("(# |\\[[0-9]+\\])","", $0); gsub(" ","_", $0); print }' | \
    cut -f 2-7 | datamash --header-in --sort --group=Sample_i,Sample_j sum Discordance  sum Number_of_sites | \
    cat <(echo -e "sample_i\tsample_j\tdiscordance\tnumber_of_sites") - | \
    awk 'NR == 1 { print $0 "\tconcordance" } NR > 1 && $4 == 0 { print $0 "\t" } NR > 1 && $4 > 0 { print $0 "\t" ($4-$3)/$4 }'
    rm ${order}
}

```


### Usage 

The function `vcf_chromosomes` extracts chromosomes names from a VCF file using bcftools. Parallelization occurs across chromosomes.

### `parallel_bcftools_merge`

`parallel_bcftools_merge` is run very similar to `bcftools merge`. The only difference is that you have to pipe it into bcftools to change it to the appropriate output. For example:

```bash
parallel_bcftools_merge -m all `ls *list_of_bcffiles` | bcftools view -O z > merged_vcf.vcf.gz
```

The `parallel_bcftools_merge` function will generate a temporary vcf for every chromosome. You can use all flags except for `-O` with this function. 

### `parallel_bcftools_gtcheck`

`parallel_bcftools_gtcheck` should not be used with `--all-sites`, or `--plot`. I recommend using this function with `-H` and `-G 1` to calculate the absolute number of differences in terms of homozygous calls between samples. Also, this function requires datamash (on OSX, install with `brew install datamash`)

The output file is slightly different than what bcftools normally outputs. In general, I use this function specifically to calculate conocordance between individual fastq runs - like this:

```bash
parallel_bcftools_gtchek -H -G 1 union_samples.vcf.gz > concordance.tsv
```

This parallelized version generates concordances for each chromosome and then merges the results together using datamash. Output looks like this:

| sample_i          | sample_j          |   discordance |   number_of_sites |   concordance |
|:------------------|:------------------|--------------:|------------------:|--------------:|
| BGI2-RET1-ED3049  | BGI1-RET1-ED3049  |           927 |           2344043 |      0.999605 |
| BGI1-RET1-CB4856  | BGI1-RET1-CB4852  |        144484 |           2171694 |      0.933469 |
| BGI1-RET1-CX11315 | BGI1-RET1-CB4852  |        106964 |           2721950 |      0.960703 |
| BGI1-RET1-CX11315 | BGI1-RET1-CB4856  |        137200 |           2059983 |      0.933398 |
| BGI1-RET1-DL238   | BGI1-RET1-CB4852  |        148217 |           2097343 |      0.929331 |
| BGI1-RET1-DL238   | BGI1-RET1-CB4856  |        124132 |           1803664 |      0.931178 |
| BGI1-RET1-DL238   | BGI1-RET1-CX11315 |        146580 |           1996802 |      0.926593 |