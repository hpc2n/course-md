# Working with NAMD

Files needed for NAMD (standard MD simulation):

   - configuration file
      - psf file (gen2xplor.psf)
      - coordinates file (box_water_nacl_eq.pdb)
      - parametens file (par_all27_prot_na.prm)

## Running NAMD

### MPI CPU version 

```
#SBATCH -N 1
#Ask for processes
#SBATCH -n 28

ml purge > /dev/null 2>&1
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-mpi 
mpirun -np 28 namd2 config-file.inp > output_cpu.dat
```

### GPU version


```
#SBATCH -N 1
#Ask for processes
#SBATCH -n 28
#SBATCH --gres=gpu:k80:2
#SBATCH --exclusive

ml purge > /dev/null 2>&1
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 config-file.inp > output_gpu.dat
```

## Analyzing the logfile

### Computing the number of nanoseconds per day (ns/day)

#### Python
```
ml purge > /dev/null 2>&1
python ns_per_day.py output_cpu.dat
```

#### Julia
```
ml purge > /dev/null 2>&1
ml Julia/1.7.1-linux-x86_64
julia ns_per_day.jl output_cpu.dat
```
