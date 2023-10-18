import {
  PriceUpdate as PriceUpdateEvent,
  Transfer as TransferEvent
} from "../generated/SweatToken/SweatToken"
import { PriceUpdate, Transfer } from "../generated/schema"

export function handlePriceUpdate(event: PriceUpdateEvent): void {
  let entity = new PriceUpdate(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.priceInUSD = event.params.priceInUSD

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handleTransfer(event: TransferEvent): void {
  let entity = new Transfer(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.from = event.params.from
  entity.to = event.params.to
  entity.value = event.params.value

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}
