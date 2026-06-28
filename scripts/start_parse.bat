@echo off
chcp 65001 > nul
start "" /wait powershell -NoProfile -ExecutionPolicy Bypass -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; & '%~dp0parse_blockcheck2.ps1'"
start "" notepad.exe "%~dp0clean_summary.txt"
