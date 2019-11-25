import pandas as pd
import os
import numpy as np


pf=pd.read_table("plasflowout/all_with_args.plasflowout") 
pf.drop(["Unnamed: 0","contig_id"],axis=1,inplace=True)
pf_=pf[["contig_name","contig_length","label"]]

deepARG_=pd.read_csv("TSV/deepARG.tsv",sep="\t")

deepARG_plas=pd.merge(deepARG_,pf_,left_on="contig_id",right_on="contig_name")
deepARG_plas['plasmid'] = np.where(deepARG_plas['label'].str.contains("plasmid")==True, 'yes', 'no')
deepARG_plas.drop("contig_name",axis=1,inplace=True)
deepARG_plas["Plasflow_phyla"]=deepARG_plas["label"].str.split(".",expand=True)[1]


deepARG_plas.to_csv("TSV/deepARG_plasflow.tsv",sep="\t",index=None)