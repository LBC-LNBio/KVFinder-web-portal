# KVFinder-web interface (KVshiny)

Welcome to the KVFinder-web interface (KVshiny), this page was built to help you get started with our web portal for [KVFinder-web service](https://github.com/LBC-LNBio/KVFinder-web-service).

## KVFinder-web 

KVFinder-web is an open-source web-based application of [parKVFinder](https://github.com/LBC-LNBio) software for cavity detection and spatial characterization of any type of biomolecular structure.

The KVFinder-web application has two independent components:

- [KVFinder-web interface](https://github.com/LBC-LNBio/KVshiny-docker) (KVshiny): a web graphical interface;
- [KVFinder-web service](https://github.com/LBC-LNBio/KVFinder-web-service): a RESTful web service.

### KVFinder-web interface

The KVFinder-web interface (KVshiny), developed in R Shiny, delivers the major functionalities of the KVFinder-web service, where users can load a target biomolecule, adjust detection parameters, select run modes, and download and visualize results. The interface provides a simple and interactive way to analyze and visualize cavities. Volumes and areas are shown in an interactive table that can be downloaded in TOML format. A biomolecule viewer, powered by the NGL engine for R, displays the biomolecular structure with its cavities, which can be downloaded in PDB format, and allows various customizations, such as highlighting cavities and displaying interface residues surrounding them.

### KVFinder-web service

KVFinder-web service, written in Rust language, has a robust web-queue-worker architecture that processes HTTP requests and responses from the interface, manages jobs, and executes parKVFinder for accepted jobs.

We provide a publicly available KVFinder-web service (https://kvfinder-web.cnpem.br).

## Local installation

To run the KVFinder-web interface (KVshiny) in Linux distributions, it is necessary to install docker-compose and its dependencies. To install it:

```bash
sudo apt install docker-compose
```

After the docker-compose installation and copy/clone of this repository. First, you have to build our KVFinder-web interface:

```bash
sudo docker build -t kvserver .
```

To start KVFinder-web interface:

```bash
sudo docker run -p 3838:3838 kvserver
```

## Funding

KVFinder-web interface was supported by Fundação de Amparo à Pesquisa do Estado de São Paulo (FAPESP) [Grant Number 2018/00629-0], Brazilian Biosciences National Laboratory (LNBio) and Brazilian Center for Research in Energy and Materials (CNPEM).

## License

The software is licensed under the terms of the Apache-2.0 License and is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache-2.0 License for more details.
