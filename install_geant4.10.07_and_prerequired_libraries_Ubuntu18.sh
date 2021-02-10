#!/bin/bash 
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
#a Linux bash script to auto-install Geant4.10.07 and prerequired libraries.
#Author: Jaafar EL Bakkali
#E-mail: jaafar.elbakkali.pro@gmail.com
#08/02/2021:
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#
cd ..
interdosi_dir=$(pwd)
number_of_cores=$(nproc)
mkdir -p prerequired_libraries
cd prerequired_libraries
# prerequiered ubuntu libraries.
sudo apt-get install libxaw7-dev libxaw7 mesa-common-dev libglu1-mesa-dev -y qt5-default libicu-dev valgrind
# cmake library.
wget -nc https://github.com/Kitware/CMake/releases/download/v3.14.0-rc4/cmake-3.14.0-rc4.tar.gz
tar -xvf cmake-*.tar.gz
cd cmake-3.14.0-rc4
./configure
make -j$number_of_cores
sudo make install
cd ..
# hdf5 c++ library.
 wget -nc https://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.10.5.tar.gz
tar -xvf hdf5-1.10.5.tar.gz
cd hdf5-1.10.5
./configure --enable-cxx --enable-threadsafe --enable-unsupported --prefix=/opt/hdf5 
make -j$number_of_cores
sudo make install
cd ..
# xerces-c-3.2.3
wget -nc https://downloads.apache.org//xerces/c/3/sources/xerces-c-3.2.3.tar.gz
tar -xvf xerces-c-3.2.3.tar.gz
cd xerces-c-3.2.3
./configure --prefix=/opt/xerces-c-3.2.3 
make -j$number_of_cores
sudo make install
xerces_root_dir=/opt/xerces-c-3.2.3 
cd ..
# Geant4.10.07
wget -nc https://geant4-data.web.cern.ch/releases/geant4.10.07.p01.tar.gz
tar -xvf geant4.10.07.p01.tar.gz
mkdir  geant4.10.07-build
mkdir geant4.10.07-install
cd geant4.10.07-install
geant4_install_dir=$(pwd)
cd ..
cd geant4.10.07-build
cmake  -DGEANT4_INSTALL_DATA=ON   -DXERCESC_ROOT_DIR=$xerces_root_dir -DGEANT4_USE_GDML=ON -DGEANT4_USE_HDF5=OFF  -DGEANT4_USE_SYSTEM_EXPAT=OFF -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_QT=ON -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_USE_USOLIDS=OFF -DCMAKE_INSTALL_PREFIX=$geant4_install_dir ../geant4.10.07
make -j$number_of_cores
make install
cd ..
EOM
echo "           ******************************************************************************"
echo "               installation of Geant4.10.7 and prerequired librarieshas been finished."
echo "           ******************************************************************************"
echo " "
printf "Press 'CTRL+C' to exit : "
trap "exit"
while :
do
sleep 10000 
done
