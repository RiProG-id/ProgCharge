#!/bin/sh
if pm list packages | grep -q "webui"; then
	am start -n io.github.a13e300.ksuwebui/.WebUIActivity --es id "PCH"
else
	echo "KSU WEBUI STANDALONE NOT INSTALLED"
fi
