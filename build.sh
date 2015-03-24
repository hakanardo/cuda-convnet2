#!/bin/sh
# Copyright 2014 Google Inc. All rights reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################

# Fill in the below environment variables.
#
# If you're not sure what these paths should be, 
# you can use the find command to try to locate them.
# For example, NUMPY_INCLUDE_PATH contains the file
# arrayobject.h. So you can search for it like this:
# 
# find /usr -name arrayobject.h
# 
# (it'll almost certainly be under /usr)

# CUDA toolkit installation directory.
export CUDA_INSTALL_PATH=/usr/

# Python include directory. This should contain the file Python.h, among others.
export PYTHON_INCLUDE_PATH=/usr/include/python2.7

# Numpy include directory. This should contain the file arrayobject.h, among others.
export NUMPY_INCLUDE_PATH=/usr/lib/python2.7/dist-packages/numpy/core/include/numpy/

# ATLAS library directory. This should contain the file libcblas.so, among others.
export ATLAS_LIB_PATH=/usr/lib/atlas-base

# You don't have to change these:
export LD_LIBRARY_PATH=$CUDA_INSTALL_PATH/lib64:$LD_LIBRARY_PATH
export CUDA_SDK_PATH=`pwd`
export PATH=$PATH:$CUDA_INSTALL_PATH/bin

GENCODE_SM35="-gencode arch=compute_35,code=sm_35"
GENCODE_SM30="-gencode arch=compute_30,code=sm_30"
export GENCODE_FLAGS="$GENCODE_SM30"

#FLAGS="-j"
make -C util numpy=1 $FLAGS $* || exit -1
make -C nvmatrix $FLAGS $* || exit -1
make -C cudaconv3 $FLAGS $* || exit -1
make -C cudaconvnet $FLAGS $* || exit -1
make -C make-data/pyext $FLAGS $* || exit -1

