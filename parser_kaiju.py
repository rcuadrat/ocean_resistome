import pandas as pd
from ete3 import NCBITaxa
import re
import os

# kaiju=pd.read_table("kaiju_on_ARGs.out",header=None)
# kaiju=kaiju[[1,2]]
# kaiju.columns=["ORF_ID","taxon_kaiju"]
# ncbi = NCBITaxa()
# taxid2name = ncbi.get_taxid_translator(list(kaiju["taxon_kaiju"].drop_duplicates()))
# taxonclassification=pd.DataFrame([taxid2name]).melt()
# taxonclassification.columns=["taxon_kaiju","taxon_name_kaiju"]
# kaiju=pd.merge(kaiju,taxonclassification,on="taxon_kaiju",how="left")

# def get_lin_super(t):
#     try:
#         lineage = ncbi.get_lineage(t)   
#         lineage2ranks = ncbi.get_rank(lineage)
#         names = ncbi.get_taxid_translator(lineage)
#         tmp=pd.DataFrame([names.values()],columns=list(lineage2ranks.values()))
#         if 'superkingdom' in tmp.columns:
#             sk=str(tmp["superkingdom"][0])
#         else:
#             name="-"
#         if 'class' in tmp.columns:
#             class_=str(tmp["class"][0])
#         else:
#             class_="-"
#         if 'order' in tmp.columns:
#             order=str(tmp["order"][0])
#         else:
#             order="-"
#         if 'phylum' in tmp.columns:
#             phy=str(tmp["phylum"][0])
#         else:
#             phy="-"
#         if 'family' in tmp.columns:
#             fam=str(tmp["family"][0])
#         else:
#             fam="-"        
#         if 'genus' in tmp.columns:
#             genus=str(tmp["genus"][0])
#         else:
#             genus="-"
#         if 'species' in tmp.columns:
#             spc=str(tmp["species"][0])
#         else:
#             spc="-"

#         return sk,class_,order,phy,fam,genus,spc
        
#     except:
#         return t

# kaiju[["superkingdom","class","order","phylum","family","genus","species"]]=kaiju["taxon_kaiju"].apply(lambda x: pd.Series(get_lin_super(x)))

# deep_plas=pd.read_csv("TSV/deepARG_plasflow.tsv",sep="\t")
# deep_plas["ORF_ID"]=deep_plas["read_id"]+"|"+deep_plas["sample"]
# deep_plas_kaiju=pd.merge(deep_plas,kaiju,on="ORF_ID")
# kaiju_contig=pd.read_table("kaiju_on_contigs.out",header=None)
# kaiju_contig=kaiju_contig[[1,2]]
# kaiju_contig.columns=["contig_id","taxon_kaiju_contig"]
# ncbi = NCBITaxa()
# taxid2name = ncbi.get_taxid_translator(list(kaiju_contig["taxon_kaiju_contig"].drop_duplicates()))
# taxonclassification=pd.DataFrame([taxid2name]).melt()
# taxonclassification.columns=["taxon_kaiju_contig","taxon_name_kaiju_contig"]
# kaiju_contig=pd.merge(kaiju_contig,taxonclassification,on="taxon_kaiju_contig",how="left")
# deep_plas_kaiju=pd.merge(deep_plas_kaiju,kaiju_contig,on="contig_id",how="left")
# deep_plas_kaiju.to_csv("TSV/deepARG_plasflow_kaiju.tsv",sep="\t",index=None)

deep_plas_kaiju=pd.read_csv("TSV/deepARG_plasflow_kaiju.tsv",sep="\t")

os.system("mkdir -p ARG_ORFs_lists")
os.system("mkdir -p ARG_ORFs_lists/ptn")
os.system("mkdir -p lists_deepARG")

all_ARGS=list(set(deep_plas_kaiju["#ARG"]))
df_tmp_list=deep_plas_kaiju[["#ARG","ORF_ID","sample","ptn_id","best-hit"]]

for a in all_ARGS:
    tmp=df_tmp_list[df_tmp_list["#ARG"]==a]
    tmp["best-hit"].drop_duplicates().to_csv("lists_deepARG/"+re.sub('[^a-zA-Z0-9 \n\.]', '', a)+".list",header=None,index=None)

    tmp["ptn_id"]=tmp["ptn_id"]+"|"+tmp["sample"]
    tmp["ptn_id"].to_csv("ARG_ORFs_lists/ptn/"+re.sub('[^a-zA-Z0-9 \n\.]', '', a)+".list",header=None,index=None)
    tmp["ORF_ID"].to_csv("ARG_ORFs_lists/"+re.sub('[^a-zA-Z0-9 \n\.]', '', a)+".list",header=None,index=None)

deep_plas_kaiju["phylogeny_ptn"]=deep_plas_kaiju["ptn_id"].str.split("|",expand=True)[0]+"|"+deep_plas_kaiju["sample"]+"|"+deep_plas_kaiju["taxon_name_kaiju"].fillna("--")+"|"+deep_plas_kaiju["plasmid"]
deep_plas_kaiju["phylogeny_nt"]=deep_plas_kaiju["ORF_ID"].str.split("|",expand=True)[0]+"|"+deep_plas_kaiju["sample"]+"|"+deep_plas_kaiju["taxon_name_kaiju"].fillna("--")+"|"+deep_plas_kaiju["plasmid"]

df_tmp_list=deep_plas_kaiju[["#ARG","ptn_id","sample","phylogeny_ptn","phylogeny_nt","ORF_ID"]]
for a in all_ARGS:
    tmp=df_tmp_list[df_tmp_list["#ARG"]==a]
    tmp["ptn_id"]=tmp["ptn_id"]+"|"+tmp["sample"]
    tmp[["ptn_id","phylogeny_ptn"]].to_csv("ARG_ORFs_lists/ptn/"+re.sub('[^a-zA-Z0-9 \n\.]', '', a)+".list_toedit",sep="\t",header=None,index=None)
    tmp[["ORF_ID","phylogeny_nt"]].to_csv("ARG_ORFs_lists/"+re.sub('[^a-zA-Z0-9 \n\.]', '', a)+".list_toedit",sep="\t",header=None,index=None)



