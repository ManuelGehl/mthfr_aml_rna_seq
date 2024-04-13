# MTHFR RNA-seq analysis

## Raw data and base calling quality control

The original fastq files were downloaded using the SRA Toolkit and the BioProject accession number PRJNA639365. The pair-ended reads were evaluated using FASTQC, which showed an overall high quality of the sequencing experiments (see [reports](https://github.com/ManuelGehl/mthfr_aml_rna_seq/tree/main/qc_reports_reads)).

## Read preprocessing and genome mapping

Due to the high quality of the sequencing data, no preprocessing of the resulting reads was necessary. The genome mapping was performed using SALMON, with the transcriptome reference from Gencode GRCh38.p14 using a [bash script](https://github.com/ManuelGehl/mthfr_aml_rna_seq/blob/main/salmon_pipe.sh).

The dataset comprised 12 samples from two different cell lines, **IMS-M2** and **U937**, with three samples each grown under normal media composition and three samples grown in the absence of **folic acid (FA)**. Additionally, the all samples were grown in the presence of the **BET inhibitor OTX015**.

Genes with fewer than 10 counts in all 12 samples were filtered out, reducing the dataset from approximately 62,000 genes to 23,000 genes. Subsequently, variance-stabilized counts were computed, and the Euclidean distances between samples were calculated (**Fig. 1A**). Additionally, a principal component analysis (PCA) was performed based on the 500 genes with the highest variance across samples (**Fig. 1B**). Both the distance plot and the PCA plot revealed that the expression profiles primarily depended on the cell line rather than the growth condition. Furthermore, it was observed that the effect of folic acid deprivation was much stronger in the U937 cell line than in the IMS-M2 cell line. Consequently, the design formula was adjusted to account for this batch variation.

<img src="https://github.com/ManuelGehl/mthfr_aml_rna_seq/blob/main/figures/Figure_1.png?raw=true" height=400>

***Figure 1:*** ***A:*** *Distance plot between different samples.* ***B:*** *PCA plot between different samples based on the 500 most variable genes in the dataset.*
<br></br>


 ## Differential expression analysis across both cell lines

The differential expression analysis identified 2,800 differentially expressed genes with a false discovery rate (FDR) of less than 0.1, and approximately 2,000 genes with an FDR of less than 0.05. An overall increase in gene expression was observed under folic acid withdrawal, consistent with previous reports suggesting this increase may arise from the release of repressive epigenetic histone marks.

Diagnostic plots (**Fig. 2**) confirmed an expected distribution of p-values, indicating successful count normalization. Similarly, the MA plot and EDA plot both reflected this normalization (**Fig. 2**).

<img src="https://github.com/ManuelGehl/mthfr_aml_rna_seq/blob/main/figures/Figure_2.png?raw=true" height=400>

***Figure 2:*** *EDA plot (**left**), MA plot (**middle**) and distribution of p-values (**right**).*
<br></br>

Gene symbols were annotated using the EnsDb.Hsapiens.v86 database, followed by filtering the dataset for genes with FDR values of NA and higher than 0.05, and genes with an absolute log2 fold change of at least 1. This filtering reduced the dataset to 99 genes, consistent with the published 80 differentially expressed genes between both cell lines.

Performing principal component analysis (PCA) on this subset revealed that while the highest variation was still attributed to different cell lines, the folic acid condition could also be separated on principal component 2 (**Fig. 3**).

<img src="https://github.com/ManuelGehl/mthfr_aml_rna_seq/blob/main/figures/Figure_3.png?raw=true" height=400>

***Figure 3:*** ***A:*** *Heatmap of hierarchical clustering. The values are z-scores scaled to the gene mean.* ***B:*** *PCA plot performed with variance-stabilized counts from 99 differentially expressed genes.*
<br></br>

Further separation of the two cell lines and clustering the scaled gene expression values showed a similar pattern. In the IMS-M2 cell line, approximately half of the genes exhibited upregulation or downregulation upon folic acid deprivation, whereas in the U937 cell line, the vast majority of genes were upregulated in the absence of folic acid.

Table 1 presents the top 10 differentially expressed genes between both cell lines. Among these genes, *SERBP1P5* stands out as the sole downregulated gene in the list, functioning as a pseudogene of the SERPINE1 mRNA binding protein 1. Additionally, *DHFRP1* serves as a pseudogene of dihydrofolate reductase. The remaining genes include leukocyte immunoglobulin-like receptor A5 (*LILRA5*), succinate receptor 1 (*SUCNR1*), IRF1 antisense RNA 1 (*C5orf56*), S100 calcium-binding protein A8 (*S100A8*), *CD36*, fibroblast activation protein alpha (*FAP*), and dehydrogenase/reductase 9 (*DHRS9*). Notably, it has been reported that genes associated with the interferon program are overexpressed in the presence of OTX015 and in the absence of folic acid, adding further intrigue to these findings.


***Table 1:*** *DEA statistics for 10 most differentially expressed genes according to absolute log2 fold change.*
|       ENSEBML ID          | log2FoldChange | pvalue             | padj               | symbol  |
|-----------------|----------------|--------------------|--------------------|---------|
| ENSG00000249565.2 | -7.11          | 4.68E-04           | 7.01E-03           | SERBP1P5 |
| ENSG00000188985.6 | 4.00           | 3.67E-03           | 3.09E-02           | DHFRP1  |
| ENSG00000049249.10| 2.29           | 2.16E-08           | 1.70E-06           | TNFRSF9 |
| ENSG00000187116.14| 2.19           | 8.42E-09           | 7.79E-07           | LILRA5  |
| ENSG00000198829.6 | 2.19           | 1.96E-25           | 3.02E-22           | SUCNR1  |
| ENSG00000197536.11| 2.05           | 3.46E-11           | 5.46E-09           | C5orf56 |
| ENSG00000143546.10| 2.04           | 4.77E-08           | 3.45E-06           | S100A8  |
| ENSG00000135218.19| 2.02           | 2.38E-10           | 3.06E-08           | CD36    |
| ENSG00000078098.15| 1.98           | 2.77E-05           | 7.49E-04           | FAP     |
| ENSG00000073737.17| 1.93           | 2.17E-06           | 9.20E-05           | DHRS9   |


