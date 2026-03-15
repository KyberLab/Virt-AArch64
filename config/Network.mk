#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




REPO_URL_IP					?= 127.0.0.1
REPO_URL_PROTO				?= ssh
REPO_URL_BASE				?= www.github.com
REPO_URL_PORT				?= 22
REPO_URL_GROUP				?= kyberlab
REPO_URL_GIT_BASE			?= $(REPO_URL_PROTO)://git@$(REPO_URL_BASE):$(REPO_URL_PORT)/$(REPO_URL_GROUP)

BENCH_REPO_BASE				?= $(REPO_URL_BASE)/docker

BENCH_USE_DNSMAP			?= 0

