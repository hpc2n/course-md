* Load the following modules:

```
ml purge  > /dev/null 2>&1
ml GCC/9.3.0  OpenMPI/4.0.3
ml VMD/1.9.4a43-Python-3.8.2
```

* Assuming you are in the folder MD_QM-NAMD_ORCA, open VMD on the
GUI and go to Extensions -> Simulation -> QwikMD
The first time VMD will ask you if you want to create the folder for QwikMD,
say OK.

* In the *Browser* option from QwikMD type 1QRA and then *Load*. Accept the
automatic Atom Renaming. You will also see warnings from *Structure Manipulation/Check*, 
close this box for now (*OK*) we will deal with parameters later.

* Go to *Chain/Type Selection* and click on the *A and water* option to
disable it.

* Then, in the *Structure Manipulation/Check* you will see the residues that
are included in your current system. The important point here is the option
*Topologies & Parameters*, if you click on it it will tell you that the residue
167 is missing some parameters for GTP. Go to the option *Add Topo+Param* 
and click on the symbol *+*. In the box *File name* write the complete path 
to the folder where the file *toppar_all36_na_nad_ppi_gdp_gtp.str* is located.
Here, you change the type of GTP to *hetero* and click on *Apply*. 

* You will see a box saying that parameters for the new residue will be added
to the library, say "Yes". Say OK to the message box "Topology Added".

* Close the windows for QwikMD, to reset the defaults. 

* In the VMD main window go again to Extensions -> Simulation -> QwikMD

* In the *Browser* option from QwikMD type 1QRA and then *Load*. Accept the
automatic Atom Renaming. Now there shouldn't be any comments related to
*Structure Manipulation/Check*.

* Go to *Chain/Type Selection* and click on the *A and water* option to
disable it.

* In the main option of QwikMD called *Advanced Run*, choose the *MD* option.
Here, choose *Solvent=Explicit*, *Minimal Box*, *Buffer=12A*, *Salt conc.=0.15mol/L*,
*Choose Salt=NaCl*.

* In *Protocol*, click on *MD* and then on the symbol *-* to remove this option.
Select *Annealing* line and change the *n Steps* value to 12000, and the value of
*Equilibration* *n Steps* to 50000.

* In the option *Simulation Setup*, click on *Save*. Write the name for the folder
which will contain the files related to the system, here we will write "mdsim" (save the
changes). Then, click on *Prepare* to save all required files. 

* Close VMD

* Copy the script *namd.sh* to the folder *mdsim/run*, move to this directory
and submit your script *sbatch namd.sh* (after fixing the project ID and reservation).
When the simulation finishes, you can
take a look at the equilibration trajectory *vmd mdsim_QwikMD.psf Equilibration.dcd*.

