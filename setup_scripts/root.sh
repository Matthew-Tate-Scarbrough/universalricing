#!/bin/sh

mkdir -p /root/.cache/bash
mkdir -p /root/.local/profile

cp .config/bash/.bashrc /root
cp .local/profile/aliases /root/.local/profile
