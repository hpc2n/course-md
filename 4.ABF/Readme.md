# Getting a Potential Mean of Force for Na-Cl with Adaptive Biasing Force (ABF) method

## Theory

The free energy along some reaction coordinate <img src="https://render.githubusercontent.com/render/math?math=\xi">
can be computed as follows [1]:

<p align="center">
<img src="https://render.githubusercontent.com/render/math?math=A(\xi)=-\frac{1}{\beta}\ln P(\xi) + A_0">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=P(\xi)"> is the probability along
the reaction coordinate and <img src="https://render.githubusercontent.com/render/math?math=A_0"> is a reference 
value. By using the expression of the free energy a force can be defined w.r.t. the reaction coordinate:

<p align="center">
<img src="https://render.githubusercontent.com/render/math?math=\frac{dA(\xi)}{d\xi}=\langle \frac{\partial U(x)}{\partial \xi} -\frac{1}{\beta} \frac{\ln |J|}{\partial \xi} \rangle = -\langle F_{\xi} \rangle_{\xi} ">
</p>

Here, <img src="https://render.githubusercontent.com/render/math?math=U(x)"> is the potential energy, 
<img src="https://render.githubusercontent.com/render/math?math=|J|"> is the determinant of the transformation of 
coordinates computed through the Jacobian. <img src="https://render.githubusercontent.com/render/math?math=-\langle F_{\xi} \rangle_{\xi}"> is 
the average of the force. In this way, the biasing force can be computed as:

<p align="center">
<img src="https://render.githubusercontent.com/render/math?math=F^{ABF} = \nabla_{x}A_{estimated} = -\langle F_{\xi} \rangle_{\xi} \nabla_{x} \xi">
</p>

## Exercise

* Load the VMD modules on Kebnekaise:

  ```
  ml GCC/9.3.0  OpenMPI/4.0.3
  ml VMD/1.9.4a43-Python-3.8.2
  ```

* Go to the Steered MD folder in case you are not there already (cd SteeredMD)

  Visualize both trajectories that you already obtained:

  ```
  vmd gen2xplor.psf smd_outa.dcd smd_outb.dcd 
  ```

  and choose frames within 4 A and 10 A of separation for the Na-Cl pair. You can save the frames
  by clicking on the **gen2xplor.psf** structure in VMD then with the mouse right bottom choose
  *Save Coordinates*. In *Selected atoms* write **all** and choose the frame you want to save.
  For this exercise, use the names **win1start.pdb, win2start.pdb, ..., win7start.pdb** (we will use
  only 7 frames but in a realistic case you may use more). 
 
* Go to the **ABF** folder and create a subfolder for each window (**window1, window2, ..., window7**).
  Copy each **win\*start.pdb** file obtained in the **SteeredMD** to the corresponding window subfolder
  in **ABF**. 

* The simulations of each window will run independently of the others. For each window you will
  need to copy the file **abf.inp** to the windows folders. Fix the *pdbfile* name with the
  pdb file of the corresponding window. Also, fix the *outputName* and *restartName* with a
  tag for the window, for instance, **abf_out1, abf_out2,...,** and **abf_out7**.

* The ABF options are set in the *colvars on* section through the **input.in** file. Here, we
  choose the Na+ and Cl- ions to define a *distance* collective variable. We will
  set the value of *upperBoundary* as the initial separation +2A and *lowerBoundary* as the
  initial separation -2A. Also, we will use *upperBoundary=upperWall* and *lowerBoundary=lowerWall*.
  For instance, for the window1, we choose the initial separation equal to 4A, thus, 
  *upperBoundary=upperWall=6* and *lowerBoundary=lowerWall=2*.

* Copy the batch script **namd_abf.sh** to each folder and fix the SNIC project name. Submit the
  job to the queue for each window.

* Once you have the results of all windows, create subfolder called *MERGE* in *ABF*. Then, copy the
  files **abf_outX.count** and **abf_outX.grad** from each window to the *MERGE* folder. If you are
  en the *ABF* folder, you can use the following script to copy these files:


> for i in `seq 1 7`; do cp window${i}/abf_out${i}.count MERGE/ ; done 

> for i in `seq 1 7`; do cp window${i}/abf_out${i}.grad MERGE/ ; done


  Copy the *abf.inp*, *input.in*, and *win1start.pdb* files from the *window1* folder to the *MERGE*
  folder. In the *abf.inp* file set the number of steps to 0. In *input.in* set *colvarsTrajFrequency =
  colvarsRestartFrequency = 0*, also *upperBoundary = upperWall = 12* so that the whole range from 2A
  to 12A is covered now. In addition to this, add the line:

  ```
  inputPrefix abf_out1 abf_out2 abf_out3 abf_out4 abf_out5 abf_out6 abf_out7
  ```

  to the **abf {}** section. On the terminal load the following modules

  ```
  ml purge  > /dev/null 2>&1
  ml GCC/10.3.0  OpenMPI/4.1.1
  ml NAMD/2.14-mpi
  ```

  and run the namd script:  **namd2 abf.inp**. The resulting *abf_out1.pmf* will contain the PMF
  computed along the whole range of the chosen collective variable. If the PMF did not converge, 
  one way to improve it is by increasing the number of steps in **abf.inp** (nsteps) to 500000.

### Solution

In case you couldn't get the input files and resulting trajectories, some solution can be
found in the **files** folder.


## References

1. https://www.ks.uiuc.edu/Research/namd//2.6b2/ug/node35.html
2. https://colvars.github.io/colvars-refman-vmd/colvars-refman-vmd.html
