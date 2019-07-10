# Background
The vast network of the interactome involves hundreds of thousands of protein-protein and other biomolecular complex interactions. 
Malfunctions in this network are responsible for a plethora of diseases, which highlights the importance of understanding how it works on a deep level. 
Adding structural information to such an intricate network comes with two challenges; the generation of hundreds of thousands of independent docking runs and an all-vs-all docking of the network components for further analysis. 
This task will generate a gargantuan number of files and will only be possible by taking advantage of exascale computing resources both for processing and I/O handling. 
This benchmark is related to our BioExcel project on high throughput modelling of interactomes.

# Description

Here we present a I/O benchmark consisting of 1,000,000 files – docking models in PDB format (plain text file) - generated by HADDOCK.
Each of these files contains in its header various energetic components that have been calculated by HADDOCK. 

```REMARK FILENAME="1ATN_1061.pdb0"
REMARK ===============================================================
REMARK HADDOCK run for 1ATN
REMARK initial structure: 1ATN_1.pdb
REMARK final NOE weights: unambig 50 amb: 50
REMARK ===============================================================
REMARK            total,bonds,angles,improper,dihe,vdw,elec,air,cdih,coup,rdcs,vean,dani,xpcs,rg
REMARK energies: 642.296, 0, 0, 0, 0, 4.80171, -0.512644, 638.007, 0, 0, 0, 0, 0, 0, 0
REMARK ===============================================================
REMARK            bonds,angles,impropers,dihe,air,cdih,coup,rdcs,vean,dani,xpcs
REMARK rms-dev.: 0,0,0,0,1.07224,0,0, 0, 0, 0, 0
REMARK ===============================================================
REMARK               air,cdih,coup,rdcs,vean,dani,xpcs
REMARK               >0.3,>5,>1,>0,>5,>0.2,>0.2
REMARK violations.: 8, 0, 0, 0, 0, 0, 0
REMARK ===============================================================
REMARK                        CVpartition#,violations,rms
REMARK AIRs cross-validation: 0, 0, 0
REMARK ===============================================================
REMARK NCS energy: 0
REMARK ===============================================================
REMARK Symmetry energy: 0
REMARK ===============================================================
REMARK Membrane restraining energy: 0
REMARK ===============================================================
REMARK Local cross-correlation:  0.0000
REMARK ===============================================================
REMARK Desolvation energy: 2.18009
REMARK Internal energy free molecules: 17670.2
REMARK Internal energy complex: 17670.2
REMARK Binding energy: 6.46916
REMARK ===============================================================
REMARK buried surface area: 1319.21
REMARK ===============================================================
REMARK water - chain_1: 0 0 0
REMARK water - chain_2: 0 0 0
REMARK ===============================================================
REMARK water - water: 0 0 0
REMARK ===============================================================
REMARK DATE:25-Dec-2018  19:07:53       created by user: enm009
```

The benchmark is composed of the results of applying HADDOCK to the cases of the Protein-Protein Docking Benchmark v5 (BM5), which is a well-accepted benchmark in the protein docking community.   Due to the nature of the BM5 benchmark, the PDB files are different in length as they represent different molecular structures.  Files are placed in a single directory and named according to the BM5 they originated from, docking procedure used, docking stage and model number, example; 1BVN_ti5-it1_167.pdb and 1AK4_cm-it0_1601.pdb.

The HADDOCK score itself is a linear combination of the extracted energetic components, weighted according to its stage (rigid-body, semi-flexible or water).
For more information about the scoring, please refer to the [HADDOCK Manual](http://www.bonvinlab.org/software/haddock2.2/scoring/).

# Download

The datasets (5 of those containing eash 250k models) can be downloaded from {LINK}

# Requirements

* Python 3.x.x

# Usage

Unpack the datasets and create first a file list containing all models to be analysed.
For example to analyse 250k models:

```bash 
$ ls -U -d dataset-01/* | head -n $i > dataset-250k.file
```
And to analyse 1 million models:

```bash 
$ ls -U -d dataset-0[1-5]/* | head -n $i > dataset-1M.file
```


Execute main code:

```bash
$ python calc-batch-hs.py dataset-250k.file
```


# Scenario
 
 Processing these files quickly without straining the system will require extremely efficient I/O solutions.
In order to evaluate this scenario we created a python script named `calc-batch-hs.py` that executes the following tasks:
1. Extract the energy terms from the header of the files
2. Calculate the HADDOCK score and 
3. Write a sorted list which represents the final ranking. 

***

This benchmark was created by Rodrigo Honorato @ Utrecht University // [BonvinLab](http://www.bonvinlab.org)
