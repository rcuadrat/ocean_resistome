import pandas as pd
import os

# Script 6 resistomeDB
# Parsing results of deepARG and merging with previous tables with infos of contig_id, nt_id, ptn_id
# Generating lists of IDs of ORF sequences (nt and ptn) annotated as ARGs by deepARG results
# Generating list of IDs of contigs with at least one ARG 
# Those lists will be used in the next script to extract those ORFs and also those contigs for further analysis.

new_contig_gene_ids=pd.read_csv("TSV/new_contig_gene_ids.tsv",sep="\t")

path_arg="deeparg_out/"
files  = os.listdir(path_arg)


deepARG=pd.DataFrame()
for f in files:
    if f.endswith(".mapping.ARG"):
        df=pd.read_csv(path_arg+f,sep="\t")
        df["sample"]=f
        deepARG=pd.concat([deepARG,df])
deepARG["gene"]=deepARG["best-hit"].str.split("|",expand=True)[4]
deepARG["sample"]=deepARG["sample"].str.replace(".fa.out.mapping.ARG","")

deepARG_=pd.merge(deepARG,new_contig_gene_ids,how="left",on=["read_id","sample"])
deepARG_["contig_id"].drop_duplicates().to_csv("CONTIGS/all/all_contigs_with_args.list",index=None,header=None)

os.system("mkdir -p ARGS")

for f in list(set(deepARG["sample"])):
    tmp=deepARG[deepARG["sample"]==f]
    tmp=tmp["read_id"]
    tmp.to_csv("ARGS/"+f.split(".")[0]+".read_list",header=None,index=None)
    
    
for f in list(set(deepARG["sample"])):
    tmp=deepARG_[deepARG_["sample"]==f]
    tmp=tmp["ptn_id"]
    tmp.to_csv("ARGS/"+f.split(".")[0]+".ptn_list",header=None,index=None)

os.system("mkdir -p TSV")
  
deepARG_.to_csv("TSV/deepARG.tsv",sep="\t",index=None)

contigs_orfs_with_args=new_contig_gene_ids[new_contig_gene_ids["contig_id"].isin(deepARG_["contig_id"].drop_duplicates())].drop_duplicates()


for s in list(set(contigs_orfs_with_args["sample"])):
    tmp=contigs_orfs_with_args[contigs_orfs_with_args["sample"]==s]
    tmp["read_id"].to_csv("ORFS/nt/"+s+"_orfs_in_contigs_with_args.list",header=None,index=None)


