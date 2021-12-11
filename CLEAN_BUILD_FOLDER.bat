@echo off
cd %cd%
for %%a in (*.com) do (
del "%%a"
)
