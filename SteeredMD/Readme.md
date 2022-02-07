# Setting up a Steered MD simulation (SMD) 

- Visualize the structure in the PDB file **box_water_nacl_eq.pdb**. This is a water box
  with one Na+ and one Cl- ions. They are approximately aligned in the X-direction.

- The goal of this exercise is that you generate a trajectory path that contains the
  Na-Cl ions at different separation distances. We will use this trajectory in the next
  section.

- The configuration file for running SMD is called **smd.inp**. The specific part for SMD
  within this file starts on line 130 with the "SMD on" instruction. SMD uses a reference file
  **smd.ref** in this case, to especify the atoms to which a steering force will be applied.

  **smd.ref** can be a copy of the initial PDB structure (**box_water_nacl_eq.pdb**),
  the only thing that needs to be modified is the occupancy column of the steered atoms
  which needs to be labeled with a non-zero value. In the present case, because we will
  apply a force on the Na+ atom, you need to change its occupancy to 1.00, for instance.

  The force constant, the velocity, and the direction of the steering force can be set in the
  SMD section as well, keywords SMDk, SMDVel, SMDDir, respectively.

  If we steer only the Na+ ion, the Cl- ion will tend to move along and we will not observe the pair
  Na-Cl at different separation distances. To avoid this issue, we can use "constraints on"
  in the configuration file. This uses a reference file called **rest.ref** where the atoms
  that need to be constraint at their initial positions are especified in the occupancy 
  column as we did in **smd.ref**. Notice that here, the Cl- is the one that needs to change
  its occupancy (use 1.00).

  Run the script **smd.inp** for 50,000 steps in the direction **1 0 0** and the same amount of
  steps in the **-1 0 0** direction. This will allow you to get Na-Cl separations longer and 
  shorter than the initial 5.3A separation of Na-Cl. The direction can be changed with the
  SMDDir option.
   
  Note: change the value of **outputName** for both simulations otherwise the outputs will be
  overwritten, for instance, you can use **smd_outa** and **smd_outb** for the output names.

  Submit the batch script **namd.sh** to the queue after fixing the SNIC project name.


# Getting a Potential Mean of Force for Na-Cl with Adaptive Bias Force (ABF) method

- Load the VMD modules on Kebnekaise:

  ```
  ml GCC/9.3.0  OpenMPI/4.0.3
  ml VMD/1.9.4a43-Python-3.8.2
  ```

  Visualize both trajectories:

  ```
  vmd gen2xplor.psf smd_outa.dcd smd_outb.dcd 
  ```

  and choose frames within 4 A and 10 A of separation for the Na-Cl pair. You can save the frames
  by clicking on the **gen2xplor.psf** structure in VMD then with the mouse right bottom choose
  *Save Coordinates*. In *Selected atoms* write **all** and choose the frame you want to save.
  For this exercise, use the names **win1start.pdb, win2start.pdb, ..., win7start.pdb**. 
  
  Now, create a folder for each window (**window1, window2, ..., window7**) and  copy the
  **win\*start.pdb** file to the corresponding folder. 

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
  job to the queue

