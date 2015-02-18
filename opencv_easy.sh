#!/bin/bash

echo "

   ____                    _______      __ 
  / __ \                  / ____\ \    / / 
 | |  | |_ __   ___ _ __ | |     \ \  / /  
 | |  | | '_ \ / _ \ '_ \| |      \ \/ /   
 | |__| | |_) |  __/ | | | |____   \  /    
  \____/| .__/ \___|_| |_|\_____|   \/     
        | |                                
        |_|                                

author :Jewel James
mailjeweljames@gmail.com
        "

sleep 5
echo "Removing possible redundancies"
sudo apt-get -y remove ffmpeg x264 libx264-dev
echo "Installing git. We need this to clone the opencv source"
sudo apt-get -y install git
echo "Installing other dependencies"
sudo apt-get -y install libopencv-dev 
sudo apt-get -y install build-essential checkinstall cmake pkg-config yasm
sudo apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev
sudo apt-get -y install python-dev python-numpy
sudo apt-get -y install libtbb-dev
sudo apt-get -y install libqt4-dev libgtk2.0-dev
sudo apt-get -y install libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev
sudo apt-get -y install x264 v4l-utils ffmpeg
echo "Downloading OpenCV from Itseez's github repo"
git clone https://github.com/Itseez/opencv.git
git checkout -b 2.4
cd opencv
rm -rf build
mkdir build
cd build
clear
echo "

Configuring OpenCV ...


"
sleep 5
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON..
clear
echo "

Compiling OpenCV source ...


"
sleep 5
sudo make -j4
echo "

Installing compiled files ...


"
sleep 5
sudo make install
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
cd ..
rm -rf ./build/
echo "

Installation finished . Testing with face detect

"
python /samples/python2/facedetect.py
exit