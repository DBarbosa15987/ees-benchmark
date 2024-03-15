## On the Energy Efficiency of Sorting Algorithms

### Authors
* [Simão Cunha](https://github.com/simaocunha71)
* [Luís Silva](https://github.com/LuisMPSilva01) 
* [João Saraiva]


### Required libraries
1. RAPL
2. lm-sensors
3. Powercap
4. Raplcap

### Setup
In order to install all the required libraries, you should execute the script:

```sudo sh measureSetup.sh```

Then, to generate the CSV file, execute the script:

```sh measure.sh```

### Meaning of the CSV file columns
* **Language** : Programming language of the sorting algorithm;
* **Program** : Name of the program running;
* **Package** : Energy consumption of the entire socket- all cores consumption, GPU e external core components);
* **Core** : Energy consumption by all cores and caches;
* **GPU** : Energy consumption by the GPU;
* **DRAM** : Energy consumption by the RAM;
* **Time** : Algorithm's execution time (in ms);
* **Temperature** : Mean temperature in all cores (in ºC);
* **Memory** : Total physical memory assigned to the algorithm execution (in KBytes);
* **PowerLimit** : Power cap of the cores (in Watts)