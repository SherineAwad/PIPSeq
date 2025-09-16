#This is a quick test for pip seq data 
#We are using pipseeker, it can be found here:
#https://www.fluentbio.com/wp-content/uploads/2023/02/Getting-Started-with-PIPseeker.pdf
#https://www.fluentbio.com/resources/pipseeker-downloads/

pipseek= /nfs/turbo/umms-thahoang/sherine/tools/pipseeker-v3.3.0-linux
	# TH-1
14161-TH-1_R2_merged.fastq.gz:
	cat 14161-TH-1_S279_R1_001.fastq.gz 14161-TH-1_S394_R1_001.fastq.gz > 14161-TH-1_R1_merged.fastq.gz
	cat 14161-TH-1_S279_R2_001.fastq.gz 14161-TH-1_S394_R2_001.fastq.gz > 14161-TH-1_R2_merged.fastq.gz

	# TH-2
14161-TH-2_R2_merged.fastq.gz:
	cat 14161-TH-2_S280_R1_001.fastq.gz 14161-TH-2_S395_R1_001.fastq.gz > 14161-TH-2_R1_merged.fastq.gz
	cat 14161-TH-2_S280_R2_001.fastq.gz 14161-TH-2_S395_R2_001.fastq.gz > 14161-TH-2_R2_merged.fastq.gz

##Prepare Reference


# Genome
Danio_rerio.GRCz11.dna.primary_assembly.fa:
	wget ftp://ftp.ensembl.org/pub/release-104/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
	gunzip Danio_rerio.GRCz11.dna.primary_assembly.fa.gz

# Annotation
Danio_rerio.GRCz11.104.gtf.gz:
	wget ftp://ftp.ensembl.org/pub/release-104/gtf/danio_rerio/Danio_rerio.GRCz11.104.gtf.gz
	gunzip Danio_rerio.GRCz11.104.gtf.gz

zebrafish_ref: Danio_rerio.GRCz11.dna.primary_assembly.fa Danio_rerio.GRCz11.104.gtf
	${pipseek}/pipseeker buildmapref \
	--fasta Danio_rerio.GRCz11.dna.primary_assembly.fa \
	--gtf Danio_rerio.GRCz11.104.gtf \
	--output-path zebrafish_ref \
	--threads 8

pipseeker_output:
	${pipseek}/pipseeker full \
	--r1 14161-TH-1_R1_merged.fastq.gz 14161-TH-2_R1_merged.fastq.gz \
	--r2 14161-TH-1_R2_merged.fastq.gz 14161-TH-2_R2_merged.fastq.gz \
	--genome zebrafish_ref \
	--outdir pipseeker_output



