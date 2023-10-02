# KVFinder-web portal

![GitHub release (latest by date)](https://img.shields.io/github/v/release/LBC-LNBio/KVFinder-web-portal?color=informational)
![GitHub](https://img.shields.io/github/license/LBC-LNBio/KVFinder-web-portal)

Welcome to the KVFinder-web portal, this page was built to help you get started with our web portal for [KVFinder-web service](https://github.com/LBC-LNBio/KVFinder-web-service).

## KVFinder-web

KVFinder-web is an open-source web-based application of an updated version of [parKVFinder](https://github.com/LBC-LNBio) software (v1.2.0) for cavity detection and characterization of any type of biomolecular structure. The characterization includes spatial, depth, constitutional and hydropathy characterization.

The KVFinder-web has two independent components:

- a RESTful web service: [KVFinder-web service](https://github.com/LBC-LNBio/KVFinder-web-service);
- a graphical web portal: [KVFinder-web portal](https://github.com/LBC-LNBio/KVFinder-web-portal)

To broaden the range of possibilities for user interaction, we also provide additional client-side applications, that are:

- a graphical PyMOL plugin: [PyMOL KVFinder-web Tools](https://github.com/LBC-LNBio/PyMOL-KVFinder-web-Tools);
- an example of a Python HTTP client: [http-client.py](https://github.com/LBC-LNBio/KVFinder-web-service/blob/master/http_client.py)

The full KVFinder-web documentation can be found here: [http://lbc-lnbio.github.io/KVFinder-web](http://lbc-lnbio.github.io/KVFinder-web).

### KVFinder-web portal

The KVFinder-web portal, developed in R Shiny, delivers the major functionalities of the KVFinder-web service, where users can load a target biomolecule, adjust detection parameters, select run modes, and download and visualize results. The web portal provides a simple and interactive way to analyze and visualize cavities. Volumes and areas are shown in an interactive table that can be downloaded in TOML format. A biomolecule viewer, powered by the NGL engine for R, displays the biomolecular structure with its cavities, which can be downloaded in PDB format, and allows various customizations, such as highlighting cavities and displaying interface residues surrounding them.

We provide a publicly available KVFinder-web service at [https://kvfinder-web.cnpem.br](https://kvfinder-web.cnpem.br) with KVFinder-web portal as the graphical web interface.

#### Local installation

To run locally the KVFinder-web portal in Linux distributions, it is necessary to install docker-compose and its dependencies. To install it:

```bash
sudo apt install docker-compose
```

Before using the KVFinder-web portal, you need to configure the URL address for the KVFinder-web service. Open the [app_server.R](kvfinder-web-portal/R/app_server.R#L14-L24) file and define the URL address:

If KVFinder-web service is running on your local machine, use the first configuration:

```r
url_address <- "http://localhost:8081/"
```

If KVFinder-web service is on a different containers in the same network, replace <ip> in the second configuration with the actual IP address of that machine.

```r
url_address <- "http://<ip>:8081/"
```

If KVFinder-web service and portal are in the same container, use the third configuration (http://kv-server:8081/).

```r
url_address <- "http://kv-server:8081/"
```

Afterwards, you have to build our KVFinder-web portal:

```bash
docker build -t kvfinder-web-portal .
```

To start KVFinder-web portal:

```bash
docker run -p 3838:3838 kvfinder-web-portal
```

### PyMOL KVFinder-web Tools

The PyMOL KVFinder-web Tools, written in Python and Qt, is a PyMOL v2.x plugin for detecting and characterizing biomolecular cavities at a KVFinder-web service with functionalities similar to [PyMOL parKVFinder Tools](https://github.com/LBC-LNBio/parKVFinder/wiki/parKVFinder-Tutorial#pymol2-parkvfinder-tools), which is natively configured to our publicly available web service ([http://kvfinder-web.cnpem.br](http://kvfinder-web.cnpem.br)).

### KVFinder-web service

KVFinder-web service, written in Rust language, has a robust web-queue-worker architecture that processes HTTP requests and responses from the interface, manages jobs, and executes parKVFinder for accepted jobs.

## Funding

KVFinder-web interface was supported by Fundação de Amparo à Pesquisa do Estado de São Paulo (FAPESP) [Grant Number 2018/00629-0], Brazilian Biosciences National Laboratory (LNBio) and Brazilian Center for Research in Energy and Materials (CNPEM).

## License

The software is licensed under the terms of the Apache-2.0 License and is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache-2.0 License for more details.

---
