#!/bin/bash
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2017 Oracle and/or its affiliates. All rights reserved.
# 
# Since: January, 2017
# Author: gerald.venzl@oracle.com
# Description: Applies all patches to the Oracle Home
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 

# Make sure Oracle perl binary is in PATH
PATH=$ORACLE_HOME/perl/bin:$PATH

# Patch database binaries with patch sets
cd $PATCH_INSTALL_DIR/

#  If exists, install newer OPatch version if present
if [ -f p6880880*.zip ]; then
   # Unzip and remove zip file
   unzip p6880880*.zip
   rm p6880880*.zip
   # Remove old OPatch folder
   rm -rf $ORACLE_HOME/OPatch
   # Move new OPatch folder into ORACLE_HOME
   mv OPatch $ORACLE_HOME/
fi;

# Loop over all directories (001, 002, 003, ...)
for file in `ls -d */`; do
   # Go into sub directory (cd 001)
   cd $file;

   # Apply patch
   opatch apply -silent

   # Go back out of patch directory
   cd ../
   # Clean up patch directory (-f needed because some files 
   # in patch directory may not have write permissions)
   # rm -rf */
   # # Delete any xml artifacts if present.
   # rm -f *.xml
   # Go back into root directory
done;

cd $HOME

rm -rf $PATCH_INSTALL_DIR
