#!/bin/bash

# generate keys
openssl genrsa -out ca.key 2048
openssl genrsa -out admin.key 2048
openssl genrsa -out kube-api.key 2048
openssl genrsa -out kube-sched.key 2048
openssl genrsa -out kube-cm.key 2048
openssl genrsa -out kube-proxy.key 2048
openssl genrsa -out kube-sa.key 2048
openssl genrsa -out worker-0.key 2048
openssl genrsa -out worker-1.key 2048
openssl genrsa -out worker-2.key 2048

# generate CA
openssl req -x509 -new -nodes -key ca.key -sha256 -days 730 -config ca.config -out ca.pem -extensions v3_ca

# generate csr
openssl req -new -key admin.key -out admin.csr -config admin.config
openssl req -new -key kube-api.key -out kube-api.csr -config kube-api.config
openssl req -new -key kube-sched.key -out kube-sched.csr -config kube-sched.config
openssl req -new -key kube-cm.key -out kube-cm.csr -config kube-cm.config
openssl req -new -key kube-proxy.key -out kube-proxy.csr -config kube-proxy.config
openssl req -new -key kube-sa.key -out kube-sa.csr -config kube-sa.config
openssl req -new -key worker-0.key -out worker-0.csr -config worker-0.config
openssl req -new -key worker-1.key -out worker-1.csr -config worker-1.config
openssl req -new -key worker-2.key -out worker-2.csr -config worker-2.config


# generate certs
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in admin.csr -out admin.pem -extfile etcd-client.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in kube-sched.csr -out kube-sched.pem -extfile etcd-client.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in kube-cm.csr -out kube-cm.pem -extfile etcd-client.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in kube-proxy.csr -out kube-proxy.pem -extfile etcd-client.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in kube-sa.csr -out kube-sa.pem -extfile etcd-client.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in kube-api.csr -out kube-api.pem -extfile kube-api.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in worker-0.csr -out worker-0.pem -extfile worker-0.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in worker-1.csr -out worker-1.pem -extfile worker-1.ext
openssl x509 -req -CA ca.pem -CAkey ca.key -CAcreateserial -days 730 -sha256 -in worker-2.csr -out worker-2.pem -extfile worker-2.ext


