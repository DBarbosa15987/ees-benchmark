## On the Energy Efficiency of Sorting Algorithms

### Authors
* [Simão Cunha](https://github.com/simaocunha71)
* [Luís Silva](https://github.com/LuisMPSilva01)
* [João Saraiva]
* [Diogo Barbosa]
* [João Sousa]


### Prerequisite Libraries
1. RAPL
2. lm-sensors
3. Powercap
4. Raplcap
5. python11
6. pyperformance

### Setup Instructions
To run these benchmarks, you need to install the pyperformance benchmarking suite by executing the following command:

```bash
pip install pyperformance
```

### Execution Steps
To conduct the tests, select benchmarks from the available options provided by pyperformance listed here: [Pyperformance Benchmark List](https://pyperformance.readthedocs.io/benchmarks.html#available-benchmarks).

Add the chosen benchmarks to the `benchmarks_to_run` file.

Afterwards, execute the benchmark script using the following command:

```bash
sh measure.sh
```

This script utilizes the `pyperformance -b` command to individually run each selected test with RAPL. The resulting measurements will be stored in `measurementsGlobal.csv`.

> [!CAUTION]
> In case adjustments are needed in the `measure.sh` script, you might have to modify the `PY_PATH` variable to match your system's specifications.

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
