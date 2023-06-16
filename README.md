# Mulesoft API sizer

This sizer aims at giving a simple and effective solution to automate sizing of several APIs in one go.

> \*Warning! The provided example scripts in /src is not intended to be a foolproof method for high accuracy due to usages with `grep`. If this is important to you, I highly recommend implementing this using proper xml parsers such as `xmlstarlet`. However, the current implementation is a good guidance for implementation and also accuracy for simple and consistent APIs.

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

- API datatype properties
- API data types
- API RAMLs
- Dataweave scripts (embedded and externalised)
- Flow components
- Flows and Subflows
- Global Elements
- Java, Groovy and Script Files (including LOC)
- MUNIT tests and samples

## TODO

- Allow for different types of repositories (currently only git)
- Implementation for Windows OS

## Usage

- Make sure all package dependencies are installed.
- Create a `config.sh` file with details such as repositories, paths, files, owner, etc. Follow the `config.example.sh`.
- Basic usage for one API (prompted)

      ./extract-api.sh

- for specific API

      ./extract-api.sh <API-NAME>

- For long list of APIs, modify `ALL_API` in `all-api.sh` to contain the list of APIs and run

      ./extract-apis.sh

- Additional option arguments
  - -h: help and usage
  - -n <API-NAME>: normal (default)
  - -v <API-NAME>: verbose logs
  - -p: prompted api

## Creating your own columns

The code works by appending the data extracted to both heading and row, each of these extractors should be placed in `SRC_PATH` and should append to `HEADING` and `ROW`. Once the extractor is created, it needs to be added to the `SRC_FILES` array.
