# MB2C Merge Bin to Cue
A script that permit to generate a Cue sheet file (.cue) from a list of .bin files (PS1 or PSX image) to further create an eboot file for PSVITA.

## Usage
Put [binmerge] at the source of this scipt folder, and the content of the PSX or PS1 image bin files. Once done, execute ./b2c.sh.

```sh
Usage: ./b2c.sh [OPTIONS]
Options:
  -i <path>    Specify input folder path
  -o <file>    Specify output file name
  -h           Display this help message
Example: ./b2c.sh -i /path/to/folder -o output.cue
```

## Requirements
* [binmerge] The tool by putnam that permit to merge bin files
* [psx2psp] convert a single .iso or .bin file from psx or ps1 to EBOOT format readable into PSVITA Adrenaline emulator homebrew (/pspemu/PSP/GAME/_gameid_)
* [adrenaline] PSP or PSX emulator for PSVITA , by theOfficialFlow


[comment]: #
   [binmerge]: <https://github.com/putnam/binmerge>
   [psx2psp]: <https://github.com/SinisterSpatula/RetroflagGpiGuides/raw/master/data/PSX2PSP.zip>
   [adrenaline]: <https://github.com/TheOfficialFloW/Adrenaline>
