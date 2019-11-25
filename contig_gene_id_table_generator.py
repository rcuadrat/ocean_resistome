import pandas as pd
import os

path_arg="ORFS/nt/"
files  = os.listdir(path_arg)


contig_gene_ids=pd.DataFrame()
for f in files:
    if f.endswith("contigs.tsv"):
        df2=pd.read_csv(path_arg+f,sep="\s",header=None,engine='python')
        df2["sample"]=f
        contig_gene_ids=pd.concat([contig_gene_ids,df2])
        
contig_gene_ids.columns=["read_id","contig_id","sample"]
contig_gene_ids["read_id"]=contig_gene_ids["read_id"].str.replace(">","")
contig_gene_ids["sample"]=contig_gene_ids["sample"].str.replace("_orf_contigs.tsv","")

path_arg="ORFS/ptn/"
files  = os.listdir(path_arg)


contig_gene_ids_ptn=pd.DataFrame()
for f in files:
    if f.endswith("contigs.tsv"):
        df2=pd.read_csv(path_arg+f,sep="\s",header=None,engine='python')
        df2["sample"]=f
        contig_gene_ids_ptn=pd.concat([contig_gene_ids_ptn,df2])
        
contig_gene_ids_ptn.columns=["read_id","contig_id","sample"]
contig_gene_ids_ptn["read_id"]=contig_gene_ids_ptn["read_id"].str.replace(">","")
contig_gene_ids_ptn["sample"]=contig_gene_ids_ptn["sample"].str.replace("_orf_contigs.tsv","")

contig_gene_ids_ptn["gene"]=contig_gene_ids_ptn["read_id"].str.split("|",expand=True)[0]
contig_gene_ids["gene"]=contig_gene_ids["read_id"].str.split("|",expand=True)[0]
new_contig_gene_ids=pd.merge(contig_gene_ids,contig_gene_ids_ptn,on=["gene","contig_id","sample"])
new_contig_gene_ids.drop("gene",axis=1,inplace=True)
new_contig_gene_ids.rename(columns={"read_id_x":"read_id","read_id_y":"ptn_id"},inplace=True)
new_contig_gene_ids.to_csv("TSV/new_contig_gene_ids.tsv",sep="\t",index=None)