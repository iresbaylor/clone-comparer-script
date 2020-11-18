# clone-comparer-script

This is a script project written to run multiple code clone detection tools and compare the results to each other. It wraps multiple projects into one script. The full script has only been tested on Ubuntu & RHEL Linux but will likely run on Mac as well. For Windows, you might try Cygwin.

## Setup

To run this script, you'll need to do the following:

1. Clone the repository with the submodules. This will install both Cyclone and the comparer tool.

```
git clone --recurse-submodules https://github.com/iresbaylor/clone-comparer.git
```

2. Install [TxL](https://www.txl.ca/txl-index.html). You'll need to do it as the superuser or NiCad won't be able to build correctly.

3. Download a copy of [NiCad](https://www.txl.ca/txl-nicaddownload.html) and place it under tools/NiCad/. Follow the instructions to initialize it.

4. Get a copy of the [Moss script](https://theory.stanford.edu/~aiken/moss/), name it moss, and put it under tools/Moss/

5. As instructed in the Moss documentation, retrieve a user ID and update the $userId parameter in the moss script.

6. Install [PyPy](https://www.pypy.org/) for Python 3. Make sure the pypy executable is in your path.

7. Run init.sh to create the Python virtual environment.

You may get an error when installing psycopg2 about needing to install a PostgreSQL package. You'll need to find the appropriate package for your operating system. On Ubuntu, run:

```
sudo apt-get install libpq-dev
```

8. Install [Maven](https://maven.apache.org/download.cgi) and [Java 15](https://jdk.java.net/15/) to run the comparer tool. Make sure both executables are in your path.

9. Build the project by navigating to tools/clone-comparer and running:
```
mvn clean install
```

## Running the project

1. Assemble a list of URLs for GitHub repositories you want to compare. Drop them in a file (see repositories.txt for an example).

2. Source the build environment:

```
source tools/codeDuplicationParser/venv/bin/activate
```

3. Run the comparer: 

```
./run.sh <mode (single/double) <repository_file>
```

4. The results will be under output-single-\<timestamp\>.csv or output-double-\<timestamp\>.csv, depending on which mode you ran.
