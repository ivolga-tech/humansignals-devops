# HumanSignals Helm Chart

[![MIT License](https://img.shields.io/badge/License-MIT-red.svg?style=flat-square)](https://opensource.org/licenses/MIT)

-----

🦔 [HumanSignals](https://humansignals.ru) is a developer-friendly, open-source product analytics suite.

This Helm chart bootstraps a [HumanSignals](https://humansignals.ru) installation on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
- Kubernetes >=1.23 <= 1.25
- Helm >= 3.7.0

## Development
The main purpose of this repository is to continue evolving our Helm chart, making it faster and easier to use. We welcome all contributions to the community and are excited to welcome you aboard.

### Testing
This repo uses several types of test suite targeting different goals:

- **lint tests**: to verify if the Helm templates can be rendered without errors
- **unit tests**: to verify if the rendered Helm templates are as we expect

#### Lint tests
We use `helm lint` that can be invoked via: `helm lint --strict --set “cloud=local” .`

#### Unit tests
In order to run the test suite, you need to install the `helm-unittest` plugin. You can do that by running: `helm plugin install https://github.com/quintush/helm-unittest --version 0.2.8`

For more information about how it works and how to write test cases, please look at the upstream [documentation](https://github.com/quintush/helm-unittest/blob/master/README.md) or to the [tests already available in this repo](https://github.com/ivolga-tech/humansignals-devops/tree/main/helm/tests).

To run the test suite you can execute: `helm unittest --helm3 --strict --file 'tests/*.yaml' --file 'tests/clickhouse-operator/*.yaml' .`

If you need to update the snapshots, execute:

```
helm unittest --helm3 --strict --file 'tests/*.yaml' --file 'tests/**/*.yaml' . -u
```

### Release

To release a new chart, bump the `version` in `Chart.yaml`. We use [Semantic Versioning](https://semver.org/):

    MAJOR version when you make incompatible API changes
    MINOR version when you add functionality in a backwards compatible manner
    PATCH version when you make backwards compatible bug fixes
