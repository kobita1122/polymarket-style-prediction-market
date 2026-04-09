# Decentralized Prediction Market (Polymarket-style)

A professional-grade implementation for "Information Markets." This repository allows users to trade on the outcome of future events. By using conditional tokens, the market aggregates collective intelligence to provide a real-time probability of event outcomes (e.g., elections, sports, or weather).

## Core Features
* **Binary Outcome Shares:** Uses ERC-20 tokens to represent "YES" and "NO" positions in a specific event.
* **Conditional Token Logic:** Ensures that the total supply of YES and NO shares is backed by the underlying collateral (USDC).
* **Optimistic Oracle Integration:** Leverages UMA or Chainlink to resolve event outcomes without a central authority.
* **Flat Architecture:** Single-directory layout for the Market Factory, Share Token, and Resolution Module.

## Logic Flow
1. **Initialize:** A market is created for "Will it rain in London tomorrow?" with 1,000 USDC collateral.
2. **Trade:** Users buy "YES" shares if they think it will rain. The price of "YES" rises as demand increases.
3. **Resolve:** After the event, the Oracle confirms it rained.
4. **Redeem:** "YES" holders can redeem each share for 1 USDC; "NO" shares become worthless.

## Setup
1. `npm install`
2. Deploy `PredictionMarketFactory.sol`.
