# Exercise: setting up a MD simulation with VMD TK terminal 

- Download the PDB structure from Protein Data Bank (https://www.rcsb.org/). 
  In the field "Enter search term" write  4AKE. Then, use the option "Download Files"
  and choose "PDB Format". The PDB file will be downloaded to your local machine.
  Then, you can transfer this file to Kebnekaise (I already did this step, the structure
  is in this directory).

- Load the VMD modules on Kebnekaise:

```
ml purge  > /dev/null 2>&1
ml GCC/9.3.0  OpenMPI/4.0.3 
ml VMD/1.9.4a43-Python-2.7.18
```

- Start VMD on the terminal by "vmd" (assuming your path is the one where you put the 4ake.pdb file).
Open VMD:  File -> New Molecule -> Browse, choose 4ake.pdb -> OK -> Load and close the 
Molecule File Browser box dialog.

- On VMD Main, go to Extensions -> Tk Console write these commands:
  - (cd $PATH_TO_PDB_FILE if you are working in your local machine)
  - set chaina [atomselect top "protein and chain A"]
  - $chaina writepdb 4ake_chaina.pdb
  - Quit VMD (File -> Quit)
  - with your preferred text editor delete the atom 1656 OXT

- Download the CHARMM36 parameters file toppar_c36_jul20.tgz from MacKerell's lab (http://mackerell.umaryland.edu/charmm_ff.shtml)
  - extract the files with the command *tar zxvf toppar_c36_jul20.tgz* (I already did this step)
  - copy and paste the file *top_all36_prot.rtf*,  *toppar_water_ions.str* and *par_all36_prot.prm* to the same folder level 
  (same $PATH) than the 4ake_chaina.pdb structure (these files should be already in this folder)

- write these lines into a file called *4ake.pgn*:

  - > package require psfgen
  - > topology top_all36_prot.rtf
  - > pdbalias residue HIS HSE
  - > pdbalias atom ILE CD1 CD
  - > segment U {pdb 4ake_chaina.pdb}
  - > coordpdb 4ake_chaina.pdb U
  - > guesscoord
  - > writepdb 4ake_corr.pdb
  - > writepsf 4ake_corr.psf

- Correcting Structure. On a Kebnekaise Linux terminal  write:
  - > vmd -dispdev text -e 4ake.pgn  
  - type *exit* on VMD terminal to close it. You will obtain the .psf and .pdb with hidrogen atoms
  (4ake_corr.psf, 4ake_corr.psf)

- Solvation. Start VMD. On VMD Tk Console type:
  - > package require solvate
  - > solvate 4ake_corr.psf 4ake_corr.pdb -t 10 -o 4ake_wb 
  - Close VMD and check if the solvated protein molecule files (4ake_wb.psf, 4ake_wb.psf) were written.
  *-t 10* creates a water box whose sides are 10 Angstrom from the more distant protein atom.

- Ionization. On VMD, open the Tk console, use the following command to place Na and Cl ions at a 150mM 
  concentration:
  - autoionize -psf 4ake_wb.psf -pdb 4ake_wb.pdb -sc 0.15 -cation SOD
  - quit VMD
  - change the names of the resulting files *ionized.pdb* to *4ake_ion.pdb* and the same for *.psf* file

- On VMD open *4ake_ion.psf* and *4ake_ion.pdb*. Then on Tk console type:
  - > set everyone [atomselect top all]
  - > measure minmax $everyone
  - > measure center $everyone
  - Keep a record of the center of mass position. Quit VMD. 

- Modify the file *toppar_water_ions.str* (keep a backup copy of it) by adding the symbol *!*  (comment out) 
  to the following lines (useful editors: vim,nano,emacs when searching for line numbers):
  - 35-36, 40, 319-320, 322, 324-327, 346, 348-350, 352-353, 355, 358, 367-369, 373-375, 377, 379-380,
  383-384
  - on line 42 replace the string *@app* with *append* 

- Use the NAMD configuration file *4ake_eq.conf* and modify the values for the Adjustable Parameters.
*structure* corresponds to the *.psf* file of the ionized solvated protein, and *coordinates* is the *.pdb*
file for the same structure. 

- Use the NAMD configuration file *4ake_eq.conf* and modify the values for the Periodic Boundary Conditions part.
The *CellBasisVector* values can be obtain from your *4ake_ion.pdb* file on the first line.
Basis vector 1 corresponds to the first value after CRYST1, and so on for the other vectors.
These are the values that will replace the *FIXME* strings in this section. 
Note: Although the basis vectors from the *4ake_ion.pdb*  work in the present example, a better
set of values is 57.13 (vector1), 74.56 (vector2), and 70.97 (vector3).
cellOrigin  at       -1.8683815002441406 -4.4046807289123535 -10.453012466430664

- In the batch script *namd.sh* replace **Project_ID** with the project for the present course. Also,
add the line *#SBATCH --reservation=*. Submit the job to the queue with the command *sbatch namd.sh*

- Analysis of the results. On a Kebnekaise terminal type: *vmd 4ake_ion.psf 4ake_ion_eq.dcd*. Then, go to 
Extensions -> Analysis -> RMSD Trajectory Tool. Check the options *Backbone*, *Plot*, and click on
*ALIGN* and finally *RMSD*. This will plot the RMSD of the aligned protein w.r.t. the backbone atoms.


