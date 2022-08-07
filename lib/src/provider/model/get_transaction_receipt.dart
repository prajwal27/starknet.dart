import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starknet/starknet.dart';

part 'get_transaction_receipt.freezed.dart';
part 'get_transaction_receipt.g.dart';

@freezed
class GetTransactionReceipt with _$GetTransactionReceipt {
  const factory GetTransactionReceipt.result({
    required TxnReceipt result,
  }) = GetTransactionReceiptResult;
  const factory GetTransactionReceipt.error({
    required JsonRpcApiError error,
  }) = GetTransactionReceiptError;

  factory GetTransactionReceipt.fromJson(Map<String, Object?> json) =>
      json.containsKey('error')
          ? GetTransactionReceiptError.fromJson(json)
          : GetTransactionReceiptResult.fromJson(json);
}

@freezed
class TxnReceipt with _$TxnReceipt {
  const factory TxnReceipt.invokeTxnReceipt({
    // start of COMMON_RECEIPT_PROPERTIES
    required Felt txnHash,
    required Felt actualFee,
    required String status,
    required String? statusData,
    required Felt? blockHash,
    required int? blockNumber,
    // end of COMMON_RECEIPT_PROPERTIES
    // start of INVOKE_TXN_RECEIPT_PROPERTIES
    required List<MsgToL1> messagesSent,
    required MsgToL2? l1OriginMessage,
    required List<Event> events,
    // end of INVOKE_TXN_RECEIPT_PROPERTIES
  }) = InvokeTxnReceipt;

  const factory TxnReceipt.declareTxnReceipt({
    // start of COMMON_RECEIPT_PROPERTIES
    required Felt txnHash,
    required Felt actualFee,
    required String status,
    required String? statusData,
    required Felt? blockHash,
    required int? blockNumber,
    // end of COMMON_RECEIPT_PROPERTIES
  }) = DeclareTxnReceipt;

  const factory TxnReceipt.deployTxnReceipt({
    // start of COMMON_RECEIPT_PROPERTIES
    required Felt txnHash,
    required Felt actualFee,
    required String status,
    required String? statusData,
    required Felt? blockHash,
    required int? blockNumber,
    // end of COMMON_RECEIPT_PROPERTIES
  }) = DeployTxnReceipt;

  const factory TxnReceipt.pendingInvokeTxnReceipt({
    // start of PENDING_COMMON_RECEIPT_PROPERTIES
    required Felt txnHash,
    required Felt actualFee,
    // end of PENDING_COMMON_RECEIPT_PROPERTIES
    // start of INVOKE_TXN_RECEIPT_PROPERTIES
    required List<MsgToL1> messagesSent,
    required MsgToL2? l1OriginMessage,
    required List<Event> events,
    // end of INVOKE_TXN_RECEIPT_PROPERTIES
  }) = PendingInvokeTxnReceipt;

  const factory TxnReceipt.pendingCommonReceiptProperties({
    required Felt txnHash,
    required Felt actualFee,
  }) = PendingCommonReceiptProperties;

  // TODO: Better way to classify json.
  factory TxnReceipt.fromJson(Map<String, Object?> json) =>
      json['status'] == 'PENDING'
          ? json.containsKey('messages_sent')
              ? PendingInvokeTxnReceipt.fromJson(json)
              : PendingCommonReceiptProperties.fromJson(json)
          : json.containsKey('events')
              ? InvokeTxnReceipt.fromJson(json)
              : DeclareTxnReceipt.fromJson(json);
}
