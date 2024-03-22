#!/bin/bash
NTIMES=10
PY_PATH="/home/diogo/miniconda3/bin/python3.11"

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
for limit in -1 5 10 15 20 25 50 
    do

    printf "\033[0;34mStarting limit %s \033[0m" "$limit"

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

	    echo -e "\nRunning $program\n"
        sudo modprobe msr
        sudo ./RAPL/main "$command_to_run" Python "$program" "$NTIMES"

        # Specify the input file name
        file="measurements.csv"
        tail -n +2 "$file" >> measurementsGlobal.csv;

        printf "\033[0;34mCooling down before next benchmark\033[0m"
        sleep 60

    done < benches_to_run

done

cd RAPL/
make clean
cd ..

sudo shutdown
