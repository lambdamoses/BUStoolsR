% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tr2g.R
\name{tr2g_fasta}
\alias{tr2g_fasta}
\title{Get transcript and gene info from names in FASTA files}
\usage{
tr2g_fasta(
  file,
  out_path = ".",
  write_tr2g = TRUE,
  use_gene_name = TRUE,
  use_transcript_version = TRUE,
  use_gene_version = TRUE,
  transcript_biotype_use = "all",
  gene_biotype_use = "all",
  chrs_only = TRUE,
  save_filtered = TRUE,
  compress_fa = FALSE,
  overwrite = FALSE
)
}
\arguments{
\item{file}{Path to the FASTA file to be read. The file can remain gzipped.}

\item{out_path}{Directory to save the outputs written to disk. If this
directory does not exist, then it will be created. Defaults to the current
working directory.}

\item{write_tr2g}{Logical, whether to write tr2g to disk. If \code{TRUE}, then
a file \code{tr2g.tsv} will be written into \code{out_path}.}

\item{use_gene_name}{Logical, whether to get gene names.}

\item{use_transcript_version}{Logical, whether to include version number in
the Ensembl transcript ID. To decide whether to
include transcript version number, check whether version numbers are included
in the \code{transcripts.txt} in the \code{kallisto} output directory. If that file
includes version numbers, then trannscript version numbers must be included
here as well. If that file does not include version numbers, then transcript
version numbers must not be included here.}

\item{use_gene_version}{Logical, whether to include version number in the
Ensembl gene ID. Unlike transcript
version number, it's up to you whether to include gene version number.}

\item{transcript_biotype_use}{Character, can be "all" or
a vector of \emph{transcript} biotypes to be used. Transcript biotypes aren't
entirely the same as gene biotypes. For instance, in Ensembl annotation,
\code{retained_intron} is a transcript biotype, but not a gene biotype. If
"cellranger", then a warning will be given. See \code{data("ensembl_tx_biotypes")}
for all available transcript biotypes from Ensembl.}

\item{gene_biotype_use}{Character, can be "all", "cellranger", or
a vector of \emph{gene} biotypes to be used. If "cellranger", then the biotypes
used by Cell Ranger's reference are used. See \code{data("cellranger_biotypes")}
for gene biotypes the Cell Ranger reference uses. See
\code{data("ensembl_gene_biotypes")} for all available gene biotypes from Ensembl.
Note that gene biotypes and transcript biotypes are not always the same.}

\item{chrs_only}{Logical, whether to include chromosomes only, for GTF and
GFF files can contain annotations for scaffolds, which are not incorporated
into chromosomes. This will also exclude haplotypes. Defaults to \code{TRUE}.
Only applicable to species found in \code{genomeStyles()}.}

\item{save_filtered}{If filtering for biotype and chromosomes, whether to
save the filtered fasta file. If \code{TRUE}, the file will be \code{tx_filtered.fa} in
\code{out_path}.}

\item{compress_fa}{Logical, whether to compress the output fasta file. If
\code{TRUE}, then the fasta file will be gzipped.}

\item{overwrite}{Logical, whether to overwrite if files with names of outputs
written to disk already exist.}
}
\value{
A data frame with at least 2 columns: \code{gene} for gene ID,
\code{transcript} for transcript ID, and optionally \code{gene_name} for gene
names.
}
\description{
FASTA files, such as those for cDNA and ncRNA from Ensembl, might have genome
annotation information in the name of each sequence entry. This function
extracts the transcript and gene IDs from such FASTA files.
}
\details{
At present, this function only works with FASTA files from Ensembl, and uses
regex to extract vertebrate Ensembl IDs. Sequence names should be formatted
as follows:\preformatted{ENST00000632684.1 cdna chromosome:GRCh38:7:142786213:142786224:1
gene:ENSG00000282431.1 gene_biotype:TR_D_gene transcript_biotype:TR_D_gene
gene_symbol:TRBD1 description:T cell receptor beta diversity 1
[Source:HGNC Symbol;Acc:HGNC:12158]
}

If your FASTA file sequence names are formatted differently, then you must
extract the transcript and gene IDs by some other means. The Bioconductor
package \code{Biostrings} is recommended; after reading the FASTA file into
R, the sequence names can be accessed by the \code{names} function.

While normally, you should call \code{\link{sort_tr2g}} to sort the
transcript IDs from the output of the \code{tr2g_*} family of functions, If
the FASTA file supplied here is the same as the one used to build the
kallisto index, then the transcript IDs in the output of this function are in
the same order as in the kallisto index, so you can skip \code{\link{sort_tr2g}}
and proceed directly to \code{\link{EC2gene}} with the output of this
function.
}
\examples{
toy_path <- system.file("testdata", package = "BUSpaRse")
file_use <- paste(toy_path, "fasta_test.fasta", sep = "/")
tr2g <- tr2g_fasta(file = file_use, save_filtered = FALSE, write_tr2g = FALSE)
}
\seealso{
ensembl_gene_biotypes ensembl_tx_biotypes cellranger_biotypes

Other functions to retrieve transcript and gene info: 
\code{\link{sort_tr2g}()},
\code{\link{tr2g_EnsDb}()},
\code{\link{tr2g_TxDb}()},
\code{\link{tr2g_ensembl}()},
\code{\link{tr2g_gff3}()},
\code{\link{tr2g_gtf}()},
\code{\link{transcript2gene}()}
}
\concept{functions to retrieve transcript and gene info}
