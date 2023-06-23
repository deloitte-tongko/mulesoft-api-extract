# Mulesoft API sizer

This sizer aims at giving a simple and effective solution to automate sizing of several APIs in one go.

> \*Warning! The provided example scripts in /src is not intended to be a foolproof method for high accuracy due to usages with `grep`. If this is important to you, I highly recommend implementing this using proper xml parsers such as `xmlstarlet`. However, the current implementation is a good guidance for implementation and also accuracy for simple and consistent APIs.

> \*Warning 2! Be careful of script injection, depending on the implementation, some of the inputs are not being sanitised, please be careful with the data being run.

## Requirements

The script requires a bash shell execution in a linux environment (developed in WSL ubuntu). The following packages are needed dependencies for the script (most come by default)

- git
- mkdir
- echo
- rm
- find
- grep/egrep
- xargs
- cat
- awk

## API features

- Runtime version
- API datatype properties
- API data types
- API RAMLs (HTTP method is commented out)
- Dataweave scripts (embedded and externalised)
- Flow components
- Flows and Subflows
- Global Elements
- Java, Groovy and Script Files (including LOC)
- MUNIT tests and samples

## TODO

- Allow for different types of repositories (currently only git)
- Implementation for Windows OS
- Allow for multiple branch acceptance (main/master/feature/etc.)
- Remove /tmp when the process is changed from using temp file and instead injection
- Optargs are a little awkward for `extract-apis.sh`
- Seperate the main extraction file into more readable format
- Make the use of variables moer consistent (some variables aren't lower case, etc.)
- Add more documentation on creating columns
- Maybe document code a little more with comments
- git credentials

## Setup

- Make sure all package dependencies are installed.
- Create a `config.sh` file with details such as repositories, src path, api path, files, owner, etc. Follow the `config.example.sh`.
- Create a file referenced by `SRCS_FILE` in `config.sh` and populate with src files which indicate the columns in the output csv file.

## Usage

### Single API (`extract-api.sh`)

- Basic usage for one API (prompted)

      ./extract-api.sh

- for specific API

      ./extract-api.sh -i <API-NAME>

- Example: verbose API to a specific file

      ./extract-api.sh -vi <API-NAME> -o <OUTPUT-FILE>

- Additional option arguments

  - -h: help and usage
  - -i <API-NAME>: input API (unprompted)
  - -o <OUTPUT-FILE>: output file path
  - -n: no output
  - -r: replace existing data
  - -v: verbose logs

### Multiple APIs (`extract-apis.sh`)

For long list of APIs, create a file referenced by `APIS_FILE` in `config.sh` to contain the list of APIs line by line.

- Basic usage (recurring prompts)

      ./extract-apis.sh

- Input list

      ./extract-apis.sh -i

- Example: verbose API with API list input and replace previous output

      ./extract-apis.sh -vri

- Additional option arguments

  - -h: help and usage
  - -i: input files
  - -o: output file path
  - -r: replace previous data
  - -v: verbose logs

## Creating your own columns

The code works by appending the data extracted to both heading and row, each of these extractors should be placed in `SRC_PATH` and should append to `HEADING` and `ROW`. Once the extractor is created, it needs to be added to the `SRC_FILES` array.
