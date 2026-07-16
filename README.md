# solidity-bank
A Solidity Bank contract supporting ETH deposits, top-three depositors and owner-only withdrawal.
## Sepolia Deployment

- Network: Ethereum Sepolia
- Contract address: [`0x292ED7D4D6967DeFC7EB515707F674a19e7Dede5`](https://sepolia.etherscan.io/address/0x292ED7D4D6967DeFC7EB515707F674a19e7Dede5)
- Solidity compiler: `0.8.34`

## Tested Features

- Deposit ETH through `deposit()`
- Receive direct ETH transfers through `receive()`
- Record each address's cumulative deposit
- Maintain the top three depositors
- Allow only the contract owner to withdraw all ETH
