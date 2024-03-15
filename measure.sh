#!/bin/bash
NTIMES=10

#Compile sensors wich will be used to calculate cool temperature
cd RAPL
gcc -shared -o sensors.so sensors.c
cd ..

#Update the temperature value
cd Utils/
python3 temperatureUpdate.py
cd ..

echo "Language,Program,PowerLimit,Package,Core,GPU,DRAM,Time,Temperature,Memory" > measurementsGlobal.csv

# NOTE: TEST best powercaps for laptop fib with various powercaps

# Loop over power limit values o (-1) é sem powercap
PY_PATH=$(~/.miniconda3/bin/python3.11)
for limit in -1 2 5 10 25 50
    do
    cd Utils/
    python3 raplCapUpdate.py $limit ../RAPL/main.c
    cd ..
    #Make RAPL lib
    cd RAPL/
    rm sensors.so
    make
    cd ..

    while read -r program; do
        command_to_run="pyperformance run -b $program --python=$PY_PATH"

        sudo modprobe msr
        sudo ./RAPL/main "$command_to_run" Python "$program" "$NTIMES"

        # Specify the input file name
        file="measurements.csv"
        tail -n +2 "$file" >> measurementsGlobal.csv;
    done < benches_to_run

done

cd RAPL/
make clean
cd ..

# TODO Para refazer sem powercap é preciso reboot, se não não funciona
# sudo reboot
