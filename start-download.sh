#!/bin/bash

downloadto="~/repo/librivox.org"
mkdir 'Librivox Download'
cd 'Librivox Download'
wget https://raw.githubusercontent.com/mattzab/librivox-dl/master/continue-download.sh
echo Download updated Book Listing
wget -O list1.xml "https://librivox.org/api/feed/audiobooks/?offset=0&limit=5000&fields=%7Blanguage,authors,title,url_zip_file%7B"
wget -O list2.xml "https://librivox.org/api/feed/audiobooks/?offset=5000&limit=5000&fields=%7Blanguage,authors,title,url_zip_file%7B"
wget -O list3.xml "https://librivox.org/api/feed/audiobooks/?offset=10000&limit=5000&fields=%7Blanguage,authors,title,url_zip_file%7B"
wget -O list4.xml "https://librivox.org/api/feed/audiobooks/?offset=15000&limit=5000&fields=%7Blanguage,authors,title,url_zip_file%7B"

echo
echo Cleaning up XML file to be used with Wget...
echo
echo replace trailing title tag with zip file extension
sed -i -- 's,</title>,.zip\n,g' *.xml
echo
echo replace leading book tag with single line break
sed -i -- 's,<book>,\n,g' *.xml
echo
echo replace trailing zip url tag with single line break
sed -i -- 's,</url_zip_file>,\n,g' *.xml
echo
echo replace trailing language tag with single line break
sed -i -- 's,</language>,.\n,g' *.xml
echo
echo replace leading first name tag with single line break
sed -i -- 's,<first_name>,\n,g' *.xml
echo
echo replace leading last name tag with single line break
sed -i -- 's,<last_name>,\n,g' *.xml
echo
echo replace trailing first name tag with period separator
sed -i -- 's,</first_name>,.,g' *.xml
echo
echo replace trailing last name tag with period separator
sed -i -- 's,</last_name>,.,g' *.xml
echo
echo remove exclamation points from titles
sed -i -- 's,!,,g' *.xml
echo
echo remove single quotes from titles
sed -i "s,',,g" *.xml
echo
echo remove ampersand from titles
sed -i 's,&amp;,And,g' *.xml
echo
echo replace colon with period
sed -i -- 's,:,.,g' *.xml
echo
echo restore the colon in url addresses
sed -i -- 's,p./,p:/,g' *.xml
echo
echo remove spaces from titles
sed -i -- 's, ,,g' *.xml
echo
echo remove leading title tag
sed -i -- 's,<title>,,g' *.xml
echo
echo remove leading url tag
sed -i -- 's,<url_zip_file>,,g' *.xml
echo
echo remove leading language tag
sed -i -- 's,<language>,,g' *.xml
echo
echo remove all remaining xml tags and everything inbetween
sed -i 's,<.*>,,g' *.xml
echo
echo cleanup white space
sed -i '/^$/d' *.xml
echo
cd $downloadto
sh "~/Librivox Download/continue-download.sh"
