# Getting a Potential Mean of Force for Na-Cl with Adaptive Bias Force (ABF) method

- Load the VMD modules on Kebnekaise:

  ```
  ml GCC/9.3.0  OpenMPI/4.0.3
  ml VMD/1.9.4a43-Python-3.8.2
  ```

- Move to the Steered MD folder in case you are not there already (cd SteeredMD)

  Visualize both trajectories that you already obtained:

  ```
  vmd gen2xplor.psf smd_outa.dcd smd_outb.dcd 
  ```

  and choose frames within 4 A and 10 A of separation for the Na-Cl pair. You can save the frames
  by clicking on the **gen2xplor.psf** structure in VMD then with the mouse right bottom choose
  *Save Coordinates*. In *Selected atoms* write **all** and choose the frame you want to save.
  For this exercise, use the names **win1start.pdb, win2start.pdb, ..., win7start.pdb** (we will use
  only 7 frames but in a realistic case you may use more). 
 
- Go to the **ABF** folder and create a subfolder for each window (**window1, window2, ..., window7**).
  Copy each **win\*start.pdb** file obtained in the **SteeredMD** to the corresponding window subfolder
  in **ABF**. 

- The simulations of each window will run independently of the others. For each window you will
  need to copy the file **abf.inp** to the windows folders. Fix the *pdbfile* name with the
  pdb file of the corresponding window. Also, fix the *outputName* and *restartName* with a
  tag for the window, for instance, 1,2,...,7.

- The ABF options are set in the *colvars on* section through the **input.in** file. Here, we
  choose the Na+ and Cl- ions to define a *distance* collective variable. We will
  set the value of *upperBoundary* as the initial separation +2A and *lowerBoundary* as the
  initial separation -2A. Also, we will use *upperBoundary=upperWall* and *lowerBoundary=lowerWall*.
  For instance, for the window1, we choose the initial separation equal to 4A, thus, 
  *upperBoundary=upperWall=6* and *lowerBoundary=lowerWall=2*.

- Copy the batch script **namd_abf.sh** to each folder and fix the SNIC project name. Submit the
  job to the queue for each window.

