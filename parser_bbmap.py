import os
import pandas as pd

df_census=pd.read_csv("TSV/census.tsv",sep='\t')

#

# features of ARGs on deepARG (came from deepARG database folder)
# Need to be downloaded from https://bitbucket.org/gusphdproj/deeparg-ss/src/master/database/v2/features.gene.length

feat=pd.read_csv("deepARGdb/v1/features.gene.length",header=None,sep="\t")
feat.columns=["best-hit","size"]
genes_on_db=feat["best-hit"].str.split("|",expand=True)[4]

#

deep=pd.read_csv("TSV/deepARG_plasflow_kaiju.tsv",sep="\t)

#parser for bbmap output with RPKG normalization
path_arg="bbmap_out/"
files  = os.listdir(path_arg)
all_FPKM=pd.DataFrame()
all_RPKG=pd.DataFrame()

reg=deep[["ORF_ID"]]
reg2=deep[["ORF_ID"]]

for f in files:
    if f.endswith(".rpkm"):
        #need to re-adjust for final file names ( sample=f.split("_")[-1].split(".")[0] )
        sample=f.split("_")[2].split(".")[0]
        df2=pd.read_csv(path_arg+f,sep="\t",skiprows=4)
        df2["sample"]=sample
        ge=df_census[df_census["sample"]==sample]["genome_equivalents:"].iloc[0]
        df2.rename(columns={"#Name":"ORF_ID"},inplace=True)
        df2=pd.merge(df2,deep[["ORF_ID","best-hit"]],on="ORF_ID")
        df2=pd.merge(df2,feat,on="best-hit")
        df2["ge"]=ge
        df2["RPKG"]=(df2["Reads"].astype(float)/(df2["size"].astype(float)/1000))/float(ge)
        df3=df2[["ORF_ID","FPKM"]]
        df2=df2[["ORF_ID","RPKG"]]
        df2.columns=["ORF_ID",sample]
        df3.columns=["ORF_ID",sample]
        reg=pd.merge(reg,df2,on="ORF_ID",how="outer")
        reg.drop_duplicates(inplace=True)
        reg2=pd.merge(reg2,df3,on="ORF_ID",how="outer")
        reg2.drop_duplicates(inplace=True)
        
        
all_RPKG=reg.copy()
all_FPKM=reg2.copy()


all_RPKG.to_csv("TSV/RPKG.tsv",sep="\t",index=None)
all_FPKM.to_csv("TSV/FPKM.tsv",sep="\t",index=None)



