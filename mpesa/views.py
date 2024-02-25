# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import json
from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic import View
from .LipaNaMpesaOnline import sendSTK, check_payment_status
from rest_framework.views import APIView
from rest_framework.generics import ListCreateAPIView
from rest_framework.status import HTTP_200_OK, HTTP_400_BAD_REQUEST
from rest_framework.response import Response
from .models import PaymentTransaction
from django.http import JsonResponse
from rest_framework.permissions import AllowAny


# Create your views here.


class PaymentTranactionView(ListCreateAPIView):
    def post(self, request):
        return HttpResponse("OK", status=200)


class SubmitView(APIView):
    permission_classes = [AllowAny, ]

    def post(self, request):
        try:
            data = request.data
            phone_number = data.get('phone_number')
            amount = data.get('amount')

            entity_id = data.get('entity_id', 0)

            paybill_account_number = data.get('paybill_account_number', None)

            transaction_id = sendSTK(phone_number, amount, entity_id, account_number=paybill_account_number)

            message = {"status": "ok", "transaction_id": transaction_id}
            return Response(message, status=HTTP_200_OK)
        except Exception as e:
            error_message = {"error": str(e)}
            return Response(error_message, status=HTTP_400_BAD_REQUEST)


class CheckTransactionOnline(APIView):
    permission_classes = [AllowAny, ]

    def post(self, request):
        trans_id = request.data['transaction_id']
        transaction = PaymentTransaction.objects.filter(id=trans_id).get()
        try:
            if transaction.checkout_request_id:
                status_response = check_payment_status(transaction.checkout_request_id)
                return JsonResponse(
                    status_response, status=200)
            else:
                return JsonResponse({
                    "message": "Server Error. Transaction not found",
                    "status": False
                }, status=400)
        except PaymentTransaction.DoesNotExist:
            return JsonResponse({
                "message": "Server Error. Transaction not found",
                "status": False
            },
                status=400)


class CheckTransaction(APIView):
    permission_classes = [AllowAny, ]

    def post(self, request):
        data = request.data
        trans_id = data['transaction_id']
        try:
            transaction = PaymentTransaction.objects.filter(id=trans_id).get()
            if transaction:
                return JsonResponse({
                    "message": "ok",
                    "finished": transaction.is_finished,
                    "successful": transaction.is_successful
                },
                    status=200)
            else:
                # TODO : Edit order if no transaction is found
                return JsonResponse({
                    "message": "Error. Transaction not found",
                    "status": False
                },
                    status=400)
        except PaymentTransaction.DoesNotExist:
            return JsonResponse({
                "message": "Server Error. Transaction not found",
                "status": False
            },
                status=400)


class RetryTransaction(APIView):
    permission_classes = [AllowAny, ]

    def post(self, request):
        trans_id = request.data['transaction_id']
        try:
            transaction = PaymentTransaction.objects.filter(id=trans_id).get()
            if transaction and transaction.is_successful:
                return JsonResponse({
                    "message": "ok",
                    "finished": transaction.is_finished,
                    "successful": transaction.is_successful
                },
                    status=200)
            else:
                response = sendSTK(
                    phone_number=transaction.phone_number,
                    amount=transaction.amount,
                    orderId=transaction.order_id,
                    transaction_id=trans_id)
                return JsonResponse({
                    "message": "ok",
                    "transaction_id": response
                },
                    status=200)

        except PaymentTransaction.DoesNotExist:
            return JsonResponse({
                "message": "Error. Transaction not found",
                "status": False
            },
                status=400)

class ConfirmView(APIView):
    permission_classes = [AllowAny, ]

    def post(self, request):
        try:
            request_data = json.loads(json.dumps(request.data))
            body = request_data.get('Body')
            stk_callback = body.get('stkCallback')
            resultcode = stk_callback.get('ResultCode')

            if resultcode == 0:
                print('Payment successful')
                checkout_request_id = stk_callback.get('CheckoutRequestID')
                metadata = stk_callback.get('CallbackMetadata').get('Item')
                receipt_number = None

                for data in metadata:
                    if data.get('Name') == "MpesaReceiptNumber":
                        receipt_number = data.get('Value')

                transaction = PaymentTransaction.objects.get(
                    checkout_request_id=checkout_request_id)

                if transaction:
                    transaction.trans_id = receipt_number
                    transaction.is_finished = True
                    transaction.is_successful = True
                    transaction.save()
            else:
                print('Unsuccessful')
                checkout_request_id = stk_callback.get('CheckoutRequestID')
                transaction = PaymentTransaction.objects.get(
                    checkout_request_id=checkout_request_id)

                if transaction:
                    transaction.is_finished = True
                    transaction.is_successful = False
                    transaction.save()

            message = {
                "ResultCode": 0,
                "ResultDesc": "The service was accepted successfully",
                "ThirdPartyTransID": "1237867865"
            }

            return Response(message, status=HTTP_200_OK)
        except Exception as e:
            error_message = {"error": str(e)}
            return Response(error_message, status=HTTP_400_BAD_REQUEST)

    def get(self, request):
        return Response("Confirm callback", status=HTTP_200_OK)


class ValidateView(APIView):
    permission_classes = [AllowAny, ]

    def post(self, request):
        # save the data
        request_data = request.data

        # Perform your processing here e.g. print it out...
        print("validate data" + request_data)

        # Prepare the response, assuming no errors have occurred. Any response
        # other than a 0 (zero) for the 'ResultCode' during Validation only means
        # an error occurred and the transaction is cancelled
        message = {
            "ResultCode": 0,
            "ResultDesc": "The service was accepted successfully",
            "ThirdPartyTransID": "1234567890"
        }

        # Send the response back to the server
        return Response(message, status=HTTP_200_OK)
