---
title: A function for retrieving SNP data from Entrez using BioPython
author: Daniel Cook
aliases:
    - /getting_snp_dat/
date: 2013-06-06
tags:
  - gist
---

[Biopython][1] is a great tool for interacting with biological databases. I use it to retrieve records from [NCBI&#8217;s Entrez databases][2] including Pubmed.

Unfortunately &#8211; one notable database biopython has trouble working with is the [SNP][3] database. This is due to the `Bio.Entrez` parser being unable to handle the XML returned from this database. One solution is to use a built in Python XML parser, but I thought I&#8217;d try to come up with an easier solution.

To solve this problem &#8211; I wrote a function for retrieving SNP data, and parsing it into an array.

```python
from pprint import pprint as pp
from Bio import Entrez

Entrez.email = "YOUR@EMAIL.HERE"

def pull_line(var_set, line):
    """
    This function parses data from lines in one of three ways:
    1.) Pulls variables out of a particular line when defined as "variablename=[value]" - uses a string to find the variable.
    2.) Pulls variables based on a set position within a line [splits the line by '|']
    3.) Defines variables that can be identified based on a limited possible set of values - [categorical variable, specified using an array]
    """
    line_set = {}
    for k,v in var_set.items():
        if type(v) == str:
            try:
                line_set[k] = [x for x in line if x.startswith(v)][0].replace(v,'')
            except:
                pass
        elif type(v) == int:
            try:
                line_set[k] = line[v]
            except:
                pass
        else:
            try:
                line_set[k] = [x for x in line if x in v][0]
            except:
                pass
    return line_set

def pull_vars(var_set,line_start,line,multi=False):
    """
    Delegates and compiles data from entrez flat files dependent on whether
    the type of data trying to be pulled is contained in unique vs. non-unique lines.
    For example - the first line of the flat file is always something like this:
    rs12009 | Homo Sapiens | 9606 | etc.
    This line is unique (refers to RefSnp identifier)- and only occurs once in each flat file. On the other hand, lines
    beginning with "ss[number]" refer to 'submitted snp' numbers and can appear multiple times.
    """
    lineset = [x.split(' | ') for x in line if x.startswith(line_start)]
    if len(lineset) == 0:
        return 
    # If the same line exists multiple times - place results into an array
    if multi == True:
        pulled_vars = []
        for line in lineset:
            # Pull date in from line and append
            pulled_vars.append(pull_line(var_set,line))
        return pulled_vars  
    else:
    # Else if the line is always unique, output single dictionary
        line = lineset[0]
        pulled_vars = {}
        return pull_line(var_set,line)

def get_snp(q):
    """ 
    Takes as input an array of snp identifiers and returns 
    a parsed dictionary of their data from Entrez.
    """
    response = Entrez.efetch(db='SNP', id=','.join(q), rettype='flt', retmode='flt').read()
    r = {} # Return dictionary variable
    # Parse flat file response
    for snp_info in filter(None,response.split('\n\n')):
        print snp_info
        # Parse the First Line. Details of rs flat files available here:
        # ftp://ftp.ncbi.nlm.nih.gov/snp/specs/00readme.txt
        snp = snp_info.split('\n')
        # Parse the 'rs' line:
        rsId = snp[0].split(" | ")[0]
        r[rsId] = {}

        # rs vars
        rs_vars = {"organism":1,
                   "taxId":2,
                   "snpClass":3,
                   "genotype":"genotype=",
                   "rsLinkout":"submitterlink=",
                   "date":"updated "}

        # rs vars
        ss_vars = {"ssId":0,
                   "handle":1,
                   "locSnpId":2,
                   "orient":"orient=",
                   "exemplar":"ss_pick=",
                   }

        # SNP line variables:
        SNP_vars = {"observed":"alleles=",
                    "value":"het=",
                    "stdError":"se(het)=",
                    "validated":"validated=",
                    "validProbMin":"min_prob=",
                    "validProbMax":"max_prob=",
                    "validation":"suspect=",
                    "AlleleOrigin":['unknown',
                                    'germline',
                                    'somatic',
                                    'inherited',
                                    'paternal',
                                    'maternal',
                                    'de-novo',
                                    'bipaternal',
                                    'unipaternal',
                                    'not-tested',
                                    'tested-inconclusive'],
                    "snpType":['notwithdrawn',
                               'artifact',
                               'gene-duplication',
                               'duplicate-submission',
                               'notspecified',
                               'ambiguous-location;',
                               'low-map-quality']}
        
        # CLINSIG line variables:
        CLINSIG_vars = {"ClinicalSignificance":['probable-pathogenic','pathogenic','other']}

        # GMAF line variables
        GMAF_vars = {"allele":"allele=",
                     "sampleSize":"count=",
                     "freq":"MAF="}

        # CTG line variables
        CTG_vars = {"groupLabel":"assembly=",
                    "chromosome":"chr=",
                    "physmapInt":"chr-pos=",
                    "asnFrom":"ctg-start=",
                    "asnTo":"ctg-end=",
                    "loctype":"loctype=",
                    "orient":"orient="}

        # LOC line variables
        LOC_vars = {"symbol":1,
                    "geneId":"locus_id=",
                    "fxnClass":"fxn-class=",
                    "allele":"allele=",
                    "readingFrame":"frame=",
                    "residue":"residue=",
                    "aaPosition":"aa_position="}

        # LOC line variables
        SEQ_vars = {"gi":1,
                    "source":"source-db=",
                    "asnFrom":"seq-pos=",
                    "orient":"orient="}

        # Pull out variable information:
        r[rsId]['rs']       = pull_vars(rs_vars,"rs",snp)
        r[rsId]['ss']       = pull_vars(ss_vars,"ss",snp,True)
        r[rsId]['SNP']      = pull_vars(SNP_vars,"SNP",snp)
        r[rsId]['CLINSIG']  = pull_vars(CLINSIG_vars,"CLINSIG",snp)
        r[rsId]['GMAF']     = pull_vars(GMAF_vars,"GMAF",snp)
        r[rsId]['CTG']      = pull_vars(CTG_vars,"CTG",snp,True)
        r[rsId]['LOC']      = pull_vars(LOC_vars,"LOC",snp,True)
        r[rsId]['SEQ']      = pull_vars(SEQ_vars,"SEQ",snp,True)
    return r
        

snp = get_snp(["12009"])
print pp(snp)
```

 [1]: http://biopython.org/
 [2]: http://www.ncbi.nlm.nih.gov/About/tools/restable_mol.html
 [3]: http://www.ncbi.nlm.nih.gov/snp