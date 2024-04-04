# MTHFR RNA-seq analysis

## Raw data and base calling quality control

The original fastq files were downloaded using the SRA Toolkit and the BioProject accession number PRJNA639365. The pair-ended reads were evaluated using FASTQC, which showed an overall high quality of the sequencing experiments (Reports).

## Read preprocessing and genome mapping

Due to the very high quality of the sequencing data, no pre-processing of the resulting reads was necessary. 

The genome mapping was planned to be performed using QuasR and the Rhisat2 aligner and the "BSgenome.Hsapiens.NCBI.GRCh38" genome as a reference (see script). Due to the high computational requirements and the fact that the sequencing reads were of exceptionally high quality, this step was omitted and the normalized count tables with FPKM values were downloaded from the GEO database.
