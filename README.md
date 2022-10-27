# Juicebox Subscription
WIP

## Motivation
Simple contract to keep track of Juicebox project subscribers

Utilizes:
* https://info.juicebox.money/dev/build/utilities/project-payer

References:
*  https://github.com/nnnnicholas/auditfund-nftdrop
* https://github.com/jbx-protocol/juice-nft-rewards

## Setup

1. Install [Foundry](https://github.com/gakonst/foundry).

```bash
curl -L https://foundry.paradigm.xyz | sh
```

2. Install external lib(s)

```bash
git submodule update --init --recursive --force && yarn install
```

then run

```bash
forge update
```

3. Run tests:

```bash
forge test
```
