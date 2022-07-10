# Geo Time

Geo time is command line utility that provides local time and zone name of a location.


## Build instruction

stack build

## Run instruction
geotime --help

Eg:
> geotime
> geotime -c [File name]


## External Libraries used

1. **text**: Time and space efficient alernative for string type
2. **aeson**: for serialization/deserialization of types
3. **mtl**: for monad transformers
4. **optparse-applicative**: for parsing command line arguments
5. **exceptions**: for exception handling in monad tranformers. Has extensible exceptions that are compatible with the monad transformer library.
6. **bytestring**: for reading file content as ByteString.
7. **req**: for building and invoking https requests.

## GHC Extensions used
1. **OverloadedStrings**: For representing string literals as Text type instead of [Char]
2. **RecordWildCards**: used for deconstructing type objects.
3. **DeriveAnyClass**: used for autogenerating instance delcaration of custom classes that has no explicity defined methods.
4. **DeriveGenerics**: allows GHC to automatically allow generating instance of Generic types class for custom types. This needed by Aeson to serialize/deserialize your types.
5. **GeneralizedNewtypeDeriving**: allow newtype to auto derives the instances of the type it's wrapping.

## External APIs used
1. Timezone DB: https://timezonedb.com/references/get-time-zone
2. Nominatom: https://nominatim.org/release-docs/develop/api/Search


## Workflow 
1. Runs the command line parser to read user arguments into object of type **Args**.
1. Reads the config file as Byte String
2. Deserialize the content into object of type **AppConfig**.
3. Runs the **GeoTimeApp** transformer
   1. Ask user to enter the address for which user want to know the local time.
   2. Call Nominatom API to find  geo coordinates of the address.
   3. Call Timezone DB API with coordinates as input to get the local time and zone name.
   4. Displays the local time and zone name.