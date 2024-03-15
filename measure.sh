#!/bin/bash
NTIMES=10

#Compile sensors wich will be used to calculate cool temperature
cd RAPL
gcc -shared -o sensors.so sensors.c
cd ..

#Update the temperature value
cd Utils/
python3 temperatureUpdate.py

#Update the number of times the program will run on each case TODO PRECISO ATUALIZAR ISTO PARA TODOS OS PROGRAMAS
for program in "../ex1"/*; do
    if [ -d "$program" ]; then
        makefile_path="$program/Makefile"
        if [ -f "$makefile_path" ]; then
            python3 ntimesUpdate.py "$NTIMES" "$makefile_path"
        else
            echo "Makefile not found: $makefile_path"
        fi
    fi
done
cd ..

# TODO Fazer drop das colunas GPU,DRAM e Language?
echo "Language,Program,PowerLimit,Package,Core,GPU,DRAM,Time,Temperature,Memory" > measurementsGlobal.csv

pwd

# Loop over power limit values o (-1) é sem powercap
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


    #TODO Fazer append do size do array e talvez do comando de compile (para as flags de compile), e mudar o resto
    # program="ex1/"
    for program in "ex1"/*; do
        if [ -d "$program" ]; then
            makefile_path="$program/Makefile"
            if [ -f "$makefile_path" ]; then
                cd $program
                make compile
                make measure

                # Specify the input file name
                file="measurements.csv"
                tail -n +2 "$file" >> ../../measurementsGlobal.csv;
                make clean
                cd ../../
            else
                echo "Makefile not found: $makefile_path"
            fi
        fi
    done

done

cd RAPL/
make clean
cd ..

# TODO Para refazer sem powercap é preciso reboot, se não não funciona
# sudo reboot