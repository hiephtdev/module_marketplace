
# Move Smart Contract Module Marketplace

**An online marketplace for Move smart contract modules on the Aptos blockchain network**

## Introduction

**Move Smart Contract Module Marketplace** is a decentralized project that allows developers to buy, sell, share, and exchange Move smart contract modules on the Aptos blockchain network. This project leverages the unique features of Aptos and Move to create a secure, efficient, and flexible platform for the blockchain developer community.

## Project Goals

- **Encourage collaboration**: Facilitate sharing and reuse of Move modules among developers, reducing development time and effort.
- **Leverage Move's modularity**: Utilize the modularity and safety of the Move language to create reliable and easily integrable smart contracts.
- **Promote innovation**: Encourage the creation of new solutions by providing an open platform for exchanging ideas and code.

## Key Features

- **Module registration**: Allows users to register and share their Move modules on the Marketplace.
- **Buying and selling modules**: Supports transactions of buying and selling modules between developers, with payment capabilities using AptosCoin.
- **Ownership management**: Enables secure and transparent transfer of module ownership.
- **Events and notifications**: Emits events when modules are registered or transferred, helping track activities on the Marketplace.
- **Leveraging Aptos technology**: Utilizes Aptos's high performance, low latency, and the safety of the Move language to provide a smooth experience.

## Project Structure

- **Move.toml**: Configuration file for the Move project.
- **sources/**: Directory containing the Move modules.
  - `Marketplace.move`: Source code of the Marketplace module.
- **scripts/**: Directory containing scripts to interact with the module.
  - `register_module.move`: Script to register a new module on the Marketplace.

## Installation Guide

### Requirements

- **Move CLI**: To compile and deploy Move contracts.
- **Aptos CLI**: To interact with the Aptos network.
- **Git**: For source code management and pushing the project to GitHub.

### Installation Steps

1. **Clone the project**

   ```bash
   git clone https://github.com/hiephtdev/module_marketplace.git
   cd module_marketplace
   ```

2. **Install Move CLI**

   ```bash
   cargo install --git https://github.com/aptos-labs/aptos-core.git aptos-move --branch main
   ```

3. **Compile the project**

   ```bash
   move compile
   ```

4. **Deploy the module to Aptos**

   ```bash
   move publish --named-addresses Marketplace=0xYourAccountAddress
   ```

   Replace `0xYourAccountAddress` with your account address on Aptos.

## Usage Instructions

### Register a New Module

Use the `register_module.move` script to register a new module:

```bash
move run scripts/register_module.move --signers 0xYourAccountAddress
```

### Buy a Module

Create a script `buy_module.move` to purchase a module and execute:

```bash
move run scripts/buy_module.move --signers 0xYourAccountAddress
```

## Contributing to the Project

We welcome contributions from the community:

- **Report issues**: If you find any bugs, please create an issue on GitHub.
- **Feature suggestions**: Submit your ideas and suggestions via pull requests or issues.
- **Development**: Participate in developing new features and improving the project.

## License

This project is released under the MIT License. Please refer to the [LICENSE](LICENSE) file for more details.

## Contact

- **Email**: work.hiepht@gmail.com
- **GitHub**: [hiephtdev](https://github.com/hiephtdev)
- **X.Com**: [hiepht_dev](https://x.com/hiepht_dev)
