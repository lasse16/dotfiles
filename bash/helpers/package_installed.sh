#!/bin/bash
package_installed()
{
	echo "$1";
	dpkg-query -s "$1" | grep -q "Status: install ok" ;
}
