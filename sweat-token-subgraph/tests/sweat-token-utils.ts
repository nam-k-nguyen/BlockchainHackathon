import { newMockEvent } from "matchstick-as"
import { ethereum, BigInt, Address } from "@graphprotocol/graph-ts"
import { PriceUpdate, Transfer } from "../generated/SweatToken/SweatToken"

export function createPriceUpdateEvent(priceInUSD: BigInt): PriceUpdate {
  let priceUpdateEvent = changetype<PriceUpdate>(newMockEvent())

  priceUpdateEvent.parameters = new Array()

  priceUpdateEvent.parameters.push(
    new ethereum.EventParam(
      "priceInUSD",
      ethereum.Value.fromUnsignedBigInt(priceInUSD)
    )
  )

  return priceUpdateEvent
}

export function createTransferEvent(
  from: Address,
  to: Address,
  value: BigInt
): Transfer {
  let transferEvent = changetype<Transfer>(newMockEvent())

  transferEvent.parameters = new Array()

  transferEvent.parameters.push(
    new ethereum.EventParam("from", ethereum.Value.fromAddress(from))
  )
  transferEvent.parameters.push(
    new ethereum.EventParam("to", ethereum.Value.fromAddress(to))
  )
  transferEvent.parameters.push(
    new ethereum.EventParam("value", ethereum.Value.fromUnsignedBigInt(value))
  )

  return transferEvent
}
