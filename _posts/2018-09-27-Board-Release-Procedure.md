---
title: "Board Release Procedure"
---
A Board Release Procedure helps you to avoid mistakes when finishing a PCB design and ensures the proper archiving of the source files.

Robert Feranic from Fedevel Academy has a [great video on Youtube](https://www.youtube.com/watch?v=ZpMvKJzZk90) explaining in more detail.

Here I included my BRP as reference. 
All of the boards I desing and/or superwise at Intech follow this standard. (Since 2017)
This document is tailored to be used with the PCB package Proteus Professional. 

<!--more-->

```
**Instructions**
EXECUTE IN ORDER STARTING FROM STEP 1.
**Check**
 1. Use global anotator to reanotate the whole design (Total)
 2. Check ERC of the schematic
 3. Regenerate all copper fills.
 4. Check Copper fill clearances.
 5. Check PCB Stackup
 6. Check High-speed differential routing and impedance.
 
**Export**
1. Generate Screenshot of 3D Board View into '/Render' folder. (min. Top & Bottom)
2. Generate PDF Artwork of PCB View into '/Render' folder. 
3. Run Pre-Production Check! 
(Errors and Warnings are not allowed under any circumstances without added documentation)
4. Generate Gerber files into '/Gerber' folder.

**Verify**
1. Check Gerber files individually in Gerber Viewer.
2. Send the gerber files out to the manufacturer.
3. Generate archive containing '/Gerber', '/Render' & '/Source' folders.
4. Name the archive 'DATE_PROJECTNAME_REVISION_YOURINITIALS.z7'. (Date format: YYYY.MM.DD)
5. Place the archive in backup folder.
6. Commit and Push everything.
```
