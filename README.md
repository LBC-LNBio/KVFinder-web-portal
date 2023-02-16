# KVFinder-web portal

![GitHub release (latest by date)](https://img.shields.io/github/v/release/LBC-LNBio/KVFinder-web-portal?color=informational)
![GitHub](https://img.shields.io/github/license/LBC-LNBio/KVFinder-web-portal)

Welcome to the KVFinder-web portal, this page was built to help you get started with our web portal for [KVFinder-web service](https://github.com/LBC-LNBio/KVFinder-web-service).

## KVFinder-web

KVFinder-web is an open-source web-based application of [parKVFinder](https://github.com/LBC-LNBio) software for cavity detection and spatial characterization of any type of biomolecular structure.

The KVFinder-web application has two independent components:

- interactive graphical clients, that are:
  - [KVFinder-web portal](https://github.com/LBC-LNBio/KVFinder-web-portal): a graphical web portal;
  - [PyMOL KVFinder-web Tools](https://github.com/LBC-LNBio/PyMOL-KVFinder-web-Tools): a graphical PyMOL plugin.
- a RESTful web service: [KVFinder-web service](https://github.com/LBC-LNBio/KVFinder-web-service);

The full KVFinder-web documentation can be found here: (<http://lbc-lnbio.github.io/KVFinder-web>).

### KVFinder-web portal

The KVFinder-web portal, developed in R Shiny, delivers the major functionalities of the KVFinder-web service, where users can load a target biomolecule, adjust detection parameters, select run modes, and download and visualize results. The web portal provides a simple and interactive way to analyze and visualize cavities. Volumes and areas are shown in an interactive table that can be downloaded in TOML format. A biomolecule viewer, powered by the NGL engine for R, displays the biomolecular structure with its cavities, which can be downloaded in PDB format, and allows various customizations, such as highlighting cavities and displaying interface residues surrounding them.

We provide a publicly available KVFinder-web service at [https://kvfinder-web.cnpem.br](https://kvfinder-web.cnpem.br) with KVFinder-web portal as the graphical web interface.

#### Local installation

To run locally the KVFinder-web portal in Linux distributions, it is necessary to install docker-compose and its dependencies. To install it:

```bash
sudo apt install docker-compose
```

After the docker-compose installation and clone of this repository. First, you have to build our KVFinder-web interface:

```bash
sudo docker build -t kvfinderwebportal .
```

To start KVFinder-web interface:

```bash
sudo docker run -p 3838:3838 kvfinderwebportal
```

### PyMOL KVFinder-web Tools

The PyMOL KVFinder-web Tools, written in Python and Qt, is a PyMOL v2.x plugin for detecting and characterizing biomolecular cavities at a KVFinder-web service with functionalities similar to [PyMOL parKVFinder Tools](https://github.com/LBC-LNBio/parKVFinder/wiki/parKVFinder-Tutorial#pymol2-parkvfinder-tools), which is natively configured to our publicly available web service (<http://kvfinder-web.cnpem.br>).

### KVFinder-web service

KVFinder-web service, written in Rust language, has a robust web-queue-worker architecture that processes HTTP requests and responses from the interface, manages jobs, and executes parKVFinder for accepted jobs.

## Funding

KVFinder-web interface was supported by Fundação de Amparo à Pesquisa do Estado de São Paulo (FAPESP) [Grant Number 2018/00629-0], Brazilian Biosciences National Laboratory (LNBio) and Brazilian Center for Research in Energy and Materials (CNPEM).

## License

The software is licensed under the terms of the Apache-2.0 License and is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache-2.0 License for more details.

---
