# Developer Instructions

There is no difference in installing Augur for our fork versus the main Augur project; however we installed and deployed our Augur fork to an EC2 instance, rather than installing locally via Vagrant. The instructions for installing and deploying the Augur project are as follows:

1. Boot up an Ubuntu server instance on AWS.

2. Install all dependencies for Augur.

```bash
# Install NodeSource
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# Install NodeJS
sudo apt-get install -y nodejs

# Install MariaDB (if needed on the same machine for the GHTorrent/msr14 dataset)
sudo apt-get install -y mariadb-server

# Install Anaconda
curl https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh > Anaconda.sh
chmod +x Anaconda.sh

# You must agree to Anaconda's license terms to proceed
./Anaconda.sh -b
rm Anaconda.sh
```

3. Install the Augur project on the server:

```sh
git clone https://github.com/computationalmystic/augur-group10.git

## Assume you are in the root from which you cloned augur
cd augur ## To get to augur root, where the make files live

# Install the Python and Node tools and libraries needed
sudo make install-dev # some libraries require a root install.

# Re-install augur project (-e flag makes it so you can modify the backend without re-installing over and over)
# * In the augur root folder *
pip install -e .
```

4. Configure the Augur config file. (augur.config.json)

```js
// Replace <GitHub API Key> with your GitHub personal access token.
// This uses the existing Facade and GHTorrent databases created by Professor Goggins.

{
    "Cache": {
        "config": {
            "cache.data_dir": "runtime/cache/",
            "cache.lock_dir": "runtime/cache/",
            "cache.type": "file"
        }
    },
    "Database": {
        "connection_string": "sqlite:///:memory:"
    },
    "Development": {
        "developer": "0",
        "interactive": "0"
    },
    "Facade": {
        "host": "classes.augurlabs.io",
        "name": "git_minimal",
        "pass": "password",
        "port": "3306",
        "projects": ["Twitter"
        ],
        "user": "augur"
    },
    "GHTorrent": {
        "host": "classes.augurlabs.io",
        "name": "ghtorrent_minimal",
        "pass": "password",
        "port": "3306",
        "user": "augur"
    },
    "GitHub": {
        "apikey": "<GitHub API Key>"
    },
    "LibrariesIO": {
        "apikey": ""
    },
    "Plugins": [],
    "PublicWWW": {
        "apikey": ""
    },
    "Server": {
        "cache_expire": 3600,
        "host": "0.0.0.0",
        "port": "5000",
        "workers": 6
    }
}
```

5. Start the Augur server(s)

```sh
# * In the Augur root folder...*
# To start the server w/o monitoring in the terminal
make dev-start

# To start the server with monitoring in the terminal
make dev

# To stop the server
make dev-stop
```
