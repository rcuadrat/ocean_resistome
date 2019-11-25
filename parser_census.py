import pandas as pd
import os

# Parser microbecensus
path="census_out/"
files  = os.listdir(path)
df_census=pd.DataFrame()
for f in files:
    if f.endswith(".census"):
        #print f
        df=pd.read_csv(path+f,sep='\t').T
        df_census=pd.concat([df_census,df])
        
df_census.reset_index(inplace=True)
del df_census["index"]
del df_census["Results"]
df_census["metagenome:"] = df_census["metagenome:"].str.split("_",expand=True)[0] 
df_census.rename(columns={"metagenome:":"sample"},inplace=True)
df_census.to_csv("TSV/census.tsv",sep="\t",index=None)